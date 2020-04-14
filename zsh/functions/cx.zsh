# Change file extensions recursively in current directory
#
# $ cx erb haml
function cx() {
  foreach f (**/*.$1)
    mv $f $f:r.$2
  end
}

