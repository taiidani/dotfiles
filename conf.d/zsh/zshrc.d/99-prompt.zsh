# Git integration
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%b'

# Prompt theming - should be done after the git integration
PROMPT='%F{blue}%B%~%b%f %F{green}${vcs_info_msg_0_}❯%f '
