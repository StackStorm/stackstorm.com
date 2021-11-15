---
title: 'Early Christmas: StackStorm Patch Release 2.5.1'
author: st2admin
type: post
date: 2017-12-19T18:10:44+00:00
url: /2017/12/19/early-christmas-stackstorm-patch-release-2-5-1/
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6359122082
categories:
  - News
tags:
  - release
  - release announcement
  - StackStorm

---
Here&#8217;s an early Christmas present for everyone: StackStorm 2.5.1 is out. Small enhancements and bugfixes, and some enhancements to Workflow Designer. Time to sneak it in before the change freeze? Or something to do on your dev system over the quiet period? Read on for details.

<!--more-->

## New & Changed Things

  * Python action logging &#8211; lots of changes here: We&#8217;ve added a `log_level` runner parameter. This controls which level of log messages are output to stderr. It defaults to DEBUG, but can be over-ridden at the runner or action level. This can help suppress noisy actions. Datastore-related logs now use DEBUG, not AUDIT, and to use the correct action class name. Finally we&#8217;ve fixed an issue with duplicate log messages.
  * New `search` rule criteria comparison operator. Check the [documentation][1] to see how to use it.
  * `st2 execution {run,get}` now colorizes the value of the status attribute. Your terminal will be that little bit prettier.
  * The CLI no longer automatically converts list items in action parameters to dicts when colons (:) are detected. You can explicitly enable this functionality with the new `--auto-dict` flag, but note that this is a temporary measure, and this flag will be deprecated in a future release in lieu of more permanent handling of complex datatypes in action params.

## Fixed Things

  * `st2 execution tail [last]` no longer throws an exception if there are no executions in the database.
  * The datastore service in Python actions now scopes the auth token to the triggering user.
  * Fixed edge case for workflows stuck in running state. In certain situations, Mistral could receive a connection error from the ST2 API. This resulted in a duplicate execution stuck in requested state. That then leads to `st2resultstracker` assuming the workflow is still running.
  * Fixed a regression and a bug where no API validation was being performed and the API returned a 500 status code. This occurred when a request payload was not included for POST and PUT API endpoints where body is mandatory.

## Workflow Composer Enhancements

We&#8217;ve made a few small usability enhancements to Workflow Designer in this release:

  * When creating or editing a workflow, you can now configure position parameters. This lets you change the Web UI parameter display ordering.
  * Workflow Designer will now prompt you to set a workflow pack and name on first save. This is much nicer than the unhelpful error message we used to give you.
  * We fixed a bug where the action icon did not display for the first action added to the canvas.

Full details of all fixes and changes are in [the changelog][2].

As ever, thanks to all those who contributed in some way, via code, bug reports, and feature requests.

## Backup First!

Packages are now available in `apt` and `yum` repos. Backup first, then follow the [General Upgrade procedure][3] to upgrade.

Having a problem? Get in touch via [Slack][4] or [GitHub][5].

 [1]: https://docs.stackstorm.com/latest/rules.html#advanced-comparison
 [2]: https://docs.stackstorm.com/changelog.html
 [3]: https://docs.stackstorm.com/install/upgrades.html#general-upgrade-procedure
 [4]: https://stackstorm.com/community-signup
 [5]: https://github.com/StackStorm/st2/issues