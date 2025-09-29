skip_global_compinit=1

# Use 1Password agent as default
export SSH_AUTH_SOCK=~/.1password/agent.sock

# export XDG_CONFIG_HOME for euporie
export XDG_CONFIG_HOME="$HOME/.config"

# export GLS_LIBRARY_DIR="$HOME/gsl"
# export LD_LIBRARY_PATH="$GLS_LIBRARY_DIR/lib:$LD_LIBRARY_PATH"

# DuckDB library for Rust 
# otherwise build+compile libduckd-rs takes a lot of time and disk
export DUCKDB_LIB_DIR=$HOME/.libduckdb
export DUCKDB_INCLUDE_DIR=$DUCKDB_LIB_DIR
export LD_LIBRARY_PATH="$DUCKDB_LIB_DIR:$LD_LIBRARY_PATH"

. "$HOME/.cargo/env"
