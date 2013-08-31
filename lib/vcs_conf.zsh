# vim: ft=zsh
# -*- mode: shell-script -*-

# Gitのブランチ名をRPROMPTに表示する --- vcs_info(zshの組み込み関数)を使う

# vcs_infoを読み込む
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git cvs svn hg bzr
zstyle ':vcs_info:*:prompt:*' formats "/%S:%b:%u:%c"
zstyle ':vcs_info:*' actionformats '/%S:%b|%a'
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
# zstyle ':vcs_info:*:prompt:*' unstagedstr 'u' #'¹'  # display ¹ if there are unstaged changes
# zstyle ':vcs_info:*:prompt:*' stagedstr  'c' #'²'    # display ² if there are staged changes
# zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}//" "${FMT_PATH}"
# zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}//"              "${FMT_PATH}"
# zstyle ':vcs_info:*:prompt:*' nvcsformats   ""                             "%~"



_vcs_info(){
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# ブランチの表示色の変更 : zsh 4.3.10 以上
_check_git_status() {
  local GIT_STATUS=''
  local MODIFIED=''
  local UNTRACKED=''
  GIT_STATUS=$(git status -s)
  MODIFIED=$( echo $GIT_STATUS | egrep "^\s?[MA]" | wc -l )
  UNTRACKED=$( echo $GIT_STATUS | egrep "^\?" | wc -l )
  if [ $MODIFIED -eq 0 ]; then
    BRANCH_COLOR=green
  else
    BRANCH_COLOR=red
  fi
  if [ $MODIFIED -eq 0 ] && [ $UNTRACKED -gt 0 ]; then
    BRANCH_COLOR=yellow
  fi
}

git_remote_status() {
  remote=${$(command git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name 2>/dev/null)/refs\/remotes\/}
  if [[ -n ${remote} ]] ; then
    ahead=$(command git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
    behind=$(command git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)

    if [ $ahead -eq 0 ] && [ $behind -gt 0 ]; then
      echo "<->"
    elif [ $ahead -gt 0 ] && [ $behind -eq 0 ]; then
      echo "<+>"
    elif [ $ahead -gt 0 ] && [ $behind -gt 0 ]; then
      echo "<*>"
    fi
  fi
}
