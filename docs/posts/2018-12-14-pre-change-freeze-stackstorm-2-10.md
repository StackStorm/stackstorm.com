---
title: 'Pre-Change Freeze: StackStorm 2.10'
author: st2admin
type: post
date: 2018-12-14T19:00:02+00:00
url: /2018/12/14/pre-change-freeze-stackstorm-2-10/
thrive_post_fonts:
  - '[]'
  - '[]'
categories:
  - Community
  - News
tags:
  - release
  - release announcement

---
**Dec 14, 2018**  
_By Lindsay Hill_

Thought you could wind down for the change freeze? Sorry, we’ve got one last thing for you to do: Upgrade StackStorm to 2.10! Orquesta is now ready for almost all workflow use-cases. We’ve also done a big update to our ChatOps internals, and we have early-access Ubuntu 18 + Python 3 packages (for test only!). Read on for full details:

<!--more-->

## Why 2.10? Why not 3.0?

We wanted to ship 3.0 this year. We really did. But we have got some big things planned, worthy of a 3.0 release, and they weren’t _quite_ ready. But we had lots of good stuff already merged into master, like Orquesta updates. So we decided to ship 2.10 now, to get that code into people&#8217;s hands now. It gives us time to make the next release worthy of a major version change.

## Orquesta: Ready for Action

Orquesta is now ready for all users. This release added those missing features that you’ve been waiting for. Key enhancements include:

  * \`with-items\` &#8211; this was the big one holding back many migrations.
  * \`delay\` &#8211; add a delay before running a task.
  * \`notify\` &#8211; this works the **opposite** way to \`skip_notify\`. You list the tasks you \*want\* notification for, not the ones you don’t. Much simpler.
  * Workflow output on error, to help understand why a task failed.
  * Unicode support for handling Unicode data in Orquesta workflows. Thank you to our Japanese users, we 😍 you.

We recommend starting your Mistral -> Orquesta migration now. In the second half of 2019 we will remove Mistral from StackStorm. Don&#8217;t worry! You still have lots of time, but you should start planning now.

## Ubuntu 18.04 + Python 3: Early Preview

Check out our staging-unstable repo &#8211; we are now building [Ubuntu 18.04 aka Bionic packages][1].

A few things to know:

  * This is still **EARLY**. There will be bugs. Do not use it in production then come crying to me because everything broke. By all means, test them out, but expect things to break. This is because&#8230;
  * These packages use **Python 3.6** for all StackStorm processes. Some Exchange packs have been updated, and will work with  Python 3. Some will work anyway, and plenty of others _will have problems_. PRs welcome.
  * No Mistral. Orquesta only. We are not going to create st2mistral packages that will work with Python 3.
  * You will need MongoDB 4.0 with Ubuntu 18.04. The one-line install script installs MongoDB 4.0 on Ubuntu 18.04, but sticks with 3.4 on other distros. In future we’ll switch to MongoDB 4.0 for all supported systems.
  * For now, those packages are only available in our [“staging-unstable” package repos][1]. To use them, pass \`&#8211;staging &#8211;unstable\` flags to the installer script. For example: \`wget https://stackstorm.com/packages/install.sh; bash install.sh &#8211;user=st2admin &#8211;password=Ch@ngeMe &#8211;staging &#8211;unstable\`

We’ll do more testing over the next few months before calling this release GA. When RHEL 8.0 comes out, we will create Python 3-only packages for that too.

## Changes Under the Hood &#8211; New Scheduler Service

To add `delay` functionality for Orquesta workflows we needed to re-design our scheduling service. This service schedules action executions.

In the past, scheduling related code was in the `st2notifier` service. It has moved to a new purpose-built `st2scheduler` service.

This gives us better decoupling, and future flexibility with regards to scheduling algorithms. Today, executions are scheduled using FIFO approach (first in first out). We have plans to add priority scheduling and more efficient workflow execution scheduling. For example, executions belonging to a particular workflow should have priority over other workflow executions. This provides better perceived performance when running many concurrent workflows.

## ChatOps Updates

We have updated all the components used by ChatOps. We updated all our hubot adapters, and we now support Node.js v8 and v10 (preferred). We no longer support Node.js v6. You will need to update your Node.js versions when you upgrade.

While we’ve been updating components, we’ve also had a cleanout. We no longer ship a Yammer adapter by default. (Be honest: you won’t miss it). You can still [add your own adapter][2].

These upgrades are laying the groundwork for future ChatOps improvements we have planned.

## Plus all the rest

Of course, there’s the usual assortment of small fixes and enhancements. A selection of interesting items:

  * \`core.http\` supports more HTTP methods such as OPTION, TRACE, PATCH, PURGE.
  * Runners are now dynamically loaded, as Python packages. In future we will stop shipping the Cloudslang and Winexe-based runners. This dynamic loading will make it easier for users who need to load those legacy runners.
  * We deprecated old runner names a **very** [long time ago][3]. We have finally removed those aliases. If you have a very old action that stops working, check it’s using the right name.
  * New MongoDB authentication options for those needing high-security authentication.

The rest of the details are in the [Change log][4].

## Updating

As always, make sure you have backups first. Then follow the [Upgrade Instructions][5]. There’s a couple of key points to call out:

  1. The GPG keys used for signing our repository metadata have changed. You will need to update your systems to use the new keys.
  2. As noted above, we now support Node.js v10. You will need to add the Node.js v10 repositories to your system to update st2chatops.

Both of those changes are straightforward. If you use Ansible, [our playbooks][6] will manage this for you.

 [1]: https://packagecloud.io/app/StackStorm/staging-unstable/search?q=&filter=all&dist=bionic
 [2]: https://docs.stackstorm.com/latest/chatops/chatops.html#using-an-external-adapter
 [3]: https://docs.stackstorm.com/upgrade_notes.html#st2-v0-9
 [4]: https://docs.stackstorm.com/changelog.html
 [5]: https://docs.stackstorm.com/latest/install/upgrades.html
 [6]: https://github.com/StackStorm/ansible-st2