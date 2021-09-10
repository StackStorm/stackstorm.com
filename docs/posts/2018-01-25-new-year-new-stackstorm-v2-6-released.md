---
title: New Year, New StackStorm – v2.6 Released
author: st2admin
type: post
date: 2018-01-25T23:38:54+00:00
url: /2018/01/25/new-year-new-stackstorm-v2-6-released/
thrive_post_fonts:
  - '[]'
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6438262333
categories:
  - News
tags:
  - release
  - StackStorm

---
**January 25, 2018**

It&#8217;s a New Year, and time for a new version of StackStorm. 2.6 is available for download now. The biggest change is moving the Web UI to the [React][1] JS framework, but of course there&#8217;s also multiple user- and developer-friendly fixes and enhancements in the backend. Read on to hear more about what&#8217;s changed:

<!--more-->

## Web UI Overhaul

Our Web UI was originally written using [Angular][2]. That served us well, but we had a number of issues, and we wanted to move to newer, more flexible framework. Thanks to a lot of work from a few clever developers, we&#8217;ve switched this to React. At first glance, you might think it looks pretty similar to before:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/01/basic_history_tab.png" alt="" width="2560" height="848" class="aligncenter size-full wp-image-7628" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/01/basic_history_tab.png 2560w, https://stackstorm.com/wp/wp-content/uploads/2018/01/basic_history_tab-150x50.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/01/basic_history_tab-300x99.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/01/basic_history_tab-768x254.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/01/basic_history_tab-1024x339.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2018/01/basic_history_tab-80x27.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/01/basic_history_tab-220x73.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/01/basic_history_tab-250x83.png 250w, https://stackstorm.com/wp/wp-content/uploads/2018/01/basic_history_tab-280x93.png 280w, https://stackstorm.com/wp/wp-content/uploads/2018/01/basic_history_tab-510x169.png 510w, https://stackstorm.com/wp/wp-content/uploads/2018/01/basic_history_tab-750x248.png 750w, https://stackstorm.com/wp/wp-content/uploads/2018/01/basic_history_tab-975x323.png 975w, https://stackstorm.com/wp/wp-content/uploads/2018/01/basic_history_tab-1190x394.png 1190w" sizes="(max-width: 2560px) 100vw, 2560px" />][3]

But as you start poking around you&#8217;ll notice a few changes. We&#8217;ve closed a number of [long-standing issues][4]. Small things that make a difference &#8211; e.g. remembering the state of the &#8220;Wrap newlines&#8221; button, more filters for the History tab, and key-bindings to make life easier.

This also sets us up for further enhancements, such as better support for [colorblind users][5]. We&#8217;re also planning a bigger overhaul of the UX, and now we&#8217;re in a position to do that.

Workflow Composer users will also see that we&#8217;ve started switching [colors and logos][6]:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/01/extreme_branding.png" alt="" width="2522" height="600" class="aligncenter size-full wp-image-7629" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/01/extreme_branding.png 2522w, https://stackstorm.com/wp/wp-content/uploads/2018/01/extreme_branding-150x36.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/01/extreme_branding-300x71.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/01/extreme_branding-768x183.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/01/extreme_branding-1024x244.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2018/01/extreme_branding-80x19.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/01/extreme_branding-220x52.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/01/extreme_branding-250x59.png 250w, https://stackstorm.com/wp/wp-content/uploads/2018/01/extreme_branding-280x67.png 280w, https://stackstorm.com/wp/wp-content/uploads/2018/01/extreme_branding-510x121.png 510w, https://stackstorm.com/wp/wp-content/uploads/2018/01/extreme_branding-750x178.png 750w, https://stackstorm.com/wp/wp-content/uploads/2018/01/extreme_branding-975x232.png 975w, https://stackstorm.com/wp/wp-content/uploads/2018/01/extreme_branding-1190x283.png 1190w" sizes="(max-width: 2522px) 100vw, 2522px" />][7]

This is not yet complete. You&#8217;ll still see a few Brocade references around the place. We&#8217;re planning to complete this migration in the next release.

On to the other changes!

## Developer-Focused Improvements

Here&#8217;s some of the improvements and fixes that developers will appreciate:

  * Packs can now have a `lib` directory to share code between actions and sensors. See the [docs][8] to understand how to use this.
  * The default log level of all Python runner actions can now be set in `st2.conf`.
  * The st2client package can now also work with Python 3. **NOTE**: This is just the start of longer-term Python 3 work. Python 2.7 is still the only officially supported and tested version. There may be rough edges if you&#8217;re using Python 3. Please file issues if you see anything misbehaving.
  * Python runner action performance regressions have been fully fixed (this was partially fixed in 2.5.1).

## User-Focused Improvements

And here&#8217;s more user-facing changes:

  * `st2 {run|action execute|execution re-run}` commands now support the `--tail` flag. This will automatically follow the requested action output.
  * `core.local` and `core.remote` now support password-protected `sudo` using the `sudo_password` runner parameter.
  * You can now request the complete result set from commands like `st2 execution list` using the `--last -1` flag.
  * Some pesky `\n` characters were showing up in some execution outputs. This has been been cleaned up.

## Other Changes

Other changes of note:

  * If you have custom Python actions that use `from st2actions.runners.pythonrunner import Action`, this should be updated to use `from st2common.runners.base_action import Action`. The legacy style is deprecated, and will be removed in 2.7.0. All packs on the [Exchange][9] have been updated to use the newer style. Make sure you update our packs, including the core st2 pack. Run `st2 pack install st2` to pull down the latest version.
  * Inquiry responses marked as &#8220;secret&#8221; are now properly masked.
  * Real-time action output streaming is enabled by default.

As always, full details in [the changelog][10].

Thank you to everyone that contributed in some way towards this release.

Packages are now available in `apt` and `yum` repos. Make sure you backup first, and follow the [General Upgrade Procedure][11] to upgrade. We also recommend checking your packs for updates.

As always, if you run into any problems, get in touch via [Slack][12] or [GitHub][13].

 [1]: https://reactjs.org/
 [2]: https://angularjs.org/
 [3]: https://stackstorm.com/wp/wp-content/uploads/2018/01/basic_history_tab.png
 [4]: https://github.com/StackStorm/st2web/issues?page=2&q=is%3Aissue+is%3Aclosed
 [5]: https://github.com/StackStorm/st2web/pull/464
 [6]: https://stackstorm.com/2017/11/03/stackstorm_goes_extreme/
 [7]: https://stackstorm.com/wp/wp-content/uploads/2018/01/extreme_branding.png
 [8]: https://docs.stackstorm.com/reference/sharing_code_sensors_actions.html
 [9]: https://exchange.stackstorm.org
 [10]: https://docs.stackstorm.com/changelog.html
 [11]: https://docs.stackstorm.com/install/upgrades.html#general-upgrade-procedure
 [12]: https://stackstorm.com/community-signup
 [13]: https://github.com/StackStorm/st2/issues