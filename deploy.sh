#!/bin/bash -e

git submodule init
git submodule update

ln -s ./bashrc ~/.bashrc
ln -s ./vimrc ~/.vimrc
ln -s ./gitconfig ~/.gitconfig
ln -s ./zshrc ~/.zshrc
ln -s ./tmux.conf ~/.tmux.conf

mkdir -p ~/.vim/colors/
cp vim/colors/wombat256mod.vim  ~/.vim/colors/
git submodule foreach git pull origin master --recurse-submodules

echo 'dotfiles deployed'
