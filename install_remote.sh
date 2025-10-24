#!/bin/bash

# stow remote files
stow -t ~ remote
stow -t ~ common

if which zsh &>/dev/null; then
  echo "zsh found, setting as default shell..."

  # Try to change shell (works if chsh doesn't require sudo)
  if chsh -s "$(command -v zsh)" 2>/dev/null; then
    echo "✓ Shell changed to zsh"
  else
    echo "⚠ Cannot use chsh (no sudo). Adding fallback to shell rc files..."
  fi
else
  echo "zsh not found, fallback to defaulf shell $SHELL"
fi
