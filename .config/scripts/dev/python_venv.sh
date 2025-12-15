#!/usr/bin/env zsh

VENV_PATH=${HOME}/projects/python/${1}

python -m venv "${VENV_PATH}"
mkdir -p "${VENV_PATH}"/src
cd "${VENV_PATH}"/src
source ../bin/activate
nvim

