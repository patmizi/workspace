#! /usr/bin/env bash

rsync -av ~/.vim/ ./.vim --exclude=plugged
rsync -av ~/.emacs.d/ ./.emacs.d 
