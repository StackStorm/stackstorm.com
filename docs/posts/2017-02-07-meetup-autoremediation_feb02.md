---
title: 'Meetup: How to automate 94% incident responses: Facebook, Neptune.io, autoremediation'
author: Dmitri Zimine
type: post
date: 2017-02-07T17:08:07+00:00
url: /2017/02/07/meetup-autoremediation_feb02/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5530648826
categories:
  - Blog
  - Community
tags:
  - Auto-remediation
  - meetup

---
**Feb 06, 2017**

_by Dmitri Zimine, <a href="https://twitter.com/dzimine" target="_blank">@dzimine</a>_

Last Thursday, we had another great meetup session on [Auto Remediation and Event Driven Automation][1]. This time it was in San Francisco at [Make School][2], thanks to our new sponsors <a href="https://www.neptune.io" target="_blank">Neptune.io</a>. The drive from South Bay was totally worth it!

<img loading="lazy" class="aligncenter wp-image-3467 size-full" src="http://stackstorm.com/wp/wp-content/uploads/2015/06/event-driven-automation-3.png" alt="event driven automation 3" width="904" height="479" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/06/event-driven-automation-3.png 904w, https://stackstorm.com/wp/wp-content/uploads/2015/06/event-driven-automation-3-300x159.png 300w" sizes="(max-width: 904px) 100vw, 904px" /> 

<!--more-->

The Facebook Infrastructure Orchestration team presented their FBAR. No, this is NOT the FBAR talk you may have heard hundred times. It is the premiere of a new talk about their System Lifecycle Automation which includes a newer and better FBAR. The FB guys keep the scent of secrecy around it: take no video, post no slides &#8211; come see in person. Those who came were truly rewarded.

There are two types of remediations in FBAR: one that is out of the box, built by SRE team, and one that is built by application owners. Results?

> 94% alarms are cleared without human intervention.

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/02/fbar_stats-1024x664.jpg" alt="" width="1024" height="664" class="aligncenter size-large wp-image-6596" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/02/fbar_stats-1024x664.jpg 1024w, https://stackstorm.com/wp/wp-content/uploads/2017/02/fbar_stats-150x97.jpg 150w, https://stackstorm.com/wp/wp-content/uploads/2017/02/fbar_stats-300x195.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2017/02/fbar_stats-768x498.jpg 768w, https://stackstorm.com/wp/wp-content/uploads/2017/02/fbar_stats-80x52.jpg 80w, https://stackstorm.com/wp/wp-content/uploads/2017/02/fbar_stats-220x143.jpg 220w, https://stackstorm.com/wp/wp-content/uploads/2017/02/fbar_stats-154x100.jpg 154w, https://stackstorm.com/wp/wp-content/uploads/2017/02/fbar_stats-231x150.jpg 231w, https://stackstorm.com/wp/wp-content/uploads/2017/02/fbar_stats-367x238.jpg 367w, https://stackstorm.com/wp/wp-content/uploads/2017/02/fbar_stats-640x415.jpg 640w, https://stackstorm.com/wp/wp-content/uploads/2017/02/fbar_stats-750x487.jpg 750w, https://stackstorm.com/wp/wp-content/uploads/2017/02/fbar_stats-917x595.jpg 917w" sizes="(max-width: 1024px) 100vw, 1024px" />][3]  
The value of auto-remediation is immediately obvious from these numbers. “At our scale, even with 2% coming to us it’s a lot of manual work” says Gabriel dos Santos.

James Mills went over advanced topics &#8211; rate limiting, preventing “run-away automations”, job prioritization, automating large batches of hosts… When FB says “large” they mean it:  
* Hundreds of millions distinct jobs per month  
* Thousands of years combined run time per month  
* Hundreds requests per second

Next on stage, <a href="https://www.neptune.io" target="_blank">Neptune.io</a> founder Kiran Gollu drove home the need and business value for automated diagnostics and remediation; that it is not “if”, it’s “when” for any sizable ops. It is just a matter of time and maturity of the incident response team when automated diagnostics and remediation becomes a necessity.

> Today, 95% of your incident&#8217;s MTTR is still manual

This resonates: “I am used to having FBAR at FB; now we need something like this at Uber n” says Rick Boone, ex FB production engineer, now SRE at Uber. Hey Rick, hope you’ll like StackStorm!

There would have been no fun without a good demo, and we enjoyed live demo of Neptune.io. It is a hosted auto-remediation solution, impressively easy to set up, nice event consolidation UI and familiar concepts to auto-remediation. StackStorm and Neptune.io are technically competitors, but we share the passion for auto-remediation, I really love some aspects of their solution and wholehartedly wish Neptune growth and success.

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/02/kiran_demo-1024x620.jpg" alt="" width="1024" height="620" class="aligncenter size-large wp-image-6597" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/02/kiran_demo-1024x620.jpg 1024w, https://stackstorm.com/wp/wp-content/uploads/2017/02/kiran_demo-150x91.jpg 150w, https://stackstorm.com/wp/wp-content/uploads/2017/02/kiran_demo-300x182.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2017/02/kiran_demo-768x465.jpg 768w, https://stackstorm.com/wp/wp-content/uploads/2017/02/kiran_demo-80x48.jpg 80w, https://stackstorm.com/wp/wp-content/uploads/2017/02/kiran_demo-220x133.jpg 220w, https://stackstorm.com/wp/wp-content/uploads/2017/02/kiran_demo-165x100.jpg 165w, https://stackstorm.com/wp/wp-content/uploads/2017/02/kiran_demo-248x150.jpg 248w, https://stackstorm.com/wp/wp-content/uploads/2017/02/kiran_demo-393x238.jpg 393w, https://stackstorm.com/wp/wp-content/uploads/2017/02/kiran_demo-686x415.jpg 686w, https://stackstorm.com/wp/wp-content/uploads/2017/02/kiran_demo-805x487.jpg 805w, https://stackstorm.com/wp/wp-content/uploads/2017/02/kiran_demo-983x595.jpg 983w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

Of course the best part of meetup is meeting up &#8211; with like-minded folks. We are a small group (only 670 :P) of experienced devops practitioners and thought leaders who are knowledgeable and passionate about automating operations. We spent a good time hearing each others’ stories, learning perspectives, posing and trying to answer challenging questions.

Among other things, we’ve talked about event correlation, the state of live event processing in the industry, the technical reason why this functionality is still missing in FBAR, StackStorm, and Neptune.io, and brainstormed some ways to solve the problem &#8211; a topic worth a dedicated blog.

We are lining up more igniting talks and inviting speakers for our next sessions. What is **YOUR** story? Care to share? Please propose the topic. To do so, go to the [Auto-Remediation meetup page][1] page, and press a big red Suggest a Meetup button.



<div id="attachment_6598" style="width: 876px" class="wp-caption aligncenter">
  <img aria-describedby="caption-attachment-6598" loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/02/slack_discussion.png" alt="" width="866" height="530" class="size-full wp-image-6598" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/02/slack_discussion.png 866w, https://stackstorm.com/wp/wp-content/uploads/2017/02/slack_discussion-150x92.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/02/slack_discussion-300x184.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/02/slack_discussion-768x470.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/02/slack_discussion-80x49.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/02/slack_discussion-220x135.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/02/slack_discussion-163x100.png 163w, https://stackstorm.com/wp/wp-content/uploads/2017/02/slack_discussion-245x150.png 245w, https://stackstorm.com/wp/wp-content/uploads/2017/02/slack_discussion-389x238.png 389w, https://stackstorm.com/wp/wp-content/uploads/2017/02/slack_discussion-678x415.png 678w, https://stackstorm.com/wp/wp-content/uploads/2017/02/slack_discussion-796x487.png 796w" sizes="(max-width: 866px) 100vw, 866px" />
  
  <p id="caption-attachment-6598" class="wp-caption-text">
    Talking same topic on stackstorm community slack today.
  </p>
</div>

And for continuous conversation (CC) on event driven automation, join our on StackStorm Slack channel &#8211; <a href="http://stackstorm.com/community-signup" target="_blank">stackstorm.com/community-signup</a>.

Until next time,

DZ.

 [1]: https://www.meetup.com/Auto-Remediation-and-Event-Driven-Automation
 [2]: https://www.makeschool.com/
 [3]: https://stackstorm.com/wp/wp-content/uploads/2017/02/fbar_stats.jpg