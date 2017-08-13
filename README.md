# __Neovim Studio__ :black_nib:

Neovim Studio is a project that seeks to turn the tried-and-true, high-efficiency text editor into a full blown IDE that
competes with the capabilities of modern IDE's like Visual Studio without the hassle of setup and
configuration.

Neovim Studio is exclusive to Linux and currently supports Pacman, Dpkg, and RPM based distributions.

## Table of Contents

## Why?

Many of my friends were interested in trying Vim but the setup and configuration for a useful, solid environment can become
messy and stressful. I wanted an IDE that worked on almost any Linux computer, could be used on a daily basis for any given
text-editing task, and be something that I could share with my colleagues.

## Install

`./neovim-install.sh`

## Feature Comparison

| Feature | Neovim Studio | Visual Studio | XCode | IntelliJ |
| -------:|:-------------:|:-------------:|:-------:|:--------:|
| Auto-completion Support (# Languages) | 11 | 7 | 10 | 17 |
| Linting Support (# Languages)         | 50 | 7 | 10 | 17 |
| "Typical" Boot Time                   | 300ms | 80s | 5s | 5s |
| Total Installation Size               | 4.2G | 30G | 20G | 5G |

If any of these values are dishonest or unreasonable, please make a pull request. If there's something we're lacking, then
we have a goal to chase after.

## Detailed Feature List

### Notable Features

+ Project Browser
+ Function Tagging
+ Version Control Integration (Git)
+ Functions in headless and/or low-performance environments
+ Integrated Terminal
+ Supports niche/uncommon languages
+ Blazing fast load times
+ Fuzzy finder *
+ Auto-completable snippets
+ Integrated database interface *
+ Strong Regex integration
+ Lifetime supply of macros
+ Mouse discouraged
+ Backed by 9,700 + 23,600 stars on Github
+ Free as in speech _and_ lunch
+ __Highly__ configurable

### Auto-Completion Support

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

### Linting Support

Most of the linting in Neovim Studio comes from [Asynchronous Lint Engine (ALE)](https://github.com/w0rp/ale).

### Full Support

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

#### Linting Support in Progress:

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

#### Supported by ALE but _not_ by Neovim Studio:
+ FusionScript
+ Swift ([Does not support Linux _yet_](https://github.com/realm/SwiftLint/issues/732))

## Goals

+ Implement every feature provided by modern IDE's (minus the graphical interface, for now :wink:).
+ Maintain considerable speed over modern IDE's.
+ Provide significantly larger language support than modern IDE's.
+ Implement all plugins that could be considered _ubiquitous_ by pre-existing Vim/Neovim users.
+ Favor the "common case" in controls, themes, and other configurations.
+ Maintain Vim/Neovim's configurability to a reasonable extent.
+ Be easy to install so you can hit the ground running.

## Contributing

## Gallery

_\* Support needs improvement or is in the process of implementation_
