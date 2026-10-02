# dotfiles

This repository tracks the dotfiles on my personal development machines.

## Initialization

The only prerequisite is [mise](https://mise.jdx.dev/).

```sh
curl https://mise.run | sh
export PATH="$HOME/.local/bin:$PATH"

### Local Machine

Apply based on the environment (work, home, linux, etc.) that you're configuring.

```sh
mise -E linux bootstrap --adopt https://github.com/taiidani/dotfiles.git
echo 'env = ["linux", "personal"]' >> ~/.config/mise/miserc.local.toml
```

### Remote Machine

Mise supports [remote provisioning](https://mise.jdx.dev/bootstrap/remote.html). More here soon!

```sh
mise -E linux bootstrap remote
```
