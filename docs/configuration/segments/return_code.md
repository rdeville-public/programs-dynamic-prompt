# `return_code` Segment

## Description

This segment show the exit code of the previous command.

This segment is shown only if this exit code is not 0.

## Requirements

This segment has no requirement.

## Variables

<center>

| Variables          | Default   | Description                                         |
| :-------------:    | :-------: | :-------------------------------------------------- |
| `RETURN_CODE_CHAR` | ` `      | Character to show before the segment content        |
| `RETURN_CODE_FG`   | white     | Foreground color of segment                         |
| `RETURN_CODE_BG`   | black     | Background color of segment, **only used by _v2_**  |

</center>

## Examples

<center>

|               | Prompt _v1_                                    | Prompt _v2_                                    |
| :-:           | :-----------                                  :| :-----------                                  :|
| Full Version  | ![!return_code v1 full][return_code_v1_full]   | ![!return_code v2 full][return_code_v2_full]   |
| Short Version | ![!return_code v1 short][return_code_v1_short] | ![!return_code v2 short][return_code_v2_short] |

</center>

[return_code_v1_full]: ../../assets/img/return_code_segment_full_v1.png
[return_code_v1_short]: ../../assets/img/return_code_segment_short_v1.png
[return_code_v2_full]: ../../assets/img/return_code_segment_full_v2.png
[return_code_v2_short]: ../../assets/img/return_code_segment_short_v2.png

