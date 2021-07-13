#! /usr/bin/env bash

. $(dirname "${0}")/lib/common.sh

install_if_not_exists() {
    if ! does_binary_exist $@; then
        warn "$@ not installed. Installing now..."
        yes | brew install $@ || {
            error "$@ installation failed"
            exit 1
        }
        success "$@ has been installed"
    fi
}