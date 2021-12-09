# `hfill` Segment

## Description

This segment is a special segment used to fill the prompt line. It is the only
one that is not in `segments/` folder.

Its aims is to separated left and right side of the prompt by computing the size
between segments on the left side, on the right side and fill this size with
space.

It has no configuration and is always shown if user defines this segment in
variable `SEGMENT`.

## Requirements

This segment has no requirement.

## Variables

This segment has no configurable variables.

## Examples

<center>

| Prompt _v1_
| -----------
| ![!hfill v1][hfill_v1]

| Prompt _v2_
| -----------
| ![!hfill v2][hfill_v2]

</center>

[hfill_v1]: ../../assets/img/hfill_segment_v1.png
[hfill_v2]: ../../assets/img/hfill_segment_v2.png

