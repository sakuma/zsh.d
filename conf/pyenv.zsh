# plugins

# virtualenv
if [[ ! -d "${PYENV_ROOT}/plugins/pyenv-virtualenv" ]]; then
  git clone https://github.com/yyuu/pyenv-virtualenv.git $PYENV_ROOT/plugins/pyenv-virtualenv
fi
# update
if [[ ! -d "${PYENV_ROOT}/plugins/pyenv-update" ]]; then
  git clone https://github.com/yyuu/pyenv-update.git $PYENV_ROOT/plugins/pyenv-update
fi
# pip-rehash
if [[ ! -d "${PYENV_ROOT}/plugins/pyenv-pip-rehash " ]]; then
  git clone https://github.com/yyuu/pyenv-pip-rehash.git $PYENV_ROOT/plugins/pyenv-pip-rehash
fi

# from `pyenv init -`
pyenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  activate|deactivate|rehash|shell)
    eval "`pyenv "sh-$command" "$@"`";;
  *)
    command pyenv "$command" "$@";;
  esac
}
# source '/Users/nao/.pyenv/libexec/../completions/pyenv.zsh'
