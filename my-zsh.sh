#!/bin/bash

function setup {    
    SRC_ZSHRC=https://raw.githubusercontent.com/aryklein/dotfiles/master/.zshrc
    
    if [[ -f ${HOME}/.zshrc ]]; then
        read -r -p "There is an existing zsh config. Do you want to override it? [y/N]: " RESPONSE
        if [[ ! $RESPONSE =~ ^(y|Y|yes|Yes)$ ]]; then
            echo "No changes were made. Bye!"
            exit 0
        else
            mv ${HOME}/.zshrc ${HOME}/.zshrc.bak
            echo "Info: .zshrc saved as .zshrc.bak"
        fi
    fi
        
    # download zshrc file (requeries wget or curl)
    echo "Downloading zsh config file..."
    if [[ -x /usr/bin/wget ]]; then 
        wget -O ${HOME}/.zshrc $SRC_ZSHRC 2>/dev/null
    elif [[ -x /usr/bin/curl ]]; then
        curl -o $HOME/.zshrc $SRC_ZSHRC  2> /dev/null
    else
        echo "Error: This script requeries 'wget' or 'curl' to work. Aborting."
        exit 1
    fi
    
    # install necesary plugins
    echo "Installing plugins..."
    mkdir -p ~/.zsh/plugins 2>/dev/null
    git clone --depth=1 https://github.com/woefe/git-prompt.zsh ~/.zsh/plugins/git-prompt.zsh 2>/dev/null
    
    # change the login shell by ZSH
    ZSH_PATH=$(which zsh)
    if [[ $SHELL != $ZSH_PATH ]]; then
        read -r -p "Login shell is not zsh. Do you want to set zsh as default login shell? [Y/n]: " RESPONSE
        if [[ $RESPONSE =~ ^(y|Y|yes|)$ ]]; then
            chsh -s $(which zsh) $USER
        else
            echo "Login shell did not change."
        fi
    fi
    
    echo "Setup done."
    echo "Info: Consider installing 'zsh-autosuggestions' and 'zsh-completions' packages for a better experience."
}

function update {
    if find $HOME/.zsh/plugins -maxdepth 2 -name .git -type d > /dev/null; then
        find $HOME/.zsh/plugins -maxdepth 2 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} git -C {} pull origin master
    else
        echo "Error: no plugins found. Aborting."
        exit 1
    fi
}

# Do not run as root
if [[ $EUID -eq 0 ]]; then
   echo "This script must not be run as root"
   exit 1
fi

# Check if zsh is installed in the system
if ! which zsh > /dev/null 2>&1; then
    echo "Error: zsh shell is not installed."
    exit 1
fi

# main function
case $1 in
    -s|--setup) echo Setup zsh...
        setup
        ;;
    -u|--update) echo Update zsh plugins...
        update
        ;;
    *)  echo "Usage: $0 [-s|-u]"
        echo "  -s, --setup: setup zsh config and install plugins"
        echo "  -u, --update: update all zsh plugins"
        ;;
esac

