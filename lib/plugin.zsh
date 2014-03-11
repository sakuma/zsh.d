############
# auto-fu.zsh
#

auto_fu_file_path=$ZSH_PLUGIN/auto-fu.zsh/auto-fu.zsh
if [ -f $auto_fu_file_path ]; then
  ######
  ## for generate
  ## A=$auto_fu_file_path; (zsh -c "source $A ; auto-fu-zcompile $A ~/.zsh.d")
  ##-------
  if [ -f $ZSH_HOME/auto-fu ]; then
    { . $ZSH_HOME/auto-fu; auto-fu-install; }
  else
    (zsh -c "source $auto_fu_file_path ; auto-fu-zcompile $auto_fu_file_path $ZSH_HOME")
    { . $ZSH_HOME/auto-fu; auto-fu-install; }
  fi

  zstyle ':auto-fu:highlight' input bold
  zstyle ':auto-fu:highlight' completion fg=black,bold
  zstyle ':auto-fu:highlight' completion/one fg=white,bold,underline
  zstyle ':auto-fu:var' postdisplay $'\n-azfu-'
  zstyle ':auto-fu:var' track-keymap-skip opp
  zle-line-init () {auto-fu-init;}; zle -N zle-line-init
  zle -N zle-keymap-select auto-fu-zle-keymap-select
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

#######
# notify
if [ -s $ZSH_PLUGIN/zsh-notify/notify.plugin.zsh ]; then
  source $ZSH_PLUGIN/zsh-notify/notify.plugin.zsh
fi
