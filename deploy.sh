#!/bin/bash

git submodule init
set +e
git submodule --quiet add --force https://github.com/VundleVim/Vundle.vim.git vim/bundle/Vundle.vim
git submodule --quiet add --force https://github.com/tmux-plugins/tpm tmux/plugins/tpm
set -e
git submodule update
git submodule foreach git pull origin master --recurse-submodules

ln -fs $(pwd)/bashrc ~/.bashrc
ln -fs $(pwd)/vimrc ~/.vimrc
ln -fs $(pwd)/gitconfig ~/.gitconfig
ln -fs $(pwd)/zshrc ~/.zshrc
ln -fs $(pwd)/tmux.conf ~/.tmux.conf

mkdir -p ~/.vim ~/.tmux
rsync -a vim/ ~/.vim
rsync -a tmux/ ~/.tmux

echo 'dotfiles deployed'
