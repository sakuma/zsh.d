export ZPLUG_HOME=$HOME/.zplug
if [[ ! -d $ZPLUG_HOME ]]; then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

# export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "aws/aws-cli", use:"bin/aws_zsh_completer.sh"
zplug "djui/alias-tips"
# zplug "docker/compose", as:command, use:"contrib/completion/zsh/_docker-compose"
# zplug "docker/docker", as:command, use:"contrib/completion/zsh/_docker"
zplug "modules/directory", from:prezto
zplug "modules/git", from:prezto
zplug "modules/osx", from:prezto
# zplug "peterhurford/git-it-on.zsh"
zplug "plugins/yarn", from:oh-my-zsh
zplug "mollifier/anyframe"
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-completions"
zplug "marzocchi/zsh-notify"
zplug "zsh-users/zaw"
# zplug "zsh-users/zsh-history-substring-search", defer:3 # Should be loaded last.
zplug "zsh-users/zsh-syntax-highlighting", defer:3 # Should be loaded 2nd last.

# setopt prompt_subst # Make sure propt is able to be generated properly.
# zplug "adambiggs/zsh-theme", as:theme, use:adambiggs.zsh-theme

# zplug "zsh-users/zsh-syntax-highlighting", defer:2
# zplug "zsh-users/zsh-autosuggestions", use:"dist/autosuggestions.zsh"

# zplug load --verbose

# Check for uninstalled plugins.
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

############
# zaw.zsh
#
if [ -s $ZPLUG_REPOS/zsh-users/zaw/zaw.zsh ]; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*' recent-dirs-max 5000
  zstyle ':chpwd:*' recent-dirs-default yes
  zstyle ':completion:*' recent-dirs-insert both

  source $ZPLUG_REPOS/zsh-users/zaw/zaw.zsh
  zstyle ':filter-select' case-insensitive yes
  zstyle ':filter-select' rotate-list yes # enable rotation for filter-select
  # zstyle ':filter-select:highlight' matched fg=yellow,standout
  # zstyle ':filter-select' max-lines 10 # use 10 lines for filter-select
  # zstyle ':filter-select' max-lines -10 # use $LINES - 10 for filter-select
  zstyle ':filter-select' extended-search yes # see below

  bindkey '^X' zaw-cdr # Ctrl - x
  bindkey '^R' zaw-history
  bindkey '^O' zaw-open-file
fi

############
# zsh-autosuggestions

if [ -s $ZPLUG_REPOS/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source $ZPLUG_REPOS/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh
  # use ctrl+t to toggle autosuggestions(hopefully this wont be needed)
  # bindkey '^T' autosuggest-toggle
  # use ctrl+f to accept a suggested word
  # bindkey '^F' autosuggest-accept-suggested-word
  bindkey '^F' autosuggest-accept
fi

############
# notify
#
if [ -s $ZPLUG_REPOS/marzocchi/zsh-notify/notify.plugin.zsh ]; then
  source $ZPLUG_REPOS/marzocchi/zsh-notify/notify.plugin.zsh
fi


############
# zsh syntax
#
if [ -s $ZPLUG_REPOS/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source $ZPLUG_REPOS/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

############
# direnv
#
if which direnv > /dev/null; then
   eval "$(direnv hook zsh)"
fi
