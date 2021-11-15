---
title: 'StackStorm 2.3.1: Bug Smashing'
author: st2admin
type: post
date: 2017-07-06T20:25:14+00:00
url: /2017/07/06/stackstorm-2-3-1-bug-smashing/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5969383653
tcb2_ready:
  - 1
categories:
  - Blog
  - News
tags:
  - release

---
_July 6, 2017_  
_by Lindsay Hill_

Hot on the heels of [StackStorm 2.3][1], we have pushed out StackStorm 2.3.1. Bugs squashed, a few useful small changes. Here&#8217;s a few of the highlights:

<!--more-->

## Additions & Changes:

  * The `remote-shell-script` runner now supports passphrases for SSH keys.
  * New `json_escape` filter for escaping JSON strings.
  * Most of our CLI commands will limit the output to 50 items. But they didn&#8217;t always tell you if there were more than 50 results available. Now they do.
  * Position parameters in actions must now be unique, and sequential. They always should have been, but now we enforce that. You&#8217;ll get a warning if you try to register actions with invalid `position` entries.
  * `st2api` whole API responses are now logged at `DEBUG` level. The default logging level is `INFO`, so this reduces clutter.

## Bugfixes

There are always bugs. But maybe now there are a few less.

  * `st2 action-alias delete` now works. It was broken in 2.3, and you had to delete aliases via API. 
  * `st2ctl register` sometimes failed to register rules, resulting in errors that could never be re-created. Annoying, and now fixed.
  * The config loader didn&#8217;t like config schema default boolean values that were `False`. It got confused. I got confused. It is now fixed.

Full details in the [Changelog][2].

We&#8217;re now getting into the next release &#8211; this will probably be 2.3.2, which will be more bugfixes and small changes. If you have any favorite bugs you need fixed, please make sure to highlight them on [GitHub][3]. No issue logged == no bug, OK? And do let us know if anything already logged is affecting you. Give it a +1. Our very scientific processes do take that into account when picking bugs to fix.

## Upgrading

Packages are now available in `apt` and `yum` repos. Make sure you backup first, and check the [upgrade notes][4], especially if you&#8217;re upgrading from pre-2.2.

As always, if you run into any problems, get in touch via [Slack][5] or [GitHub][3].

 [1]: https://stackstorm.com/2017/06/19/stackstorm-2-3-something-everyone/
 [2]: https://docs.stackstorm.com/changelog.html
 [3]: https://github.com/StackStorm/st2/issues
 [4]: https://docs.stackstorm.com/upgrade_notes.html
 [5]: https://stackstorm.com/community-signup