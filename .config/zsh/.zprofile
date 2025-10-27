#!/bin/bash 

######################################################################################
########################## PATH env var Updates ######################################
######################################################################################

# TeX Live
export PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"
export MANPATH="/usr/local/texlive/2025/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2025/texmf-dist/doc/info:$INFOPATH"

# Created by `pipx` on 2024-12-18 10:03:22
export PATH="$HOME/.local/bin:$PATH"

# Rust Cargo
export PATH="$HOME/.cargo:$PATH"

# Telegram
export PATH="$HOME/Telegram:$PATH"

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

######################################################################################
########################## Python Path Updates #######################################
######################################################################################

# custom py_datafusion lib
export PYTHONPATH="$HOME/mystuff/py_datafusion/src:$PYTHONPATH"

# BLEND access
export PYTHONPATH="$HOME/projects/general-data-science/BLEND:$PYTHONPATH"

# JOSIE
export PYTHONPATH="$HOME/projects/general-data-science/JOSIE:$PYTHONPATH"

# My super simple CKAN client
export PYTHONPATH="$HOME/projects/general-data-science/ULOD:$PYTHONPATH"

# Corrsketch
export PYTHONPATH="$HOME/projects/general-data-science/correlation:$PYTHONPATH"



