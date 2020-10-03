source $ZPLUG_HOME/init.zsh

zplug zplug/zplug, hook-build:'zplug --self-manage'
zplug rupa/z, use:z.sh
zplug mafredri/zsh-async, use:async.zsh
zplug sindresorhus/pure, use:pure.zsh, as:theme
zplug zsh-users/zsh-syntax-highlighting, defer:2
zplug zsh-users/zsh-completions, defer:3
zplug g-plane/zsh-yarn-autocompletions, hook-build:'./zplug.zsh', defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

for function in $HOME/.zsh/functions/*.zsh; do
  source $function
done

for config in $HOME/.zsh/config/*.zsh; do
  source $config
done

# hub alias
eval "$(hub alias -s)"

# asdf
. /usr/local/opt/asdf/asdf.sh

