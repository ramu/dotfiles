#!/bin/zsh
# vcs_info
zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

if is-at-least 4.3.10; then
   zstyle ':vcs_info:git:*' check-for-changes true
   zstyle ':vcs_info:git:*' stagedstr "+"
   zstyle ':vcs_info:git:*' unstagedstr "-"
   zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
   zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'
fi

# not pushed
function git_not_pushed() {
   if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
      head="$(git rev-parse HEAD 2>/dev/null)"
      if [[ $? -eq 0 ]]; then
         for x in $(git rev-parse --remotes)
         do
            if [ "$head" = "$x" ]; then
               return 0
            fi
         done
         echo "*NP*"
      fi
   fi
   return 0
}

