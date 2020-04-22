# Fuzzy search git branches and checkout selected branch
#
function fb() {
  local branches branch
  branches=$(git branch -a) &&
    branch=$(echo "$branches" | fzy ) &&
    git checkout $(echo "$branch" | sed "s:.* remotes/origin/::" | sed "s:.* ::")
}
