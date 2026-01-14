#!/bin/zsh
# source
[[ -s ~/.gvm/scripts/gvm ]] && source ~/.gvm/scripts/gvm
[[ -s ~/.zsh/modules/kube-ps1/kube-ps1.sh ]] && source ~/.zsh/modules/kube-ps1/kube-ps1.sh

[[ -s ~/.cargo/env ]] && source ~/.cargo/env

# uv (Python version/package manager)
(( $+commands[uv] )) && eval "$(uv generate-shell-completion zsh)"

