#! /usr/bin/env bash

install_if_not_exists() {
    if ! command_exists $@; then
        warn "$@ not installed. Installing now..."
        yes | brew install $@ || {
            error "$@ installation failed"
            exit 1
        }
        success "$@ has been installed"
    fi
}