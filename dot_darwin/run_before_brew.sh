#! /bin/bash
#
# iOS App Store additions
# DaisyDisk
# GIPHY Capture
# Magnet
# Pixelmator Pro
# Pocket
# Reeder
# Spark

echo "Running brew bundle"
brew bundle --no-lock --file=/dev/stdin <<EOF
tap 'espanso/espanso'

brew 'asdf'
brew 'gh'
brew 'watch'

cask '1password'
cask 'discord'
cask 'docker'
cask 'dropbox'
cask 'espanso'
cask 'fantastical'
cask 'firefox'
cask 'iterm2'
cask 'paw'
cask 'redisinsight'
cask 'signal'
cask 'skitch'
cask 'slack'
cask 'transmit'
cask 'visual-studio-code'
cask 'zoom'

# https://github.com/GitCredentialManager/git-credential-manager
tap 'microsoft/git'
cask 'git-credential-manager-core'
EOF
echo "Brew bundle complete"
