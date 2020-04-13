source $ZPLUG_HOME/init.zsh

zplug rupa/z, use:z.sh
zplug mafredri/zsh-async, use:async.zsh
zplug sindresorhus/pure, use:pure.zsh, as:theme
zplug zsh-users/zsh-syntax-highlighting, defer:2
zplug zsh-users/zsh-completions, defer:3

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

for zsh_source in $HOME/.zsh/config/*.zsh; do
  source $zsh_source
done

# hub alias
eval "$(hub alias -s)"

# asdf
. /usr/local/opt/asdf/asdf.sh

