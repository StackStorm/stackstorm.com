---
title: 'Patch Patch Patch: StackStorm 2.7.2'
author: st2admin
type: post
date: 2018-05-16T20:21:14+00:00
url: /2018/05/16/patch-patch-patch-stackstorm-2-7-2/
thrive_post_fonts:
  - '[]'
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
Hey folks &#8211; StackStorm 2.7.2 has been released. We&#8217;ve fixed a bug affecting sensors, improved Jinja rendering, fixed a couple of Web UI bugs and improved the LDAP & RBAC handling for Enterprise users. This is a recommended update for all users. Read on for the details.

<!--more-->

## Changes & Fixes

  * Sensors that use `select.poll()` were broken in 2.7 due to eventlet changes. This has been fixed.
  * Pack configuration now properly renders Jinja expressions when lists are used.
  * Config rendering error messages are now a bit easier to understand.
  * Web UI links to actions from the Rules tab now work properly.
  * The Web UI no longer crashes if your action metadata includes a custom object that has a secret parameter.

## Enterprise Enhancements

A couple of improvements to LDAP & RBAC handling, especially for those people using automatic group -> role synchronization:

  * Cache users group information for 120s. This reduces the load on the LDAP server.
  * Fix a race condition where not all groups would be synchronized if the user re-authenticated witht the same token within a short window.

Details of fixes and changes are in [the changelog][1].

As ever, thanks to all those who contributed in some way, via code, bug reports, and feature requests.

## Backup First!

Packages are now available in `apt` and `yum` repos. Backup first, then follow the [General Upgrade procedure][2] to upgrade.

Having a problem? Get in touch via [Slack][3] or [GitHub][4].

 [1]: https://docs.stackstorm.com/changelog.html
 [2]: https://docs.stackstorm.com/install/upgrades.html#general-upgrade-procedure
 [3]: https://stackstorm.com/community-signup
 [4]: https://github.com/StackStorm/st2/issues