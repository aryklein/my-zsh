#!/bin/bash

function setup {    
    SRC_ZSHRC=https://raw.githubusercontent.com/aryklein/dotfiles/master/.zshrc
    
    if [[ -f ${HOME}/.zshrc ]]; then
        read -r -p "There is an existing ZSH config. Do you want to override it? [y/N]: " RESPONSE
        if [[ ! $RESPONSE =~ ^(y|Y|yes|Yes)$ ]]; then
            echo "No changes were made. Bye!"
            exit 0
        fi
    fi
        
    # download zshrc file (requeries wget or curl)
    echo "Downloading zsh config file..."
    if [[ -x /usr/bin/wget ]]; then 
        wget -O ${HOME}/.zshrc $SRC_ZSHRC 2>/dev/null
    elif [[ -x /usr/bin/curl ]]; then
        curl -o $HOME/.zshrc $SRC_ZSHRC  2> /dev/null
    else
        echo "This script requeries wget or curl, but it's not installed. Aborting."
        exit 1
    fi
    
    # install necesary plugins
    echo "Installing plugins..."
    mkdir ~/.zsh 2>/dev/null
    git clone --depth=1 https://github.com/woefe/git-prompt.zsh ~/.zsh/git-prompt.zsh 2>/dev/null
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions 2>/dev/null
    
    # change the login shell by ZSH
    ZSH_PATH=$(which zsh)
    if [[ $SHELL != $ZSH_PATH ]]; then
        read -r -p "Login shell is not ZSH. Do you want to set ZSH as default login shell? [Y/n]: " RESPONSE
        if [[ $RESPONSE =~ ^(y|Y|yes|)$ ]]; then
            chsh -s $(which zsh) $USER
        else
            echo "Login shell did not change."
        fi
    fi
    
    echo "Setup done."
}

function update {
    find $HOME/.zsh -maxdepth 2 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} git -C {} pull origin master
}

