#!/bin/sh
VIMRC_HOME=~/.hydro_vimrc

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

[ -e "$VIMRC_HOME/vimrc" ] && die "$VIMRC_HOME/vimrc already exists."
[ -e "~/.vimrc" ] && die "~/.vimrc already exists."

git clone git@github.com:kwokhou/hydro-vimrc.git "$VIMRC_HOME"

cd "$VIMRC_HOME"

ln -sf `pwd`/vimrc ~/.vimrc

echo "hydro-vimrc is installed."
