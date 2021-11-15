---
title: 'OpenStack Automation Meetup: Impressions'
author: Dmitri Zimine
type: post
date: 2014-10-15T17:02:23+00:00
excerpt: '<a href="/2014/10/15/openstack-automation-meetup-impressions-2/">READ MORE</a>'
url: /2014/10/15/openstack-automation-meetup-impressions-2/
dsq_thread_id:
  - 3181236872
categories:
  - Blog

---
**October 15, 2014**

_by Evan Powell_

Last night StackStorm hosted a <a href="http://www.meetup.com/San-Francisco-Silicon-Valley-OpenStack-Meetup/events/206106642/" target="_blank">San Francisco / Silicon Valley OpenStack Meetup</a> at our offices in Palo Alto. Our CTO and co-founder Dmitri Zimine &#8211; who is one of the world’s experts at operations automation &#8211; led the group through a review of twenty OpenStack projects that have to do with operations automation.

I won’t walk you through all the content. You can see some of it in his recent series of articles for Opensource.com for example <a href="http://stackstorm.com/2014/09/13/openstack-automation-cloud-deployment-tools/" target="_blank">here</a>.

A few highlights if you did not make it:

<!--more-->

  * At the risk of using a very broad brush, my sense is that we are not seeing great progress in OpenStack specific automation projects. And even some of the leading projects &#8211; Heat most notably &#8211; seem to be more and more focused solely on OpenStack, whereas autoscaling often (at least in design) implies scaling across multiple clouds, that may or not be OpenStack (for example, they may well be AWS).  We’ve seen that lead to Heat not being trusted for use across clouds even though enabling scaling across different types of clouds as a use case was supposed to be embraced by Heat.
  * On the other hand, bespoke automation via scripting tying together pockets of automation seems to be a real trend even despite the ~20 OpenStack specific automation projects Dmitri reviewed.
  * I tweeted a comment from the Meetup conversation about Heat being the recommended method of integrating Docker into OpenStack and whether that made sense. Net/net &#8211; there is some skepticism as to whether Docker + OpenStack makes a lot of sense.

And one final take-away: OpenStack despite its feet of clay and areas of over-reach (I wrote about this previously <a href="http://stackstorm.com/2014/09/18/thoughts-openstack-silicon-valley-part-1/" target="_blank">here</a>) -> **is happening**. However, we’re in a trough of disappointment.  We need to power through it and focus on areas of OpenStack adoption that are inevitable.

  * For example &#8211; the Meetup attendees included CTOs and other stackers from leading technology companies that are investing a huge amount in OpenStack based SaaS solutions. The momentum at these companies &#8211; including a couple of StackStorm (beta) users &#8211; is unstoppable. OpenStack will definitely be the platform used for some really innovative software platforms and offerings and that alone will help OpenStack continue to progress and mature.

Also, we did get one comment on the Meetup site that the “spread” we put out was the best he had seen at any OpenStack Meetups, and the commenter is a “veritable fixture” at OpenStack events. We also received a few comments asking why we didn’t try to pitch StackStorm product. Well, in both cases we are trying to be good community members.

And we’ll double down on being a good community member &#8211; a community broader than OpenStack &#8211; in early November when we open source StackStorm itself. Stay tuned.

<img loading="lazy" class="alignnone size-large wp-image-877" src="http://stackstorm.com/wp/wp-content/uploads/2014/10/meetup-photo-1024x768.jpg" alt="meetup photo" width="625" height="468" />