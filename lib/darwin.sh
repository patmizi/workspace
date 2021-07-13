#! /usr/bin/env bash

. $(dirname "${0}")/lib/common.sh

install_if_not_exists() {
    _does_command_exist=$(command_exists "$@")
    status_code=$?
    if [ $status_code -ne 0 ]; then
        _does_package_exist=$(package_exists "$@")
        status_code=$?
        if [ $status_code -ne 0 ]; then
            warn "$@ not installed. Installing now..."
            yes | brew install $@ || {
                error "$@ installation failed"
                exit 1
            }
            success "$@ has been installed"
        fi
    fi
}