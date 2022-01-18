# `docker` Segment

## Description

This segment show docker information of the form <TODO:segment_form>.

This segment is shown only when <TODO:segment_constraint>.

## Requirements

This segment has no requirement.

## Variables

<center>

| Variables                | Default                | Description                                         |
| :-------------:          | :-------:              | :-------------------------------------------------- |
| `DOCKER_CHAR` | `<TODO:segment_char> ` | Character to show before the segment content        |
| `DOCKER_FG`   | white                  | Foreground color of segment                         |
| `DOCKER_BG`   | black                  | Background color of segment, **only used by _v2_**  |

<TODO:segment_variables>

</center>

## Examples

<center>

|                       | Prompt _v1_                                                | Prompt _v2_                                                |
| :-:                   | -----------                                                | -----------                                                |
| Full Version          | ![!docker v1 full][docker_v1_full]   | ![!docker v2 full][docker_v2_full]   |
| Maximum Short Version | ![!docker v1 short][docker_v1_short] | ![!docker v2 short][docker_v2_short] |

</center>

[docker_v1_full]: <TODO:segment_screenshots>
[docker_v1_short]: <TODO:segment_screenshots>
[docker_v2_full]: <TODO:segment_screenshots>
[docker_v2_short]: <TODO:segment_screenshots>

