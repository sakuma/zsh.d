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


# RPROMPT

# Gitのブランチ名をRPROMPTに表示する --- vcs_info(zshの組み込み関数)を使う

# vcs_infoを読み込む
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git cvs svn hg
zstyle ':vcs_info:*:prompt:*' formats "/%S:%b:%u:%c"
zstyle ':vcs_info:*' actionformats '/%S:%b|%a'
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
# zstyle ':vcs_info:*:prompt:*' unstagedstr 'u' #'¹'  # display ¹ if there are unstaged changes
# zstyle ':vcs_info:*:prompt:*' stagedstr  'c' #'²'    # display ² if there are staged changes
# zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}//" "${FMT_PATH}"
# zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}//"              "${FMT_PATH}"
# zstyle ':vcs_info:*:prompt:*' nvcsformats   ""                             "%~"



_git_info(){
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# ブランチの表示色の変更 : zsh 4.3.10 以上
_check_git_status() {
    GIT_STATUS=$( git status 2>/dev/null )
    GIT_STATUS_LINE=$( echo $GIT_STATUS | wc -l)
    current_branch=$( git branch --contains | awk '{print $2}' )
    head=$(git rev-parse HEAD)
    BRANCH_COLOR=green

    pushed="false"
    for x in $(git rev-parse --remotes); do
        if [[ $head == $x ]]; then
            pushed="true"
        fi
    done

    existes_remote_branch="false"
    for remote_branch in $( git branch -r ); do
        if [[ -n $( echo $remote_branch | grep $current_branch ) ]]; then
            existes_remote_branch="true"
        fi
    done

    if [[ $existes_remote_branch = "true" ]]; then
        if [[ $pushed = "true" ]]; then
            if [[ $GIT_STATUS_LINE = "2" ]]; then
                BRANCH_COLOR=green
            else
                BRANCH_COLOR=red
            fi
        else
            if [[ $GIT_STATUS_LINE = "4" ]]; then
                BRANCH_COLOR=yellow
            else
                BRANCH_COLOR=red
            fi
        fi
    else
        if [[ $GIT_STATUS_LINE = "2" ]]; then
            BRANCH_COLOR=cyan
        else
            BRANCH_COLOR=red
        fi
    fi
}

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

# Google による検索
function ggl() {
    local str opt
    if [ $# != 0 ]; then
            for i in $*; do
                str="$str+$i"
            done
            str=`echo $str | sed 's/^¥+//'`
            opt='search?num=50&hl=ja&lr=lang_ja'
            opt="${opt}&q=${str}"
    fi
    open http://www.google.com/$opt
}

# "Control-^" で parent directory へ移動
function cdup() {
    echo
    cd ..
    zle reset-prompt
}
zle -N cdup
bindkey '^\^' cdup

unsetopt extended_glob
