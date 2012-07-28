#!/bin/zsh

_Z_CMD=j
. `brew --prefix` /usr/local/Cellar/z/1.1/etc/profile.d/z.sh
function precmd () {
  source /usr/local/Cellar/z/1.1/etc/profile.d/z.sh
  _z --add "$(pwd -P)"
}
