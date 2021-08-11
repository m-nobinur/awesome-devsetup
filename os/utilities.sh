#!/bin/bash

# Get your utilities formulae from: https://brew.sh/
export utils=(
    coreutils   # GNU core utilities
    git         # For version controling.
    mas         # mac appstore cli
    tree        # For tree structure file and directories.
    trash       # CLI tool that moves files or folder to the trash
    lsd         # ls with colorful output, file type icons, and more
    cmatrix     # matrix scrolling lines in the terminal
    docker      # Pack, ship and run any application as a container.
    node        # Javascript Runtime
    yarn        # JavaScript package manager
    python@3.9  # Python Interpreter
    gcc         # C++ GNU compiler
    neovim      # Vim-fork focused on extensibility and agility
    #rust       # Safe, concurrent, practical Programming languageK
    #rustup-init # Rust toolchain installer
)

# Get fonts from: https://github.com/Homebrew/homebrew-cask-fonts/tree/master/Casks
export fonts=(
    font-fira-code
    font-fira-code-nerd-font
    font-victor-mono
    font-anonymous-pro
    # font-jetbrains-mono
    # font-meslo-lg
)