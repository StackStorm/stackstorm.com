---
title: The Brief History of ChatOps at StackStorm (and How We Got Here)
author: st2admin
type: post
date: 2016-02-26T02:19:14+00:00
url: /2016/02/25/history-of-chatops/
dsq_thread_id:
  - 4612083713
categories:
  - Blog
  - Community
  - Events
tags:
  - chatops
  - StackStorm

---
**February 25, 2016**  
_by Evan Powell_

These days ChatOps has become all the rage. In this blog I’ll talk a little bit about how we came to be here &#8211; in a leading position when it comes to ChatOps adoption for operations. And I’ll point you to some resources from users and our own engineers to learn more.

The history lesson will be brief, I promise.

We started StackStorm after observing that existing solutions in the devops universe were generally point solutions, often evolved from scripts and other projects that DevOps engineers wrote to make their own lives easier. And that’s a great way to build a solution that appeals at least to those types of users for those specific use cases.

<img src="http://stackstorm.com/wp/wp-content/uploads/2016/02/chatops.png" alt="chatops" class="aligncenter" /> 

What we saw was that while there were leaders within certain segments amongst those tools, there was no clearly adopted pattern for the wiring that tied all these tools together. Moreover, with our backgrounds in enterprises we knew that wiring together extremely heterogeneous environments is always a challenge. The enterprise is more a brownfield than a greenfield.

A quick shout out to teams at Facebook and at WebEx Spark and all those other early interviewees that taught us so much about event driven automation. And if you want to join a non commercial Bay Area meet-up about the subject and hear speakers from organizations like Facebook and LinkedIn and Netflix, please join here:  
<a href="http://www.meetup.com/Auto-Remediation-and-Event-Driven-Automation/" target="_blank">http://www.meetup.com/Auto-Remediation-and-Event-Driven-Automation/</a> <!--more-->

## So &#8211; where does ChatOps join the story?

ChatOps is a huge movement in DevOps &#8211; and crossing into the enterprise. An analyst recently told me that 2016 is a the year of ChatOps and I tend to believe him.

To get going ChatOps experimenters are tying together one or two or three systems either directly into Slack or via Hubot, Lita, Err or another fairly friendly bot. And by doing so they are starting to experience the power of ChatOps.

It is what happens next, when they then try to tie together most of their environment, that they run into barriers. These barriers include:  
Tying oneself too closely to a single chat vendor  
Needing a little more smarts in processing what is happening before alerting, and often interrupting, the humans  
Spending significant effort to integrate and then update integrations with underlying systems  
Requiring human sign off and wanting that sign off to address an entire workflow, as opposed to a single step action.

In short &#8211; the reason that StackStorm is getting rapid adoption for ChatOps is that underneath your ChatOps &#8211; you need an event driven automation platform.

Here are some useful resources from StackStorm and other engineers about ChatOps:

  * [The promise and peril of direct to chat or bot centric ChatOps][1] (from our CTO Dmitri Zimine)
  * [Bringing the humans into the loop via approvals][2] (from StackStorm user Igor Cherkaev)
  * [Perspectives on ChatOps from the real world][3] &#8211; James White, Sally Lehman, and StackStorm alumni James Fryman
  * [Can Microsoft’s Yammer work with StackStorm chatops][4] (from StackStorm engineer Edward Medvedev)
  * [Giving your StackStorm powered bot some intelligence via rules and alias capabilities][5] (also from StackStorm engineer Edward Medvedev)
  * [Using StackStorm based ChatOps to manage content in StackStorm][6] (from StackStorm user Jon Middleton):
  * [Patterns of chatops adoption &#8211; how ChatOps can help you see and refactor your automations][7] (from StackStorm user Joe Topjian):
  * [ChatOps bit by bit][8] (by StackStorm alumni James Fryman):

As you can see, there are a lot of resources on the adoption of ChatOps including various patterns and considerations available on the StackStorm blog.

Thanks for reading. Please provide feedback. And if you have an idea for an interesting blog about your experience with StackStorm or ChatOps or event driven automation more broadly, please ping me directly <a href="http://twitter.com/epowell101" target="_blank">@epowell101</a> or via the <a href="https://stackstorm.com/community/" target="_blank">ST2 Slack community</a>.

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2014/03/ph-evan2-150x150.jpg" alt="ph-evan" width="150" height="150" class="alignnone size-thumbnail wp-image-236" /> 

Evan

 [1]: https://stackstorm.com/2015/12/10/chatops_pitfalls_and_tips/
 [2]: https://stackstorm.com/2016/01/21/stackstorm-and-chatops-actions-with-confirmation/
 [3]: https://stackstorm.com/2016/01/16/automation-happy-hour-10-designing-a-remediation-solution/
 [4]: https://stackstorm.com/2016/02/08/stackstorm-yammer-cat-pictures/
 [5]: https://stackstorm.com/2015/12/08/stackstorm-1-2-0-the-new-chatops/
 [6]: https://stackstorm.com/2016/02/15/improvments-to-chatops-pack-development-user-story-in-st2-1-4dev/
 [7]: https://stackstorm.com/2015/08/14/user-story-stackstorm-workflows-and-chatops/
 [8]: https://stackstorm.com/2016/02/03/on-force-multiplication-and-event-driven-automation/