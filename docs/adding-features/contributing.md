# Contributing

The dynamic prompt project welcomes contributions from developers and user in
the open source community. Contribution can be made in a number of ways, a few
example are :

  * Code patch via pull requests,
  * Documentation improvements,
  * Bug reports and patch reviews,
  * Proposition of new features,
  * etc.

## Code of conduct

Everyone interacting in the dynamic prompt's codebases, issues trackers, etc. is
expected to follow this [Code of conduct][code_of_conduct].

## Reporting an Issue

Please include as much details as you can when reporting an issue in the [issue
trackers][issue_tracker]. If the problem is visual (for instance, wrong segment
display) please add a screenshot.

## Testing the development version

If you want to just try out the dynamic prompt you can do it safely in a
docker container by using the script `test.sh` provided in the repo. For more
information, see [Testing the prompt][testing].

## Running the tests

To run the tests, the easier way to do is to run the prompt in the docker
container with the help of the script `tools/test` script provided in the repo. The run
the following scripts that are in the folder `ci/`:

  * `shellcheck.sh`: Will pass the shellcheck "linter" on all bash scripts of
    the repo

  * `ci.zsh`/`ci.bash`: Will print _v1_ and _v2_ of the prompt for `bash` or
    `zsh` depending on the extension and will compute the average time to
    compute the prompt for 100 run.

For more information about these scripts, see [CI Scripts
Documentation][scripts_documentation].

## Submitting Pull Requests

Once you are happy with your changes or you are ready for some feedback, push it
to your fork and send a pull request[^1]. For a change to be accepted it will most
likely need to have tests and documentation if it is a new feature.

For more information, you can check [Developers
Guidelines][developers_guidelines] which provide you guidelines and a tutorial
detailing a proposed workflow.

[^1]: !!! important
          Only pull requests done on [framagit][framagit_repo] will be
          considered as described in [Developers
          Guidelines][developers_guidelines]

<!-- Link external to this documentation -->
[issue_tracker]: https://framagit.org/rdeville/dynamic-prompt/issues
[framagit_repo]: https://framagit.org/rdeville/dynamic-prompt
[framasoft]: https://framasoft.org
<!-- Link internal to this documentation -->
[code_of_conduct]: ../about/code_of_conduct.md
[testing]: ../../getting_started/#testing-the-prompt
[developers_guidelines]: developers_guidelines.md
[keep_your_configuration]: ../configuration/keep_your_configuration.md
[doc_configuration]: ../configuration/configure_your_prompt.md
[scripts_documentation]: ../technical_documentation/scripts_documentation/ci_scripts.md
