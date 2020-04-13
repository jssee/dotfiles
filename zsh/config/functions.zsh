# $ size dir1 file2.js
function size() {
  # du -sh "$@" 2>&1 | grep -v '^du:' | sort -nr
  du -shck "$@" | sort -rn | awk '
      function human(x) {
    s="kMGTEPYZ";
    while (x>=1000 && length(s)>1)
        {x/=1024; s=substr(s,2)}
    return int(x+0.5) substr(s,1,1)
      }
      {gsub(/^[0-9]+/, human($1)); print}'
}

# Make a directory and cd into it
function mkd() {
  mkdir -p "$@" && cd "$_";
}

function fb() {
  local branches branch
  branches=$(git branch -a) &&
    branch=$(echo "$branches" | fzy ) &&
    git checkout $(echo "$branch" | sed "s:.* remotes/origin/::" | sed "s:.* ::")
}

