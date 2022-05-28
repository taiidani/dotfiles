#! /bin/bash

if [[ ! $(asdf plugin list | grep '^nodejs$') ]]; then
    asdf plugin add nodejs
fi

if [[ ! $(asdf plugin list | grep '^golang$') ]]; then
    asdf plugin add golang
fi

if [[ ! $(asdf plugin list | grep '^terraform$') ]]; then
    asdf plugin add terraform
fi

if [[ ! $(asdf plugin list | grep '^nomad$') ]]; then
    asdf plugin add nomad
fi

if [[ ! $(asdf plugin list | grep '^consul$') ]]; then
    asdf plugin add consul
fi

if [[ ! $(asdf plugin list | grep '^vault$') ]]; then
    asdf plugin add vault
fi

if [[ ! $(asdf plugin list | grep '^waypoint$') ]]; then
    asdf plugin add waypoint
fi

if [[ ! $(asdf plugin list | grep '^packer$') ]]; then
    asdf plugin add packer
fi

asdf install
