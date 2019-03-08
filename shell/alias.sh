# Simpler cd.
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias wd="cd ~/Sites"

alias ls="lsd -a --color=never --date=relative --icon=never"
alias l="ls -la"

alias c="clear"
alias v="nvim"
alias oo="open ."

alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# remove those damn DS_Store files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Quickly show and hide hidden files
alias show='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hide='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# Lock current session and proceed to the login screen.
alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

# Set upstream
alias sup='git push -u origin $(git symbolic-ref --short HEAD)'
