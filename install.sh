#!/bin/bash

DIR=$(dirname $(realpath $0))
[ -z "$DESTDIR" ] && DESTDIR="$HOME"

make_link() {
  echo "install $1"
  mkdir -p "$DESTDIR/$(dirname $1)"
  ln -nsfT "$DIR/$1" "$DESTDIR/$1"
}
echo "target directory: $DESTDIR"
make_link .vimrc
make_link .vim/colors
make_link .vim/indent
make_link .bashrc
make_link .inputrc
make_link .xprofile
make_link .config/fontconfig/fonts.conf
make_link .imwheelrc
