#!/bin/zsh
# prompt
promptinit

# 実行したプロセスの消費時間が下記値を超えたら統計情報表示
REPORTTIME=3

function _update_vcs_info_msg() {
  psvar=();
  LANG=en_US.UTF-8 vcs_info;
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_";
  psvar[2]=$(git_not_pushed);
}
add-zsh-hook precmd _update_vcs_info_msg

# set prompt
case ${UID} in
0)
  PROMPT='[%n@%m %~]${WINDOW:+"[$WINDOW]"}%# '
  PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  ;;
*)
  [ -n "$TMUX" ] &&
     PROMPT='%{${fg[blue]}%}$(tmux display -p "[#I-#P]")${reset_color}'
  PROMPT="${PROMPT}${WINDOW:+[$WINDOW]}[$RED%n@%m$GREEN:%~%{$reset_color%}]%#
%(?.%{$fg[yellow]%}.%{$fg[blue]%})%(?!(*'-') <!(*;-;%)? <)%{${reset_color}%} "
  PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
  SPROMPT="%{$fg[red]%}%{$suggest%}(*'~'%)? < もしかして %B%r%b %{$fg[red]%}かな?[n,y,a,e]:%{${reset_color}%} "
  RPROMPT="%1(v|%F{green}%1v%f|) %2(v|%F{red}%2v%f|)"
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
    PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
  ;;
esac
RPROMPT='$(kube_ps1) '$RPROMPT

