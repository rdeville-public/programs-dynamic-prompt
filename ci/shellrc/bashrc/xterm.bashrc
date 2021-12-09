#!/usr/bin/env bash

# VARIABLES
# =============================================================================
# Store absolute path of script
SCRIPTPATH="$( cd "$(dirname "$0")" || exit 1; pwd -P )"

# Or whereever you clone this repo
export PROMPT_DIR="${SCRIPTPATH}/dynamic-prompt"
# The prompt version you want to use, "1" or "2"
export PROMPT_VERSION="2"
# Not required, but sometimes, the shell emulator variables is not well set
export SHELL="/bin/bash"
# Not required, but you can force to ensure usage of unicode or true colors
export SHELL_APP=unknown

# Source the file that will setup the prompt computation.
source "${PROMPT_DIR}/prompt.sh"

# Explicitly tell bash to use method precmd before letting user to type command.
if ! [[ "${PROMPT_COMMAND}" =~ precmd ]]
then
  export PROMPT_COMMAND="precmd;${PROMPT_COMMAND}"
fi

