# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt inc_append_history
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward
# Don't add certain commands to the history file.
HISTORY_IGNORE="(\&|[bf]g|c|clear|history|exit|q|pwd|* --help)"
# Ignore commands that start with spaces and duplicates.
HISTCONTROL=ignoreboth

# Fish-like syntax highlighting and autosuggestions
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Delete key acting funky and inserting a tilde?
bindkey "^[[3~" delete-char

# Make new shells get the history lines from all previous
# shells instead of the default "last window closed" history.
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

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

# Mise
eval "$(mise activate zsh)"

# GitHub
export GITHUB_TOKEN="$(gh auth token)"
export PATH="$HOME/.local/bin:$PATH"
