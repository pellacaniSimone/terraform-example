#!/usr/bin/bash

export VIRTUAL_ENV="/root/.venv"
export PATH="$VIRTUAL_ENV/bin:$PATH" 
export JUPYTER_TOKEN="1ecb2d7fb61a3ac17e71b3ad128ae9f9e5b3a6d0f5b46ae0" # change if needed

source /root/.venv/bin/activate
jupyter-lab --port=80 --no-browser --ip=0.0.0.0 --allow-root 