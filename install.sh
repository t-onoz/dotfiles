#!/bin/bash

DIR=$(dirname $(realpath $0))
LINKS='.vimrc .vim/colors .vim/indent .bashrc .inputrc .config/fontconfig/fonts.conf'

for i in $LINKS; do
  mkdir -p "${HOME}/$(dirname $i)"
  ln --backup=numbered -nsfT "${DIR}/$i" "$HOME/$i"
done

