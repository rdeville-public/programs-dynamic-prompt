# `kube` Segment

## Description

This segment show kubernetes information of the form
`current-cluster:current-namespace` as set in your kube config.

This segment is shown only when global variable `KUBE_ENV` exists and is not
empty and kubernetes context can be retrive with `kubectl` command.

As I manage multiple kubernetes cluster depending on project, I set variables
`KUBE_ENV` and `KUBECONFIG` by project using [direnv][direnv].

To see how to use `direnv` for your folder, see section
[Using direnv to setup environment-variables][using_direnv]

## Requirements

This segment require the command `kubectl` to be in your `PATH`.

To install `kubectl`, see [Install and Set Up kubectl][install_kubectl].

## Variables

<center>

| Variables       | Default   | Description                                         |
| :-------------: | :-------: | :-------------------------------------------------- |
| `KUBE_CHAR`     | `⎈ `      | Character to show before the segment content        |
| `KUBE_FG`       | white     | Foreground color of segment                         |
| `KUBE_BG`       | black     | Background color of segment, **only used by _v2_**  |

</center>

## Examples

<center>

|                       | Prompt _v1_                    | Prompt _v2_                    |
| :-:                   |:-----------                   :|:-----------                   :|
| Full Version          | ![!kube v1 full][kube_v1_full]   | ![!kube v2 full][kube_v2_full]   |
| Maximum Short Version | ![!kube v1 short][kube_v1_short] | ![!kube v2 short][kube_v2_short] |

</center>

[direnv]: https://direnv.net/
[install_kubectl]: https://kubernetes.io/docs/tasks/tools/install-kubectl/

[using_direnv]: ../../technical_documentation/direnv.md

[kube_v1_full]: ../../assets/img/kube_segment_full_v1.png
[kube_v1_short]: ../../assets/img/kube_segment_short_v1.png
[kube_v2_full]: ../../assets/img/kube_segment_full_v2.png
[kube_v2_short]: ../../assets/img/kube_segment_short_v2.png
