export PATH="$HOME/.bin:$PATH"
# recommended by brew doctor
export PATH="/usr/local/bin:$PATH"
source /Users/jesse/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Users/jesse/z/z.sh
fpath=( "$HOME/.zfunctions" $fpath )
autoload -U promptinit; promptinit
prompt pure

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
