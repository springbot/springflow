SpringFlow
=======

Adds the 'git sf' Git extension to provide high-level repository operations
for [DataSift's SpringFlow branching model](http://datasift.github.com/gitflow/), which is based on [Vincent Driessen’s original blog post](http://nvie.com/posts/a-successful-git-branching-model/).

Installation
------------

1. `git clone git@github.com:springbot/springflow.git`
2. `cd springflow`
3. `./install.sh`

Upgrading To The Latest Version
-------------------------------

Upgrading to the latest version of the SpringFlow tools is very easy:

1. `git sf upgrade`

Initialize Your Repo
--------------------
`git sf init`

Develop a Feature
---------------
Using a JIRA ticket number, e.g., WWW-3547:
`git sf feature start 3547`

Now make some commits on your feature branch. You can push and share your branch with `git sf push`

Stay up to date with `git sf update`. This will pull in changes on your feature branch from the remote, as well as `master`. To get up to date with `master`, do the usual `git merge master` or better, `git rebase master`.

Open a Pull Request with `git sf feature submit` (and follow on-screen instructions) when you're ready to bring your feature into master. You can also open the pull request on GitHub if you prefer. Once the Pull Request has been merged, you can clean up your branch with `git sf feature finish <STORY-NUMBER>`.

Cut a Release
-------------
Start a release with `git sf release start <yyyy-mm-dd>`, where `yyyy-mm-dd` is today's date. This will create a new branch, `release/2014-10-07` that can be deployed to stage for testing. Vet this release, and add any fixes and tweaks to this branch if necessary.

When the release is approved, `git sf release finish <yyyy-mm-dd>`. You'll be prompted to provide tag details. This is a good place to add release notes and describe what's going out in this release.

Hotfix Production
-----------------
Start a hotfix with `git sf hotfix start <hotfix-name>`. Make your fixes and test them appropriately. When you're finished, `git sf hotfix finish <hotfix-name>` to merge the fix into `master`, `deploy` and cut a new release.

Further Reading
---------------
SpringFlow is based on HubFlow, which itself is based on GitFlow. You might find it helpful to read up on those projects for background.

See our tutorial website to learn more about the [GitFlow](http://datasift.github.com/gitflow/IntroducingGitFlow.html) branching model and [how to use the SpringFlow tools](http://datasift.github.com/gitflow/GitFlowForGitHub.html).

Changelog
---------

To see what's new in each release, see our [Changelog](http://datasift.github.com/gitflow/ChangeLog.html).

License Terms
-------------
SpringFlow is published under the liberal terms of the BSD License, see the
[LICENSE](LICENSE) file. Although the BSD License does not require you to share
any modifications you make to the source code, you are very much encouraged and
invited to contribute back your modifications to the community, preferably
in a Github fork, of course.
