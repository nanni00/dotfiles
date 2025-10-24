#!/bin/bash

# get the user task (if any)
task=$1

if [ $task == "--stow" ]; then
  stow -t ~ .config
fi

if [ $task == "--set-zsh" ]; then
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
fi

if [ $task == "--install-oh-my-zsh" ]; then
  # download and install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ $task == "--install-powerlevel10k" ]; then
  # download Powelevel10k (oh-my-zsh custom theme)
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

if [ $task == "--install-conda" ]; then
  # download and install miniconda
  echo "Downloading miniconda..."
  MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
  MINICONDA_ROOT="$HOME/.miniconda3"
  MINICONDA_TMP_FILE="/tmp/miniconda.sh"
  wget $MINICONDA_URL -O $MINICONDA_TMP_FILE

  echo "Installing miniconda at $MINICONDA_ROOT..."
  bash $MINICONDA_TMP_FILE -b -p $MINICONDA_ROOT
  echo "Done. Removing temporary files..."
  rm $MINICONDA_TMP_FILE

  echo "Appending conda bin to PATH..."
  export PATH="$MINICONDA_ROOT/bin:$PATH"
  source $MINICONDA_ROOT/bin/activate
  conda init --all
fi
