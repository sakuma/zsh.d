# plugin - virtualenv
if [[ ! -d "${PYENV_ROOT}/plugins/pyenv-virtualenv" ]]; then
  git clone https://github.com/yyuu/pyenv-virtualenv.git $PYENV_ROOT/plugins/pyenv-virtualenv
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
