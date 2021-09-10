---
title: 'First Event-Driven Automation Meetup Fun & Filling. Next = FBAR'
author: st2admin
type: post
date: 2015-05-15T17:39:18+00:00
excerpt: '<a href="http://stackstorm.com/2015/05/15/first-event-driven-automation-meetup-fun-filling-next-fbar/">READ MORE</a>'
url: /2015/05/15/first-event-driven-automation-meetup-fun-filling-next-fbar/
dsq_thread_id:
  - 3766919432
categories:
  - Blog
  - Community
  - Home

---
**May 15, 2015**

_by Evan Powell_

Yesterday’s inaugural <a href="http://www.meetup.com/Auto-Remediation-and-Event-Driven-Automation/events/222051597/" target="_blank">event-driven automation meetup</a> was informative, and a lot of fun.

LinkedIn did a great job of hosting and accommodating us at the last minute, as reservations exceed expectations and a larger room, more pizza, and beer were needed.

It was great to see friends from Netflix, HP, Facebook, Asurion, eBay, VISA and elsewhere in attendance. The questions were sharp and direct. As someone pointed out &#8211; &#8220;event-driven automation&#8221; is a relatively new space now getting tremendous attention as operators seek to compare notes on how they are boosting their operational agility through intelligent automation.

I strongly recommend the talks given by both Brian Sherwin and <a href="https://www.slideshare.net/slideshow/embed_code/key/cHCIlAlU4Xb1Lw" target="_blank">Dmitri Zimine</a>.

Brian&#8217;s talk got right into why and how LinkedIn built what they are calling Nurse. His talk was engaging and straightforward and Nurse itself is clearly extremely well thought through. Nurse has been designed to do remediations as simply as possible, with workflow and basic event handling included. While Nurse is relatively new and is being rolled out more broadly within LinkedIn, it already is handling some thousands of plans a week. It is run as a true Remediation as a Service in that the developers themselves &#8211; who are responsible for most of the ops of their code &#8211; utilize Nurse to save time and improve availability of their applications a pattern we also see frequently with StackStorm. LinkedIn has not yet open sourced Nurse; however, Brian indicated that they are interested in doing so.

<!--more-->Dmitri&#8217;s talk was really two talks in one. First he put the new kid on the block – event-driven automation &#8211; in perspective. After all, he helped create the original run book automation many years ago while running engineering at Opalis.

He touched on what&#8217;s different now, emphasizing infrastructure as code as well as improvements in the ability of systems like StackStorm to be quickly integrated into today&#8217;s environments. The combination of these two capabilities is necessary for event-driven automation to keep up with the pace of change of today&#8217;s operating environments.

Dmitri then dove into the details of workflow patterns. One of my favorite slides was when he came to the concept of joins. So much in workflow sounds so straightforward &#8211; even joins. But it turns out there are 16 patterns for how joins are executed by workflows and each has it&#8217;s plusses and minuses. It is non-trivial to select the right join pattern for your workflow use case.

<img loading="lazy" class="alignnone size-full wp-image-3224" src="http://stackstorm.com/wp/wp-content/uploads/2015/05/Slide1-e1431711350821.jpg" alt="Slide1" width="360" height="270" /><img loading="lazy" class="alignnone size-full wp-image-3225" src="http://stackstorm.com/wp/wp-content/uploads/2015/05/Slide2-e1431711373338.jpg" alt="Slide2" width="360" height="270" /> 

After both Brian and Dmitri&#8217;s talks there were a variety of excellent questions asked. A couple of questions touched on reliability as in how is it possible to run the workflow reliably and what happens when an execution fails. In the case of StackStorm, we are built to support 100% uptime with rolling upgrades, horizontal scalability, the ability to update content in the form of integrations and workflows and rules without outages and so forth; we built it in this way based on the requirement that the control system must be more reliable than that which is under control.

Brian has a different perspective which, to paraphrase, is that important workflows that fail will inevitably be requested again if they are important. This makes a lot of sense as in their design monitoring triggers all workflows, and if the event is not cleared by monitoring, the corresponding remediation workflow will be triggered and hence attempted again. Brian also discussed how they have designed Nurse to limit or eliminate the risk of infinite loops as well through mechanisms such as a maximum number of executions per a period of time per plan.

Please stay in touch with us and suggest topics via <a href="http://www.meetup.com/Auto-Remediation-and-Event-Driven-Automation/events/222051597/" target="_blank">this meetup</a>—we’d appreciate it if you would tell _at least_ two friends about it. We&#8217;re off and running in building a community, let&#8217;s keep that up. I&#8217;ve pinged a couple of attendees already about speaking and it sounds like Facebook is definitely interested in hosting soon to discuss their famous FBAR.  
&nbsp;