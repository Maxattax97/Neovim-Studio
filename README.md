# __Neovim Studio__

Neovim Studio is a project that seeks to turn the tried-and-true, high-efficiency text editor into a full blown IDE that
competes with (and surpasses) the capabilities of modern IDE's like Visual Studio without the hassle of setup and
configuration.

Neovim Studio is exclusive to Linux and currently supports Pacman, Dpkg, and RPM based distributions.

### Table of Contents

### Why?

Many of my friends were interested in trying Vim but the setup and configuration for a useful, solid environment can become
messy and stressful. I wanted an IDE that worked on almost any Linux computer, could be used on a daily basis for any given
text-editing task, and be something that I could share with my colleagues.

### Install

`./neovim-install.sh`

### Feature Comparison (This is a lie at the moment)

| Feature | Neovim Studio | Visual Studio | XCode | IntelliJ |
| -------:|:-------------:|:-------------:|:-------:|:--------:|
| Auto-completion Support (# Languages) | 11 | 7 | 10 | 17 |
| Linting Support (# Languages)         | 50 | 7 | 10 | 17 |
| Function tagging                      | X | X | X | X |
| Project Browser                       | X | X | X | X |
| Version Control Integration           | X |  |  | X |
| "Typical" Boot Time                   | 1s | 80s | 5s | 5s |
| Functions in Headless Environments    | X |  |  |  |
| Integrated Terminal                   | X |  | X |  |
| Total Installation Size               | 3G | 30G | 10G | 15G |
| Better in General                     | X |  |  |  |
| Needs Fixing                          | X | ~ |  |  |

If any of these values are dishonest or unreasonable, please make a pull request. If there's something we're lacking, then
we have a goal to chase after.

### Detailed Feature List

##### Languages with Auto-Completion Support
+ C
+ C++
+ Objective-C
+ Objective-C++
+ Javascript
+ Rust
+ Java *
+ Perl
+ CSS
+ HTML
+ XML

##### Linting Support
Most of the linting in Neovim Studio comes from [Asynchronous Lint Engine (ALE)](https://github.com/w0rp/ale).
+ ASM
+ Ansible
+ AsciiDoc
+ Awk
+ Bash
+ Bourne Shell
+ C
+ C++
+ C#
+ Chef
+ CoffeScript
+ CSS
+ Cython
+ D
+ Dart
+ Elixir
+ Erb
+ Fortran
+ Go
+ Handlebars
+ Haskell
+ HTML
+ Java
+ Javascript
+ JSON
+ LaTeX *
+ Lua
+ Markdown
+ Nim
+ nroff
+ Objective-C
+ Objective-C++
+ Perl
+ PHP
+ Pod
+ Pug
+ Puppet
+ Python
+ reStructuredText
+ Ruby
+ Rust
+ Slim
+ Stylus
+ SQL
+ Texinfo
+ Typescript
+ Vimscript
+ XHTML
+ XML
+ YAML
+ English (see [Proselint](https://github.com/amperser/proselint))

Languages with linting support in progress:
+ Crystal
+ Dockerfile
+ Elm
+ Erlang
+ Haml
+ Kotlin
+ MATLAB
+ Nix
+ OCaml
+ R
+ ReasonML
+ RPM Spec
+ Scala
+ Verilog

Languages that are supported by ALE but _not_ by Neovim Studio:
+ FusionScript
+ Swift ([Does not support Linux _yet_](https://github.com/realm/SwiftLint/issues/732))

_\* Support needs improvement_

### Goals

+ Implement every feature provided by modern IDE's (minus the graphical interface [for now ;)]).
+ Maintain considerable speed over modern IDE's.
+ Provide significantly larger language support than modern IDE's.
+ Implement all plugins that could be considered _ubiquitous_ by pre-existing Vim/Neovim users.
+ Favor the "common case" in controls, themes, and other configurations.
+ To be the flagship or "go-to" IDE amongst Linux users.

### Contributing

### Gallery
