---
title: 2.1 is here! New Pack Management and More!
author: st2admin
type: post
date: 2016-12-06T18:05:58+00:00
url: /2016/12/06/2-1-new-pack-management/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5360242487
categories:
  - Community
  - News
tags:
  - release
  - release announcement

---
**December 6, 2016**  
_by Lindsay Hill_

Ta-da! It’s here! StackStorm version 2.1 has been released, and there are some big changes. So big that we started wondering if we should have called this release version 3.0. Pack management has had a _lot_ of work done, and we think you’ll be pleased with the results. Plus good news for those patiently waiting for Ubuntu 16.04LTS support!

## Packs Packs Packs&#8230;it’s (mostly) all about Packs

The big theme for this release is Pack Management. We’ve upgraded, enhanced, overhauled & refitted pack management, and we’re very pleased to introduce the [StackStorm Exchange][1]

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm_exchange-1024x944.png" alt="stackstorm_exchange" width="800" height="737" class="aligncenter wp-image-6370" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm_exchange-1024x944.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm_exchange-150x138.png 150w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm_exchange-300x276.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm_exchange-768x708.png 768w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm_exchange-80x74.png 80w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm_exchange-220x203.png 220w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm_exchange-109x100.png 109w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm_exchange-163x150.png 163w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm_exchange-258x238.png 258w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm_exchange-450x415.png 450w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm_exchange-528x487.png 528w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm_exchange-646x595.png 646w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm_exchange.png 1339w" sizes="(max-width: 800px) 100vw, 800px" />][2]

<p style="text-align: center;">
  Shiny new StackStorm Pack Exchange.
</p>

<!--more-->

With this change, working with packs becomes more like the “usual” package management you know from working with development platforms and operating systems. Installing, updating, and managing StackStorm packs has become a smoother, more streamlined experience.

We have a new CLI for pack management (`st2 pack`), new [GitHub organisation][3], and new workflows. Particularly for our long-time users, you must read the [documentation][4] to understand the changes.

Key things to watch out for:

  * Pack names now have to have underscores, not dashes
  * The “packs” pack is now deprecated. Use `st2 pack` instead
  * Pack versions **must** use semantic versioning. `0.1.0` is fine, `0.5` is not.
  * `st2 pack config` only works with the newer `config.schema.yaml` style of [configuration][5].

All packs in the StackStorm Exchange have been updated to account for these differences. Your private packs may need changes too. It’s a big change &#8211; that’s why Dmitri put out the [early warning][6]. We’ll also have a follow-up blog coming soon explaining more about the changes, why we made them, and all the cool things you can now do.

## Ubuntu 16.04LTS &#8211; Xenial support!

So, you started asking for [Xenial support][7] about oh, 10s after Ubuntu released 16.04LTS. We’re pleased to announce that it is here at last. Ubuntu 16.04 is now a supported platform, and packages are available. Run the [one-line installer][8], and it will auto-magically sort it out. Or do the install [manually][9]. It’s up to you.

> Aside: RHEL 6.x/CentOS 6.x is starting to get long in the tooth, and becoming more of a pain to support. How hurt would you be if we dropped RHEL 6.x support in May 2017? Let us know! 

## Other Bits & Bobs

OK, so this release is mostly about new pack management. But it’s not just that. There’s a few other fixes & improvements too. The full list is in our [changelog][10] as always, but the highlights are:

### Enhancements:

  * Performance: Speed up short-lived Python runner actions. We’ve re-organized and refactored some code to avoid expensive imports in the places where those imports are not actually needed. You should notice this if you have a lot of small actions being spawned.
  * Add support for default values and dynamic config values for nested config objects. This one is really important for using `config.schema.yaml` &#8211; which you should be doing now. No excuses for not migrating your packs.
  * Improved performance for querying action execution history, with additional indexes and allowing users to supply multiple resource IDs when filtering results.

### Bugfixes:

Yes, there were bugs. We’ve been trying the stick approach with the developers, but it hasn’t worked. Given their dietary habits, I’m not sure the carrot approach will help either. Until we find a way to write perfect code every time, we’ll keep doing what we’re doing: fix bugs just as soon as we find them, and add tests so they don’t happen again.

Here’s a few notable fixes:

  * Action parameter names should only allow valid word characters (a-z, 0-9, _). That was always the intention, but let you get away with anything for a while there. No more. Pack registration will fail if you try to use a verboten character.
  * Sensors tried to use a temporary token to access the datastore, and didn’t do anything if that token expired. This caused much confusion when your custom sensor worked for a while, then randomly stopped behaving. Sorry about that [pixelrebel][11].

Thanks to Anthony Shaw, Paul Mulvihill, Eric Edgar and more, for their contributions.

## Installing & Upgrading

We **strongly** urge you to read the [upgrade notes][12] before upgrading. Things have changed, and if you blindly upgrade without paying attention you will get caught out. It’s bad enough to strike a bug when you upgrade, but it’s more embarrassing to be caught out by a known, documented change in behavior.

New 2.1 packages are now in the `stable` repositories. If you’re already running StackStorm 2.0, you can upgrade using `yum` or `apt`.

> As always, we strongly recommend that you treat your automation code as true code &#8211; use source control systems, use configuration management systems. You break it, you get to keep the pieces. This is particularly important for this release where we’ve made many changes to pack management. 

Of course, if you have any problems, jump into our [Slack Community][13], and we’ll do our very best to help.

 [1]: https://exchange.stackstorm.org
 [2]: https://exchange.stackstorm.org/
 [3]: https://github.com/StackStorm-Exchange
 [4]: https://docs.stackstorm.com/latest/reference/packmgmt.html
 [5]: https://docs.stackstorm.com/pack_configs.html#configuration-schema
 [6]: https://stackstorm.com/2016/11/29/2-1-headsup/
 [7]: https://github.com/StackStorm/st2-packages/issues/296
 [8]: https://docs.stackstorm.com/install/
 [9]: https://docs.stackstorm.com/install/deb.html
 [10]: https://docs.stackstorm.com/changelog.html
 [11]: https://github.com/pixelrebel
 [12]: https://docs.stackstorm.com/upgrade_notes.html
 [13]: https://stackstorm.com/community-signup