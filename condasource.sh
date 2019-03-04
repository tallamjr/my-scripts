#!/bin/bash

function conda_auto_env() {
  if [ -e "environment.yml" ]; then
    # echo "environment.yml file found"
    # ENV=$(head -n 1 environment.yml | cut -f2 -d ' ')
    ENV=`grep 'name:' environment.yml | tail -n1 | awk '{ print $2}'`

    # Check if you are already in the environment
    if [[ $PATH != *$ENV* ]]; then
      # Check if the environment exists
      conda activate $ENV
      if [ $? -eq 0 ]; then
        :
      else
        # Create the environment and activate
        echo "Conda env '$ENV' doesn't exist."
        conda env create -q
        conda activate $ENV
      fi
    fi
  fi
}

export PROMPT_COMMAND=conda_auto_env
