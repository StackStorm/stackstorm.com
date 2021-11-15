---
title: 'StackStorm 2.3.2: Summer of Bugfixes Continues'
author: st2admin
type: post
date: 2017-07-28T21:47:21+00:00
url: /2017/07/28/stackstorm-2-3-2-summer-bugfixes-continues/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 6024103435
tcb2_ready:
  - 1
categories:
  - Blog
tags:
  - release

---
_July 29, 2017_  
_by Lindsay Hill_

The Summer of Bugfixes continues here at StackStorm. The team has put together another patch release, fixing a few annoyances, cleaning up some old bugs, and making StackStorm all-around easier to use. Read on for some of the notable changes:

<!--more-->

## Additions & Changes:

  * New Jinja filter: `regex_substring` &#8211; this will search for a pattern, and return the result, rather than just True|False.
  * The `st2` CLI will now display a note “there are more results” if you use the `-n` flag, and more items are available. This makes for a more consistent experience, and makes sure that you know that you’re not seeing all results. Previously we only displayed this message if you did not request any limit, or requested a higher number than the default (50).
  * You can now explicitly set `stream_url` using st2client and the `st2` CLI.

## Bugfixes

More fixes, including a personal interest bug for me: proxies.

  * Pack installation now works out of the box with proxies. Check [the docs][1] for more details.
  * Pack install now works with private repos that don’t contain a `.git` suffix.
  * Another Unicode fix: this time it’s st2client displaying Unicode in pack descriptions.
  * API fixes: more checks to validate data. You always send properly formed data, so this won’t affect you, right? Right?

Full details in the [Changelog][2].

Much love to those in our community who contributed with bug reports, issues and code. It means a lot to us.  
Our current thinking is that we’ll have 2.3.3 release in the next few weeks. More bugfixes and minor cleanups, so don’t forget to log issues and/or vote on [existing ones][3].

We’re also working on features for the next major release. Some WIP code is already available for [Pack UI][4], [Timezone support][5] in st2web, [st2.ask][6] and [Mistral pause & resume][7]. Look for version 2.4 in September.

## Upgrading

Packages are now available in `apt` and `yum` repos. Make sure you backup first, and check the [upgrade notes][8], especially if you&#8217;re upgrading from pre-2.2. Make sure you check your packs for upgrades too. The community continues to enhance our packs, and system upgrades are also a good time to look at pack changes.

As always, if you run into any problems, get in touch via [Slack][9] or [GitHub][3].

 [1]: https://docs.stackstorm.com/latest/packs.html#installing-packs-from-behind-a-proxy
 [2]: https://docs.stackstorm.com/changelog.html
 [3]: https://github.com/StackStorm/st2/issues
 [4]: https://github.com/StackStorm/st2web/pull/387
 [5]: https://github.com/StackStorm/st2web/pull/380
 [6]: https://github.com/StackStorm/st2/pull/3537
 [7]: https://github.com/StackStorm/st2/pull/3507
 [8]: https://docs.stackstorm.com/upgrade_notes.html
 [9]: https://stackstorm.com/community-signup