#!/bin/bash 

######################################################################################
########################## PATH env var Updates ######################################
######################################################################################

# TeX Live
# 2025
# export PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"
# export MANPATH="/usr/local/texlive/2025/texmf-dist/doc/man:$MANPATH"
# export INFOPATH="/usr/local/texlive/2025/texmf-dist/doc/info:$INFOPATH"
# 2026
export PATH="/usr/local/texlive/2026/bin/x86_64-linux:$PATH"
export MANPATH="/usr/local/texlive/2026/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2026/texmf-dist/doc/info:$INFOPATH"
export TEXMFHOME="$HOME/texmf"

# Created by `pipx` on 2024-12-18 10:03:22
export PATH="$HOME/.local/bin:$PATH"

# Rust Cargo
export PATH="$HOME/.cargo:$PATH"

# Telegram
export PATH="$HOME/Telegram:$PATH"

# export SOLR_PATH="$HOME/Apache/solr-9.10.0"
# export PATH="$SOLR_PATH/bin:$PATH"

######################################################################################
########################## Other global Updates ######################################
######################################################################################

# Use LazyVim instead of my custom nvim super-basic setup
#
# Setup nvim has been a nice experience, but for non-advanced use cases is much better
# using a ready-to-go Neovim complete setup (also, almost all the best packages for 
# nvim have been created by folke, who is the author of LazyVim too)
export NVIM_APPNAME="lazyvim"

# Neo4j custom data path
export NEO4J_DESKTOP_DATA_PATH="$HOME/.local/neo4j/data"

export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64

# For Lucene/PyLucen-10.0.0
export JCC_JDK=/usr/lib/jvm/java-21-openjdk-amd64

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
