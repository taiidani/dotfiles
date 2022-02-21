#! /bin/bash

if [[ ! $(asdf plugin list | grep '^nodejs$') ]]; then
    asdf plugin add nodejs
fi

if [[ ! $(asdf plugin list | grep '^golang$') ]]; then
    asdf plugin add golang
fi

asdf install
