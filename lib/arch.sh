#! /usr/bin/env bash

install_if_not_exists() {
    if ! command_exists "$@"; then
        warn "$@ not installed. Installing now..."
        sudo pacman -S --noconfirm $@ || {
            error "$@ installation failed"  
            exit 1
        }
        success "$@ has been installed"
    fi
}