#!/usr/bin/env bash
# *****************************************************************************
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Run shellcheck on each .sh files in the repo.
# If shell check does not pass on a file, exit without continuing on another
# file

# VARIABLES
# =============================================================================
# Store absolute path of script
SCRIPTPATH="$( cd "$(dirname "$0")" || exit 1; pwd -P )"

# METHODS
# =============================================================================
main()
{
  # Main method that run shellcheck on each .sh files in the repo.
  # If shell check does not pass on a file, exit without continuing on another
  # file
  # NO PARAM

  while read -r i_file
  do
    if ! shellcheck "${i_file}"
    then
      exit 1
    fi
  done <<<"$(find "${SCRIPTPATH}/../" -name "*.sh" -print)"
}

main

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
