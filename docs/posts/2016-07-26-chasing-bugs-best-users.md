---
title: Chasing Bugs, and the Best Users
author: st2admin
type: post
date: 2016-07-26T21:30:40+00:00
url: /2016/07/26/chasing-bugs-best-users/
dsq_thread_id:
  - 5016914759
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
tags:
  - bugs
  - GitHub

---
**July 26, 2016**  
_by Lindsay Hill_

We love our users. We love them even when they report bugs. We love them **because** they report bugs. But we **really, really** love our users when they report bugs, along with complete configurations, how to reproduce the bug, and logs. Recently [Brian Martin][1] did just this, helping us resolve a tricky deadlock bug. Thank you Brian!

## Tracking down Deadlocks

When you&#8217;re investigating a bug report, the first thing you want to do is to try to reproduce it. This helps you see what&#8217;s going on, and it gives you a clear test case to see if you&#8217;ve resolved it. Deadlocks & race conditions can be horrible bugs to work with, as they are often difficult to reproduce. They might depend upon your hardware resources, or what other jobs are running at the same time. Even reproducing it on the exact same setup is tough.

<!--more-->

So when you get initial reports of a possible deadlock, you groan, knowing that it&#8217;s going to be tough to prove/disprove the issue.

## A Great Bug Report

[@bri365][1] logged issue [#2814][2] two weeks ago: &#8220;Workflows with action policies can deadlock.&#8221; Yuck. Brian had identified a problem where the system deadlocks when the `action_dispatcher_pool` gets filled with workflows. All workflow actions are subsequently held in the `_work_buffer` queue indefinitely.

Basically if you&#8217;re trying to run a lot of workflows at once, they might fill up the same queue that the actions use. The workflows want to run their actions, but they can&#8217;t, because the queue is full&#8230;of workflows. The queue will never empty.

It was a pretty good description. But it went on. Brian created an example pack, containing simplified actions and policies, and the commands required to trigger the deadlock. Further on, he added the complete commands required to create a StackStorm system, add this test pack, and trigger the deadlock, and example CLI output.

He also proposed a couple of possible design changes to resolve the issue, and a workaround using another policy.

This triggered a discussion with the developers, who worked through a few ideas, before agreeing on an approach, and creating a patch.

> If you think this bug might affect you, we&#8217;ve merged a patch in [#2823][3]. This is currently in the 1.6dev branch. We&#8217;re not too far away from releasing 1.6, but if you&#8217;re feeling keen, try out the [unstable][4] repo. Note that this has not undergone full testing! 

Thanks Brian. We really appreciate it.

If you think you&#8217;ve found a bug, please help us to help you. The more detail you can give us, the faster we can resolve the issue. We&#8217;re always happy to chat about it on our [#community][5] Slack channel too. Jump in there and we can work through any issues you&#8217;re having.

 [1]: https://github.com/bri365
 [2]: https://github.com/StackStorm/st2/issues/2814
 [3]: https://github.com/StackStorm/st2/pull/2823
 [4]: https://packagecloud.io/StackStorm/unstable/install
 [5]: http://stackstorm.com/community-signup