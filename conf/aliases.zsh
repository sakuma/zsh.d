# vim: ft=zsh
# -*- mode:shell-script -*-

alias l="ls -lAh"
alias ls='ls -F --color=auto'
alias ll='ls -l'
alias la='ls -A'

function lsf {
    find ./ -type f -depth 1 -exec basename {} \;
}

function lsd {
    find ./ -type d -depth 1 -exec basename {} \;
}

alias sudo="sudo env PATH=$PATH"

# Macでの設定
if [[ `uname` == "Darwin" ]]; then
    alias ema='/Applications/Emacs.app/Contents/MacOS/Emacs'
    alias freemind='/Applications/FreeMind.app/Contents/MacOS/JavaApplicationStub'
    alias astah='java -Xmx256m -Xss2m -jar /Applications/astah_community/astah-community.jar'
fi

if [[ -x /Applications/Emacs.app/Contents/MacOS/bin/emacsclient ]]; then
  alias emal='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
fi

alias taif='tail -f'

alias -g M="| $PAGER"
alias -g G='| grep'
alias -g W='| wc'
alias -g H='| head'
alias -g T='| tail'

# rvm config
alias ru='rvm use'

# git
alias g='git'
alias gis='git status'
alias gil='git log'
alias gill='git pull'
alias gish='git push'
alias gic='git commit'
alias gicl='git clone'
alias gif='git fetch --prune'
alias gic='git checkout'
alias gicb='git checkout -b'

which hub > /dev/null
if [ $? = 0 ]; then
  alias git=hub
else
  echo "Not installed 'hub'"
fi

# rails2
# alias ss='ruby script/server'
# alias ssu='ruby script/server -u'
# alias sc='ruby script/console'
# alias sdb='ruby script/dbconsole'

# rails3
# alias r='rails'
alias be='bundle exec'
alias ber='bundle exec rails'
alias berk='bundle exec rake'
alias py='pry -r ./config/environment'
alias bpy='bundle exec pry -r ./config/environment'

# tscreen
if [[ -x /usr/bin/tscreen ]]; then
    alias screen='tscreen'
fi
