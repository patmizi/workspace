#! /usr/bin/env bash

. $(dirname "${0}")/lib/common.sh
. $(dirname "${0}")/lib/darwin.sh

install_if_not_exists zsh
warn "Use the chsh command to change the default shell to zsh otherwise you'll be stuck with bash"
install_if_not_exists git
install_if_not_exists neovim
install_if_not_exists code 
if ! command_exists terraform-ls; then
    warn "terraform-ls not installed. Installing now..."
    brew install hashicorp/tap/terraform-ls
    success "terraform-ls has been installed"
fi
brew tap homebrew/cask-fonts
brew cask install font-jetbrains-mono-nerd-font
warn 'Custom font installed. Please set this manually otherwise devicons will not work :('

common_setup