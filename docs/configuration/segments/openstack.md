# `openstack` Segment

## Description

This segment show openstack information of the form `os_domain:os_project_name`.

This segment is shown only when both variables `OS_PROJECT_NAME` and
`OS_USER_DOMAIN_NAME`, usually done when sourcing `openrc.sh` file.

As I manage multiple OpenStack pool of ressources depending on project, I set
variables OpenStack by project using [direnv][direnv]. Allowing me to avoind to
type `source openrc.sh` command each time I enter the working project
that use OpenStack.

To see how to use `direnv` for your folder, see
[Using direnv to setup environment-variables][using_direnv]

## Requirements

This segment has no requirement as it only show content of variables
`OS_PROJECT_NAME` and `OS_USER_DOMAIN_NAME`.

## Variables

<center>

| Variables        | Default   | Description                                         |
| :-------------:  | :-------: | :-------------------------------------------------- |
| `OPENSTACK_CHAR` | ` `      | Character to show before the segment content        |
| `OPENSTACK_FG`   | white     | Foreground color of segment                         |
| `OPENSTACK_BG`   | black     | Background color of segment, **only used by _v2_**  |

</center>

## Examples

<center>

|                       | Prompt _v1_                                | Prompt _v2_                                |
| :-:                   |:-----------                               :|:-----------                               :|
| Full Version          | ![!openstack v1 full][openstack_v1_full]   | ![!openstack v2 full][openstack_v2_full]   |
| Maximum Short Version | ![!openstack v1 short][openstack_v1_short] | ![!openstack v2 short][openstack_v2_short] |

</center>

[direnv]: https://direnv.net/

[using_direnv]: ../../technical_documentation/direnv.md

[openstack_v1_full]: ../../assets/img/openstack_segment_full_v1.png
[openstack_v1_short]: ../../assets/img/openstack_segment_short_v1.png
[openstack_v2_full]: ../../assets/img/openstack_segment_full_v2.png
[openstack_v2_short]: ../../assets/img/openstack_segment_short_v2.png
