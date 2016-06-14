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


############
# notify
#
if [ -s $ZSH_PLUGIN/zsh-notify/notify.plugin.zsh ]; then
  source $ZSH_PLUGIN/zsh-notify/notify.plugin.zsh
fi


############
# zsh syntax
#
if [ -s $ZSH_PLUGIN/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source $ZSH_PLUGIN/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

############
# direnv
#
if which direnv > /dev/null; then
   eval "$(direnv hook zsh)"
fi
