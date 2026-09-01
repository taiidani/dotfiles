# dotfiles

This repository tracks the dotfiles on my personal development machines.

## Initialization

The only prerequisite is [mise](https://mise.jdx.dev/).

### Local Machine

Apply based on the environment (work or home) that you're configuring.

```sh
mise -E work bootstrap --from git@github.com:taiidani/dotfiles.git
```

### Remote Machine

Mise supports [remote provisioning](https://mise.jdx.dev/bootstrap/remote.html). More here soon!

```sh
mise -E linux bootstrap remote
```
