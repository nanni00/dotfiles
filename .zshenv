skip_global_compinit=1

# Use 1Password agent as default
export SSH_AUTH_SOCK=~/.1password/agent.sock

# export XDG_CONFIG_HOME for euporie
export XDG_CONFIG_HOME="$HOME/.config"

. "$HOME/.cargo/env"
