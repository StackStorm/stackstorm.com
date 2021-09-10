---
title: StackStorm 1.3.0 is here!
author: Dmitri Zimine
type: post
date: 2016-01-29T21:07:51+00:00
url: /2016/01/29/stackstorm-1-3-0-is-here/
dsq_thread_id:
  - 4534879396
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community

---
**January 29, 2016**  
_by Dmitri Zimine_

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2016/01/1.3.0.9.png" alt="1.3.0" width="658" height="265" class="aligncenter size-full wp-image-5300" /> 

Fellow automators, we are happy to announce StackStorm 1.3. In this &#8220;Holiday release&#8221; (yes most of the work took place around the holidays) we took a break from &#8220;big features&#8221; and focused on addressing key learnings from extensive field usage, turning feedback from our expert users, and our own take aways from internal StackStorm use, into practical product improvements. The highlight of the release is a long-awaited ability to restart a workflow from a point of failure. We have been pushing it through for quite a while, first in upstream OpenStack Mistral, than exposing it via StackStorm, and now it&#8217;s ready for the prime time. With other highlights &#8211; making it easier to debug rules, track complex automation executions, and keep the history size under control &#8211; 1.3 release is a major step up in making StackStorm performant, operational and convenient.

Read on to learn about release highlights and what is coming up next. To upgrade, [follow this KB][1].

<!--more-->

# Feature highlights

### 1. Rule debugging

StackStorm is built to be as transparent &#8211; so users trust the system to take powerful actions. However, we have learned that debugging a rule could be frustrating even for a StackStorm expert. You configure a sensor and set up a rule to call an action on an external event. The event fired, but action did not execute. Where did it fail? Did the event come to a sensor? Did the trigger instance got fired? Did the rule match? Was the action scheduled? And where do I look for all of it? v1.3 brings the tools to find the answers.

Specifically, we put in place some missed links to track the whole pipeline; added extra options to CLI commands and improved `st2-rule-tester` to enable an end-to-end rule debugging workflow for a variety of scenarios. Traces and trace-tags come handy here, too (see below). Check [rule troubleshooting docs][2] for instructions; a blog post with details is coming shortly.

### 2. Traces improvements

Firing multiple actions on external events, nested workflows, triggering more actions and workflow on action completions via rules and action-triggers give great power. But operating and troubleshooting complex automation requires good tooling. We have been improving transparency: few versions ago (0.1.3), we introduced traces and trace-tags to gain everything comprising a full end-to-end automation execution.Now, ased on the field feedback from our largest users, we are bringing **extra options** to help ops get to the crux of the problem faster, with less noise. With [new improved trace][3] you can:

  * View a causation chain of all the trigger instances, rule invocations, and action executions &#8211; getting everything that leads to a failed execution, for instance.
  * Filter out the noise &#8211; show only executions, triggers, rules, or turn off all action-triggers that didn&#8217;t lead to triggering with `--hide-noop-triggers` flag.

Trace tags for an action execution can now be supplied in the WebUI. Viewing traces are still in CLI only: a convenient view in WebUI to see the whole chain of events is something we are thinking next; contributions welcome!

### 3. Keeping history trimmed

Running StackStorm at scale produces hundreds of thousands action executions. Over time the ever-growing operational history begins to impact performance. To make it easier to keep the history size under the tap, we introduce a [garbage collector service][4] that auto-trims the DB per your desired configuration. Commands are also available to purge history manually by a variety of criteria.

&#8220;But what is happening with my year worth of operation execution records? I need the audit, and want to do some analytics on it!&#8221; Not to worry: all audit data, all the details of executions are stored in structured `*.audit.log` files. Save them, grok them to your Logstash or Splunk, slice and dice them for insides of your operations. A dedicated audit service is on the roadmap for Enterprise Edition; it will provide a native indexed searchable view for years worth of history, with analytics and reporting on top (sign up for &#8220;alpha&#8221; soon).

### 4. Re-run workflow from a failure point

With transparency of workflow executions you know exactly which task has failed; we commented elsewhere on the [return of workflows as the backbone of event driven automation][5] &#8211; take a look if you are interested in the subject.

But what exactly are you supposed to do when a workflow fails &#8211; even if workflow tells you which one fails, now what? When, after a long preparation, workflow creates 100 instances and fails on 99th&#8230; and you know exactly the point of failure, it still sucks. What if it failed by external conditions, e.g network connectivity lost or a target service unavailable? Can I fix the conditions, and just continue the workflow execution from where it failed? From 1.3 the answer is &#8220;yes you can&#8221;.

Now you can re-run a failed workflow from a point of failure. Do `st2 re-run` and point it to a failed task (or tasks!); StackStorm re-runs the failed task with the same input, and continues workflow execution. Read [here how to do it][6].

This ability to recover from failure, along with clarity of execution state, is a highlight of the 1.3 release, and one big reason why workflows are triumphing over &#8220;just scripts&#8221;.

* * *

As usual, there are a number of smaller improvements, each to make StackStorm one bit better and one notch easier to use. Check the [CHANGELOG][7] to appreciate the improvements.

We are especially happy with community contributions. Folks from [Plexxi][8], [SendGrid][9], [TCP Cloud][10], [Netflix][11], [Move.com][12], and [Dimension Data][13], along with individual contributors brought in quite a few features and fixes. My personal favorites are the support for containers from [Andrew Shaw][14], HipChat improvements for Chatops from [Charlotte St. John][15], and SQS AWS actions from [Adam Hamsik][16] and [kuboj][17]. Thank you ALL from behalf of all StackStorm users!

# Upgrading 1.2 -> 1.3

Please follow this KB for upgrading. We strongly recommend migrate if/when possible, but the in place-upgrade is tested and should generally work. Always keep the content separated so that you can deploy full automation on a new instance of StackStorm.

# What&#8217;s next

These weeks we are heads down improving StackStorm installation. All-in-one installer is a great way to get the turn-key StackStorm installation for evaluation on a clean system. However we understand the need for a custom package-based installations. Stay tuned for proper self-contained deb/rpm packages, they&#8217;re just around the corner. And a docker image with StackStorm is in the works, as an alternative for quick evaluation.

Our immediate next focus is managing and operating automation content. A Forge for convenient sharing of integration and automation packs; an end-to-end user flow and tooling support for pack development, deployment, and updates; pack versioning and dependencies, UI improvements to and much more.

And, of course, ChatOps. We see it as a focal point of operations, bridging team work with automation in a magical way. StackStorm brings ChatOps as essential part of end-to-end solution, stay tuned for improvements (some hints [here][18]).

For a year of upcoming StackStorm functionality, see [ROADMAP][19].

As always, your feedback is not welcome, it is required! Leave comments here, share and discuss ideas on [stackstorm-community][20], and submit PRs on Github. We are excited to see StackStorm maturing, and together with our user community we will make it great.

 [1]: https://stackstorm.reamaze.com/kb/installation/upgrade-from-v1-dot-2-to-v1-dot-3
 [2]: https://docs.stackstorm.com/troubleshooting/rules.html
 [3]: https://docs.stackstorm.com/traces.html
 [4]: https://docs.stackstorm.com/troubleshooting/purging_old_data.html
 [5]: http://devops.com/2015/04/09/return-workflows/
 [6]: https://docs.stackstorm.com/mistral.html#rerunning-workflow-execution
 [7]: https://docs.stackstorm.com/changelog.html#january-22-2016
 [8]: http://www.plexxi.com/
 [9]: https://sendgrid.com/
 [10]: http://www.tcpcloud.eu/
 [11]: http://www.netflix.com
 [12]: http://www.move.com
 [13]: https://www.dimensiondata.com/Global
 [14]: https://github.com/tonybaloney
 [15]: https://github.com/charlottestjohn
 [16]: https://github.com/haad
 [17]: https://github.com/kuboj
 [18]: https://stackstorm.com/2015/12/10/chatops_pitfalls_and_tips/#5_future
 [19]: http://docs.stackstorm.com/roadmap.html
 [20]: http://stackstorm-community.slack.com