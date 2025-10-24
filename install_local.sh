#!/bin/bash

# Stow local and common packages
stow -t ~ local
stow -t ~ common

sudo apt install neovim git zsh tmux
