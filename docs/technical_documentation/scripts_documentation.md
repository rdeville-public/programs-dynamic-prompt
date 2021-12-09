# Scripts documentation

This page is here to list all the main scripts of this project with link to
there full documentation.

  * [`promp.sh` script][prompt.sh]: the main script of this project.
  * [`test.sh` script][test.sh]: a script to safely test the prompt in a
    container.
  * [`new_segment.sh` script][new_segment.sh]: a script to help you adding your
    own segment.
  * [`which_term.sh` script][which_term.sh]: script showing the name of your
    terminal used by dynamic prompt.
  * [`debug.sh` scripts][debug.sh]: script use to print error/warning/debug
    informations.
  * [CI scripts][ci_scripts]: set of script to ensure the prompt is working and
    valid in CI.
    * [`ci.bash` script][ci.bash]: Script to test the prompt for bash.
    * [`ci.zsh` script][ci.zsh]: Script to test the prompt for zsh.
    * [`shellcheck.sh` script][shellcheck.sh]: Script to ensure syntax of of the
      code.

[prompt.sh]: scripts_documentation/prompt.sh.md
[test.sh]: scripts_documentation/test.sh.md
[new_segment.sh]: scripts_documentation/new_segment.sh.md
[which_term.sh]: scripts_documentation/which_term.sh.md
[debug.sh]: scripts_documentation/debug.sh.md
[ci_scripts]: scripts_documentation/ci_scripts.md
[ci.bash]: scripts_documentation/ci_scripts.md#cibash-script
[ci.zsh]: scripts_documentation/ci_scripts.md#cizsh-script
[shellcheck.sh]: scripts_documentation/ci_scripts.md#shellchecksh-script
