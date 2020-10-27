#! /usr/bin/env bash
set -e

error() {
    printf "\033[31;1m $1 \033[0m\n"
}

warn() {
    printf "\033[33;1m $1 \033[0m\n"
}

success() {
    printf "\033[32;1m $1 \033[0m\n"
}

command_exists() {
	command -v "$@" >/dev/null 2>&1
}

darwin_setup() {
    if ! command_exists git; then
        warn 'Git not installed. Installing now...'
        brew install git || {
            error 'Git installation failed'
            exit 1
        }
        success 'Git has been installed'
    fi
    if ! command_exists nvim; then
        warn 'NeoVim not installed. Installing now...'
        brew install neovim || {
            error 'NeoVim installation failed'
            exit 1
        }
        success 'NeoVim has been installed'
    fi
    return
}

ubuntu_setup() {
    if ! command_exists git; then
        warn 'Git not installed. Installing now...'
        sudo apt-get install -y git || {
            error 'Git installation failed'
            exit 1
        }
        success 'Git has been installed'
    fi
    if ! command_exists nvim; then
        warn 'NeoVim not installed. Installing now...'
        sudo apt-get install -y neovim || {
            error 'NeoVim installation failed'
            exit 1
        }
        success 'NeoVim has been installed'
    fi
    return
}

common_setup() {
    rm -rf ~/.workspace_tmp
    mkdir -p ~/.workspace_tmp 
    git clone --depth=1 https://github.com/patmizi/workspace ~/.workspace_tmp
    rsync -av ~/.workspace_tmp/ ~/ --exclude=init.sh --exclude=.git
    # rm -rf ~/.workspace_tmp
}

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
else
    OS=$(uname -s)
    VER=$(uname -r)
fi

if [ $OS == 'Darwin' ]; then
    success 'Setting up Mac environment'
    darwin_setup
elif [ $OS == 'Ubuntu' ]; then
    success 'Setting up Ubuntu environment'
    ubuntu_setup
fi

common_setup
