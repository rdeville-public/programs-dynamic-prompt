# Add/Update documentation

When reading this documentation your might have see some grammatical or spelling
mistake you may want to correct.

Or when adding a new features, you will need to document it to be shown in this
current documentation.

This tutorial will show you how update the documentation, how to check it
locally and finally propose your modification.


## Description

This documentation is generated using [MkDocs][mkdocs], allowing to write the
documentation in markdown format. All this documentations is located in the
folder `docs/` of the repo. The configuration of the documentation is done
within a single file `mkdocs.yml` at the root of the repo.


## Render the documentation

To render the documentation locally, you will need following dependencies:

  - python3
  - pip
  - pipenv (optional)

!!! note
    Pipenv is here to help making the python virtual environment. If you are
    used to manipulate python virtual environment, do it your preferred way ;-).

The installation of `pipenv` is done using `pip`:

```bash
  pip install pipenv
```

Once pipenv is install, you can install the python virtual environment and
activate it with the following commands:

```bash
# Assuming you are at the root of the repo
# Install the virtual environment
pipenv install
# Activate it
pipenv shell
```

!!! note
    If you are using `virtualenv` segment, this one should activate and show
    you the name of the virtual environment and python version used in this
    virtual environment :grinning:.

Now, run the following commands:

```bash
mkdocs server
```

This will allow you to navigate through this documentation locally, with the
following url [http://localhost:8000](http://localhost:8000).

## Add/Update the documentation

Once the documentation is served, you can minimize the terminal which run the
server of the documentation, as it will reload automatically the documentation
when you will modify it. Which is convenient to see your modification in live.

Do all the modification of the documentation you need/want.

If you add new markdown files, do not forget to put them in the file
`mkdocs.yml` otherwise they will still be rendered but they will not be shown on
the left side of the documentation. And so not accessible unless other pages
link to them.

## Ready to publish

Once eveything is done, you can now prepare a merge request as described in :

  * [Developers Guidelines-6. Prepare your merge request][prepare_merge_request].

And finally, you can propose your merge request as explain in :

  * [Developers Guidelines-7. Propose your merge request][propose_merge_request].

[mkdocs]: https://www.mkdocs.org/
[prepare_merge_request]: developers_guidelines.md#6-prepare-your-merge-request
[propose_merge_request]: developers_guidelines.md#7-propose-your-merge-request
