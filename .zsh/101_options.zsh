#!/bin/zsh
# set options
setopt always_last_prompt  #
setopt auto_list           #
setopt auto_menu           # 補完キー連打で順に補完候補を自動補完
setopt auto_pushd          # auto pushd command. 
setopt auto_param_keys     # 
setopt auto_param_slash    # Directory / auto
setopt auto_cd             # cd書かなくても移動できる
setopt brace_ccl           # ブレース展開機能有効
setopt correct             # auto correct
setopt cdable_vars         #
setopt complete_in_word    #
setopt complete_aliases    #
setopt extended_glob       # '#' '~' '^'
setopt extended_history    # timestamp
setopt hist_ignore_dups    #
setopt hist_ignore_space   #
setopt list_packed         # 
setopt list_types          # 補完候補一覧でファイル種別表示
setopt magic_equal_subst   #
setopt mark_dirs           # Directory / auto
setopt multios             # multi redirect/pipe
setopt no_beep             #
setopt no_list_beep        # 
setopt noflowcontrol       # no flowcontrol
setopt notify              # 
setopt nonomatch           # no "glob no match"
setopt numeric_glob_sort   # 
setopt prompt_subst        # プロンプトにescape sequence(環境変数)を通す
setopt pushd_ignore_dups   #
setopt rec_exact           #
setopt transient_rprompt   # コマンド実行後に右プロンプトを消す
