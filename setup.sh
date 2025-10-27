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
CONDA_CREATE_ENV="--conda-create-env"

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

  # specify custom installation path
  read -p "Miniconda install location (leave empty for default $MINICONDA_ROOT): " MINICONDA_INSTALL
  if [ ! -z "${MINICONDA_INSTALL}" ] && [[ "$MINICONDA_INSTALL" != "\n" ]]; then
    miniconda_custom_dirname="$(dirname $MINICONDA_INSTALL)"

    if [ -d $MINICONDA_INSTALL ]; then
      echo "Directory already exists: $MINICONDA_INSTALL"
      exit 1
    elif [ ! -d miniconda_custom_dirname ]; then
      echo "Path not valid: $miniconda_custom_dirname"
      exit 1
    else
      MINICONDA_ROOT=$MINICONDA_INSTALL
    fi
  fi

  echo "Miniconda install location: $MINICONDA_ROOT"

  exit 1
  wget $MINICONDA_URL -O $MINICONDA_TMP_FILE
  bash $MINICONDA_TMP_FILE -b -p $MINICONDA_ROOT
  echo "Done. Removing temporary files..."
  rm $MINICONDA_TMP_FILE

  echo "Appending conda bin to PATH..."
  export PATH="$MINICONDA_ROOT/bin:$PATH"
  source $MINICONDA_ROOT/bin/activate
  conda init --all
fi

if [ $task == $CONDA_CREATE_ENV ]; then
  DOTFILES_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
  CONDA_ENVS_DIR="$DOTFILES_DIR/conda-envs"

  # get the environments list
  envs=($(ls $CONDA_ENVS_DIR))
  echo "Available environment configurations in $CONDA_ENVS_DIR: "
  i=0
  for env in ${envs[@]}; do
    echo "[$i]  ${env}"
    i=$((i + 1))
  done

  read -p "YAML environment file index, name or absolute path: " CONDA_YML

  INT_REGEX="^[0-9]+$"
  if [[ $CONDA_YML =~ $INT_REGEX ]]; then
    if [ ! $CONDA_YML -lt ${#envs[@]} ]; then
      echo "Invalid index."
      exit 1
    fi

    CONDA_YML=${envs[$CONDA_YML]}
    CONDA_YML="$CONDA_ENVS_DIR/$CONDA_YML"
  elif [[ " ${envs[*]} " =~ [[:space:]]${CONDA_YML}[[:space:]] ]]; then
    CONDA_YML="$CONDA_ENVS_DIR/$CONDA_YML"
  elif [ -f $CONDA_YML ]; then
    echo
  else
    echo "Input '$CONDA_YML' not recognized as a valid index or name of available environments or absolute path."
    exit 1
  fi

  echo "Creating conda environment from YAML file $CONDA_YML..."
  conda env create --file=$CONDA_YML
fi
