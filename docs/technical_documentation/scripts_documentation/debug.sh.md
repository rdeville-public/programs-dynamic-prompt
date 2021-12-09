# `debug.sh` script

The debug script contains simply a function to print colored message depending
on the its severity and the value of the global variable `DEBUG_LEVEL`. If no
severity is provided, the message is always printed with the INFO color.

Ordered supported severities are :

  - `ERROR`
  - `TIME`
  - `WARNING`
  - `INFO`


Feel free to use this script for your own script but be carefull to rename the
variable `DEBUG_LEVEL` otherwise the dynamic prompt will also print debug
information and will be unusable as shown below when `DEBUG_LEVEL` is set to
`INFO`.

![!Prompt debug info level][prompt_debug_info_level]

??? info "Content of the `debug.sh` script (click to reveal)"

    ```
        TODO
    ```



[prompt_debug_info_level]: TODO
