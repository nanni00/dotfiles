#!/bin/bash

ZSHENV="$HOME/.zshenv"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom/"

# available tasks
STOW="--stow"
DEFINE_DATADIR="--define-data-directory"
SELECT_ZSH="--select-zsh"
INSTALL_OH_MY_ZSH="--install-oh-my-zsh"
INSTALL_OH_MY_ZSH_PLUGINS="--install-oh-my-zsh-plugins"
INSTALL_POWERLEVEL10K="--install-powerlevel10k"
INSTALL_CONDA="--install-conda"

# get the user task (if any)
task=$1

if [ $task == $STOW ]; then
  stow -t ~ .
fi

if [ $task == $DEFINE_DATADIR ]; then
  read -p "Define absolute path to main data directory: " DATADIR
  echo "DATADIR=$DATADIR"

  if [ ! -d $DATADIR ]; then
    echo "Path $DATADIR is not a directory."
  else
    echo "Valid path. Appending it to .zshenv (old DATADIR will not be overridden if any)."
    echo "export DATADIR=$DATADIR" >>$ZSHENV
  fi
fi

if [ $task == $SELECT_ZSH ]; then
  if which zsh &>/dev/null; then
    echo "zsh found, setting as default shell..."

    # Try to change shell (works if chsh doesn't require sudo)
    chsh -s "$(command -v zsh)"
    echo "Shell changed to zsh"

    if [ ! -f $ZSHENV ]; then
      echo "export ZDOTDIR=$HOME/.config/zsh" >>$ZSHENV
    else
      if ! grep -qF 'export ZDOTDIR="$HOME/.config/zsh"' "$ZSHENV"; then
        echo "export ZDOTDIR=$ZSHENV" >>"$ZSHENV"
        echo "Added ZDOTDIR to .zshenv"
      fi
    fi
  else
    echo "zsh not found, fallback to defaulf shell $SHELL"
  fi
fi

if [ $task == $INSTALL_OH_MY_ZSH ]; then
  echo "You have to manually create the .zshenv file to use the default conf provided by this setup."

  # download and install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ $task == $INSTALL_OH_MY_ZSH_PLUGINS ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

if [ $task == $INSTALL_POWERLEVEL10K ]; then
  # download Powelevel10k (oh-my-zsh custom theme)
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

if [ $task == $INSTALL_CONDA ]; then
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
