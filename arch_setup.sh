#! /usr/bin/env bash

. $(dirname "${0}")/lib/common.sh
. $(dirname "${0}")/lib/arch.sh

install_if_not_exists zsh
warn "Use the chsh command to change the default shell to zsh otherwise you'll be stuck with bash"
install_if_not_exists git
install_if_not_exists neovim
install_if_not_exists code 
if ! command_exists terraform-ls; then
    warn "terraform-ls not installed. Installing now..."
    wget -q -O tfls.zip https://github.com/hashicorp/terraform-ls/releases/download/v0.16.1/terraform-ls_0.16.1_linux_amd64.zip
    sudo unzip tfls.zip -d /usr/local/bin/
    rm -f tfls.zip
    success "terraform-ls has been installed"
fi
install_if_not_exists ttf-jetbrains-mono
warn 'Custom font installed. Please set this manually otherwise devicons will not work :('

common_setup