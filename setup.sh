#!/bin/bash

set -euo pipefail

DOT_LOCAL="$HOME/.local"
ZSHENV="$HOME/.zshenv"
ZDOTDIR="$HOME/.config/zsh"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

STOW="--stow"
SELECT_ZSH="--select-zsh"
INSTALL_OH_MY_ZSH="--install-oh-my-zsh"
INSTALL_OH_MY_ZSH_PLUGINS="--install-oh-my-zsh-plugins"
INSTALL_POWERLEVEL10K="--install-powerlevel10k"

task="${1:-}"

usage() {
  cat <<EOF
Usage: ./setup.sh <task>

Tasks:
  $STOW
  $SELECT_ZSH
  $INSTALL_OH_MY_ZSH
  $INSTALL_OH_MY_ZSH_PLUGINS
  $INSTALL_POWERLEVEL10K
EOF
}

add_zshenv_export() {
  local name="$1"
  local value="$2"

  touch "$ZSHENV"
  if grep -qE "^export[[:space:]]+$name=" "$ZSHENV"; then
    echo "$name already exists in $ZSHENV; leaving it unchanged."
  else
    printf 'export %s=%q\n' "$name" "$value" >>"$ZSHENV"
    echo "Added $name to $ZSHENV."
  fi
}

mkdir -p "$DOT_LOCAL"

case "$task" in
"$STOW")
  stow -t "$HOME" .
  ;;
"$SELECT_ZSH")
  if command -v zsh >/dev/null 2>&1; then
    echo "zsh found; setting it as the default shell..."
    chsh -s "$(command -v zsh)"
    echo "Shell changed to zsh."
    add_zshenv_export "ZDOTDIR" "$ZDOTDIR"
  else
    echo "zsh not found; keeping current shell: ${SHELL:-unknown}"
  fi
  ;;
"$INSTALL_OH_MY_ZSH")
  echo "Create $ZSHENV first if you want this repo's zsh config to load by default."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ;;
"$INSTALL_OH_MY_ZSH_PLUGINS")
  mkdir -p "$ZSH_CUSTOM/plugins"
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  ;;
"$INSTALL_POWERLEVEL10K")
  mkdir -p "$ZSH_CUSTOM/themes"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
  ;;
"" | "-h" | "--help")
  usage
  ;;
*)
  echo "Unknown task: $task"
  usage
  exit 1
  ;;
esac
