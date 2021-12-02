# `hostname` Segment

## Description

This segment print the hostname of the computer.

## Requirements

This segment has no requirement.

## Variables

<center>

| Variables       | Default | Description                                            |
| :----------:    | :-----: | ------------------------------------------------       |
| `HOSTNAME_CHAR` | ` `    | Character to show before the segment content           |
| `HOSTNAME_FG`   | white   | Foreground color of the segment                        |
| `HOSTNAME_BG`   | black   | Background color of the segment, **only used by _v2_** |

</center>

## Examples

<center>

|                       | Prompt _v1_                              | Prompt _v2_                              |
| :-:                   |:-----------                             :|:-----------                             :|
| Full Version          | ![!hostname v1 full][hostname_v1_full]   | ![!hostname v2 full][hostname_v2_full]   |
| Maximum Short Version | ![!hostname v1 short][hostname_v1_short] | ![!hostname v2 short][hostname_v2_short] |

</center>

[hostname_v1_full]: ../../assets/img/hostname_segment_full_v1.png
[hostname_v1_short]: ../../assets/img/hostname_segment_short_v1.png
[hostname_v2_full]: ../../assets/img/hostname_segment_full_v2.png
[hostname_v2_short]: ../../assets/img/hostname_segment_short_v2.png

