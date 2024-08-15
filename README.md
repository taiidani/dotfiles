# dotfiles

This repository tracks the dotfiles on my HashiCorp workstation.

## Preparation

In order to prepare a fresh install to use my dotfiles, I must perform some initial setup steps before initializing Chezmoi.

### macOS

1. Install [Homebrew](https://brew.sh/)
1. Install the Brew recipes

   ```sh
   brew bundle install
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
