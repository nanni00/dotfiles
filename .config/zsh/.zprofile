#!/bin/bash 

######################################################################################
########################## PATH env var Updates ######################################
######################################################################################

# TeX Live
PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"
export MANPATH="/usr/local/texlive/2025/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2025/texmf-dist/doc/info:$INFOPATH"

# Created by `pipx` on 2024-12-18 10:03:22
PATH="$HOME/.local/bin:$PATH"

# Created by `nanni` on 2025-04-29 21:47:32
PATH="$HOME/verapdf:$PATH"

# Created by `nanni` on 2025-04-29 22:21:45
# PATH="$PATH:/home/nanni/ghostscript/bin"

# Lua language and LuaRocks
PATH="$HOME/lua/bin:$PATH"
PATH="$HOME/luarocks/bin:$PATH"

# CTags
PATH="$HOME/.uctags/2025-08-28/usr/local/bin:$PATH"

# Rust Cargo
PATH="$HOME/.cargo:$PATH"

# Telegram
PATH="$HOME/Telegram:$PATH"

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
export NEO4J_DESKTOP_DATA_PATH="$HOME/neo4j/data"

######################################################################################
########################## Python Path Updates #######################################
######################################################################################

# custom py_datafusion lib
PYTHONPATH="$HOME/mystuff/py_datafusion/src:$PYTHONPATH"

# BLEND access
PYTHONPATH="$HOME/projects/general-data-science/BLEND:$PYTHONPATH"

# JOSIE
PYTHONPATH="$HOME/projects/general-data-science/JOSIE:$PYTHONPATH"

# My super simple CKAN client
PYTHONPATH="$HOME/projects/general-data-science/ULOD:$PYTHONPATH"

# Corrsketch
PYTHONPATH="$HOME/projects/general-data-science/correlation:$PYTHONPATH"


function check_paths() {
  TAG=$1
  PATHS=$(echo $2 | tr ":" " ")
  TMP=""

  for path in $PATHS; do
    if [ -d $path ]; then
      TMP="$TMP:$path"
    fi
  done

  TAG=$TMP
  echo "Tag $1 ==> $TAG"
}

check_paths "PATH" $PATH 
check_paths "PYTHONPATH" $PYTHONPATH

