#!/bin/bash

git submodule init
git submodule update

ln -s ./bashrc ~/.bashrc
ln -s ./vimrc ~/.vimrc
ln -s ./gitconfig ~/.gitconfig
ln -s ./zshrc ~/.zshrc
ln -s ./tmux.conf ~/.tmux.conf

git submodule foreach git pull origin master --recurse-submodules

