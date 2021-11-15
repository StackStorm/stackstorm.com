---
title: 'Quick One: ST2 2.4.1 is Released'
author: st2admin
type: post
date: 2017-09-18T22:18:39+00:00
url: /2017/09/18/quick-one-st2-2-4-1-released/
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6153506086
categories:
  - News
tags:
  - release announcement

---
**September 18, 2017**  
_by Lindsay Hill_

Quick note today: We quietly published StackStorm 2.4.1 last week. Nothing major, just a few bug fixes.

First one: Mistral shutdown with systemd is **much** faster. The issue has been resolved [upstream][1]. We&#8217;ve fixed a couple more Mistral-related issues, including better handling of Unicode results.

For our RBAC users, we have fixed a problem where the the system user was being used for pack installation, not the actual user who requested the pack install.

Usual [update process][2] applies (backup first!!!).

 [1]: https://review.openstack.org/#/c/499853/
 [2]: https://docs.stackstorm.com/install/upgrades.html