######################################################################################
########################## PATH env var Updates ######################################
######################################################################################

# TeX Live
export PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"
export MANPATH="/usr/local/texlive/2025/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2025/texmf-dist/doc/info:$INFOPATH"

# Created by `pipx` on 2024-12-18 10:03:22
export PATH="$HOME/.local/bin:$PATH"

# Created by `nanni` on 2025-04-29 21:47:32
export PATH="$HOME/verapdf:$PATH"

# Created by `nanni` on 2025-04-29 22:21:45
# PATH="$PATH:/home/nanni/ghostscript/bin"

# Lua language and LuaRocks
export PATH="$HOME/lua/bin:$PATH"
export PATH="$HOME/luarocks/bin:$PATH"

# CTags
export PATH="$HOME/.uctags/2025-08-28/usr/local/bin:$PATH"

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



