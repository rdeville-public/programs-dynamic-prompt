# `tmux` Segment

## Description

This segment inform me when I am in tmux of the form `session_name:pane_name`.

This segment is because I do no usually look at the bottom of my terminal which
usually is fullscreen on a 24" monitor to know if I'm in tmux or not.

This segment is only shown when global shell environment variable `TMUX` exists
and is not empty.

## Requirements

Obviously, this segment requires `tmux` to be installed.

## Variables

<center>

| Variables       | Default   | Description                                         |
| :-------------: | :-------: | :-------------------------------------------------- |
| `TMUX_CHAR`     | ` `      | Character to show before the segment content        |
| `TMUX_FG`       | white     | Foreground color of segment                         |
| `TMUX_BG`       | black     | Background color of segment, **only used by _v2_**  |

</center>


## Examples

<center>

|                       | Prompt _v1_                      | Prompt _v2_                      |
| :-:                   |:-----------                     :|:-----------                     :|
| Full Version          | ![!tmux v1 full][tmux_v1_full]   | ![!tmux v2 full][tmux_v2_full]   |
| Maximum Short Version | ![!tmux v1 short][tmux_v1_short] | ![!tmux v2 short][tmux_v2_short] |

</center>

[tmux_v1_full]: ../../assets/img/tmux_segment_full_v1.png
[tmux_v1_short]: ../../assets/img/tmux_segment_short_v1.png
[tmux_v2_full]: ../../assets/img/tmux_segment_full_v2.png
[tmux_v2_short]: ../../assets/img/tmux_segment_short_v2.png
