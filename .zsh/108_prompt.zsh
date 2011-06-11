#!/bin/zsh
# prompt
promptinit

# set prompt
case ${UID} in
0)
  PROMPT='[%n@%m %~]${WINDOW:+"[$WINDOW]"}%# '
  PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  ;;
*)
#  PROMPT='%{$fg[green]%}[%n@%m %~]%{$reset_color%}${WINDOW:+"[$WINDOW]"}%# '
#  PROMPT='['$RED'%n@'$GREEN'%m %~]%{$reset_color%}${WINDOW:+"[$WINDOW]"}%# '
  PROMPT='${WINDOW:+"[$WINDOW]"}['$RED'%n@%m'$GREEN':%~%{$reset_color%}]%# '
#  PROMPT=$'\n%{\e[0;32;40;1m%}%n%{\e[0m%}\n%{\e[0;37;40;1m%}$%{\e[0m%} '
  PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
  SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
  precmd() { psvar=(); LANG=en_US.UTF-8 vcs_info; [[ -n $vcs_info_msg_0_ ]] && psvar[1]="$vcs_info_msg_0_" }
  RPROMPT="%1(v|%F{green}%1v%f|)"
  #RPROMPT="%(1v.%F{green}%1v%f.)"
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
    PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
  ;;
esac


