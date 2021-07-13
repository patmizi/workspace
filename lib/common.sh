#! /usr/bin/env bash

ERROR_CHECK_BINARY=106
ERROR_CHECK_PACKAGE=107

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
    $(command -v "$1" >/dev/null 2>&1) && echo 1
}

package_exists() {
    $(dpkg -l "$1" >/dev/null 2>&1) && echo 1
}

file_exists() {
    $(ls "$1" >/dev/null 2>&1) && echo 1
}

directory_exists() {
    $(ls "$1" >/dev/null 2>&1) && echo 1
}

path_contains() {
    [[ $PATH == *"$1"* ]] && echo 1
}

common_setup() {
    ls ~
    if [ ! -ds ~/.oh-my-zsh ]; then
        warn "Oh My Zsh is not installed. Installin now..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        success "Oh My Zsh installed"
    fi
    if ! command_exists sdk; then
        warn "SDKMan not installed. Installing now..."
        curl -s "https://get.sdkman.io" | bash
        success "SDKMan installed"
    fi
    if ! command_exists cargo; then
        warn "Rust is not installed. Installing now..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        success "Rust installed"
    fi
    if [ ! -f ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
        warn "zsh-autosuggestions is not installed. Installing now..."
        git clone https://github.com/zsh-users/zsh-autosuggestions \
            ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        success "zsh-autosuggestions installed"
    fi
    if ! command_exists pyenv; then
        warn "pyenv is not installed. Installing now..."
        curl https://pyenv.run | bash
        success "pyenv installed"
    fi
    if ! command_exists nvm; then
        warn "nvm is not installed. Installing now..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
        success "nvm installed"
    fi

    if ! command_exists tfswitch; then
        warn "tfswitch is not installed. Installing now..."
        curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash
        success "tfswitch installed"
    fi

    # Sync configs with remote
    rm -rf ~/.workspace_tmp
    mkdir -p ~/.workspace_tmp 
    git clone --depth=1 https://github.com/patmizi/workspace ~/.workspace_tmp
    rsync -av ~/.workspace_tmp/ ~/ --exclude=.git --exclude=README.md --exclude=lib --exclude=darwin --exclude=darwin_setup.sh --exclude=ubuntu_setup.sh --exclude=arch_setup.sh
    rm -rf ~/.workspace_tmp
}