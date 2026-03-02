# dotfiles

This repository tracks the dotfiles on my personal development machines.

## Initialization

1. Clone this repository to your local machine.
   ```sh
   git clone https://github.com/taiidani/dotfiles.git ~/.dotfiles
   ```
1. Install [Homebrew](https://brew.sh/)
1. Install Mise
   ```sh
   brew install mise
   ```
1. Run Dotter to deploy the configurations
   ```sh
   mise exec aqua:SuperCuber/dotter@latest -- dotter deploy --dry-run
   ```
