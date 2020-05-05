function! StatusBranch()
  let branch = fugitive#head()
  return empty(branch) ? '' : '(' . branch . ')'
endfunction

set statusline=\ ❮\ %<%f\ %{StatusBranch()}\ %h%m%r%=\ %y\ ❯\ 

