#! /usr/bin/env bash

install_if_not_exists() {
    if ! command_exists "$@"; then
        warn "$@ not installed. Installing now..."
        yes | sudo apt-get install $@ || {
            error "$@ installation failed"
            exit 1
        }
        success "$@ has been installed"
    fi
}

snap_install_if_not_exists() {
    if ! command_exists "$@"; then
        warn "$@ not installed. Installing now..."
        yes | sudo apt-get install --classic $@ || {
            error "$@ installation failed"
            exit 1
        }
        success "$@ has been installed"
    fi
}