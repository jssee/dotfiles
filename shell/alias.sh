# Simpler cd.
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# remove those damn DS_Store files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Quickly show and hide hidden files
alias show='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hide='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# Lock current session and proceed to the login screen.
alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

# Set upstream
alias sup='git push -u origin $(git symbolic-ref --short HEAD)'
