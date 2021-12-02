# `virtualenv` segment

## Description

This segment is a "meta-segment" to show virtual environment information.

For now, only `python` is supported. as it is the only one I use. If you want to
add support of another virtual environment, like nix, guix, npm, feel free to
contribute, I'll be glad to help as much as I can.

As it only support `python` for now, this segment is only shown when global
variable `VIRTUAL_ENV` exists and is not empty. For `python`, this usually means
you activate the python virtual environment with command like:

```bash
# Usually, manuall done with:
source .venv/bin/activate
```

The virtual environment information is of the form
`python_version:name_of_virtual_env` and is only shown when variable
`VIRTUAL_ENV` exists and is not empty.

## Requirements

This segment has no specific requirement as it depends on your virtual
environment management software.

## Variables

<center>

| Variables         | Default   | Description                                         |
| :-------------:   | :-------: | :-------------------------------------------------- |
| `VIRTUALENV_CHAR` | ` `      | Character to show before the segment content        |
| `VIRTUALENV_FG`   | white     | Foreground color of segment                         |
| `VIRTUALENV_BG`   | black     | Background color of segment, **only used by _v2_**  |

</center>

## Examples

<center>

|                       | Prompt _v1_                                  | Prompt _v2_                                  |
| :-:                   |:-----------                                 :|:-----------                                 :|
| Full Version          | ![!virtualenv v1 full][virtualenv_v1_full]   | ![!virtualenv v2 full][virtualenv_v2_full]   |
| Maximum Short Version | ![!virtualenv v1 short][virtualenv_v1_short] | ![!virtualenv v2 short][virtualenv_v2_short] |

</center>

[virtualenv_v1_full]: ../../assets/img/python_virtual_env_segment_full_v1.png
[virtualenv_v1_short]: ../../assets/img/python_virtual_env_segment_short_v1.png
[virtualenv_v2_full]: ../../assets/img/python_virtual_env_segment_full_v2.png
[virtualenv_v2_short]: ../../assets/img/python_virtual_env_segment_short_v2.png
