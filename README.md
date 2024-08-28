# dotfiles

This repository tracks the dotfiles on my HashiCorp workstation.

## Initialization

1. Install [Homebrew](https://brew.sh/)
1. Install the Brew recipes, which include `chezmoi` and `mise` for both Linux and macOS.
   ```sh
   brew bundle install --file "Brewfile.$(uname)"
   ```
1. Install the `mise` tooling.
   ```sh
   mise install
   eval "$(mise activate zsh)"
   ```
1. Initialize `chezmoi`.
   ```sh
   chezmoi init taiidani
   ```

1. Finally, apply chezmoi into the system.

   ```sh
   chezmoi apply
   ```

1. Follow the instructions provided by the chezmoi scripts.
