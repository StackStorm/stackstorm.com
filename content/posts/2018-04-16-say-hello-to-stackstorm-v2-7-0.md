---
title: Say hello to StackStorm v2.7
author: Tomaz Muraus
type: post
date: 2018-04-16T23:38:38+00:00
url: /2018/04/16/say-hello-to-stackstorm-v2-7-0/
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Blog
  - News
tags:
  - release

---
_April 16, 2018_  
_by Tomaz Muraus_

Spring is here and with that we are happy to announce a new StackStorm release: v2.7. This release includes various new features, improvements and bug-fixes. The biggest change you&#8217;ll notice is improved Mistral performance. Read on for more details on this, and everything else we&#8217;ve done:

<!--more-->

> Note: StackStorm 2.7.1 was released a few days after 2.7.0. This fixed two small issues, one related to the release of [Pip 10.0][1]. If you installed StackStorm v2.7.0, you should upgrade to v2.7.1.

## Improved Performance of Mistral Workflows

One of the bigger changes included in this release is how we retrieve results for Mistral workflows.

In the previous versions, we used the `st2resultstracker` service which would periodically poll Mistral for results of the completed workflows and store that information in the database. That was a so-called polling approach.

In this release we switched from polling to a push-based approach. Instead of `st2resulttracker` periodically polling Mistral for workflow status, Mistral now notifies StackStorm of completion, using the `st2api` service.

This approach allows for a better utilization of CPU by action runners services and Mistral. On average users should see long Mistral workflows complete 5-20% faster compared to older versions.

<div id="attachment_7716" style="width: 1034px" class="wp-caption aligncenter">
  <a href="https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-resultstracker_2018-01-19_at_11.39.24_pm.png"><img aria-describedby="caption-attachment-7716" loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-resultstracker_2018-01-19_at_11.39.24_pm-1024x651.png" alt="" width="1024" height="651" class="wp-image-7716 size-large" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-resultstracker_2018-01-19_at_11.39.24_pm-1024x651.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-resultstracker_2018-01-19_at_11.39.24_pm-150x95.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-resultstracker_2018-01-19_at_11.39.24_pm-300x191.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-resultstracker_2018-01-19_at_11.39.24_pm-768x488.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-resultstracker_2018-01-19_at_11.39.24_pm-80x51.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-resultstracker_2018-01-19_at_11.39.24_pm-220x140.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-resultstracker_2018-01-19_at_11.39.24_pm-157x100.png 157w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-resultstracker_2018-01-19_at_11.39.24_pm-236x150.png 236w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-resultstracker_2018-01-19_at_11.39.24_pm-374x238.png 374w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-resultstracker_2018-01-19_at_11.39.24_pm-653x415.png 653w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-resultstracker_2018-01-19_at_11.39.24_pm-766x487.png 766w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-resultstracker_2018-01-19_at_11.39.24_pm-936x595.png 936w" sizes="(max-width: 1024px) 100vw, 1024px" /></a>
  
  <p id="caption-attachment-7716" class="wp-caption-text">
    StackStorm services CPU usage when using old polling approach. For higher resolution, click on the photo.
  </p>
</div>

<div id="attachment_7717" style="width: 1034px" class="wp-caption aligncenter">
  <a href="https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-callback_2018-01-20_at_12.05.21_am.png"><img aria-describedby="caption-attachment-7717" loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-callback_2018-01-20_at_12.05.21_am-1024x651.png" alt="" width="1024" height="651" class="wp-image-7717 size-large" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-callback_2018-01-20_at_12.05.21_am-1024x651.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-callback_2018-01-20_at_12.05.21_am-150x95.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-callback_2018-01-20_at_12.05.21_am-300x191.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-callback_2018-01-20_at_12.05.21_am-768x488.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-callback_2018-01-20_at_12.05.21_am-80x51.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-callback_2018-01-20_at_12.05.21_am-220x140.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-callback_2018-01-20_at_12.05.21_am-157x100.png 157w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-callback_2018-01-20_at_12.05.21_am-236x150.png 236w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-callback_2018-01-20_at_12.05.21_am-374x238.png 374w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-callback_2018-01-20_at_12.05.21_am-653x415.png 653w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-callback_2018-01-20_at_12.05.21_am-766x487.png 766w, https://stackstorm.com/wp/wp-content/uploads/2018/04/mistral-st2-callback_2018-01-20_at_12.05.21_am-936x595.png 936w" sizes="(max-width: 1024px) 100vw, 1024px" /></a>
  
  <p id="caption-attachment-7717" class="wp-caption-text">
    StackStorm services CPU usage when using new push (callback) approach. For higher resolution, click on the photo.
  </p>
</div>

We believe the performance increases we have seen and measured should apply to most of our users, so we have enabled this behavior by default. If for some reason you want to revert back to the previous approach you can do that by setting the `mistral.enable_polling` config option to `True` and restart all ST2 services.

> &#8230;ran about 20% faster, with more of the machine actually being utilized by st2actionrunner instances instead of dominated by st2resultstracker and st2api

<p style="text-align: center;">
  <em>Quote from Nick Maludy (Encore Technologies), a long time StackStorm user and contributor who has tested this change on their setup.</em>
</p>

For more information, please refer to the [Mistral Workflows Completion, Latency, and Performance][2] section of the documentation.

For people who would like to dig deeper and are interested in the code changes, you can check those pull requests &#8211; <https://github.com/StackStorm/st2/pull/4000>, <https://github.com/StackStorm/st2mistral/pull/35>, <https://github.com/StackStorm/st2/pull/4023>.

## Ability to specify a git revision of a pack action to use for an execution

We added a new feature which allows users to specify a git revision (tag/branch/commit hash) of a pack resource (action) to use for an execution.

This functionality is useful in many scenarios, including zero downtime pack deployments where you have deployed a new version of a pack to the system, but you want some of your executions to still use the old version of the pack content.

Right now this feature is supported by the local and Python runner. It only applies and works with packs which are git repositories (this is the default recommended way and true for all packs on [StackStorm Exchange][3]).

Internally this feature utilizes [git worktree][4] functionality and requires a git version >= 2.5 to be installed on the system (the latest stable git version is recommended).

If you running Ubuntu 14.04 you can get the latest version of git from the [official git ppa repository][5] and if you use RedHat 6 / 7, you can use [IUS repositories][6].

### Example Usage

The best way to demonstrate this functionality is using a pack which was built for purposes of demonstrating and testing it &#8211; <https://github.com/StackStorm-Exchange/stackstorm-test-content-version>.

<span>This pack contains 3 different actions which sole purpose is to print out the current pack version. The pack itself contains 4 different versions/tags (v0.1.0, v0.2.0, v0.3.0, v0.4.0). In a standard StackStorm pack git repository layout each pack version should have a corresponding git tag.</span>

By default, if no version if specified, the latest installed and checked out version is used. This is the same behavior as before:



To run a specific version, you provide content_version runner parameter. In this case we specified git tag v0.2.0 which matches the same pack version:



More information and limitations can be found in the documentation &#8211; [Using a Specific Version of Pack Content When Running an Action][7].

For people interested in the code changes, please see the following pull requests &#8211; <https://github.com/StackStorm/st2/pull/3997>, <https://github.com/StackStorm/st2/pull/4078>.

## Other Changes

In addition to those two new features, this release also includes many other improvements and bug-fixes.

To name a few:

<ul style="list-style-type: circle;">
  <li>
    `st2 execution tail` command now supports double nested workflows.
  </li>
  <li>
    Fix Python runner actions and “Argument list too long” error when very large parameters are passed into the action.
  </li>
  <li>
    All the runners are now fully standalone and re-distributable Python packages.
  </li>
  <li>
    Updates to the Windows runner so the result object now matches result object from the local and remote runner. This change is partially backward incompatible, for more details, please refer to the <a href="https://docs.stackstorm.com/upgrade_notes.html#st2-v2-7">Upgrade Notes</a>.
  </li>
  <li>
    Various internal code changes which will make supporting Python 3 in the future easier.
  </li>
</ul>

For a full list of changes, please refer to the changelog.

## Try It Out

v2.7.1 packages are available in apt and yum repos. Follow the standard instructions to [install this version][8], or upgrade following the [General Upgrade Procedure][9]. As always, backup first.

## Thank You

As always, this release wouldn’t have been possible without our great open-source community and users.

Special thanks to Nick Maludy, Anthony Shaw, Ben Hohnke, Carlos, @djh2020, @mxmader, @sumkire, @SURAJTHEGREAT and others who have contributed to the release in one form or another.

 [1]: https://blog.python.org/2018/04/pip-10-has-been-released.html
 [2]: https://docs.stackstorm.com/mistral.html#mistral-workflows-completion-latency-and-performance
 [3]: https://exchange.stackstorm.org/
 [4]: https://git-scm.com/docs/git-worktree
 [5]: https://launchpad.net/~git-core/+archive/ubuntu/ppa
 [6]: https://ius.io/Packages/
 [7]: https://docs.stackstorm.com/latest/reference/content_version.html
 [8]: https://docs.stackstorm.com/install/index.html
 [9]: https://docs.stackstorm.com/install/upgrades.html#general-upgrade-procedure