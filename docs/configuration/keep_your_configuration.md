# Keep your configuration

Now you have done your own configuration, you may want to keep track of it.

In this document, we will see how to keep your configuration versionned.

There is two main way to do this:

  - [Making a fork](#make-a-fork) from the repo on [framagit][framagit_repo]
  - [Cloning this repo locally](#make-a-clone-on-other-platform), and push it on another platform

The preferred way is by forking it, especially if you want to contribute, this
will ease you merge request process, but it is not mandatory. If you want to
contribute, see [contributing][contributing] and [Developpers
Guidelines][developers_guidelines]

From time to times, you may want to be up to date with the latest release of the
prompt. As there is no automatic mechanism for now, see section
[Resynchronize with the main repo](#resynchronize-with-the-main-repo) to do so.

## Make a fork

If you want to make a fork, simply, from the repo on [framagit][framagit_repo],
click on the `fork` button as shown below:

![!fork_button][fork_button]

Then, you will be ask where to store the forked repo, as shown below:

![!fork_namespace][fork_namespace]

Then, clone your fork on your computer. Make your own modification, commit them
and push them. They will be push on your fork. Thus, if you change computer, you
will just need to clone your fork.

## Make a clone on other platform

!!! note
    This method is not recommended if you wish to contribute on this project,
    because you will still need to make a repo on [framagit][framagit] if you
    want to push on the main projet. See [Contributing][contributing] for more
    informations.

For this section, we will assume you already prepared an empty repo on your
other platform, for this example, we will use `mygitplaform.tld`. As there
exists a lots of different git platforms, please refers to the documentation of
your platform.

If you want to version your configuration on other platform, first, you need
to clone this repo :

```bash
# Assuming repo ~/.shell exist, but you can clone it wherever you want.
git clone https://framagit.org/rdeville/dynamic-prompt.git ~/.shell/prompt
```

Then, go to the repo and update the remote, i.e. the URL to which the repo will
be pushed. In this example, we have already create an empty repo on
`mygitplaform.tld/user/my-dynamic-prompt`.

```bash
# Go to the prompt folder
cd ~/.shell/prompt
# Remove the origin remote that point to https://framagit.org/rdeville/dynamic-prompt.git
git remote remove origin
# Add your own origin remote usic https
git remote add origin https://mygitplaform.tld/user/my-dynamic-prompt.git
# OR
# Add your own origin remote usic ssh
git remote add origin git@mygitplaform.tld:user/my-dynamic-prompt.git
```

Of course, you can also do it with one single git command:

```bash
# Go the the prompt folder
cd ~/.shell/prompt
# Change url of the origin remote using http
git remote set-url origin https://mygitplaform.tld/user/my-dynamic-prompt.git
# OR
# Add your own origin remote usic ssh
git remote set-url origin git@mygitplaform.tld:user/my-dynamic-prompt.git
```

Then make your own modification, commit them and push them. They will be push
your own origin remote, i.e. in this exemple
`mygitplatform.tld/user/my-dynamic-prompt`.

## Resynchronize with the main repo

If you want to update your own repo to have the last version of the prompt, you
will first need to add a remote pointing to the main repo on
[framagit][framagit_repo].

First, list the current remote to ensure that remote `upstream` does not exists
yet:

```bash
git remote -v
> origin <URL_TO_YOUR_ORIGIN_REMOTE> (fetch)
> origin <URL_TO_YOUR_ORIGIN_REMOTE> (push)
```

If there is no `upstream` remote, you will need to add it:

```bash
git remote add upstream https://framagit.org/rdeville/dynamic-prompt.git
```

Ensure that the remote upstream is well sets:

```bash
git remote -v
> origin <URL_TO_YOUR_ORIGIN_REMOTE> (fetch)
> origin <URL_TO_YOUR_ORIGIN_REMOTE> (push)
> upstream https://framagit.org/rdeville/dynamic-prompt.git (fetch)
> upstream https://framagit.org/rdeville/dynamic-prompt.git (push)
```

Once done, fetch branches from this `upstream` remote, commit to `master` of
the main repo will be stored in local branch `upstream/master`:

```text
git fetch upstream
> remote: Counting objects: 75, done.
> remote: Compressing objects: 100% (53/53), done.
> remote: Total 62 (delta 27), reused 44 (delta 9)
> Unpacking objects: 100% (62/62), done.
> From https://framagit.org/rdeville/dynamic-prompt.git
>  * [new branch]      master     -> upstream/master*
```

Check out your fork's local `master` branch.

```text
git checkout master
> Switched to branch 'master'
```

Merge the changes from `upstream/master` into your local `master` branch. This
brings your fork's `master` branch into sync with the `upstream` repository,
without losing your local changes.

```text
git merge upstream/master
> Updating a422352..5fdff0f
> Fast-forward
>  README                    |    9 -------
>  index.md                  |    7 ++++++
>  2 files changed, 7 insertions(+), 9 deletions(-)
>  delete mode 100644 README
>  create mode 100644 index.md
```

If your local branch didn't have any unique commits, Git will instead perform a
"fast-forward":

```text
git merge upstream/master
> Updating 34e91da..16c56ad
> Fast-forward
>  index.md                 |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
```

Here you are up-to-date with the main repo :wink:.

From now, you may want to add your own segment.

Before to do so, please take a look at :

  * [Contributing][contributing] page which will introduce you to
    contribution on dynamic prompt

  * [Developers guidelines][developers_guidelines] page which give some
    advices about developments, such as the code of style used in this project,
    preferred commits structures and a tutorial following a proposed workflow.

<!-- Link external to this documentation -->
[framagit]: https://framagit.org
[framagit_repo]: https://framagit.org/rdeville/dynamic-prompt
<!-- Link internal to this documentation -->
[contributing]: ../adding-features/contributing.md
[developers_guidelines]: ../adding-features/developers_guidelines.md
<!-- Link to assets of this documentation -->
[fork_button]: ../assets/img/gitlab_fork.png
[fork_namespace]: ../assets/img/gitlab_fork_choice.png
