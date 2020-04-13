compdef g=git
function g {
  if [[ $# -gt 0 ]]; then
    git "$@"
  else
    git status --short --branch
  fi
}

alias sup='git push -u origin $(git symbolic-ref --short HEAD)'
