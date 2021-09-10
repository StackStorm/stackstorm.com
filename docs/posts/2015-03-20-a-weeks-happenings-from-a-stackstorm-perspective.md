---
title: A Week’s Happenings From A StackStorm Perspective
author: st2admin
type: post
date: 2015-03-20T21:29:32+00:00
excerpt: '<a href="http://stackstorm.com/2015/03/20/a-weeks-happenings-from-a-stackstorm-perspective/">READ MORE</a>'
url: /2015/03/20/a-weeks-happenings-from-a-stackstorm-perspective/
dsq_thread_id:
  - 3613062159
categories:
  - Blog
  - Community
  - Home

---
**March 20, 2015**

_by Evan Powell_

The last couple of weeks we have hit an inflection point in that downloads are running at 5-7x February levels, IRC chats are getting more and more substantive, and folks like Rackspace and others are contributing to StackStorm (thank you! &#8211; let’s automate all the things &#8211; _intelligently_ &#8211; together :)).

Here are some highlights including a few events at which we attended and spoke:

  * <a href="http://bsidesljubljana.si/" target="_blank"><strong>Security BSides Ljubljana</strong></a> &#8211; our own Tomaz Muraus spoke at BSides in Slovenia about using StackStorm as IFTTT-like software for responding to security events. Being Tomas, he didn’t just speak with some nice looking slides &#8211; he also demo’d and made available the code for the remediations he demonstrated.

Please take a look here:  <a href="http://www.tomaz.me/slides/automated-security-remediation-using-stackstorm/#1" target="_blank">Tomaz&#8217;s amazing slides</a>

<!--more-->

<img loading="lazy" class="alignnone size-full wp-image-2895" src="http://stackstorm.com/wp/wp-content/uploads/2015/03/Remediation-demo.png" alt="Remediation demo" width="975" height="625" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/03/Remediation-demo.png 975w, https://stackstorm.com/wp/wp-content/uploads/2015/03/Remediation-demo-300x192.png 300w" sizes="(max-width: 975px) 100vw, 975px" /> 

  * **<a href="https://www.usenix.org/conference/srecon15" target="_blank">SREcon15</a> **&#8211; StackStorm exhibited at SREcon where there was a rockstar group of speakers discussing running systems at massive scale. As is typically the case, the side conversations were at least as valuable as the already useful sessions. As the leading open source solution for event driven automation at scale, we of course took a special interest in Pedro Canahuati’s  keynote which discussed at some length a real inspiration for us &#8211; Facebook’s FBAR (not FUBAR). The slides are not yet posted, as far as I can tell.  You should follow him at @collidr if you do not already.  His title is Director, Production Engineering & Site Reliability at Facebook.

One comment Pedro made, which he confirmed via Twitter, is that he estimates that Facebook saves 16,680 hours \*a day\* thanks to their event driven automation, aka FBAR. Next time you unfriend someone (or like! a kitten photo), think about the StackStorm like wiring that makes possible your Facebook happiness. That’s thousands of engineers that are being freed from countless mundane actions by FBAR which it seems is now a fundamental underpinning of Facebook.

<a href="https://www.facebook.com/notes/facebook-engineering/making-facebook-self-healing/10150275248698920" target="_blank">Here</a> is a somewhat dated write up on Facebook’s FBAR from Facebook, posted back in 2011. It still does a good job of explaining the fundamental approach &#8211; which is again similar to what StackStorm gives you. We will post the slides and so forth from Pedro’s talk here as well when they become available.

  * **<a href="http://www.dcdconverged.com/conferences/enterprise-usa" target="_blank">Datacenter Dynamics 2015</a>:** Last but not least, I spent some time in NYC helping keynote the Datacenter Dynamics conference. This is the leading set of conferences attended by the data center building, powering and operating market. It was great to catch up with some friends and users in NYC and to hear perspectives on the transformation of the data center. My talk was on the importance of software defined infrastructure which I’ve written and spoken about extensively elsewhere.

I was really happy to see the adoption of <a href="http://www.opencompute.org/" target="_blank">Open Compute</a> in this environment. Cole Crawford (<a href="https://twitter.com/coleinthecloud" target="_blank">@coleinthecloud</a>) clearly did amazing work bringing essentially open source hardware from a provocative idea to a reality in his time starting and running Open Compute. Don Duet from Goldman Sachs  &#8211; their “co-head of Technology” &#8211; shared that 70% of their purchases of compute this year will be Open Compute. That’s significant and disruptive, especially when you consider that Don has <a href="http://www.goldmansachs.com/what-we-do/engineering/see-our-work/don-duet-cloud-startup-article.pdf" target="_blank">elsewhere</a> indicated that one of Goldman Sachs&#8217; early private clouds is at over 300,000 cores.

I listened very attentively to all of Don’s comments at the conference because while Goldman is not afraid to go off on their own, they are also extremely thoughtful about how to collaborate with the broader community as Don’s role on the board of Open Compute indicates. One thing Don chose to mention when being interviewed by the New York Times on stage was that Goldman Sachs is building event driven automation that will be made more intelligent via the kind of machine intelligence we have spoken about leveraging ourselves in the future.  I look forward to collaborating with Goldman Sachs more in this area.

So, in short, when you look at the world from where we sit you see others recognizing the power of event driven automation all around you.

Top tier investment banks (which are pretty much technology companies these days), hyper scale operators, and now tens of thousands of folks that have downloaded StackStorm are using event driven automation in ever more interesting ways.

Please take a look at the links above to learn more about what others are saying &#8211; and to grab simple examples of the use of StackStorm in responding to security events.

Next week will be at least as exciting. While our CTO and co-founder Dmitri Zimine will be participating in a symposium on approaches to event driven automation back in the DC area with tier one financials and intelligence agencies and academicians, we will also all be riding a wave of ever more users who are providing all sorts of feedback, most of it shared politely 🙂

We will also be publishing a major operational pattern as code via a guest post on the New Relic site very shortly and will republish that on our own blog as well, along with more details and of course the code itself. There is even a snazzy video that will walk users through how to use StackStorm for a particular auto remediation use case in conjunction with New Relic and others.

Stay tuned, keep automating, and let me know your thoughts at <a href="http://twitter.com/epowell101" target="_blank">@epowell101</a>, or in the comments below, or on our <a href="#stackstorm%20on irc.freenode.net" target="_blank">IRC at #stackstorm on freenode</a>. If you haven’t already, we invite you to check out our product by <a href="http://docs.stackstorm.com/install/index.html" target="_blank">installing StackStorm</a> and following the <a href="http://docs.stackstorm.com/start.html" target="_blank">quick start</a> instructions — it will take less than 30 minutes to give you a taste of our automation.  
&nbsp;