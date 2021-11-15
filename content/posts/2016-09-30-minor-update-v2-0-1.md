---
title: 'Minor update: v2.0.1'
author: st2admin
type: post
date: 2016-09-30T21:48:56+00:00
url: /2016/09/30/minor-update-v2-0-1/
dsq_thread_id:
  - 5186795455
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Blog
  - Community
  - News
tags:
  - release

---
**Sep 30, 2016**  
_by Lindsay Hill_

Hey folks, StackStorm v2.0.1 has been released, with a few small fixes and enhancements. We&#8217;ve also had some great code contributions recently, with a new integration for [Datadog][1], and improvements to our Github and Nagios packs.

Read on for details, plus a few hints on what we&#8217;re up to next.

<!--more-->

## StackStorm v2.0.1

Mostly fixes and cleanups in this release:

  * Fixed the problem where `st2actionrunner` files could disappear after a while. Tracked it down to a problem with our logrotate config, of all things.
  * Using `--attr` with the `st2 execution get` command now correctly works with child properties of the result and trigger_instance dictionary.
  * The `st2 trace list` command and associated API endpoint now list traces sorted by `start_timestamp` in descending order by default. You can also specify sort order by adding `?sort_desc=True|False` query parameters, or by passing `--sort=asc|desc` to the `st2 trace list` CLI command.
  * Action default parameter values now support Jinja template notation for parameters of type object.
  * `st2 key delete` properly supports `--user/-u`. It was supposed to. Now it actually does.
  * Fixed a bug in `st2web` where it would cache old parameter entries.

Updates are available via `apt` or `yum`. You can insert your own broken record comment here about &#8220;backup first, yada yada&#8230;&#8221;

## Community Highlights

  * New integration with [Datadog][2], with a huge set of supported actions. Thanks [@sanecz][3]!
  * Updated [Github][4] pack with support for managing releases and deployments, courtesy of [jjm][5].
  * AWS pack [update][6] to allow processing more SQS messages.
  * HPE-ICSP [bugfixes][7] from [Paul Mulvihill][8] 

## Want to see the future?

The cool thing about StackStorm code development is being able to see the WIP PRs, before they get merged into the main codebase. Here&#8217;s some interesting pieces coming up:

  * [Extend auth to secure ChatOps][9]: The much-loved [@anthonypjshaw][10] just couldn&#8217;t wait for our planned works around improving security controls with ChatOps, so he&#8217;s jump-started things, putting together a great PR.
  * [Pluggable runners][11]: Our very own [@BigMStone][12] is doing work to let us treat runners as plugins. This should make it easier to add new runner types in future. Now I can finally write my actions in Visual Basic.
  * [Pack Management][13]: We want to make it easier to discover and share packs. This PR will lay the groundwork for that.

Watch out for them to get merged into future releases. If you&#8217;re really keen, try them out on your development systems, and pitch in with code & feedback!

 [1]: https://www.datadoghq.com/
 [2]: https://github.com/StackStorm-Exchange/stackstorm-datadog
 [3]: https://twitter.com/sanecz
 [4]: https://github.com/StackStorm-Exchange/stackstorm-github
 [5]: https://github.com/jjm
 [6]: https://github.com/StackStorm-Exchange/stackstorm-aws
 [7]: https://github.com/StackStorm-Exchange/stackstorm-hpe_icsp
 [8]: https://github.com/paul-mulvihill
 [9]: https://github.com/StackStorm/st2/pull/2920
 [10]: https://twitter.com/anthonypjshaw
 [11]: https://github.com/StackStorm/st2/pull/2824
 [12]: https://twitter.com/BigMStone
 [13]: https://github.com/StackStorm/st2/pull/2842