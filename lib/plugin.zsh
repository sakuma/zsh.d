############
# auto-fu.zsh
#
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


############
# zaw.zsh
#
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



