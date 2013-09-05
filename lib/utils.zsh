# vim: ft=zsh
# -*- mode: shell-script -*-
#
# Google による検索
function ggl() {
    if [[ $(uname) = "Darwin" ]]; then
        local str opt
        if [ $# != 0 ]; then
            for i in $*; do
                str="$str+$i"
            done
            str=`echo $str | sed 's/^¥+//'`
            opt='search?num=50&hl=ja&lr=lang_ja'
            opt="${opt}&q=${str}"
        fi
        open http://www.google.co.jp/$opt
    else
        echo "not supported"
    fi
}

# "Control-^" で parent directory へ移動
function cdup() {
    echo
    cd ..
    zle reset-prompt
}
zle -N cdup
bindkey '^\^' cdup


function ls_abbrev() {
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-aCF' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}

function get_git_status() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    # echo
    # ls or ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        echo
        git status #-sb
        echo
    fi
    zle reset-prompt
    return 0
}
zle -N get_git_status
# Ctrl+Space
bindkey '^@' get_git_status


# auto-fu.zsh
if [ -f $ZSH_PLUGIN/auto-fu.zsh/auto-fu.zsh ]; then
    source $ZSH_PLUGIN/auto-fu.zsh/auto-fu.zsh
    function zle-line-init () {
        auto-fu-init
    }
    zle -N zle-line-init
    zstyle ':completion:*' completer _oldlist _complete
    # zstyle ':auto-fu:var' postdisplay $''
    # zstyle ':auto-fu:var' disable magic-space
    zstyle ':auto-fu:var' disable all
    zstyle ':auto-fu:highlight' completion
else
  echo "Not found 'auto-fu', -> 'git submodule init; git submodule update'"
fi


# zaw.zsh
if [ -s $ZSH_PLUGIN/zaw/zaw.zsh ]; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*' recent-dirs-max 5000
  zstyle ':chpwd:*' recent-dirs-default yes
  zstyle ':completion:*' recent-dirs-insert both

  source $ZSH_PLUGIN/zaw/zaw.zsh
  zstyle ':filter-select' case-insensitive yes
  zstyle ':filter-select' rotate-list yes # enable rotation for filter-select
  # zstyle ':filter-select:highlight' matched fg=yellow,standout
  # zstyle ':filter-select' max-lines 10 # use 10 lines for filter-select
  # zstyle ':filter-select' max-lines -10 # use $LINES - 10 for filter-select
  zstyle ':filter-select' extended-search yes # see below

  bindkey '^X' zaw-cdr # Ctrl - x
  bindkey '^R' zaw-history
  bindkey '^O' zaw-open-file
else
  echo "Not found 'zaw', -> 'git submodule init; git submodule update'"
fi


