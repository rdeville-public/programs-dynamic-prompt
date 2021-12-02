# `bgjobs` Segment

## Description

This segment print the number of jobs running in background of the current
terminal.

This segment is only shown when there are background running jobs.

## Requirements

This segment has no requirement.

## Variables

<center>

| Variables       | Default   | Description                                        |
| :-------------: | :-------: | :-----------------------------------------------   |
| `BGJOBS_CHAR`   | `&`       | Character to show before the segment content       |
| `BGJOBS_FG`     | white     | Foreground color of segment                        |
| `BGJOBS_BG`     | black     | Background color of segment, **only used by _v2_** |

</center>

## Examples

**Note**: On example below, you see string `bgjobs` after the segment character
instead of number. This is because this screenshot was done using `DEBUG_MODE`
variable.


<center>

|                       | Prompt _v1_                          | Prompt _v2_                          |
| :-:                   |:-----------                         :|:-----------                         :|
| Full Version          | ![!bgjobs v1 full][bgjobs_v1_full]   | ![!bgjobs v2 full][bgjobs_v2_full]   |
| Maximum Short Version | ![!bgjobs v1 short][bgjobs_v1_short] | ![!bgjobs v2 short][bgjobs_v2_short] |

</center>

[bgjobs_v1_full]: ../../assets/img/bgjobs_full_v1.png
[bgjobs_v1_short]: ../../assets/img/bgjobs_short_v1.png
[bgjobs_v2_full]: ../../assets/img/bgjobs_full_v2.png
[bgjobs_v2_short]: ../../assets/img/bgjobs_short_v2.png
