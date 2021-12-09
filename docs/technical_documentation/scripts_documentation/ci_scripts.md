# CI Scripts

In order to automate the validation of the dynamic prompt, the project comme
from a continous integration which rely on three scripts than can be run locally
to ensure your shell scripts are correct and the display of the prompt is
correct to.

## `ci.bash` and `ci.zsh` script

These script will simply print the prompt line for prompt version _v1_ and _v2_
when using respectively `bash` and `zsh`.

If not integer is provided as first argument, the script will compute 100 times
the prompt lines and print the average times of computation.

The prompt line printed is automatically generated using all segments in the
`segments/` folder, i.e. it will automatically use all segments, even the one
you work on or just added. No configuration are required.


Below is the usage of these script:

??? info "Usage of `ci.bash` (Click to reveal)"

    ```
    TODO
    ```


??? info "Usage of `ci.zsh` (Click to reveal)"
    ```
    TODO
    ```

Below is the example of expected outputs:

![!ci.zsh output][ci.zsh_output]

## `shellcheck.sh` script

[Shellcheck][shellcheck] is a script analysis tools use to avoid bugs in shell
scripts. The `schellcheck.sh` require this program to run.

This script will search for every `*.sh` script on the repo and will run
shellcheck agains them.

**REMARK** To avoid lots and lots of output, `shellcheck.sh` will stop as soon
as a script analysis output errors/warnings/infos. To avoid this behaviour, use
the options `-f` as shown below in the usage of this script:

??? info "Usage of `shellcheck.sh` (Click to reveal)"

    ```
    TODO
    ```


[shellcheck]: https://www.shellcheck.net/

[ci.zsh_output]: TODO
