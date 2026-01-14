#!/bin/zsh

_Z_CMD=j
_Z_DATA=~/log/.z
. `brew --prefix` /opt/homebrew/Cellar/z/1.12/etc/profile.d/z.sh
function precmd () {
  source /opt/homebrew/Cellar/z/1.12/etc/profile.d/z.sh
  _z --add "$(pwd -P)"
}
