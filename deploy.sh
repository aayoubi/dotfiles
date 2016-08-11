#!/bin/bash -e

git submodule init
git submodule update

rm -i ~/.bashrc ~/.vimrc ~/.gitconfig ~/.zshrc ~/.tmux.conf

ln -s $(pwd)/bashrc ~/.bashrc
ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/gitconfig ~/.gitconfig
ln -s $(pwd)/zshrc ~/.zshrc
ln -s $(pwd)/tmux.conf ~/.tmux.conf

mkdir -p ~/.vim/colors/
cp vim/colors/wombat256mod.vim  ~/.vim/colors/
git submodule foreach git pull origin master --recurse-submodules

echo 'dotfiles deployed'
