# General variables


## Variables descriptions

Some variable are independent of the segments organisation as they define the
global display of the prompt _v1_ and prompt _v2_.

Columns _v1_ and _v2_ in the following table show default value depending on
prompt version. If value is `None`, this means that no value is assigned by
default.
Below are variables used independently of segments used. They are used to set
main colors background and foreground.

<center>

| Variables                  | _v1_    | _v2_    | Description                                                                                                                                                       |
| :------------------------: | :-----: | :-----: | --------------------------------------------------------------------------------------------------------------------                                              |
| `PROMPT_ENV_LEFT`          | `[`     | `None`  | Character on the left of the segment for _v1_,<br>Separator for segment on the left part of _v2_.                                                                 |
| `PROMPT_ENV_RIGHT`         | `]`     | `None`  | Character on the right of the segment for _v1_,<br>Separator for segment on the right part of  _v2_.                                                              |
| `S_LINE_PROMPT_END`        | `None`  | `None`  | Character at the end of the prompt when prompt <br>**does not fill terminal line**, i.e. when not using <br>`hfill` segment.<br>Same behaviour for _v1_ and _v2_. |
| `M_LINE_PROMPT_END`        | ` ﬌ `   | ` ﬌ `   | Character at the end of the prompt when prompt <br>**does fill terminal line**, i.e. when using `hfill` <br>segment. <br>Same behaviour for _v1_ and _v2_.        |
| `DEFAULT_FG`               | white   | white   | Default foreground color,<br> i.e. the fallback colors when foreground is not <br>defined for a segment.                                                          |
| `DEFAULT_BG`               | black   | black   | Default background color,<br> i.e. the color of the horizontal line.<br>Also, the fallback of background colors when<br> not define for a segment in _v2_.        |
| `CORRECT_WRONG_FG`         | white   | white   | If using `zsh`, the foreground colors of the <br>wrong command when printing command correction.                                                                  |
| `CORRECT_RIGHT_FG`         | white   | white   | If using `zsh`, the foreground colors of the <br>proposed command when printing correction.                                                                       |

</center>

For variables having `FG` or `BG`, i.e. defining respectively foreground or
background colors, when setting colors variables, you do not need to write the
full syntax, just enter the color code corresponding of the color your want. The
surrounded of the color code will be set by dynamic prompt depending on your
terminal. Example of value are shown below:

<center>

| Color            | 8 colors   | 256 colors   | True colors      |
| ---------------- |:----------:|:------------:|:----------------:|
| Red              | 1          | 196          | 255;0;0          |
| Green            | 2          | 046          | 0;255;0          |
| Blue             | 4          | 021          | 0;0;255          |

</center>

Set of 256 colors supported by 256 colors terminal are shown at the end of the
file `common.exemple.sh` and in the image below. The number on the left of
hexadecimal colors value is the code of this color in 256 colors support.

<center>

![!256_colors][256_colors]

</center>

## Some examples

As always, images and examples are the best explications. Below are some
examples with different values for previously described variables. As before, to
better see the segment, the file `common.example.sh` is used as base
configuration for screenshots below.

### Prompt _v1_

??? example "Default values"

    Below is the value of these variables in you want to put them in your
    configuration file but if you want to use their default value.
    ```bash
    PROMPT_ENV_LEFT="["
    PROMPT_ENV_RIGHT="]"
    S_LINE_PROMPT_END=""
    M_LINE_PROMPT_END=" ﬌ "
    DEFAULT_FG=""
    DEFAULT_BG=""
    CORRECT_WRONG_FG=""
    CORRECT_RIGHT_FG=""
    ```

    ![!Prompt v1 Default General Variables][prompt_v1_default_general_variables]

??? example "`common.examples.sh` values - 8/16 colors support"

    Below is the example of the content of these values in the example file
    `common.example.sh` on terminal that support only 8 colors

    ```bash
    PROMPT_ENV_LEFT="["      # v1 Default "["
    PROMPT_ENV_RIGHT="]"     # v1 Default "]"
    S_LINE_PROMPT_END=""     # Default ""
    M_LINE_PROMPT_END=" ﬌ "  # Default " ﬌ "
    DEFAULT_FG="0"           # Usually black
    DEFAULT_BG="1"           # Usually red
    CORRECT_WRONG_FG="1"     # Usually red
    CORRECT_RIGHT_FG="2"     # Usually green
    ```

    ![!Prompt v1 Common General Variables 8 colors][prompt_v1_common_general_variables_8_colors]

??? example "`common.examples.sh` values - 256 colors support"

    Below is the example of the content of these values in the example file
    `common.example.sh` on terminal that support 256 colors

    ```bash
    PROMPT_ENV_LEFT="["     # v1 Default "]"
    PROMPT_ENV_RIGHT="]"    # v1 Default "["
    S_LINE_PROMPT_END=""    # Default ""
    M_LINE_PROMPT_END=" ﬌ " # Default " ﬌ "
    DEFAULT_FG="16"         # rgb(000,000,000) # 000000
    DEFAULT_BG="52"         # rgb(095,000,000) # 5F0000
    CORRECT_WRONG_FG="160"  # rgb(215,000,000) # D70000
    CORRECT_RIGHT_FG="40"   # rgb(000,215,000) # 00D700
    ```

    ![!Prompt v1 Common General Variables 256 colors][prompt_v1_common_general_variables_256_colors]

??? example "`common.examples.sh` values - true colors support (i.e. 24 bits colors)"

    Below is the example of the content of these values in the example file
    `common.example.sh` on terminal that support true colors

    ```bash
    PROMPT_ENV_LEFT="["        # v1 Default "]"
    PROMPT_ENV_RIGHT="]"       # v1 Default "]"
    S_LINE_PROMPT_END=""       # Default ""
    M_LINE_PROMPT_END=" ﬌ "    # Default " ﬌ "
    DEFAULT_FG="0;0;0"         # rgb(000,000,000) # 000000
    DEFAULT_BG="95;0;0"        # rgb(095,000,000) # 5F0000
    CORRECT_WRONG_FG="215;0;0" # rgb(215,000,000) # D70000
    CORRECT_RIGHT_FG="0;215;0" # rgb(000,215,000) # 00D700
    ```

    ![!Prompt v1 Common General Variables true colors][prompt_v1_common_general_variables_true_colors]

### Prompt _v2_

Following examples assume your terminal support unicode characters.

??? example "Default values"

    Below is the value of these variables in you want to put them in your
    configuration file but if you want to use their default value.
    ```bash
    PROMPT_ENV_LEFT=""
    PROMPT_ENV_RIGHT=""
    S_LINE_PROMPT_END=""
    M_LINE_PROMPT_END=" ﬌ "
    DEFAULT_FG=""
    DEFAULT_BG=""
    CORRECT_WRONG_FG=""
    CORRECT_RIGHT_FG=""
    ```

    ![!Prompt v2 Default General Variables][prompt_v2_default_general_variables]

??? example "`common.examples.sh` values - 8/16 colors support"

    Below is the example of the content of these values in the example file
    `common.example.sh` on terminal that support only 8 colors

    ```bash
    PROMPT_ENV_LEFT=" "    # v2 Default ""
    PROMPT_ENV_RIGHT=" "   # v2 Default ""
    S_LINE_PROMPT_END=""   # Default ""
    M_LINE_PROMPT_END=" ﬌ " # Default " ﬌ "
    DEFAULT_FG="0"          # Usually black
    DEFAULT_BG="1"          # Usually red
    CORRECT_WRONG_FG="1"    # Usually red
    CORRECT_RIGHT_FG="2"    # Usually green
    ```

    ![!Prompt v2 Common General Variables 8 colors][prompt_v2_common_general_variables_8_colors]

??? example "`common.examples.sh` values - 256 colors support"

    Below is the example of the content of these values in the example file
    `common.example.sh` on terminal that support 256 colors

    ```bash
    PROMPT_ENV_LEFT=" "    # v2 Default ""
    PROMPT_ENV_RIGHT=" "   # v2 Default ""
    S_LINE_PROMPT_END=""   # Default ""
    M_LINE_PROMPT_END=" ﬌ " # Default " ﬌ "
    DEFAULT_FG="16"         # rgb(000,000,000) # 000000
    DEFAULT_BG="52"         # rgb(095,000,000) # 5F0000
    CORRECT_WRONG_FG="160"  # rgb(215,000,000) # D70000
    CORRECT_RIGHT_FG="40"   # rgb(000,215,000) # 00D700
    ```

    ![!Prompt v2 Common General Variables 256 colors][prompt_v2_common_general_variables_256_colors]

??? example "`common.examples.sh` values - true colors support (i.e. 24 bits colors)"

    Below is the example of the content of these values in the example file
    `common.example.sh` on terminal that support true colors

    ```bash
    PROMPT_ENV_LEFT=" "    # v2 Default ""
    PROMPT_ENV_RIGHT=" "   # v2 Default ""
    S_LINE_PROMPT_END=""   # Default ""
    M_LINE_PROMPT_END=" ﬌ " # Default " ﬌ "
    DEFAULT_FG="0;0;0"         # rgb(000,000,000) # 000000
    DEFAULT_BG="95;0;0"        # rgb(095,000,000) # 5F0000
    CORRECT_WRONG_FG="215;0;0" # rgb(215,000,000) # D70000
    CORRECT_RIGHT_FG="0;215;0" # rgb(000,215,000) # 00D700
    ```

    ![!Prompt v2 Common General Variables true colors][prompt_v2_common_general_variables_true_colors]


As you may have seen on examples above for prompt _v1_ and _v2_, there is only
little differences between variables values but both use these variables to
compute prompt lines.

## Additional notes

If you want a good starting point, I provided a file `common.example.sh` that
have a base configuration.

This file have lots of comment to help you understand what variables stands for.

Moreover, in this file, I already handled most configuration, such as defining
variable for 8/16 colors terminal emulator, 256 colors terminal emulator and
true colors terminal emulator.

You can copy it to your desire `$(hostname).sh`, copy it to `common.sh` or make
a symlnks to it if you wish to use the same as mine (not recommended as you will
have udpates from the upstream `common.examples.sh` even if you do not want).

Remark that all variables start with `local`, which can look like odds in bash
scripts, because this should not be working, and you are "almost" right. Alone
this script will not work, it is because it is sourced by `prompt.sh` that make
this script work. Moreover, the local in front of variable are here to avoid
making these variables global and so adding some mess in your environment
variables.

Now that prompt line organisation and behaviour are set, as well as the general
variables, you may want to configure segments you have decided to use as define
in your variable `SEGMENT`.

To to so, see [All supported segments][all_supported_segments] which list
currently supported segment as well as link to each of their individual
documentations.


<!-- Link internal to this documentation -->
[all_supported_segments]: all_supported_segments.md

<!-- Link to assets of this documentation -->
[256_colors]: ../assets/img/256_colors.png
[prompt_v1_default_general_variables]: ../assets/img/general_variable_default_v1.png
[prompt_v1_common_general_variables_8_colors]: ../assets/img/general_variable_8_colors_v1.png
[prompt_v1_common_general_variables_256_colors]: ../assets/img/general_variable_256_colors_v1.png
[prompt_v1_common_general_variables_true_colors]:
[prompt_v2_default_general_variables]: ../assets/img/general_variable_default_v2.png
[prompt_v2_common_general_variables_8_colors]: ../assets/img/general_variable_8_colors_v2.png
[prompt_v2_common_general_variables_256_colors]: ../assets/img/general_variable_256_colors_v2.png
[prompt_v2_common_general_variables_true_colors]: ../assets/img/general_variable_256_true_colors_v2.png
