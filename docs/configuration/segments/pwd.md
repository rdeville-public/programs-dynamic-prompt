# `pwd` Segment

## Description

This segment print the current dir path.

If user is in a subfolder of its `${HOME}` folder, then `${HOME}` path will be
contracted to `~`.

Its shorten version is particular as it will be dynamically computed to print as
much as possible up to 5 character.

## Requirements

This segment has no requirement.

## Variables

<center>

| Variables    | Default | Description                                            |
| :----------: | :-----: | -------------------------------------------------      |
| `PWD_CHAR`   | ` `    | Character to show before the segment information       |
| `PWD_FG`     | white   | Foreground color of the segment                        |
| `PWD_BG`     | black   | Background color of the segment, **only used by _v2_** |

</center>

## Examples

<center>

|                       | Prompt _v1_                    | Prompt _v2_                    |
| :-:                   | :-----------                  :|:-----------                   :|
| Full Version          | ![!pwd v1 full][pwd_v1_full]   | ![!pwd v2 full][pwd_v2_full]   |
| Maximum Short Version | ![!pwd v1 short][pwd_v1_short] | ![!pwd v2 short][pwd_v2_short] |

</center>

[pwd_v1_full]: ../../assets/img/pwd_segment_full_v1.png
[pwd_v1_short]: ../../assets/img/pwd_segment_short_v1.png
[pwd_v2_full]: ../../assets/img/pwd_segment_full_v2.png
[pwd_v2_short]: ../../assets/img/pwd_segment_short_v2.png
