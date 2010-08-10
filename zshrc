# -*- mode:shell-script -*-

### PATH
export PATH=/usr/local/bin:$PATH
# Ports用
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# export PATH=/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH

# java
# export JAVA_HOME=/usr

### clojure

export CLOJURE_EXT=~/.clojure
PATH=$PATH:/opt/local/share/java/clojure-contrib/launchers/bash
alias clj=clj-env-dir

# jruby
# export PATH=/Users/nao/workspace/ruby/jruby/jruby-source/bin:$PATH
# export JRUBY_HOME=/Users/nao/workspace/ruby/jruby/jruby-source

# export GEM_PATH=/opt/local/lib/ruby/gems/1.8/gems

# rvm (Ruby Version Manager)
if [[ -s /Users/nao/.rvm/scripts/rvm ]] ; then source /Users/nao/.rvm/scripts/rvm ; fi

# function gemdir {
#   if [[ -z "$1" ]] ; then
#     echo "gemdir expects a parameter, which should be a valid RVM Ruby selector"
#   else
#     rvm "$1"
#     cd $(rvm gemdir)
#     pwd
#   fi
# }

function cd_gem_dir {
  if [[ -z "$1" ]] ; then
    echo "gemdir expects a parameter, which should be a valid RVM Ruby selector"
  else
    cd $(rvm gemdir $1)
    pwd
  fi
}

# function rvm_use {
#     if [ -z "$1" ]; then
#         echo "Ruby interpreter expects a parameter, which should be a valid RVM Ruby selector"
#         echo "ex) % ru jruby"
#     elif rvm use $1 ;then
#         RUBY_VER=$(~/.rvm/bin/rvm-prompt)
#     else
#         echo "or 'rvm list' "
#     fi
# }


export EDITOR=vim

# Short Cuts
alias ls='ls -GF'
alias ll='ls -l'
alias la='ls -A'
# same -> % gemdir system
alias cdg='cd /opt/local/lib/ruby/gems/1.8/gems; pwd'
# alias cdg=cd_gem_dir
# alias cdg19='cd /opt/local/lib/ruby1.9/gems/1.9.1/gems; pwd'
alias ema='/Applications/Emacs.app/Contents/MacOS/Emacs'
alias emal='emacsclient'
alias freemind='/Applications/FreeMind.app/Contents/MacOS/JavaApplicationStub'
alias astah='java -Xmx256m -Xss2m -jar /Applications/astah_community/astah-community.jar'
alias taif='tail -f'

alias -g M="| $PAGER"
alias -g G='| grep'
alias -g W='| wc'
alias -g H='| head'
alias -g T='| tail'

# rvm config
alias ru='rvm use'

# grep config
export GREP_COLOR='1;37' # 白
export GREP_OPTIONS='--color=auto'
# パイプでも表示するが Git表示でおかしくなる
# export GREP_OPTIONS='--color=always'

# alias grep='grep --colour'
# 環境変数 GREP_COLORに ANSIエスケープシーケンスで定義される色指定を
# 置くことにより、任意の色でカラー出力できます。

# 色指定の例:
#     Black       0;30     Dark Gray     1;30
#     Blue        0;34     Light Blue    1;34
#     Green       0;32     Light Green   1;32
#     Cyan        0;36     Light Cyan    1;36
#     Red         0;31     Light Red     1;31
#     Purple      0;35     Light Purple  1;35
#     Brown       0;33     Yellow        1;33
#     Light Gray  0;37     White         1;37

# セミコロンの前の0は通常輝度を指示し、1は高輝度を指示します。
# 3xの代わりに4xと指定すると反転表示の指示です。たとえば
#   set GREP_COLOR=1;41;37
# のようにすると、マッチした部分を赤い背景に白い文字で表示します。


# git
alias gis='git status'
alias gil='git log'
# rails
alias ss='./script/server'
alias ssu='./script/server -u'
alias sc='./script/console'




##############################################
###
#     Programing Language

# Scheme
SCHEME_LIBRARY_PATH="/usr/local/lib/slib/"
export SCHEME_LIBRARY_PATH

export CLASSPATH=/opt/local/share/java/clojure/lib/clojure.jar:/opt/local/share/java/clojure/lib/clojure-contrib.jar

## Ruby
# Gems
# export PATH=$HOME/.gem/ruby/1.8/bin:$PATH
#export PATH=/Library/Ruby/Gems/1.8/gems/ZenTest-4.2.1/bin:$PATH
# export GEM_HOME=$HOME/.gem/ruby/1.8

### require 'rubygems' を省略できる
# export RUBYOPT=rubygems

#export RUBYLIB=/opt/local/lib/ruby/gems/1.8/gems/ruby-graphviz-0.9.0/lib/:$RUBYLIB
#export RUBYPATH=/opt/local/lib/ruby/gems/1.8/gems:$RUBYPATH
#export RUBYPATH=/opt/local/lib/ruby/vendor_ruby/1.8
#/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/gems/1.8/gems:$PATH







# コード補完
autoload -U compinit
compinit -u

zstyle ':completion:*' list-colors 'di=36' 'ln=35'
zstyle ':completion:*:default' menu select=1
export LSCOLORS=gxfxcbdxbxegedabagacad
    # position: 1   5    0    5    0

    # * 01: ディレクトリ前景色
    # * 02: ディレクトリ背景色
    # * 03: シンボリックリンク前景色
    # * 04: シンボリックリンク背景色
    # * 05: ソケットファイル前景色
    # * 06: ソケットファイル背景色
    # * 07: FIFOファイル前景色
    # * 08: FIFOファイル背景色
    # * 09: 実行ファイル前景色
    # * 10: 実行ファイル背景色
    # * 11: ブロックスペシャルファイル前景色
    # * 12: ブロックスペシャルファイル背景色
    # * 13: キャラクタスペシャルファイル前景色
    # * 14: キャラクタスペシャルファイル背景色
    # * 15: setuidつき実行ファイル前景色
    # * 16: setuidつき実行ファイル背景色
    # * 17: setgidつき実行ファイル前景色
    # * 18: setgidつき実行ファイル背景色
    # * 19: スティッキビットありother書き込み権限つきディレクトリ前景色
    # * 20: スティッキビットありother書き込み権限つきディレクトリ背景色
    # * 21: スティッキビットなしother書き込み権限つきディレクトリ前景色
    # * 22: スティッキビットなしother書き込み権限つきディレクトリ背景色

    # * a: 黒
    # * b: 赤
    # * c: 緑
    # * d: 茶
    # * e: 青
    # * f: マゼンタ
    # * g: シアン
    # * h: 白
    # * A: 黒(太字)
    # * B: 赤(太字)
    # * C: 緑(太字)
    # * D: 茶(太字)
    # * E: 青(太字)
    # * F: マゼンタ(太字)
    # * G: シアン(太字)
    # * H: 白(太字)
    # * x: デフォルト色


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


# lsコマンドの補完候補にも色付き表示
# eval `dircolors`
# zstyle ':completion:*:default' list-colors ${LS_COLORS}

# kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# 大文字・小文字を区別しないで補完出来るようにするが、大文字を入力した場合は区別する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'



# # 通常
# PROMPT="%/ %% "
# # 複数行
# PROMPT2="%_%% "
# # 入力ミスを確認する場合に表示されるプロンプト
# SPROMPT="%r is correct? [n,y,a,e]: "

# set prompt
#
autoload colors
colors

# color

# red
# blue
# green
# cyan
# yellow
# white
# black

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

# ## zstyle ':vcs_info:*' formats '%S:%r-%b'
zstyle ':vcs_info:*' formats "/%S:%b"
zstyle ':vcs_info:*' actionformats '/%S:%b|%a'
# zstyle ':vcs_info:*' enable git cvs svn
# zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
# zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '

# zstyle ':vcs_info:*:prompt:*' formats "/%S:%b:%u:%c"
# zstyle ':vcs_info:*:prompt:*' actionformats '/%S:%b:%u:%c|%a'
# # zstyle ':vcs_info:*' enable git cvs svn
# # zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
# # zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
# zstyle ':vcs_info:*:prompt:*' check-for-changes true
# zstyle ':vcs_info:*:prompt:*' unstagedstr 'u' #'¹'  # display ¹ if there are unstaged changes
# zstyle ':vcs_info:*:prompt:*' stagedstr  'c'#'²'    # display ² if there are staged changes
# # zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}//" "${FMT_PATH}"
# # zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}//"              "${FMT_PATH}"
# zstyle ':vcs_info:*:prompt:*' nvcsformats   ""                             "%~"



_git_info(){
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# ブランチの表示色の変更
_check_git_status() {
    GIT_STATUS=$( git status 2>/dev/null )
    if [[ -n $( echo $GIT_STATUS | grep "^nothing to commit (working directory clean)$" ) ]] ;then
        # on "zsh 4.3.10"
        # GIT_LINE=$( echo $GIT_STATUS | wc -l)
        GIT_LINE=$( echo $GIT_STATUS | wc -l | cut -c 8 )
        if [[ $GIT_LINE == "2" ]]; then
             # ワーキングディレクトリがcleanな状態
            BRANCH_CLOR=green
        else
             # cleanだが、pushしてない or remoteとの差分コミットあり
            BRANCH_CLOR=yellow
        fi
    else
        BRANCH_CLOR=red
    fi
}

_current_ruby_ver() {
    RUBY_VER=$(~/.rvm/bin/rvm-prompt)
}

_org_pwd() {
    GIT_DIR=$(pwd | xargs dirname)
}

_update_rprompt () {
    # 左プロンプトにRubyバージョン表記
    PROMPT="%{${fg[green]}%}$RUBY_VER:%#%{${reset_color}%} "
    if [ ${vcs_info_msg_0_} ]; then
        if [[ -z $( git status 2>/dev/null | grep "fatal" ) ]]; then
            _check_git_status
        fi
        RPROMPT="%{${fg[white]}%}[%~%1(v|%F{$BRANCH_CLOR}%1v%f|)%{${fg[white]}%}]%{${reset_color}%}"
    else
        RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
    fi
}

# プロンプトを再評価
# setopt prompt_subst


precmd() {
    vcs_info 'prompt'
    _current_ruby_ver
    _git_info
    _update_rprompt
}

chpwd() {
    vcs_info 'prompt'
    _current_ruby_ver
    _git_info
    _update_rprompt
}



## Command history configuration
#
HISTFILE=~/.zsh.d/history
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
