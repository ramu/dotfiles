#!/bin/zsh

_Z_CMD=j
_Z_DATA=~/.zsh/.z
. `brew --prefix` /usr/local/Cellar/z/1.9/etc/profile.d/z.sh
function precmd () {
  source /usr/local/Cellar/z/1.9/etc/profile.d/z.sh
  _z --add "$(pwd -P)"
}
