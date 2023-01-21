# dotfiles

This repository tracks the dotfiles on my personal development machines.

## Preparation

In order to prepare a fresh install to use my dotfiles, I must perform some initial setup steps before initializing Chezmoi.

### macOS

1. Install [Homebrew](https://brew.sh/)
1. Install the prerequisite recipes
   ```sh
   brew install chezmoi vault
   ```

### Linux

1. Install [chezmoi](https://github.com/twpayne/chezmoi) and initialize it.
   ```sh
   sh -c "$(curl -fsLS git.io/chezmoi)" -- init taiidani
   ```

1. Install [Vault](https://www.vaultproject.io/).
   ```sh
   curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
   sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
   sudo apt-get update && sudo apt-get install vault
   ```

## Initialization

1. Log into Vault with my [HCP Vault](https://rnd.vault.0846e66f-a975-4a88-9e46-6dc6267e9b73.aws.hashicorp.cloud:8200/ui/vault/secrets?namespace=admin) credentials.
   ```sh
   export VAULT_ADDR=https://rnd.vault.0846e66f-a975-4a88-9e46-6dc6267e9b73.aws.hashicorp.cloud:8200
   export VAULT_NAMESPACE=admin
   vault login --method=userpass username=rnixon
   ```
1. Finally, apply chezmoi into the system.
   ```sh
   chezmoi apply
   ```
1. Follow the instructions provided by the chezmoi scripts.
