#!/bin/zsh

_Z_CMD=j
_Z_DATA=~/.zsh/.z
. `brew --prefix` /opt/homebrew/Cellar/z/1.9/etc/profile.d/z.sh
function precmd () {
  source /opt/homebrew/Cellar/z/1.9/etc/profile.d/z.sh
  _z --add "$(pwd -P)"
}
