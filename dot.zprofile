# vim: ft=zsh
# -*- mode:shell-script -*-

ZSH_HOME=$HOME/.zsh.d
ZDOTDIR=$ZSH_HOME
ZSH_CUSTOM_LIB=$ZSH_HOME/lib
ZSH_PLUGIN=$ZSH_HOME/plugin

source $ZSH_HOME/paths
source $ZSH_HOME/zshrc


# if [ -f ~/.zshrc ] ; then
#     source ~/.zshrc
# fi


## ログインシェルとしてzshが起動された場合
# 1 ~/.zshenv
# 2 ~/.zprofile
# 3 ~/.zshrc
# 4 ~/.zlogin

## インタラクティブシェル（ログインシェルとしてではない）としてzshが起動された場合
# 1 ~/.zshenv
# 2 ~/.zshrc

## シェルスクリプトを実行するコマンドとしてzshが起動された場合
# 1 ~/.zshenv

## ログインシェルとして起動されたzshからログアウトする場合
# 1 ~/.zlogout




### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
