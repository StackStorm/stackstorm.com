---
title: 'DAY FOUR: A DevOps Friendly Architecture Is Fundamentally Different Than Legacy Products'
author: Dmitri Zimine
type: post
date: 2014-05-09T06:30:18+00:00
excerpt: '<a href="/2014/05/09/day-four-devops-friendly-architecture-fundamentally-different-legacy-products/">READ MORE</a>'
url: /2014/05/09/day-four-devops-friendly-architecture-fundamentally-different-legacy-products/
dsq_thread_id:
  - 3184949985
categories:
  - Blog

---
**May 9, 2014**

_by Evan Powell_

There is a huge amount of DevOps washing going on right now, and for good reason. As CA pointed out in a recent blog, most CIOs now understand that DevOps, done right, is revolutionary. And, what is more, they understand they need to do stuff to get DevOps working. And that stuff includes buying new tools.

So I&#8217;m not the only person building software to notice that there is a massive opportunity to provide CIOs with the tooling they need to build **and operate** software in a DevOps approach. As a result it feels like every software vendor in the world is rebranding their products as DevOps friendly.

<!--more-->

[<img loading="lazy" class="alignnone size-full wp-image-413" src="http://stackstorm.com/wp/wp-content/uploads/2014/05/pie-chart-1.jpg" alt="pie-chart-1" width="776" height="461" />][1]

But they cannot all really be &#8220;DevOps friendly&#8221;, can they? Are they all really able to be tied together in a loosely coupled architecture with no single points of failure? Of course not. Believe the hype – DevOps is fundamental and is happening. On the other hand, don&#8217;t believe the hype – **most vendors must rewrite their infrastructure software in order to be able to fit into a DevOps environment and hence to be able to add value to DevOps**.

Here&#8217;s a cheat sheet of what makes a set of code DevOps friendly:

  * Scriptable – with APIs that work reliably
  * Infrastructure as code – if you cannot store your desired configuration state in the repo and rebuild the system with that code, and likewise, share those configurations, than you are not DevOps friendly
  * A loosely coupled architecture that scales in the modern way – out
  * Open – last but not least your code needs to be open to inspection and open source is typically the right approach (however, having said that we see our friends at New Relic and Spunk in lots and lots of environments)

Again, the common theme is pragmatism. It&#8217;d be great to use LogStash for everything but at a certain scale at least many users decide they&#8217;d rather use Splunk.  The driver that determines which package is used is _does it complete the mission__?_ It is **not** _is it cheap?_ If you are doing things in a way that delivers a 10-100x step function in productivity if done right, you are not worried so much about cost. The ROI is massive. You are worried about _does it fit? Does it work? Can I support it? Does it promise more or less technical debt?_

If I thought that DevOps washing had merit I never would have invested in StackStorm and never would have helped found it. So I&#8217;m biased. However, I&#8217;m also right. Outside of New Relic and Splunk there are not many existing well-known proprietary vendors doing well in the space.

All of the management software from VMware, for example, fails the above tests. They know that and are scrambling to get it right. They are one of the best infrastructure software companies ever. Like every honest entrepreneur in infrastructure, I hugely admire VMware. Diane and Mandel and the rest of the team went from being out of favor on Sand Hill to changing the world with a fundamentally better way of doing things. Awesome. And yet – today that core DNA has moved along. VMware management is flying a plane with one big engine, vSphere, that is rapidly being commoditized and despite lots of acquisitions they have yet to find another growth engine. It sure isn&#8217;t their management code which had been the hope for years. Maybe VDI, maybe VSAN (every other OS vendor has tried it, why not VMware), maybe the mobile device management space where they recently spent $1.5B buying AirWatch. The Nicera IP seems extremely valuable however SDN has a little ways to go.

I spend some cycles on the side working with a big hedge fund. Don&#8217;t think they don&#8217;t get the above. They get it. Questions like _Do you fit into the DevOps future?_ are starting to move billions of public and private market investments because they are moving IT buyer behavior. And the technical debt of the legacy vendors cannot be wished away – it is a rewrite for many of them.

It feels a lot like the end of Phase I of operations automation to me. Then companies like our friends Opalis (which Dmitri as head of engineering and our advisor Scott Broder as CEO helped build) and of course Ben Horowitz&#8217;s company Opsware delivered incredible automation and coined the term run book automation. And then virtualization came along and the Phase I leaders of operations automation exited, Opalis to Microsoft and Opsware to HP; in both cases a major driver for the exit was that executives at Opalis and at Opsware recognized that their fundamental product architecture – as well as buyer behaviors – were changing.

Tool makers focused on virtualization have started to recognize that they face a very similar set of challenges to remain relevant in the DevOps world. Startups and other pure plays built from the ground up by and for DevOps are way ahead, have no technical debt, and are already entering into virtuous cycles with the right users.

Speaking of virtuous cycles, we&#8217;ll address how to enable a flywheel of feedback and learning in our next post.

 [1]: http://stackstorm.com/wp/wp-content/uploads/2014/05/pie-chart-1.jpg