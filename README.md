# dotfiles

This repository tracks the dotfiles on my personal development machines.

## Preparation

In order to prepare a fresh install to use my dotfiles, I must:

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
1. Log into Vault with my [HCP Vault](https://vault-cluster.vault.52365203-003f-492b-bd1a-546d7f153d24.aws.hashicorp.cloud:8200/ui/vault/secrets?namespace=admin) credentials.
   ```sh
   export VAULT_ADDR=https://vault-cluster.vault.52365203-003f-492b-bd1a-546d7f153d24.aws.hashicorp.cloud:8200
   export VAULT_NAMESPACE=admin
   vault login --method=userpass username=rnixon
   ```
1. Finally, apply chezmoi into the system.
   ```sh
   ./bin/chezmoi apply
   ```
1. Follow the instructions provided by the chezmoi scripts.
