#!/bin/bash

# Feature list: https://stackoverflow.com/questions/208193/why-should-i-use-an-ide

NEOVIM_STUDIO_DIR="${HOME}/.neovim-studio"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TARGET_PROFILE="${NEOVIM_STUDIO_DIR}/neovim_studio_profile" # If .profile is used, a logout will be required.

RED='\e[0;31m'
LIGHT_RED='\e[1;31m'
YELLOW='\e[1;33m'
GREEN='\e[0;32m'
LIGHT_GREEN='\e[1;32m'
CYAN='\e[0;36m'
LIGHT_CYAN='\e[1;36m'
BLUE='\e[0;34m'
LIGHT_BLUE='\e[1;34m'
PURPLE='\e[0;35m'
LIGHT_PURPLE='\e[1;35m'
BROWN='\e[0;33m'
BLACK='\e[0;30m'
DARK_GREY='\e[1;30m'
LIGHT_GREY='\e[0;37m'
WHITE='\e[1;37m'
CLEAR='\e[0m'
BLINK='\e[5m'
BOLD='\e[1m'

cd "$HOME"; check # These are for safety.
clear; clear

log "Setting up the Neovim Studio installation directory in $NEOVIM_STUDIO_DIR ..."
mkdir -p "$NEOVIM_STUDIO_DIR"; check
cp -r "${SCRIPT_DIR}/includes/" "$NEOVIM_STUDIO_DIR"; check
mkdir -p "${NEOVIM_STUDIO_DIR}/ulti-snippets"; check
# This will also clear the plugin_paths.vim file.
echo "let g:UltiSnipsSnippetsDir = '${NEOVIM_STUDIO_DIR}/ulti-snippets'" > "${NEOVIM_STUDIO_DIR}/includes/plugin_paths.vim"; check
mkdir -p "${NEOVIM_STUDIO_DIR}/go/"; check # This will be appended to $GOPATH

log "Collecting system information ..."
THREADS="$(grep -c '^processor' /proc/cpuinfo)"
ARCHITECTURE="64"
if [ -z "$(uname --machine | grep "64")" ]; then
    ARCHITECTURE="32"
fi
log "Detected a ${ARCHITECTURE}-bit system with ${THREADS} threads"

log "Checking for the local package manager ..."
APT_GET_INSTALLED="$(which apt-get 2>/dev/null)"
PACMAN_INSTALLED="$(which pacman 2>/dev/null)"
YUM_INSTALLED="$(which yum 2>/dev/null)"

# TODO: Install Linuxbrew for packages like Swift?
# TODO: Replace RVM with RBEnv.

if [ ! -z "$PACMAN_INSTALLED" ]; then
    log "Found Pacman"

    log "Updating system ..."
    sudo pacman -Syu --noconfirm; check

    # TODO: Combine all of these into one for faster speed.
    log "Installing core packages ..."
    sudo pacman -S --needed --noconfirm git neovim gnupg xsel xvfb; check

    additional_packages=""

    if [ -z "$(command -v rvm)" ]; then
        additional_packages="$additional_packages ruby"
    fi

    log "Installing language dependencies and alternative package managers ..."
    sudo pacman -S --needed --noconfirm crystal mono rust cargo go python-pip python2-pip dmd ctags clang \
        ghc cabal-install happy alex stack erlang elixir jdk8-openjdk perl php $additional_packages; check
    # TODO: RVM/Ruby is buggy for Antergos. Re-evaluate at a later date.

    log "Installing linter packages ..."
    sudo pacman -S --needed --noconfirm gawk shellcheck cppcheck tidy luarocks nim python2-pylint python-pylint; check

    #log "Installing autocompletion packages ..."
    #sudo pacman -S --needed --noconfirm ; check

    success "Pacman installs complete"
elif [ ! -z "$APT_GET_INSTALLED" ]; then
    success "Found APT-GET"
    log "Updating system ..."
    sudo apt-get update; check
    sudo apt-get upgrade -y; check

    log "Installing core packages ..."
    sudo apt-get install -y git git-core build-essential curl wget gnupg2 xsel xvfb; check # zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

    log "Adding PPA's and latest stable versions ..."
    sudo add-apt-repository ppa:neovim-ppa/unstable -y # We'll have to use unstable to hit every platform.

    if [ -z "$(command -v erl)" ]; then
        log "Installing Erlang ..."
        wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb; check
        sudo dpkg -i erlang-solutions_1.0_all.deb; check
        rm erlang-solutions_1.0_all.deb; check
    fi

    if [ -z "$(which dmd)" ]; then
        log "Installing DMD ..."
        sudo wget http://master.dl.sourceforge.net/project/d-apt/files/d-apt.list -O /etc/apt/sources.list.d/d-apt.list \
            ; check
        sudo apt-get update
        sudo apt-get -y --allow-unauthenticated install --reinstall d-apt-keyring; check
        sudo apt-get update;
    fi

    if [ -z "$(which crystal)" ]; then
        log "Adding Crystal ..."
        sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 09617FD37CC06B54; check
        sudo bash -c "echo \"deb https://dist.crystal-lang.org/apt crystal main\" > /etc/apt/sources.list.d/crystal.list" \
            ; check
    fi

    if [ -z "$(which rustc)" ] && [ -z "$(which cargo)" ]; then
        curl https://sh.rustup.rs -sSf | sh -s -- -y; check
    fi

    log "Installing Neovim ..."
    sudo apt-get install -y neovim

    log "Installing language dependencies and alternative package managers ..."
    sudo apt-get install -y esl-erlang elixir mono-complete haskell-platform haskell-stack dmd-bin golang python-pip \
	    python3-pip libclang1 libclang-dev exuberant-ctags openjdk-8-jdk perl php; check

    log "Installing linter packages ..."
    sudo apt-get install -y gawk shellcheck cppcheck tidy luarocks nim pylint; check # crystal

    #log "Installing autocompletion packages ..."
    #sudo pacman -S --needed --noconfirm ; check

    success "APT-GET installs complete"
elif [ ! -z "$YUM_INSTALLED" ]; then
    # Update to DNF?
    error "YUM-based distributions are not yet supported"
else
    error "Your package manager is not supported by this installer"
    exit 1
fi



if [ -z "$(which ruby)" ] || [ -z "$(which gem)" ]; then
    log "Installing Ruby Version Manager (RVM) ..."
    gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3; check
    # This is using github's stable branch because the normal installer is broken and not pointing to stable.
    curl -sSL https://raw.githubusercontent.com/wayneeseguin/rvm/stable/binscripts/rvm-installer | bash -s stable --ruby; check # Broken: haml_lint, sqlint
fi

if [ -z "$(which node)" ] && [ -z "$(which nodejs)" ]; then
    log "Installing Node Version Manager (NVM) ..."
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash; check

    export NVM_DIR="${HOME}/.nvm"
    source "${HOME}/.nvm/nvm.sh"; check
    command -v nvm; check
    nvm install lts/boron; check # Install Node.js v6.x LTS
    nvm alias default lts/boron; check
    nvm use lts/boron; check
fi



if [ ! -e "${NEOVIM_STUDIO_DIR}/eclim/" ]; then
    log "Installing Eclim ..."
    mkdir -p "${NEOVIM_STUDIO_DIR}/eclim/"; check
    if [ "$ARCHITECTURE" == "64" ]; then
        wget -O "${NEOVIM_STUDIO_DIR}/eclim/eclipse.tar.gz" http://mirror.math.princeton.edu/pub/eclipse//technology/epp/downloads/release/oxygen/R/eclipse-java-oxygen-R-linux-gtk-x86_64.tar.gz; check
    else
        wget -O "${NEOVIM_STUDIO_DIR}/eclim/eclipse.tar.gz" http://mirror.math.princeton.edu/pub/eclipse//technology/epp/downloads/release/oxygen/R/eclipse-java-oxygen-R-linux-gtk.tar.gz; check
    fi
    tar -zxf "${NEOVIM_STUDIO_DIR}/eclim/eclipse.tar.gz" -C "${NEOVIM_STUDIO_DIR}/eclim/"; check
    wget -O "${NEOVIM_STUDIO_DIR}/eclim/eclim.jar" https://github.com/ervandew/eclim/releases/download/2.7.0/eclim_2.7.0.jar; check
    java -Dvim.files=$HOME/.config/nvim -Declipse.home=$NEOVIM_STUDIO_DIR/eclim/eclipse -jar $NEOVIM_STUDIO_DIR/eclim/eclim.jar install; check
else
    log "Eclim is already installed; skipping ..."
fi



log "Appending environment variables to ${TARGET_PROFILE} ..."
# Note that this first line clears the file.
if [ "${TARGET_PROFILE}" != "${HOME}/.bashrc" ] && [ "${TARGET_PROFILE}" != "${HOME}/.profile" ]; then
    echo "if [ ! -z \"\${NEOVIM_STUDIO_PROFILE_SOURCED}\" ]; then" > "${TARGET_PROFILE}"
    echo "    return 0" >> "${TARGET_PROFILE}"
    echo 'fi' >> "${TARGET_PROFILE}"
    echo '' >> "${TARGET_PROFILE}"
fi

echo "if [ -e \"${NEOVIM_STUDIO_DIR}\" ]; then" >> "${TARGET_PROFILE}"
echo "    export NEOVIM_STUDIO_DIR=\"${NEOVIM_STUDIO_DIR}\"" >> "${TARGET_PROFILE}"
echo "    export NEOVIM_STUDIO_PROFILE_SOURCED=1" >> "${TARGET_PROFILE}"
echo 'fi' >> "${TARGET_PROFILE}"
echo '' >> "${TARGET_PROFILE}"

echo 'if [ -e "${HOME}/.cargo/bin" ]; then' >> "${TARGET_PROFILE}"
echo '    export PATH="${PATH}:${HOME}/.cargo/bin"' >> "${TARGET_PROFILE}"
echo 'fi' >> "${TARGET_PROFILE}"
echo '' >> "${TARGET_PROFILE}"

echo 'if [ -s "${HOME}/.nvm/nvm.sh" ] && [ -z "$(command -v nvm)" ]; then' >> "${TARGET_PROFILE}"
echo '    export NVM_DIR="${HOME}/.nvm"' >> "${TARGET_PROFILE}"
echo '    source "${NVM_DIR}/nvm.sh"' >> "${TARGET_PROFILE}"
echo '    source "${NVM_DIR}/bash_completion"' >> "${TARGET_PROFILE}"
echo 'fi' >> "${TARGET_PROFILE}"
echo '' >> "${TARGET_PROFILE}"

echo 'if [ -e "${HOME}/.rvm/scripts/rvm" ] && [ -z "$(command -v rvm)" ]; then' >> "${TARGET_PROFILE}"
echo '    source ${HOME}/.rvm/scripts/rvm' >> "${TARGET_PROFILE}"
echo '    export PATH=${PATH}:${HOME}/.rvm/bin' >> "${TARGET_PROFILE}"
echo 'fi' >> "${TARGET_PROFILE}"
echo '' >> "${TARGET_PROFILE}"

# With RVM, is this necessary?
echo 'if [ -e "${HOME}/.gem/ruby/2.4.0/bin" ] && [ -z "$(command -v gem)" ]; then' >> "${TARGET_PROFILE}"
echo '    export PATH="${PATH}:${HOME}/.gem/ruby/2.4.0/bin"' >> "${TARGET_PROFILE}"
echo 'fi' >> "${TARGET_PROFILE}"
echo '' >> "${TARGET_PROFILE}"

echo 'if [ -e "${HOME}/.local/bin" ]; then' >> "${TARGET_PROFILE}"
echo '    export PATH="${PATH}:${HOME}/.local/bin"' >> "${TARGET_PROFILE}"
echo 'fi' >> "${TARGET_PROFILE}"
echo '' >> "${TARGET_PROFILE}"

echo "if [ -e \"${NEOVIM_STUDIO_DIR}/go\" ]; then" >> "${TARGET_PROFILE}"
echo '    if [ -z "$GOPATH" ]; then' >> "${TARGET_PROFILE}"
echo "        export GOPATH=\"${NEOVIM_STUDIO_DIR}/go\"" >> "${TARGET_PROFILE}"
echo '    else' >> "${TARGET_PROFILE}"
echo "        export GOPATH=\"\${GOPATH}:${NEOVIM_STUDIO_DIR}/go\"" >> "${TARGET_PROFILE}" >> "${TARGET_PROFILE}"
echo '    fi' >> "${TARGET_PROFILE}"
echo "    export PATH=\"\${PATH}:${NEOVIM_STUDIO_DIR}/go/bin\"" >> "${TARGET_PROFILE}"
echo 'fi' >> "${TARGET_PROFILE}"
echo '' >> "${TARGET_PROFILE}"

echo "if [ -e \"${NEOVIM_STUDIO_DIR}/dcd/bin\" ]; then" >> "${TARGET_PROFILE}"
echo "    export PATH=\"\${PATH}:${NEOVIM_STUDIO_DIR}/dcd/bin\"" >> "${TARGET_PROFILE}"
echo 'fi' >> "${TARGET_PROFILE}"
echo '' >> "${TARGET_PROFILE}"

if [ "${TARGET_PROFILE}" != "${HOME}/.bashrc" ]; then
    echo '' >> "${HOME}/.bashrc"
    echo '# {{START_NEOVIM_STUDIO_TOKEN}}' >> "${HOME}/.bashrc"
    echo "if [ -z \"\${NEOVIM_STUDIO_PROFILE_SOURCED}\" ] && [ -e \"${TARGET_PROFILE}\" ]; then" >> "${HOME}/.bashrc"
    echo "    source \"${TARGET_PROFILE}\"" >> "${HOME}/.bashrc"
    echo 'fi' >> "${HOME}/.bashrc"
    echo '# {{END_NEOVIM_STUDIO_TOKEN}}' >> "${HOME}/.bashrc"
    echo '' >> "${HOME}/.bashrc"
fi

if [ "${TARGET_PROFILE}" != "${HOME}/.profile" ]; then
    echo '' >> "${HOME}/.profile"
    echo '# {{START_NEOVIM_STUDIO_TOKEN}}' >> "${HOME}/.profile"
    echo "if [ -z \"\${NEOVIM_STUDIO_PROFILE_SOURCED}\" ] && [ -e \"${TARGET_PROFILE}\" ]; then" >> "${HOME}/.profile"
    echo "    source \"${TARGET_PROFILE}\"" >> "${HOME}/.profile"
    echo 'fi' >> "${HOME}/.profile"
    echo '# {{END_NEOVIM_STUDIO_TOKEN}}' >> "${HOME}/.profile"
    echo '' >> "${HOME}/.profile"
fi

log "Sourcing the new environment variables ..."
source "${TARGET_PROFILE}"



log "Locating Clang ..."
libclangPath=$(ldconfig -p | grep -o -m 1 "/.\+clang.\+") # Don't check these; permissions errors.
libclangIncludes=$(find / -path "*clang/*/include" 2>/dev/null | grep -m1 "clang")

if [ ! -z "$libclangPath" ] && [ -e "$libclangPath" ] && [ ! -z "$libclangIncludes" ] && [ -e "$libclangIncludes" ]; then
    echo "let g:deoplete#sources#clang#libclang_path = '${libclangPath}'" >> "${NEOVIM_STUDIO_DIR}/includes/plugin_paths.vim"; check
    echo "let g:deoplete#sources#clang#clang_header = '${libclangIncludes}'" >> "${NEOVIM_STUDIO_DIR}/includes/plugin_paths.vim"; check
else
    error "Failed to find libclang and its includes:"
    error "libclang: ${libclangPath}"
    error "includes: ${libclangIncludes}"
    exit 1
fi

log "Linking Neovim configuration ..."
if [ ! -e "${NEOVIM_STUDIO_DIR}/init.vim" ]; then
    cp "${SCRIPT_DIR}/init.vim" "${NEOVIM_STUDIO_DIR}/init.vim"; check
    mkdir -p "${HOME}/.config/nvim/"; check
    cd "${HOME}/.config/nvim"; check
    ln -s "${NEOVIM_STUDIO_DIR}/init.vim"; check
    cd "${HOME}"; check
else
    log "A Neovim configuration was already found in ${NEOVIM_STUDIO_DIR}/init.vim; backing up and writing a new copy ..."
    mv "${NEOVIM_STUDIO_DIR}/init.vim" "${NEOVIM_STUDIO_DIR}/init.vim.bak"; check
    cp "${SCRIPT_DIR}/init.vim" "${NEOVIM_STUDIO_DIR}/init.vim"; check
    mkdir -p "${HOME}/.config/nvim/"; check
    cd "${HOME}/.config/nvim"; check
    rm "init.vim" 2>/dev/null
    ln -s "${NEOVIM_STUDIO_DIR}/init.vim"; check
    cd "${HOME}"; check
fi



log "Installing Plug ..."
if [ ! -e "${HOME}/.local/share/nvim/site/autoload/plug.vim" ]; then
    curl -fLo "${HOME}/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; check
else
    log "Plug is already installed; skipping ..."
fi



log "Installing DejaVu Sans Mono, Nerd Font Complete ..."
if [ ! -e "/usr/share/fonts/DejaVu Sans Mono Nerd Font Complete.ttf" ]; then
    mkdir -p /usr/share/fonts; check
    cd /usr/share/fonts; check
    sudo curl -fLo "DejaVu Sans Mono Nerd Font Complete.ttf" \
        https://raw.githubusercontent.com/ryanoasis/nerd-fonts/1.0.0/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.ttf; check
    fc-cache -fv; check
    cd "$HOME"; check
else
    log "Nerd Font Complete is already installed; skipping ..."
fi



# log "Updating Haskell Stack to the latest stable version ..."
# stack update; check
# stack upgrade; check



log "Installing linters from alternative package managers ..."

log "Installing from NPM ..."
# When installed with NVM, sudo is not required for global installs.
if [ ! -z "$(command -v nvm)" ]; then
    log "Using NVM's NPM ..."
    npm install -g coffeescript coffeelint csslint stylelint eslint jshint flow-remove-types flow-bin jsonlint \
    tern ember-template-lint pug-lint sass-lint typescript type-check swaglint; check
else
    log "Using system-installed NPM ..."
    sudo npm install -g coffeescript coffeelint csslint stylelint eslint jshint flow-remove-types flow-bin \
    jsonlint tern ember-template-lint pug-lint sass-lint typescript type-check swaglint; check
fi

log "Installing from Gem ..."
# TODO: Broken: haml_lint
if [ ! -z "$(command -v rvm)" ]; then
    log "Using RVM's Gem ..."
    gem install neovim foodcritic erubi mdl puppet-lint reek rubocop slim_lint --no-user-install; check
else
    log "Using system-installed RVM ..."
    sudo gem install neovim foodcritic erubi mdl puppet-lint reek rubocop slim_lint --no-user-install; check
fi

log "Installing from Pip ..."
sudo pip2 install neovim ansible-lint; check
sudo pip3 install neovim flake8; check # Flake8 should safely be used on ONE version: 3.x or 2.x
sudo pip install proselint cmakelint cython vim-vint yamllint; check

log "Installing from Go ..."
go get -v -u github.com/golang/lint/golint; check
go get -v -u github.com/alecthomas/gometalinter; check # Unstable version

# Haskell stuff sucks.
# log "Installing from Cabal ..."
# cabal update
# cabal install hlint; check

log "Installing from LuaRocks ..."
sudo luarocks install luacheck; check



# log "Building Hadolint from source ..."
# if [ ! -e "${NEOVIM_STUDIO_DIR}/hadolint/" ]; then
#     mkdir -p "${NEOVIM_STUDIO_DIR}/hadolint/"; check
#     git clone https://github.com/lukasmartinelli/hadolint "${NEOVIM_STUDIO_DIR}/hadolint/"; check
#     cd "${NEOVIM_STUDIO_DIR}/hadolint/"; check
#     stack setup; check
#     stack build; check
#     cd "$HOME"; check
# fi



log "Installing Racer ..."
cargo install racer
code="$?"
if [ "$code" -eq 101 ]; then
    log "Racer is already installed; skipping ..."
elif [ "$code" -ne 1 ]; then
    check # 1 is an OK status with Cargo.
fi

if [ ! -e "${NEOVIM_STUDIO_DIR}/rust/" ]; then
    log "Installing Rust documentation ..."
    mkdir -p "${NEOVIM_STUDIO_DIR}/rust/"; check
    git clone --depth=1 https://github.com/rust-lang/rust.git "${NEOVIM_STUDIO_DIR}/rust/"; check
fi

rustRacerPath="${HOME}/.cargo/bin/racer"
rustSourcePath="${NEOVIM_STUDIO_DIR}/rust/src/"
if [ -e "$rustRacerPath" ] && [ -e "$rustSourcePath" ]; then
    echo "let g:deoplete#sources#rust#racer_binary='${rustRacerPath}'" >> "${NEOVIM_STUDIO_DIR}/includes/plugin_paths.vim"; check
    echo "let g:deoplete#sources#rust#rust_source_path='${rustSourcePath}'" >> "${NEOVIM_STUDIO_DIR}/includes/plugin_paths.vim"; check
else
    error "Failed to find Racer and Rust source:"
    error "racer: ${rustRacerPath}"
    error "rust source: ${rustSourcePath}"
    exit 1
fi


# Having compilation issues with Mix.
if [ ! -e "${NEOVIM_STUDIO_DIR}/credo/" ]; then
    log "Building Credo from source ..."
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
    log "Building D Completion Daemon from source ..."
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



log "Installing Neovim plugins ..."
log "You may have a couple errors here -- don't mind them!"
nvim -c "PlugInstall" -c "qa"
sudo -E nvim -c "PlugInstall" -c "qa" # Some plugins require sudo privileges to install correctly.



success "Installation complete for Neovim Studio"
success "A couple of things to do before starting:"
success "1. You use a well-developed terminal emulator like Konsole for fully-functioning themes"
success "2. Set your terminal emulator's profile to use \"DejaVuSansMono Nerd Font\" or a similar Powerline font"
success "3. To use Neovim Studio in this shell, execute \`source ${TARGET_PROFILE}\`"
echo ""
success "When those are taken care of, execute \`nvim\` to begin an epic experience"



checkCount=0
checkTotal=100

check()
{
    code="$?"
    checkCount=$((checkCount+=1))
    if [ "$code" -ne 0 ]; then
        error "Aborting: previous command failed (code ${code})"
        exit 1
    fi
}

success()
{
    echo -e "${LIGHT_GREEN}=(${checkCount}/${checkTotal})=[ ${*}${CLEAR}"
}

log()
{
    echo -e "${LIGHT_BLUE}=(${checkCount}/${checkTotal})=[ ${*}${CLEAR}"
}

warn()
{
    echo -e "${YELLOW}=(${checkCount}/${checkTotal})=[ ${*}${CLEAR}"
}

error()
{
    echo -e "${RED}${BLINK}=(${checkCount}/${checkTotal})=[ ${*}${CLEAR}"
}

writeInitVimFile()
{
cat << EOF > "$NEOVIM_STUDIO_DIR/init.vim"
if &compatible
    set nocompatible
endif

set runtimepath+=$NEOVIM_STUDIO_DIR/dein/repos/github.com/Shougo/dein.vim

if dein#load_state($NEOVIM_STUDIO_DIR . '/dein/')
    call dein#begin($NEOVIM_STUDIO_DIR . '/dein/')
    call dein#add($NEOVIM_STUDIO_DIR . '/dein/')

    call dein#add('deoplete.nvim')

    source $NEOVIM_STUDIO_DIR/includes/plugins.vim
    source $NEOVIM_STUDIO_DIR/includes/custom_plugins.vim

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

source $NEOVIM_STUDIO_DIR/includes/general.vim
source $NEOVIM_STUDIO_DIR/includes/plugin_paths.vim
source $NEOVIM_STUDIO_DIR/includes/plugin_settings.vim
source $NEOVIM_STUDIO_DIR/includes/themes.vim
source $NEOVIM_STUDIO_DIR/includes/autocommands.vim
source $NEOVIM_STUDIO_DIR/includes/custom_settings.vim

"" Automatically install new plugins.
if dein#check_install()
    call dein#install()
endif
EOF
}
