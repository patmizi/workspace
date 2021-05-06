#! /usr/bin/env bash

rsync -av ~/.vim/ ./.vim --exclude=plugged
