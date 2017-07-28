#!/bin/bash

# Feature list: https://stackoverflow.com/questions/208193/why-should-i-use-an-ide

NEOVIM_STUDIO_DIR="${HOME}/.neovim-studio"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CLEAR='\033[0m'

# Running as superuser will not install into user's home.
#if ! [ "$(id -u)" = 0 ]; then
#    echo -e "${RED}Superuser permissions are required to run this script${CLEAR}"
#    exit 1
#fi

check()
{
    code="$?"
    if [ "$code" -ne 0 ]; then
        echo -e "${RED}Previous command failed (code ${code}); aborting ...${CLEAR}"
        exit 1
    fi
}

cd "$HOME"; check # These are for safety.
clear; clear

echo -e "${BLUE}Checking for the local package manager ...${CLEAR}"
APT_GET_INSTALLED=$(which apt-get)
PACMAN_INSTALLED=$(which pacman)
YUM_INSTALLED=$(which yum)
YAOURT_INSTALLED=$(which yaourt)
NPM_INSTALLED=$(which npm)
CARGO_INSTALLED=$(which cargo)

if [ ! -z "$PACMAN_INSTALLED" ]; then
    echo -e "${GREEN}Found Pacman${CLEAR}"
    echo -e "${BLUE}Updating system ...${CLEAR}"
    sudo pacman -Syu --noconfirm; check

    echo -e "${BLUE}Installing core packages ...${CLEAR}"
    sudo pacman -S --needed --noconfirm git neovim; check

    echo -e "${BLUE}Installing language dependencies and alternative package managers ...${CLEAR}"
    sudo pacman -S --needed --noconfirm nodejs npm rust cargo ruby go python-pip python2-pip dmd ctags clang; check

    echo -e "${BLUE}Installing linter packages ...${CLEAR}"
    sudo pacman -S --needed --noconfirm gawk shellcheck cppcheck mono crystal dmd stack ghc elixir tidy luarocks nim; check

    #echo -e "${BLUE}Installing autocompletion packages ...${CLEAR}"
    #sudo pacman -S --needed --noconfirm ; check

    echo -e "${GREEN}Pacman installs complete${CLEAR}"
elif [ ! -z "$APT_GET_INSTALLED" ]; then
    echo -e "${RED}APT-based distributions are not yet supported${CLEAR}"
elif [ ! -z "$YUM_INSTALLED" ]; then
    # Update to DNF?
    echo -e "${RED}YUM-based distributions are not yet supported${CLEAR}"
else
    echo -e "${RED}Your package manager is not supported by this installer${CLEAR}"
    exit 1
fi



echo -e "${BLUE}Setting up the Neovim Studio installation directory in $NEOVIM_STUDIO_DIR ...${CLEAR}"
mkdir -p "$NEOVIM_STUDIO_DIR"; check
mkdir -p "${NEOVIM_STUDIO_DIR}/includes/"; check
libclangPath=$(ldconfig -p | grep -o -m 1 "/.\+clang.\+") # Don't check these; permissions errors.
libclangIncludes=$(find / -path "*clang/*/include")

if [ ! -z "$libclangPath" ] && [ -e "$libclangPath" ] && [ ! -z "$libclangIncludes" ] && [ -e "$libclangIncludes" ]; then
    echo "let g:deoplete#sources#clang#libclang_path = '${libclangPath}'" > "${NEOVIM_STUDIO_DIR}/includes/clang.vim"; check
    echo "let g:deoplete#sources#clang#clang_header = '${libclangIncludes}'" >> "${NEOVIM_STUDIO_DIR}/includes/clang.vim"; check
else
    echo -e "${RED}Failed to find libclang and its includes:${CLEAR}"
    echo -e "${RED}libclang: ${libclangPath}${CLEAR}"
    echo -e "${RED}includes: ${libclangIncludes}${CLEAR}"
    exit 1
fi

cp "${SCRIPT_DIR}/init.vim" "${NEOVIM_STUDIO_DIR}/init.vim"; check
mkdir -p "${HOME}/.config/nvim/"; check
cd "${HOME}/.config/nvim"; check
ln -s "${NEOVIM_STUDIO_DIR}/init.vim"; check
cd "${HOME}"; check



if [ ! -e "${HOME}/.local/share/nvim/site/autoload/plug.vim" ]; then
    echo -e "${BLUE}Installing Plug ...${CLEAR}"
    curl -fLo "${HOME}/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; check
else
    echo -e "${BLUE}Plug is already installed; skipping ...${CLEAR}"
fi



if [ ! -e "/usr/share/fonts/DejaVu Sans Mono Nerd Font Complete.ttf" ]; then
    echo -e "${BLUE}Installing Nerd Font Complete ...${CLEAR}"
    mkdir -p /usr/share/fonts; check
    cd /usr/share/fonts; check
    sudo curl -fLo "DejaVu Sans Mono Nerd Font Complete.ttf" \
        https://raw.githubusercontent.com/ryanoasis/nerd-fonts/1.0.0/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.ttf; check
    fc-cache -fv; check
    cd "$HOME"; check
else
    echo -e "${BLUE}Nerd Font Complete is already installed; skipping ...${CLEAR}"
fi



# TODO: Fix Haskell and Cabal
# echo -e "${BLUE}Installing the Haskell toolchain ...${CLEAR}"
# stack setup; check
# stack install Cabal; check



echo -e "${BLUE}Installing linters from alternative package managers ...${CLEAR}"
echo -e "${BLUE}Installing from NPM ...${CLEAR}"
sudo npm install -g coffeescript coffeelint csslint stylelint eslint jshint flow-remove-types flow-bin jsonlint \
    tern; check # Broken: elm

echo -e "${BLUE}Installing from Pip ...${CLEAR}"
sudo pip2 install neovim ansible-lint; check
sudo pip3 install neovim; check
sudo pip install proselint cmakelint cython; check

echo -e "${BLUE}Installing from Gem ...${CLEAR}"
gem install neovim foodcritic erubi haml_lint mdl; check # TODO: Check Ruby provider.

echo -e "${BLUE}Installing from Go ...${CLEAR}"
go get -v -u github.com/golang/lint/golint; check
go get -v -u github.com/alecthomas/gometalinter; check # Unstable version

# echo -e "${BLUE}Installing from Cabal ...${CLEAR}"
# cabal install hlint; check

echo -e "${BLUE}Installing from LuaRocks ...${CLEAR}"
sudo luarocks install luacheck; check



# echo -e "${BLUE}Building Hadolint from source ...${CLEAR}"
# mkdir -p "${NEOVIM_STUDIO_DIR}/hadolint/"; check
# git clone https://github.com/lukasmartinelli/hadolint "${NEOVIM_STUDIO_DIR}/hadolint/"; check
# cd "${NEOVIM_STUDIO_DIR}/hadolint/"; check
# stack build; check
# cd "$HOME"; check



echo -e "${BLUE}Installing Racer ...${CLEAR}"
cargo install racer
code="$?"
if [ "$code" -eq 101 ]; then
    echo -e "${BLUE}Racer is already installed; skipping ...${CLEAR}"
elif [ "$code" -ne 1 ]; then
    check # 1 is an OK status with Cargo.
fi

if [ ! -e "${NEOVIM_STUDIO_DIR}/rust/" ]; then
    echo -e "${BLUE}Installing Rust documentation ...${CLEAR}"
    mkdir -p "${NEOVIM_STUDIO_DIR}/rust/"; check
    git clone --depth=1 https://github.com/rust-lang/rust.git "${NEOVIM_STUDIO_DIR}/rust/"; check
fi

rustRacerPath="${HOME}/.cargo/bin/racer"
rustSourcePath="${NEOVIM_STUDIO_DIR}/rust/src/"
if [ -e "$rustRacerPath" ] && [ -e "$rustSourcePath" ]; then
    echo "let g:deoplete#sources#rust#racer_binary='${rustRacerPath}'" > "${NEOVIM_STUDIO_DIR}/includes/rust.vim"; check
    echo "let g:deoplete#sources#rust#rust_source_path='${rustSourcePath}'" >> "${NEOVIM_STUDIO_DIR}/includes/rust.vim"; check
else
    echo -e "${RED}Failed to find Racer and Rust source:${CLEAR}"
    echo -e "${RED}racer: ${rustRacerPath}${CLEAR}"
    echo -e "${RED}rust source: ${rustSourcePath}${CLEAR}"
    exit 1
fi



if [ ! -e "${NEOVIM_STUDIO_DIR}/credo/" ]; then
    echo -e "${BLUE}Building Credo from source ...${CLEAR}"
    mkdir -p "${NEOVIM_STUDIO_DIR}/credo/"; check
    git clone https://github.com/rrrene/credo "${NEOVIM_STUDIO_DIR}/credo/"; check
    cd "${NEOVIM_STUDIO_DIR}/credo/"; check
    mix local.hex --force; check
    yes | mix deps.get; check
    mix archive.build; check
    yes | mix archive.install; check
    cd "$HOME"; check
fi



if [ ! -e "${NEOVIM_STUDIO_DIR}/dcd/" ]; then
    echo -e "${BLUE}Building D Completion Daemon from source ...${CLEAR}"
    mkdir -p "${NEOVIM_STUDIO_DIR}/dcd/"; check
    git clone https://github.com/dlang-community/DCD "${NEOVIM_STUDIO_DIR}/dcd/"; check
    cd "${NEOVIM_STUDIO_DIR}/dcd/"; check
    git submodule update --init --recursive; check
    make; check
    cd "$HOME"; check
fi

# Dogma
# Skip for now, we have Credo

# TODO: erlc, checkstyle, kotlinc, mlint
# Bookmark: NIX

# Post-install
cd "$HOME"; check

echo -e "${BLUE}Appending environment variables to ${HOME}/.profile ..."
echo "if [ -e \"${NEOVIM_STUDIO_DIR}\" ]; then" >> "${HOME}/.profile"
echo "    export NEOVIM_STUDIO_DIR=\"${NEOVIM_STUDIO_DIR}\"" >> "${HOME}/.profile"
echo 'fi' >> "${HOME}/.profile"
echo '' >> "${HOME}/.profile"
echo 'if [ -e "${HOME}/.cargo/bin" ]; then' >> "${HOME}/.profile"
echo '    export PATH="${PATH}:${HOME}/.cargo/bin"' >> "${HOME}/.profile"
echo 'fi' >> "${HOME}/.profile"
echo '' >> "${HOME}/.profile"
echo 'if [ -e "${HOME}/.gem/ruby/2.4.0/bin" ]; then' >> "${HOME}/.profile"
echo '    export PATH="${PATH}:${HOME}/.gem/ruby/2.4.0/bin"' >> "${HOME}/.profile"
echo 'fi' >> "${HOME}/.profile"
echo '' >> "${HOME}/.profile"

echo -e "${BLUE}Sourcing the new environment variables ...${CLEAR}"
source "${HOME}/.profile"



echo -e "${BLUE}Installing Neovim plugins ...${CLEAR}"
echo -e "${BLUE}You may have a couple errors here -- don't mind them!${CLEAR}"
nvim -c "PlugInstall" -c "qa"
sudo nvim -c "PlugInstall" -c "qa" # Some plugins require sudo privileges to install correctly.



echo -e "${GREEN}Installation complete${CLEAR}"
echo -e "${GREEN}Please set your terminal profile to use \"DejaVuSansMono Nerd Font\" or a similar Powerline font${CLEAR}"
echo -e "${GREEN}It is recommended that you use a well-developed terminal emulator like Konsole for fully-functioning themes${CLEAR}"
echo ""
echo -e "${GREEN}TO BEGIN YOUR EPIC JOURNEY, TYPE \`nvim\` !${CLEAR}"
