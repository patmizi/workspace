#!/usr/bin/env bash

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
else
    OS=$(uname -s)
    VER=$(uname -r)
fi

echo "OS: $OS"
echo "VER: $VER"

if [[ $OS == 'Darwin' ]]; then
    echo 'Setting up Mac environment'
    darwin_setup
elif [[ $OS == 'Ubuntu' ]]; then
    echo 'Setting up Ubuntu environment'
    ubuntu_setup
elif [[ $OS == 'Manjaro Linux' ]]; then
    echo 'Setting up Manjaro environment'
    arch_setup
else
    echo 'Could not find supported operating system'
fi
