#!/bin/bash
# *****************************************************************************
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Script to test CI in bash

# METHODS
# =============================================================================
process_computation()
{
  # Process CI on prompt version to compute time.
  # If average time greater than maximum time, exit with return code 1
  # *PARAM $1: integer, prompt version

  PROMPT_VERSION=$1
  bash -c "${PROMPT_DIR}/prompt_ci.bash"
  for ((i=0;i<${nb_run};i++))
  do
    ns=$(${PROMPT_DIR}/prompt_ci.bash | grep "ms" | grep "ns" | cut -d "=" -f 1 | sed -e "s/ns//g" )
    IFS=" " read -r -a ns <<< "${ns}"
    ns=${ns[$(( ${#ns[@]} - 1 ))]}
    ns=${ns#0}
    if [[ ${ns} -lt 0 ]]
    then
      final_nb_run=$(( final_nb_run - 1 ))
    else
      sum=$(( sum + ns ))
    fi
  done
  avg_ns=$(( sum / final_nb_run ))
  if [[ ${#avg_ns} -ne 9 ]]
  then
    nb_zero=$(( 9 - ${#avg_ns} ))
    for (( i=0;i<nb_zero;i++))
    do
      avg_ns="0${avg_ns}"
    done
  fi
  prompt_debug "average spent time for ${final_nb_run} run of precmd: "
  prompt_debug "    - ${avg_ns}ns"
  prompt_debug "    - ${avg_ns:0:6}.${avg_ns:6}μs"
  prompt_debug "    - ${avg_ns:0:3}.${avg_ns:3:6}ms"
  if [[ ${avg_ns:0:3} -ge ${max_time} ]]
  then
    if [[ -e ${common_config_bak} ]]
      then
        prompt_debug "mv ${common_config_bak} ${common_config}"
        mv ${common_config_bak} ${common_config}
    fi
    rm ${PROMPT_DIR}/prompt_ci.bash
    exit 1
  fi
}


main()
{
  # Main method to test CI on zsh
  # PARAM $1: integer, number of run to do

  # Load debug function to be able to print debug infos
  source "${PROMPT_DIR}/lib/debug.sh"
  source ~/.bashrc
  local sum=0
  local ns=0
  if [[ -n "$1" ]]
  then
      local nb_run=$1
  else
      local nb_run=100
  fi
  local final_nb_run=${nb_run}
  local max_time=1000
  local avg_ns
  local idx=0
  local prompt=""
  local prompt_array=()
  local common_config="${PROMPT_DIR}/hosts/common.sh"
  local common_config_bak="${PROMPT_DIR}/hosts/common.sh.bak"
  for i_segment in ${PROMPT_DIR}/segment/*.sh
  do
    i_segment=${i_segment##*/}
    i_segment=${i_segment/.sh/}
    prompt+="${i_segment},"
    idx=$(( idx + 1 ))
    if [[ $idx -eq 3 ]]
    then
      prompt+="hfill,"
    elif [[ $idx -eq 6 ]]
    then
      prompt=${prompt%%,}
      prompt_array+=("${prompt}")
      prompt=""
      idx=0
    fi
  done
  prompt=${prompt%%,}
  prompt_array+=("${prompt}")

  if [[ -e ${common_config} ]]
  then
    prompt_debug "mv ${common_config} ${common_config_bak}"
    mv ${common_config} ${common_config_bak}
  fi
  echo "SEGMENT=(" > ${common_config}
  for i_prompt_line in "${prompt_array[@]}"
  do
    if [[ -n ${i_prompt_line} ]]
    then
      echo "\"${i_prompt_line}\"" >> ${common_config}
    fi
  done
  echo ")" >> ${common_config}
  echo "SEGMENT_PRIORITY=(" >> ${common_config}
  for i_prompt_line in "${prompt_array[@]}"
  do
    if [[ -n ${i_prompt_line} ]]
    then
      echo "\"${i_prompt_line/hfill,/}\"" >> ${common_config}
    fi
  done
  echo ")" >> ${common_config}

  cat ${PROMPT_DIR}/prompt.sh  > ${PROMPT_DIR}/prompt_ci.bash
  echo "\
SHELL=\"/bin/bash\"
CI=true
DEBUG_MODE=\"true\"
DEBUG_LEVEL=\"TIME\"
precmd
echo -e \"\${PS1}\""  >> ${PROMPT_DIR}/prompt_ci.bash
  chmod 755 ${PROMPT_DIR}/prompt_ci.bash

  process_computation 1
  process_computation 2

  rm ${PROMPT_DIR}/prompt_ci.bash

  if [[ -e ${common_config_bak} ]]
  then
    prompt_debug "mv ${common_config_bak} ${common_config}"
    mv ${common_config_bak} ${common_config}
  fi
}

main $@

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
