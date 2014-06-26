# from `rbenv init -`
rbenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell|update)
    eval "`rbenv "sh-$command" "$@"`";;
  *)
    command rbenv "$command" "$@";;
  esac
}

function install_rbenv() {
  if [ ! -d $RBENV_ROOT ]; then
    git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
  fi
}

function install_rbenv_plugin_manager() {
  local plugin_name=$1
  local github_url=$2
  if [ ! -d $RBENV_ROOT/plugins/$plugin_name ]; then
    git clone $github_url $RBENV_ROOT/plugins/$plugin_name
  fi
}

install_rbenv
if [ ! -d $RBENV_ROOT/plugins ]; then mkdir $RBENV_ROOT/plugins; fi

install_rbenv_plugin_manager 'rbenv-path' 'https://github.com/taqtiqa/rbenv-path.git'
export RBENV_PLUGIN_ROOT="${RBENV_ROOT}/plugins/rbenv-path"
# plugin manager
install_rbenv_plugin_manager 'rbenv-plugin' 'https://github.com/taqtiqa/rbenv-plugin.git'

# Homebrew's 'findutils'
if ! which gfind >/dev/null 2>&1; then
  ln -fs /usr/local/bin/gfind /usr/local/bin/find
fi

# by rbenv-plugin
rbenv plugin install sstephenson:rbenv-vars
rbenv plugin install chriseppstein:rbenv-each
rbenv plugin install rkh:rbenv-update
rbenv plugin install rkh:rbenv-whatis
rbenv plugin install sstephenson:rbenv-gem-rehash
rbenv plugin install amatsuda:gem-src
rbenv plugin install tpope:rbenv-aliases
rbenv plugin install tpope:rbenv-ctags
rbenv plugin install tpope:rbenv-communal-gems
rbenv plugin install mislav:rbenv-user-gems
rbenv plugin install jf:rbenv-gemset
