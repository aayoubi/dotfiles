#!/bin/bash

git submodule init
set +e
git submodule --quiet add --force https://github.com/VundleVim/Vundle.vim.git vim/bundle/Vundle.vim
set -e
git submodule update
git submodule foreach git pull origin master --recurse-submodules

set +e
rm -i ~/.bashrc ~/.vimrc ~/.gitconfig ~/.zshrc ~/.tmux.conf
set -e

ln -s $(pwd)/bashrc ~/.bashrc
ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/gitconfig ~/.gitconfig
ln -s $(pwd)/zshrc ~/.zshrc
ln -s $(pwd)/tmux.conf ~/.tmux.conf

mkdir -p ~/.vim/colors/
cp vim/colors/wombat256mod.vim  ~/.vim/colors/
cp -pr vim/bundle  ~/.vim/

echo 'dotfiles deployed'
