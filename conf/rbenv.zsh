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

function set_default_gems() {
  cp -f $ZSH_HOME/misc/rbenv-default-gems $RBENV_ROOT/default-gems
}

install_rbenv
if [ ! -d $RBENV_ROOT/plugins ]; then mkdir $RBENV_ROOT/plugins; fi

install_rbenv_plugin_manager 'rbenv-path' 'https://github.com/taqtiqa/rbenv-path.git'
export RBENV_PLUGIN_ROOT="${RBENV_ROOT}/plugins/rbenv-path"
# plugin manager
install_rbenv_plugin_manager 'rbenv-plugin' 'https://github.com/taqtiqa/rbenv-plugin.git'

# bin_path="$(abs_dirname "$0")"
for plugin_bin in "${RBENV_ROOT}/plugins/"*/bin; do
  bin_path="${bin_path}:${plugin_bin}"
done
export PATH="${bin_path}:${PATH}"

# Homebrew's 'findutils'
ln -fs /usr/local/bin/gfind /usr/local/bin/find

# by rbenv-plugin
rbenv plugin install sstephenson:rbenv-vars
rbenv plugin install chriseppstein:rbenv-each
rbenv plugin install rkh:rbenv-update
rbenv plugin install rkh:rbenv-whatis
rbenv plugin install rkh:rbenv-use
rbenv plugin install sstephenson:rbenv-gem-rehash
rbenv plugin install sstephenson:rbenv-default-gems
set_default_gems
rbenv plugin install tpope:rbenv-aliases
rbenv plugin install tpope:rbenv-ctags
rbenv plugin install tpope:rbenv-communal-gems
rbenv plugin install mislav:rbenv-user-gems
rbenv plugin install jf:rbenv-gemset
