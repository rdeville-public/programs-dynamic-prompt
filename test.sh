#!/bin/bash
# *****************************************************************************
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# SHELLCHECK
# =============================================================================
# Globally disable some shellcheck warning
# shellcheck disable=SC1090,SC2155
# SC1090: Can't follow non-constant source. Use a directive to specify
#         location.
# see: https://github.com/koalaman/shellcheck/wiki/SC1090
# SC2154: openstack is referenced but not assigned.
# see: https://github.com/koalaman/shellcheck/wiki/SC2154
# SC2155: Declare and assign separately to avoid masking return values.
# see: https://github.com/koalaman/shellcheck/wiki/SC2155

# DESCRIPTION
# =============================================================================
# Script to be able to test the prompt in a docker to either prepare
# configuration for later use of to have a clean development environment

# VARIABLES
# =============================================================================
# Store absolute path of script
SCRIPTPATH="$( cd "$(dirname "$0")" || exit 1 ; pwd -P )"
# Compute size of terminal
TERMSIZE=$(tput cols)
# Compute line to show true colors
TRUE_COLORS_LINE=$(
  awk 'BEGIN{
    s="----------"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76);
        g = (colnum*510/76);
        b = (colnum*255/76);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
}')

# METHODS
# =============================================================================
usage(){
  # Manual page describing usage of script
  # NO PARAM

  echo -e "\
${E_BOLD} NAME${E_NORMAL}
    test.sh - Ask user parameter to test prompt config in docker

${E_BOLD} SYNOPSIS${E_NORMAL}
    ${E_BOLD}test.sh \
[ ${E_BOLD}-s${E_NORMAL} ${E_UNDER}shell${E_NORMAL} ] \
[ ${E_BOLD}-p${E_NORMAL} ${E_UNDER}prompt_version${E_NORMAL} ] \
[ ${E_BOLD}-a${E_NORMAL} ${E_UNDER}shell_app${E_NORMAL} ] \
[ ${E_BOLD}-d${E_NORMAL} ${E_UNDER}debug_level${E_NORMAL} ] \
[ ${E_BOLD}-b${E_NORMAL} ] \
[ ${E_BOLD}-m${E_NORMAL} ] \
[ ${E_BOLD}-h${E_NORMAL} ]

${E_BOLD} DESCRIPTION${E_NORMAL}
    ${E_BOLD}test.sh${E_NORMAL} is a script that will let you set parameters to test your
    configuration for the prompt line promposed by this repo in a docker
    environment to avoid messing with your actual prompt.

    By default, without any options, the script will pass through some
    interactive dialog boxes to ask you main parameters you want to set. But
    once you know which main parameters you want to test, which are also
    recalled before running the docker when in interactive mode, you can
    override them by passing arguments to the script.

    NOTE: Despite the fact that is a bash script, there is not order on options.

${E_BOLD} OPTIONS${E_NORMAL}

    ${E_BOLD}-s,--shell${E_NORMAL}
        The name of the shell you want to test. Possible values are :
          - ${E_BOLD}bash${E_NORMAL}
          - ${E_BOLD}zsh${E_NORMAL}

    ${E_BOLD}-p,--prompt${E_NORMAL}
        The prompt version you want to test. Possible values are :
          - ${E_BOLD}1${E_NORMAL}
          - ${E_BOLD}2${E_NORMAL}

    ${E_BOLD}-a,--app${E_NORMAL}
        The terminal emulator value you want to emulate for your test depending
        on support of unicode char and true colors of your terminal.
        Possible values are :
          - ${E_BOLD}unknown${E_NORMAL}: If your terminal emulator does not support neither unicode
            char, neither true colors
          - ${E_BOLD}xterm${E_NORMAL}: If your terminal emulator does support unicode char but does
            not support true colors
          - ${E_BOLD}st${E_NORMAL}: If your terminal emulator does support unicode char and true
            colors.

        Unicode char are special char like some emoji.
        If your terminal support unicode char, you should see a heart between
        the following single quotes: '♡ '

        True colors means your terminal emulator is able to show colors with
        values RGB from 0 to 255.
        If your terminal support true colors, then the between lines
        '======================' should show continous colors, if you only see
        char '-' or discontinous colors, this mean your terminal does not
        support true colors.
===============================================================================
|${TRUE_COLORS_LINE}|
===============================================================================

    ${E_BOLD}-d,--debug_level${E_NORMAL}
        The debug level you want to be shown. Possible values are :
          - ${E_BOLD}0${E_NORMAL}: [Default] Show only errors
          - ${E_BOLD}1${E_NORMAL}: Shown errors and time to compute the prompt
          - ${E_BOLD}2${E_NORMAL}: Shown errors, warnings and time to compute the prompt
          - ${E_BOLD}3${E_NORMAL}: Shown errors, warnings, infos and time to compute the prompt

    ${E_BOLD}-m,--mount${E_NORMAL}
        If you set all previous parameter, you can directly build and run the
        docker without the confirmation dialog.


    ${E_BOLD}-b,--build${E_NORMAL}
        If you set all previous parameter, you can directly build and run the
        docker without the confirmation dialog.

    ${E_BOLD}-h,--help${E_NORMAL}
        Print this help
  "
}


ask_shell_to_test(){
  # Ask the user which shell (bash/zsh) to test
  # NO PARAM

  local answer=""
  clear
  while [[ ${answer} -ne 1 ]] && [[ ${answer} -ne 2 ]]
  do
    echo -e "${E_INFO}\
+-----------------------------------------------------------------------------+
|     Which shell do you want to use [Default 2 (zsh)]?                       |
|         1: bash (/bin/bash)                                                 |
|         2: zsh(/bin/zsh)                                                    |
+-----------------------------------------------------------------------------+
| Press ${E_ERROR}${E_BOLD}<Ctrl+C>${E_INFO} to cancel                                                    |
+-----------------------------------------------------------------------------+
${E_NORMAL}"
    read -r -e answer
    answer=${answer:-2}
    case ${answer} in
      1)
        shell="bash"
        ;;
      2)
        shell="zsh"
        ;;
      *)
        echo -e "${E_ERROR}Please enter 1 or 2${E_NORMAL}"
        ;;
    esac
  done
}


ask_prompt_version()
{
  # Ask user which version of the prompt to test
  # NO PARAM

  local answer=""

  cat ${PROMPT_DIR}/prompt.sh  > ${PROMPT_DIR}/prompt_ci.bash
  echo "\
SHELL=\"/bin/bash\"
CI=true
DEBUG_MODE=\"true\"
precmd
echo -e \"\${PS1}\""  >> ${PROMPT_DIR}/prompt_ci.bash
  chmod 755 ${PROMPT_DIR}/prompt_ci.bash

  clear
  while [[ ${answer} -ne 1 ]] && [[ ${answer} -ne 2 ]]
  do
    echo -e "${E_INFO}\
+-----------------------------------------------------------------------------+
|     Which prompt version do you want to test [Default 2] ?                  |
|         ${E_BOLD}1: Version 1, the \"classic\" version${E_NORMAL}${E_INFO}                                 |"
OLD_SHELL=${SHELL}
SHELL="/bin/bash"
PROMPT_VERSION=1
bash -c "${PROMPT_DIR}/prompt_ci.bash"
    echo -e "${E_INFO}\
|         ${E_BOLD}2: Version 2, the \"powerline\" version${E_NORMAL}${E_INFO}                               |"
PROMPT_VERSION=2
bash -c "${PROMPT_DIR}/prompt_ci.bash"
SHELL=${OLD_SHELL}
    echo -e "${E_INFO}\
+-----------------------------------------------------------------------------+
| Press ${E_ERROR}${E_BOLD}<Ctrl+C>${E_INFO} to cancel                                                    |
+-----------------------------------------------------------------------------+
${E_NORMAL}"
    read -r -e answer
    answer=${answer:-2}
    case ${answer} in
      1|2)
        prompt_version=${answer}
        ;;
      *)
        echo -e "${E_ERROR}Please enter 1 or 2${E_NORMAL}"
        ;;
    esac
  done
}


ask_unicode_support()
{
  # Ask the user if its terminal emulator support unicode
  # NO PARAM

  local answer=""
  clear
  while ! [[ ${answer} =~ (y|Y|yes|YES|ye|YE|n|N|no|NO) ]]
  do
    echo -e "${E_INFO}\
+-----------------------------------------------------------------------------+
|     Does your shell support unicode,                                        |
|     i.e. do you see a heart between the single quotes : '♡ ' ? [Y/n]        |
+-----------------------------------------------------------------------------+
| Press ${E_ERROR}${E_BOLD}<Ctrl+C>${E_INFO} to cancel                                                    |
+-----------------------------------------------------------------------------+
${E_NORMAL}"
    read -r -e answer
    answer=${answer:-Y}
    case ${answer} in
      y|Y|yes|YES|ye|YE)
        shell_app="xterm"
        ;;
      n|N|no|NO)
        ;;
      *)
        echo -e "${E_ERROR}Please enter y|yes or n|no${E_NORMAL}"
        ;;
    esac
  done
}

ask_true_color_support()
{
  # Ask user if his/her terminal emulator support true colors
  # NO PARAM

  local answer=""
  clear
  local true_color_support=""
  while ! [[ ${answer} =~ (y|Y|yes|YES|ye|YE|n|N|no|NO) ]]
  do
    echo -e "${E_INFO}\
+-----------------------------------------------------------------------------+
|     Does your shell support true colors ?                                   |
|     i.e. do you see a continous colors line below ? [Y/n]                   |
|${TRUE_COLORS_LINE}${E_INFO}|
+-----------------------------------------------------------------------------+
| Press ${E_ERROR}${E_BOLD}<Ctrl+C>${E_INFO} to cancel                                                    |
+-----------------------------------------------------------------------------+
${E_NORMAL}"
    read -r -e answer
    answer=${answer:-Y}
    case ${answer} in
      y|Y|yes|YES|ye|YE)
        shell_app="st"
        ;;
      n|N|no|NO)
        ;;
      *)
        echo -e "${E_ERROR}Please enter y|yes or n|no${E_NORMAL}"
        ;;
    esac
  done
}

ask_debug_level(){
  # Ask the user the debug level he/she want to use in the container
  # NO PARAM

  local answer
  clear
  while ! [[ ${debug_level} =~ [0-3] ]]
  do
    echo -e "${E_INFO}\
+-----------------------------------------------------------------------------+
|     What debug level informations you want to be shown.                     |
|     REMARK: Options '3' is not recommended as it will print lots of infos ! |
|       0: Print only errors                                                  |
|       1: Print errors and precmd computation time [Default]                 |
|       2: Print errors, warnings and precmd computation time                 |
|       3: Print errors, warnings, infos and precmd computation time          |
+-----------------------------------------------------------------------------+
| Press ${E_ERROR}${E_BOLD}<Ctrl+C>${E_INFO} to cancel                                                    |
+-----------------------------------------------------------------------------+
${E_NORMAL}"
    read -r -e debug_level
    debug_level=${debug_level:-1}
    case ${debug_level} in
      [0-3])
        ;;
      *)
        echo -e "${E_ERROR}Please enter a value between 0 and 3${E_NORMAL}"
        ;;
    esac
  done
}

ask_mount()
{
  # Ask user if he/she wants to mount the prompt folder to prepare or work on
  # configuration or if he/she does want to, in order to work on development
  # NO PARAM

  local answer
  clear
  while ! [[ ${answer} =~ (y|Y|yes|YES|ye|YE|n|N|no|NO) ]]
  do
    echo -e "${E_INFO}\
+-----------------------------------------------------------------------------+
|     Do you want to mount your prompt folder within the docker [Y/n] ?
|       If 'yes', the folder ${SCRIPTPATH} will be mount as volume to
|         /root/.prompt, i.e. modifications done in the docker container will
|         remains when leaving the container, better for configuration,
|       If 'no', the folder ${SCRIPTPATH} will be copied in the container
|         to /root/.prompt, i.e. modification will not remains once leaving
|         the container, better for development
+-----------------------------------------------------------------------------+
| Press ${E_ERROR}${E_BOLD}<Ctrl+C>${E_INFO} to cancel                                                    |
+-----------------------------------------------------------------------------+
${E_NORMAL}"
    read -r -e answer
    answer=${answer:-Y}
    case ${answer} in
      y|Y|yes|YES|ye|YE)
        mount="true"
        ;;
      n|N|no|NO)
        mount="false"
        ;;
      *)
        echo -e "${E_ERROR}Please enter y|yes or n|no${E_NORMAL}"
        ;;
    esac
  done
}


ask_confirmation()
{
  # Recap user parameter and present what will be done
  # NO PARAM

  local cmd="./test.sh -b -s ${shell} -p ${prompt_version} -a ${shell_app} -d ${debug_level}"
  if [[ ${mount} == "true" ]]
  then
    cmd+=" -m"
  fi
  while [[ ${answer} -ne 1 ]] && [[ ${answer} -ne 2 ]]
  do
    echo -e "${E_INFO}\
+-----------------------------------------------------------------------------+
|     Here is what will be done :
|     - Build a docker image called ${image_name} if not already built
|     - Run a container called ${container_name} that will be delete on exit
|     - Within this container, shell '${shell}' will be used to test prompt version ${prompt_version}
|
|     NOTE: If you do not want to pass through this interactive process the next
| time, here is the command to use:
|     \`\`\`
|       ${cmd}
|     \`\`\`
|     Do you want to continue [Y/n] ?
+-----------------------------------------------------------------------------+
| Press ${E_ERROR}${E_BOLD}<Ctrl+C>${E_INFO} to cancel                                                    |
+-----------------------------------------------------------------------------+
${E_NORMAL}"
    read -r -e answer
    answer=${answer:-Y}
    case ${answer} in
      y|Y|yes|YES|ye|YE)
        return 0
        ;;
      n|N|no|NO)
        return 1
        ;;
      *)
        echo -e "${E_ERROR}Please enter y|yes or n|no${E_NORMAL}"
        ;;
    esac
  done
}


build_docker_image()
{
  # Build the docker image if not already built
  # NO PARAM

  local dockerfile_path
  local curr_pwd=$(pwd)
  if [[ "${mount}" == "true" ]]
  then
    dockerfile_path=${SCRIPTPATH}/test/Dockerfile_mount
    image_name="${image_name}:mount_prompt"
  else
    dockerfile_path=${SCRIPTPATH}/test/Dockerfile_copy
    image_name="${image_name}:cloned_prompt"
  fi
  cd "${SCRIPTPATH}" || exit 1
  prompt_debug "Building docker image ${image_name}."
  prompt_debug "Docker build log redirected to ${SCRIPTPATH}/docker_build.log${E_NORMAL}"
  docker build --tag "${image_name}" -f "${dockerfile_path}" . > "${SCRIPTPATH}/docker_build.log"
  cd "${curr_pwd}" || exit 1
  return 0
}


run_docker()
{
  # Run the docker to test the user provided bash
  # NO PARAM

  local volumes=""
  local environment=""
  environment+="-e SHELL_APP=${shell_app} "
  environment+="-e SHELL=/bin/${shell} "
  environment+="-e PROMPT_VERSION=${prompt_version} "
  environment+="-e DEBUG_LEVEL=${debug_level} "
  environment+="-e DEBUG_MODE=true "
  if [[ ${mount} == "true" ]]
  then
    volumes+="-v ${SCRIPTPATH}:/root/.prompt"
  fi

  prompt_debug "${E_INFO} Running container ${container_name}${E_NORMAL}"

  # shellcheck disable=2086
  # SC2086: Double quote to prevent globbing and word splitting.

  prompt_debug "docker run \\
    ${environment} \\
    ${volumes} \\
    -it \\
    --name "${container_name}" \\
    --rm  \\
    --hostname "${container_name}" "${image_name}" \\
    "/bin/${shell}""
  docker run \
    ${environment} \
    ${volumes} \
    -it \
    --name "${container_name}" \
    --rm  \
    --hostname "${container_name}" "${image_name}" \
    "/bin/${shell}"
  return 0
}


parse_args()
{
  while [[ $# -gt 0 ]]
  do
    case $1 in
      -s|--shell)
        shift
        shell=$1
        shift
        ;;
      -p|--prompt)
        shift
        prompt_version=$1
        shift
        ;;
      -a|--app)
        shift
        shell_app=$1
        shift
        ;;
      -b|--build)
        validate_build="true"
        shift
        ;;
      -d|--debug-level)
        shift
        debug_level=$1
        shift
        ;;
      -m|--mount)
        mount="true"
        shift
        ;;
      -h|--help)
        usage
        exit 0
        ;;
    esac
  done
}

main()
{
  # Main method launching menus to ask user parameter
  # NO PARAM or $@ corresponding to arguments described in usage()

  # Source debug method
  source "${SCRIPTPATH}/lib/debug.sh"

  local build="false"
  local validate_build="false"
  local shell=
  local prompt_version
  local shell_app
  local debug_level
  local mount

  parse_args "$@"

  if [[ ${validate_build} == "true" ]]
  then
    if [[ -z "${shell}" ]] \
      || [[ -z "${prompt_version}" ]] \
      || [[ -z "${shell_app}" ]] \
      || [[ -z "${debug_level}" ]]
    then
      echo -e "${E_WARNING}\
+-----------------------------------------------------------------------------+
|                             [WARNING]                                       |
| You can only use option -b,--build if you use all following options:        |
|  ${E_BOLD}-s, --shell${E_WARNING}                                                                |
|          The name of the shell you want to test. Possible values are :${E_WARNING}      |
|            ${E_NORMAL}- bash${E_WARNING}                                                           |
|            ${E_NORMAL}- zsh${E_WARNING}                                                            |
|      ${E_BOLD}-p, --prompt${E_WARNING}                                                           |
|          The prompt version you want to test. Possible values are :         |
|            - ${E_NORMAL}1${E_WARNING}                                                              |
|            - ${E_NORMAL}2${E_WARNING}                                                              |
|      ${E_BOLD}-a, --app${E_WARNING}                                                              |
|          The terminal emulator value you want to emulate for your test      |
|          depending on support of unicode char and true colors of your       |
|          terminal.                                                          |
|          Possible values are :                                              |
|            - ${E_NORMAL}unknown:${E_WARNING}                                                       |
|              ${E_NORMAL}${E_DIM}If your terminal emulator does not support neither unicode${E_WARNING}     |
|              ${E_NORMAL}${E_DIM}char, neither true colors.${E_WARNING}                                     |
|            - ${E_NORMAL}xterm:${E_WARNING}:                                                        |
|              ${E_NORMAL}${E_DIM}If your terminal emulator does support unicode char but does${E_WARNING}   |
|              ${E_NORMAL}${E_DIM}not support true colors.${E_WARNING}                                       |
|            - ${E_NORMAL}st:${E_WARNING}                                                            |
|              ${E_NORMAL}${E_DIM}If your terminal emulator does support unicode char and true${E_WARNING}   |
|              ${E_NORMAL}${E_DIM}colors.${E_WARNING}                                                        |
|      ${E_BOLD}-d, --debug_level${E_WARNING}                                                      |
|          The debug leve to be shown in the container :                      |
|            - ${E_NORMAL}0${E_WARNING}: [Default] Show only errors                                  |
|            - ${E_NORMAL}1${E_WARNING}: [Default] Show error and time to compute                    |
|            - ${E_NORMAL}2${E_WARNING}: [Default] Show error, warning and time to compute           |
|            - ${E_NORMAL}3${E_WARNING}: [Default] Show error, warning, info and time to compute     |
|   Docker will not be build and run directly.                                |
+-----------------------------------------------------------------------------+
| Press ${E_INFO}${E_BOLD}<Enter>${E_WARNING} to fall back to interactive                                   |
| Press ${E_ERROR}${E_BOLD}<Ctrl+C>${E_WARNING} to cancel                                                    |
+-----------------------------------------------------------------------------+
${E_NORMAL}"
      read -r
    else
      build="true"
    fi
  fi

  local image_name="dynamic-prompt"
  local container_name
  while [[ ${build} == "false" ]]
  do
    [[ -z "${shell}" ]] && ask_shell_to_test
    [[ -z "${prompt_version}" ]] && ask_prompt_version
    [[ -z "${shell_app}" ]] && ask_unicode_support && ask_true_color_support
    [[ -z "${debug_level}" ]] && ask_debug_level
    [[ -z "${mount}" ]] && ask_mount

    container_name="${image_name}-v${prompt_version}-${shell_app}"
    if ask_confirmation "${shell}" "${shell_app}" "${prompt_version}"
    then
      build="true"
    else
      unset shell
      unset shell_app
      unset prompt_version
      unset debug_level
      unset mount
    fi
  done
  container_name="${image_name}-v${prompt_version}-${shell_app}"
  build_docker_image "${image_name}" "${container_name}"
  run_docker "${image_name}" "${container_name}"
  return 0
}

main "$@"

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
