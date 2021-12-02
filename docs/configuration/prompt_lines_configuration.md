# Prompt lines configuration

Before starting customization of colors, chars, etc., you will need to configure
which segment you want to activate/deactivate and the order in which they are
compressed.

This is done by two variables in your configuration files in `hosts/` folder:

<center>

| Variables             | Description                                                                                                                    |
| :-------------------: | ----------------------------------------------------------------------------------------------------------------------------   |
| `SEGMENT`             | An array which define lines and segment used for the prompt                                                                    |
| `SEGMENT_PRIORITY`    | An array which define in which order segment will be compressed <br>when there is not enough space to print full informations. |

</center>


!!! note
    Following example with these two variables will only uses some supported
    segments, not all segments. To see the list of all supported segments, see
    section [All Supported Segments][all_supported_segments].

    Moreover, following example uses the content of `common.example.sh` as color
    configuration of segments, to see them more clearly. If you do not have make
    a copy of this file that you rename into `common.sh`, your prompt colors
    might be different.

Exemples are better than long explication, so let us start.

## Variable `SEGMENT`

As this variable is an array, the easiest form is:

```bash
SEGMENT=("first line" "second line")
```

You can see this documentation [Arrays on tldp.org][tldp.org_array] if you want
to learn more about arrays in bash

In this array, each cell will define which segments are used for each prompt
line. Segment should be separated by a comma `,`.

### Basic prompt

For instance, if you want simple line prompt with only `username`, `hostname`
and `pwd` segments with command entry at the end (like default bash prompt), the
variable `SEGMENT` should be:

```bash
SEGMENT=("username, hostname, pwd")
```

  * Prompt _v1_ (click on image to enlarge)

![!Prompt v1 minimal][prompt_v1_minimal]

  * Prompt _v2_ (click on image to enlarge)

![!Prompt v2 minimal][Prompt_v2_minimal]

In this example, some segment will never be shown, for instance git
informations, provided by `git` segment, or python virtual environtment,
provided by `virtualenv` segment, will never be displayed !

### Basic prompt with command below

If you want simple line prompt with only `username`, `hostname` and
`pwd` segments but with command entry below the prompt the variable `SEGMENT`
should be:

```bash
SEGMENT=("username, hostname, pwd, hfill")
```

See the special segment called `hfill` (see section [hfill][hfill]) which will
fill the line with empty char to colorize a complete line of your terminal.

  * Prompt _v1_ (click on image to enlarge)

![!Prompt v1 minimal hfill][prompt_v1_minimal_hfill]

  * Prompt _v2_ (click on image to enlarge)

![!Prompt v2 minimal hfill][prompt_v2_minimal_hfill]

### Default prompt

The default value of `SEGMENT`, which is also the value used for most exemples in
this documentation using most of the supported segments, is :

```bash
SEGMENT=(
    "return_code, tmux, pwd, hfill, keepass, username, hostname"
    "vcsh, virtualenv, vcs, kube, openstack, hfill"
)
```

  * Prompt _v1_ (click on image to enlarge)

![!Prompt v1 Default Empty][prompt_v1_default_empty]

  * Prompt _v2_ (click on image to enlarge)

![!Prompt v2 Default Empty][prompt_v2_default_empty]

!!! important

    **If using multine prompt, like the default one, if a line of the prompt
    does not have any no information to show, for instance when you are in your
    home folder and there is no specific environment loaded, then the line will
    not be prompt.**

    For instance, below are shown prompt in my `home` folder and in a work
    folder where lots of segments are loaded, using the default multiline
    configuration.**

      * Basic folder

    Prompt _v1_ (click on image to enlarge)

    ![!Prompt v1 Default empty][prompt_v1_default_empty]

    Prompt _v2_ (click on image to enlarge)

    ![!Prompt v2 Default empty][prompt_v2_default_empty]

      * When (almost) every segment are loaded

    Prompt _v1_ (click on image to enlarge)

    ![!Prompt v1 Default full][prompt_v1_default_full]

    Prompt _v2_ (click on image to enlarge)

    ![!Prompt v2 Default full][prompt_v2_default_full]


!!! warning
    Only the first line of the prompt in multiline configuration will be
    colorized. So if the first line does not show any information, you will not
    have the colored line. See in the examples below the 4 lines configuration.


More examples are provided at the end of this page, see section [More
examples][more_examples].

## Variable `SEGMENT_PRIORITY`

Finally, let us configure the behaviour of the prompt when it will shrink, when
ther is not enough place to print all segment.

Below is exemple of this behaviour:

  * The prompt _v1_ (click on image to enlarge)

![!Prompt v1 shrink][prompt_v1_shrink]

  * The prompt _v2_ (click on image to enlarge)

![!Prompt v2 shrink][prompt_v2_shrink]

This behaviour is configured through the variable `SEGMENT_PRIORITY` which
defines the order in which segment will be contracted or hidden.

As this variable is an array, the easiest form is:

```bash
SEGMENT_PRIORITY=("first line" "second line")
```

You can see this documentation [Arrays on tldp.org][tldp.org_array] if you want
to learn more about arrays in bash

In this array, each cell will define the order in which segments will be
compressed for each prompt line. Segment should be separated by a comma `,`.

For instance, let us use the default 2 lines prompt:

```bash
SEGMENT=(
    "tmux, pwd, hfill, keepass, username, hostname"
    "vcsh, virtualenv, vcs, kube, openstack, hfill"
)
```

By default, the value of `SEGMENT_PRIORITY` is :

```bash
SEGMENT_PRIORITY=(
    "tmux, username, hostname, keepass, pwd, return_code"
    "vcsh, virtualenv, kube, openstack, vcs"
)
```

This means that the prompt will shrink as follow:

  * On first line, segment `tmux` will be first to shrink, then this will be
    segment `username`, then `hostname`, then `keepass`, then `pwd` and finally
    `return_code`. When none of these segment can be shrinked anymore, they will
    disappear in the same order.

  * In parallel, second lines will also shrink when needed. First segment `vcsh`
    will shrink, then `virtualenv`, then `kube` then `openstack` and finally
    `vcs`. Finally, when none of these segment can be shrinked anymore, they
    will disappear in the same order.

This behaviour is the one illustrated in the GIFs above.

!!! warning
    **DO NOT PUT `hfill` SEGMENT AS HFILL WILL _NEVER_ SHRINK AND IS USED TO
    FULLFILL THE PROMPT LINE**

    **BE SURE YOU PUT ALL SEGMENT YOU USE !**

If you want to change this behaviour, you just have to change the order of the
segment in `SEGMENT_PRIORITY`.

```bash
SEGMENT_PRIORITY=(
    "username, hostname, pwd, tmux, return_code, keepass"
    "vcsh, kube, openstack, virtualenv, vcs"
)
```

!!! warning
    The variable `SEGMENT_PRIORITY` must be set accordingly to segments you use
    as defined in variable `SEGMENT`. For instance, if using simple one line
    which fill the prompt with only `username`, `hostname` and `pwd`, and you
    want `hostname` to shrink first, then `username` and finally `pwd`, values
    `SEGMENT` and `SEGMENT_PRIORITY` should be as follow:

    ```bash
    SEGMENT=(
        "username, hostname, pwd, hfill"
    )
    SEGMENT_PRIORITY=(
        "hostname, username, pwd"
    )
    ```

### More examples

Here are some other exemples show for _v1_ and _v2_. Click on images and GIFs to
enlarge them.

??? example "Single line not filling terminal with lots of segments (**not recommended**)"

    Here is an example when lots (almost all segments) are put in one single
    line and when they are all loaded.

    ```bash
    SEGMENT=(
        "tmux, vcsh, virtualenv, vcs, kube, openstack, keepass, username, hostname, pwd"
    )
    SEGMENT_PRIORITY=(
        "hostname, username, keepass, openstack, kube, vcs, virtualenv, vcsh, tmux, pwd"
    )
    ```

    * Prompt _v1_ (click on image to enlarge)

    ![!Prompt v1 Single Line All Segments][prompt_v1_single_line_all_segments]
    ![!Prompt v1 Single Line All Segments Shrink][prompt_v1_single_line_all_segments_shrink]

    * Prompt _v2_ (click on image to enlarge)

    ![!Prompt v2 Single Line All Segments][prompt_v2_single_line_all_segments]
    ![!Prompt v2 Single Line All Segments Shrink][prompt_v2_single_line_all_segments_shrink]

    As you can see (or probably not), this configuration is barely readable and
    so barely usable.

??? example "Crazy terminal with 4 lines"

    Let's go crazy, use 4 lines with all segment reparted on the lines and add
    some comment in the array to remember why each segment is on its line:

    ```bash
    SEGMENT=(
        # Virtualization environment
        "tmux, vcsh"
        # Global variable config environement
        "keepass, kube, openstack"
        # Programation environment
        "vcsh, virtualenv"
        # Classic prompt
        "username, hostname, pwd"
    )
    SEGMENT_PRIORITY=(
        # Virtualization environment
        "tmux, vcsh"
        # Global variable config environement
        "keepass, kube, openstack"
        # Programation environment
        "vcsh, virtualenv"
        # Classic prompt
        "username, hostname, pwd"
    )
    ```

    * Prompt _v1_ (click on image to enlarge)

    ![!Prompt v1 4 lines][prompt_v1_4_lines]
    ![!Prompt v1 4 lines shrink][prompt_v1_4_lines_shrink]

    * Prompt _v2_ (click on image to enlarge)

    ![!Prompt v2 4 lines][prompt_v2_4_lines]
    ![!Prompt v2 4 lines shrink][prompt_v2_4_lines_shrink]

??? example "Crazy terminal with 4 lines filling the terminal (not recommended)"

    Let's go crazy, use 4 lines filling full terminal size with all segment
    reparted on the lines and add some comment in the array to remember why each
    segment is on its line:

    ```bash
    SEGMENT=(
        # Virtualization environment
        "tmux, hfill, vcsh"
        # Global variable config environement
        "keepass, hfill, kube, openstack"
        # Programation environment
        "vcsh, hfill, virtualenv"
        # Classic prompt
        "username, hostname, pwd, hfill"
    )
    ```
    * Prompt _v1_ (click on image to enlarge)

    ![!Prompt v1 4 lines full loaded][prompt_v1_4_lines_full_loaded]
    ![!Prompt v1 4 lines full loaded shrink][prompt_v1_4_lines_full_loaded_shrink]

    * Prompt _v2_ (click on image to enlarge)

    ![!Prompt v2 4 lines full loaded][prompt_v2_4_lines_full_loaded]
    ![!Prompt v2 4 lines full loaded shrink][prompt_v2_4_lines_full_loaded_shrink]

!!! warning
    Only the first line of the prompt in multiline configuration will have a
    full colored line. So if the first line does not show any information, you
    will not have the colored line.

    For instance, below is the behavour of the last examples when in a folder
    where no environment is loaded.

    * Prompt _v1_ (click on image to enlarge)

    ![!Prompt v1 4 lines full empty][prompt_v1_4_lines_full_empty]

    * Prompt _v2_ (click on image to enlarge)

    ![!Prompt v1 4 lines full empty][prompt_v2_4_lines_full_empty]

### Debugging

There are two variables that can be usefull and should mainly be used only using
`export` command directly from the user input. These variable are `DEBUG_MODE`
and `DEBUG_LEVEL`.

#### `DEBUG_MODE` variable

When this variable is set to any value, then the prompt will automatically
activate all used segments. Those which does not have real informations to show
will be filled with fake value.

This variable is usefull to see how your prompt look like when all segments are
loaded and/or when debugging.

Below is an example of such behaviour.

![!Prompt v2 Debug Mode][prompt_debug_mode]

#### `DEBUG_LEVEL` variable

This variable have for possible value:

  * `ERROR` (the default value), print only errors information
  * `TIME`, print errors and the time of computation of the prompt
  * `WARNING`, print errors, the time of computation and warnings.
  * `INFO`, print a **lots** of informations, errors, time of computation and
    warnings.
  * `DEBUG`, print a **lots more** output, debug information, basic information,
    errors, warning, and time of computation.

When set, computation of the prompt will output some debug information depending
on level sets. The more level is close to `DEBUG` the more informations will be
outputed. This is done through the script `lib/debug.sh`, for more information see
[Debug Script Documentation][debug_script_documentation].

This variable should not be set to `WARNING`, `INFO` nor `DEBUG` except when
debugging because setting these values will prompt lots of information and make
your prompt unusable as shown below:

![!Prompt v1 Debug Level][prompt_debug_level]

Now, before starting to configure each segment, you will need to setup some
[General Variables][general_variables] used by both prompt _v1_ and prompt _v2_.

<!-- Link external to this documentation -->
[tldp.org_array]: https://www.tldp.org/LDP/abs/html/arrays.html

<!-- Link internal to this documentation -->
[all_supported_segments]: all_supported_segments.md
[general_variables]: general_variables.md
[more_examples]: #more-examples
[debug_script_documentation]: ../technical_documentation/scripts_documentation/debug.sh.md

<!-- Link to assets of this documentation -->
[prompt_v1_minimal]: ../assets/img/prompt_one_line_minimal_v1.png
[prompt_v2_minimal]: ../assets/img/prompt_one_line_minimal_v2.png
[prompt_v1_minimal_hfill]: ../assets/img/prompt_one_line_minimal_hfill_v1.png
[prompt_v2_minimal_hfill]: ../assets/img/prompt_one_line_minimal_hfill_v2.png
[prompt_v1_default_empty]: ../assets/img/default_prompt_v1.png
[prompt_v2_default_empty]: ../assets/img/default_prompt_v2.png
[prompt_v1_default_full]: ../assets/img/default_prompt_full_option_v1.png
[prompt_v2_default_full]: ../assets/img/default_prompt_full_option_v2.png
[prompt_v1_shrink]: ../assets/img/shrink_v1.gif
[prompt_v2_shrink]: ../assets/img/shrink_v2.gif
[prompt_v1_single_line_all_segments]: ../assets/img/one_line_all_segments_v1.png
[prompt_v1_single_line_all_segments_shrink]: ../assets/img/one_line_all_segments_shring_v1.gif
[prompt_v2_single_line_all_segments]: ../assets/img/one_line_all_segments_v2.png
[prompt_v2_single_line_all_segments_shrink]: ../assets/img/one_line_all_segments_shring_v2.gif
[prompt_v1_4_lines]: ../assets/img/prompt_4_lines_v1.png
[prompt_v1_4_lines_shrink]: ../assets/img/prompt_4_lines_shrink_v1.gif
[prompt_v2_4_lines]: ../assets/img/prompt_4_lines_v2.png
[prompt_v2_4_lines_shrink]: ../assets/img/prompt_4_lines_shrink_v2.gif
[prompt_v1_4_lines_full_loaded]: ../assets/img/prompt_4_lines_hfill_v1.png
[prompt_v1_4_lines_full_loaded_shrink]: ../assets/img/prompt_4_lines_hfill_shrink_v1.gif
[prompt_v2_4_lines_full_loaded]: ../assets/img/prompt_4_lines_hfill_v2.png
[prompt_v2_4_lines_full_loaded_shrink]: ../assets/img/prompt_4_lines_hfill_shrink_v2.gif
[prompt_v1_4_lines_full_empty]: ../assets/img/prompt_4_lines_hfill_empty_v1.png
[prompt_v2_4_lines_full_empty]: ../assets/img/prompt_4_lines_hfill_empty_v2.png
[prompt_debug_mode]: ../assets/img/debug_mode.gif
[prompt_debug_level]: ../assets/img/debug_level_demo.gif
