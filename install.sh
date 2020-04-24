#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link_safe () {
  if [ ! -L "$2" ]; then
    ln -s "$1" "$2"
  else
    echo "$2" exist.
  fi
}

# vim
# ln -s "${BASEDIR}"/vimrc ~/.vimrc
# ln -s "${BASEDIR}"/vim/ ~/.vim

# zsh
link_safe "${BASEDIR}"/.zshrc ~/.zshrc

# git
# ln -s "${BASEDIR}"/gitconfig ~/.gitconfig
