# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_expire_dups_first
# Don't add certain commands to the history file.
HISTORY_IGNORE="(\&|[bf]g|c|clear|history|exit|q|pwd|* --help)"

# Fish-like syntax highlighting and autosuggestions
source {{zsh_addons_path}}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source {{zsh_addons_path}}/zsh-autosuggestions/zsh-autosuggestions.zsh

# Use history substring search
source {{zsh_addons_path}}/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "\e[A" history-substring-search-up
bindkey "\e[B" history-substring-search-down

# Delete key acting funky and inserting a tilde?
bindkey "^[[3~" delete-char
bindkey "\e[H"  beginning-of-line
bindkey "\e[F"  end-of-line

setopt auto_cd
setopt correct
setopt interactive_comments

# Git integration
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
# RPROMPT='${vcs_info_msg_0_}'
# PROMPT='%# ${vcs_info_msg_0_}'
zstyle ':vcs_info:git:*' formats '%b'

# Prompt theming - should be done after the git integration
PROMPT='%F{blue}%B%~%b%f %F{green}${vcs_info_msg_0_}❯%f '

# Completion
autoload -U compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Mise
eval "$(mise activate zsh)"

# GitHub
export GITHUB_TOKEN="$(gh auth token)"
export PATH="$HOME/.local/bin:$PATH"
