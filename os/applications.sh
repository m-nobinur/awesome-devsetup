#!/bin/bash

# Get your app formulae from: https://brew.sh/
export apps=(
    anaconda            # scientific computing environment for python & R
    google-chrome       # web browser
    alacritty           # GPU-accelerated terminal emulator
    vlc                 # video player
    evernote            # note taking app
    visual-studio-code  # code editor
    telegram-desktop    # messaging app
    whatsapp            # instant messaging app
    lastpass            # password manager
    zoom                # video calling app
    google-drive        # cloud drive
    amethyst            # Automatic tiling window manager
    karabiner-elements  # Keyboard customizer
    #iterm2             # terminal emulator
    #alfred             # Application launcher and productivity software
    #virtualbox         # Hypervisor for x86 virtualization
    #mamp               # Web development solution with Apache, Nginx, PHP & MySQL
)

# Install Apps from Appstore those are not available in brew formulaes
# To get the app identifier run 'mas search AppName' on terminal
export mas_apps=(
    585829637       # Todoist: To-Do List & Tasks;
    595191960       # CopyClip: Clip-Board History;
)