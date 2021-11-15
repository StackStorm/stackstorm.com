---
title: Auto-Remediation Defined
author: st2admin
type: post
date: 2015-08-07T17:43:29+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/08/07/auto-remediation-defined/
dsq_thread_id:
  - 4401881221
categories:
  - Blog
  - Community
  - Home

---
**August 7, 2015**  
_by Evan Powell_

One thing I tried to do when helping kick off the &#8220;software defined storage&#8221; craze some years ago was to define what we meant at Nexenta by that term.  A number of analysts in the space were positive about our clarity as were, more importantly, many users and partners.

I realized that while we&#8217;ve blogged here and there about what we mean at StackStorm by auto-remediation, we have not directly posited a canonical definition of it.  People seem to grok that auto-remediation is a subset of event-driven automation however it is nigh time for us to have a single spot for our take on the definition.  With no further adieu, please read on and comment back here or via twitter.

**Auto remediation** is an approach to automation that responds to events with automations able to fix, or remediate, underlying conditions. Remediation means more that simply clearing an alert; for example, it can mean ascertaining the scope of a problem through automated validation and investigation, noting the diagnosis of a problem in a ticketing system and very often in a chat system as well as in a logging system, and then taking a series of steps where each step’s completion or failure can be a prerequisite for the next step.

<!--more-->

Components needed by auto-remediation software include the ability to listen to events, some notion of a rules engine to respond appropriately to these events, and a workflow engine to transparently execute often long running automations comprised of multiple discrete tasks tied together with conditional logic. Additionally, as discussed below, the human factors of auto-remediation are crucial as we build and increasingly trust autonomous systems to run ever more complex environments.

Attempts at auto remediation should recognize the challenges and limitations of prior attempts at closed loop automation most of which were at the time called &#8220;run book automation&#8221; with leading solutions including Opalis, Tidal Software, RealOps and others, most of which were purchased by large system vendors. These limitations have included:

  * _Challenges in authoring and maintaining both the necessary integrations and the automations themselves_; modern systems support <span style="text-decoration: underline;">infrastructure as code</span> so these artifacts are treated as code and hence can be authored and maintained far easier; additionally systems such as StackStorm can incorporate existing scripts, tie into the four leading configuration management systems, and have a large open source community of thousands of integrations already available.
  * _A loss of context on the part of the human operators leading to a loss of trust_; modern systems are radically transparent and proactively keep humans in the loop, for example by the automation system interacting with operators via chat as a peer to these operators or through advanced visualization techniques.
  * __The risk of run away automations or flapping;__ any control system has to be able to control itself &#8211; auto remediation systems must have the ability to limit responses to given sources of events for example both to insure human error does not spawn a cycle of remediations remediating remediations and as a part of security in depth. _ _
  * _Last but not least, the ability to scale to today’s environments_.  Prior systems automated much less dynamic environments that were orders of magnitude smaller than today’s; modern auto remediation needs to scale horizontally and typically incorporates a message queue and other techniques to achieve this scale.

Successful auto remediation systems include Facebook’s Auto Remediation, or FBAR, and WebEx Spark’s Bootstrap 2.0.  More information about these systems is available <a href="https://www.facebook.com/notes/facebook-engineering/making-facebook-self-healing/10150275248698920" target="_blank">here</a> for Facebook (although you would have learned more from the recent event driven <a href="http://www.meetup.com/Auto-Remediation-and-Event-Driven-Automation/events/222695645/" target="_blank">automation meet-up)</a> and here for <a href="http://www.slideshare.net/EvanPowell/just-a-few-slides-from-spark-meet-up" target="_blank">WebEx&#8217;s Spark </a>(disclosure, leverages StackStorm and from a later talk at <a href="http://www.meetup.com/Auto-Remediation-and-Event-Driven-Automation" target="_blank">the same meet-up</a>).

You can read much more about example uses of event-driven automation and specifically auto-remediation on the StackStorm site.  For here suffice it to say that use cases for auto-remediation range from providing resilient environments for your Cassandra cluster and other key components (more on that at the upcoming Cassandra Summit) to responding to a broad and ever changing set of cyber intrusions at banks and other larger targets.  A good resource for the later use case including a demo is a talk given at BSides in the Spring by our own Tomaz Muraus.

[<img loading="lazy" class="aligncenter size-full wp-image-3933" src="http://stackstorm.com/wp/wp-content/uploads/2015/08/auto-remediation-re-security.jpg" alt="auto remediation re security" width="957" height="593" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/08/auto-remediation-re-security.jpg 957w, https://stackstorm.com/wp/wp-content/uploads/2015/08/auto-remediation-re-security-300x186.jpg 300w" sizes="(max-width: 957px) 100vw, 957px" />][1]

Please help us solidify this definition.  Any and all feedback is welcome.

&nbsp;

 [1]: http://http://www.tomaz.me/slides/automated-security-remediation-using-stackstorm/