#!/usr/bin/env bash

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
    command -v "$1" >/dev/null 2>&1
}

darwin_install_if_not_exists() {
    if ! command_exists $@; then
        warn "$@ not installed. Installing now..."
        brew install $@ || {
            error "$@ installation failed"
            exit 1
        }
        success "$@ has been installed"
    fi
}

ubuntu_install_if_not_exists() {
    if ! command_exists "$@"; then
        warn "$@ not installed. Installing now..."
        sudo apt-get install -y $@ || {
            error "$@ installation failed"
            exit 1
        }
        success "$@ has been installed"
    fi
}

arch_install_if_not_exists() {
    if ! command_exists "$@"; then
        warn "$@ not installed. Installing now..."
        sudo pacman -S --noconfirm $@ || {
            error "$@ installation failed"  
            exit 1
        }
        success "$@ has been installed"
    fi
}

darwin_setup() {
    darwin_install_if_not_exists git
    darwin_install_if_not_exists neovim
    darwin_install_if_not_exists hashicorp/tap/terraform-ls
	  brew tap homebrew/cask-fonts
	  brew cask install font-jetbrains-mono-nerd-font
	  warn 'Custom font installed. Please set this manually otherwise devicons will not work :('
}

ubuntu_setup() {
    ubuntu_install_if_not_exists git
    ubuntu_install_if_not_exists neovim
    if ! command_exists terraform-ls; then
        warn "terraform-ls not installed. Installing now..."
        wget -q -O tfls.zip https://github.com/hashicorp/terraform-ls/releases/download/v0.8.0/terraform-ls_0.8.0_linux_amd64.zip
        sudo unzip tfls.zip -d /usr/local/bin/
        rm -f tfls.zip
        success "terraform-ls has been installed"
    fi
    mkdir -p ~/.local/share/fonts
    pushd ~/.local/share/fonts
        warn 'JetBrains Mono font not installed. Installing now'
        curl -fLo "JetBrains Mono Regular Nerd Font Complete Mono.ttf" "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/JetBrainsMono/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf"
        warn 'Custom font installed. Please set this manually otherwise devicons will not work :('
    popd
}

arch_setup() {
    arch_install_if_not_exists git
    arch_install_if_not_exists neovim
    if ! command_exists terraform-ls; then
        warn "terraform-ls not installed. Installing now..."
        wget -q -O tfls.zip https://github.com/hashicorp/terraform-ls/releases/download/v0.8.0/terraform-ls_0.8.0_linux_amd64.zip
        sudo unzip tfls.zip -d /usr/local/bin/
        rm -f tfls.zip
        success "terraform-ls has been installed"
    fi
    arch_install_if_not_exists ttf-jetbrains-mono
    warn 'Custom font installed. Please set this manually otherwise devicons will not work :('
}

common_setup() {
    rm -rf ~/.workspace_tmp
    mkdir -p ~/.workspace_tmp 
    git clone --depth=1 https://github.com/patmizi/workspace ~/.workspace_tmp
    rsync -av ~/.workspace_tmp/ ~/ --exclude=init.sh --exclude=.git
    rm -rf ~/.workspace_tmp
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
}

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
else
    OS=$(uname -s)
    VER=$(uname -r)
fi

success "OS: $OS"
success "VER: $VER"

if [[ $OS == 'Darwin' ]]; then
    success 'Setting up Mac environment'
    darwin_setup
elif [[ $OS == 'Ubuntu' ]]; then
    success 'Setting up Ubuntu environment'
    ubuntu_setup
elif [[ $OS == 'Manjaro Linux' ]]; then
    success 'Setting up Manjaro environment'
    arch_setup
else
    warn 'Could not find supported operating system'
fi

common_setup
