# No arguments: `git status`
# With arguments: acts like `git`
compdef g=git
function g {
  if [[ $# -gt 0 ]]; then
    git "$@"
  else
    git status --short --branch
  fi
}
