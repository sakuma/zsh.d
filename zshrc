# -*- mode:shell-script -*-

##
# VIEW MODE

source $HOME/.zsh.d/config

##
# PATH

source $HOME/.zsh.d/paths


function cd_gem_dir {
  if [[ -z "$1" ]] ; then
    echo "gemdir expects a parameter, which should be a valid RVM Ruby selector"
  else
    cd $(rvm gemdir $1)
    pwd
  fi
}


# EDITOR
if [[ -x $( which vim ) ]]; then
    export EDITOR=vim
else
    export EDITOR=vi
fi


###
# Alias
source $HOME/.zsh.d/aliases


###
# 色関連
source $HOME/.zsh.d/color


##
# utils
source $HOME/.zsh.d/utils


##
# VSC (Git, SVN, ... more)
source $HOME/.zsh.d/vcs_conf


##
# コード補完

# 拡張用の補完パス
fpath=($HOME/.zsh.d/completions $fpath)

autoload -U compinit
compinit -u


# 文字列
export LANG=ja_JP.UTF-8
# export LANG=ja_JP.eucJP

## auto change directory
setopt auto_cd

## cd -[tab] で過去の移動したディレクトリを番号付きで表示する
setopt auto_pushd

## auto_pushdで重複するディレクトリは記録しないようにする
setopt pushd_ignore_dups

# コマンドのスペルミスを指摘して予想される正しいコマンドを提示
# このときのプロンプトはSPROMPT
setopt correct

# 補完候補を詰めて表示する設定
setopt list_packed

# aliasを補完候補に含める
setopt complete_aliases

# 補完リストが多いときに尋ねる数
# -1 : 尋ねない
#  0 : ウィンドウから溢れるときは尋ねる
LISTMAX=0
export LISTMAX

# Don't beep
setopt nolistbeep

# 補完候補一覧でファイルの種別を識別マーク表示(ls -F の記号)
setopt list_types

# 補完候補リストの日本語を正しく表示
setopt print_eight_bit

# シングルクォート内にシングルクォートを使えるようにする
setopt rc_quotes

# 補完で末尾に補われた / が自動的に 削除される
setopt auto_remove_slash

# lsコマンドの補完候補にも色付き表示
# eval `dircolors`
# zstyle ':completion:*:default' list-colors ${LS_COLORS}

# kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# 大文字・小文字を区別しないで補完出来るようにするが、大文字を入力した場合は区別する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 単語境界にならない記号
# デフォルト => '*?_-.[]~=/&;!#$%^(){}<>'
export WORDCHARS='*?[]~=&;!#$%^(){}<>'

# # 通常
# PROMPT="%/ %% "
# # 複数行
# PROMPT2="%_%% "
# # 入力ミスを確認する場合に表示されるプロンプト
# SPROMPT="%r is correct? [n,y,a,e]: "


# PROMPT, SPROMPT
case ${UID} in
0) #root
  PROMPT="[%{${fg[red]}%}%n@%m%{${reset_color}%}] %{${fg[blue]}%}#%{${reset_color}%} "
  PROMPT2="%B%{${fg[blue]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[blue]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  ;;
*)

  # PROMPT="[%n@%m] %{${fg[blue]}%}#%{${reset_color}%} "
  PROMPT2="%B%{${fg[blue]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[white]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  #RPROMPT="%{${fg[blue]}%}[%/]%{${reset_color}%}"
  ;;
esac


_update_prompt () {
    RUBY_VER=$(rvm-prompt 2&>/dev/null)

    if [[ $PROMPT_VIEW_MODE == 'client' ]]; then
        PROMPT="%{${fg[green]}%}$RUBY_VER$%{${reset_color}%} "
    else # server用
        PROMPT="%{${fg[cyan]}%}%n@%{${fg[white]}%}%m%{${fg[cyan]}%} $ %{${reset_color}%}"
    fi
    if [ ${vcs_info_msg_0_} ]; then
        if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) = "true" ]]; then
            _git_info
            _check_git_status
        fi
        RPROMPT="%{${fg[white]}%}[%~%1(v|%F{$BRANCH_COLOR}%1v%f|)%{${fg[white]}%}]%{${reset_color}%}"
    else
        RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
    fi
}

# プロンプトを再評価
# setopt prompt_subst

# カーソル位置は保持したままファ イル名一覧を順次その場で表示
# setopt always_last_prompt


precmd() {
    vcs_info 'prompt'
    _update_prompt
}

chpwd() {
    vcs_info 'prompt'
    _update_prompt
}



## Command history configuration
#
HISTFILE=$HOME/.zsh.d/history
HISTSIZE=10000
SAVEHIST=10000

# 履歴を複数端末間で共有する
setopt share_history

# 重複するコマンドが記憶されるとき、古い方を削除する
setopt hist_ignore_all_dups

# 直前のコマンドと同じ場合履歴に追加しない
setopt hist_ignore_dups

# 重複するコマンドが保存されるとき、古い方を削除する
setopt hist_save_no_dups

## Emacs Like keybind
#
bindkey -e

## Vi like
#
# bindkey -v


compinit -d $HOME/.zsh.d/.zcompdump

## historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

unsetopt extended_glob
