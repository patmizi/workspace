#! /usr/bin/env bash

. $(dirname "${0}")/lib/common.sh
. $(dirname "${0}")/lib/ubuntu.sh

install_if_not_exists zsh
warn "Use the chsh command to change the default shell to zsh otherwise you'll be stuck with bash"
install_if_not_exists git
install_if_not_exists neovim
snap_install_if_not_exists code 
if ! command_exists terraform-ls; then
    warn "terraform-ls not installed. Installing now..."
    wget -q -O tfls.zip https://github.com/hashicorp/terraform-ls/releases/download/v0.16.1/terraform-ls_0.16.1_linux_amd64.zip
    sudo unzip tfls.zip -d /usr/local/bin/
    rm -f tfls.zip
    success "terraform-ls has been installed"
fi
mkdir -p ~/.local/share/fonts
pushd ~/.local/share/fonts
    warn 'JetBrains Mono font not installed. Installing now'
    curl -fLo "JetBrains Mono Regular Nerd Font Complete Mono.ttf" \
            "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf"
    warn 'Custom font installed. Please set this manually in terminal settings otherwise devicons will not work :('
popd

common_setup