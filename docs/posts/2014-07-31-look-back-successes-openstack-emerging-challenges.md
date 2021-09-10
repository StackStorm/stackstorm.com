---
title: A Look Back At The Successes Of OpenStack, And Some Emerging Challenges
author: Dmitri Zimine
type: post
date: 2014-07-31T16:36:08+00:00
excerpt: '<a href="/2014/07/31/look-back-successes-openstack-emerging-challenges/">READ MORE</a>'
url: /2014/07/31/look-back-successes-openstack-emerging-challenges/
dsq_thread_id:
  - 3184722225
categories:
  - Blog
tags:
  - automation
  - devops
  - openstack

---
**July 31, 2014**

_by Evan Powell_

As an entrepreneur betting heavily – in time, money, and relationships – on OpenStack, I’m biased towards its success and more than a little interested in how it is growing up. I have long believed in open infrastructure and remain convinced that OpenStack is the best chance we all have for a future of greater innovation, quality, capability, and, yes, affordability for cloud infrastructure.

I first looked at OpenStack a number of years ago when growing Nexenta and creating a market we then called the OpenStorage market, and recently took some time to look at the entire project and how far it’s come, as well as some emerging challenges.

  1. **The gap between the mainstream user and hyper scale cloud providers is growing greater by the day**

<!--more-->

  * As someone must have said – the only constant about change is that it is accelerating. Containers, closed loop automation like Facebook’s FBAR, visions for container approaches expanding into orchestration via Docker’s libswarm and/or Google’s recently launched Kubernetes projects, and even the emergence of software defined networking are all impacting the ability of enterprises to play catch up with a state of the art that is accelerating away from them.
  * Impact for OpenStack: This divergence is contributing to the scope explosion of OpenStack. It makes it yet more important that OpenStack get its innovation mojo back.

<ol start="2">
  <li>
    <strong>The OpenStack scope explosion – which suggests lots of innovation – actually obscures the bigger story which is stagnation in many projects</strong>
  </li>
</ol>

  * There is massive innovation in the creation of new projects. Just in the automation space alone there are 20 projects (StackStorm’s co-founder surveyed them in a recent OpenStack meet up [here][1].)
  * So while the proliferation of projects shows pent up demand for innovation, in countless projects there is a feeling that commits are concentrated around the edges, that they skew towards insuring vendor solution X works well with OpenStack, or are simply bug fixes and pieces of polish. There are micro forks happening everywhere, all the time, as developers sprint ahead of the trunk, frustrated at commits sitting in review for weeks or months.  In DevOps we talk about ways to (credit to the Phoenix Project) “Amplify the Feedback Loops.”  Feedback loops are generally much too long in OpenStack.
  * Impact for OpenStack: One impact is that the top operators don’t use any of the distributions (35 or 37 operators at a recent operators summit when asked “what distribution do you use?” replied “none.”). Another impact is that top developers move on to more enjoyable, more fruitful projects. And as a result of micro forks and the failure of the distribution model to take off we are introducing more and more complexity into OpenStack and hence introducing more barriers to adoption.

<ol start="3">
  <li>
    <strong>The real crux of the story isn’t AWS vs. OpenStack or even vs. Mesos and Docker, it is DevOps</strong>
  </li>
</ol>

  * Countless articles have been written about OpenStack that, except for the names of the contestants, read like the sports pages: “Team X reacted to Team Y by signing a new member of the team.” Yes, the Mirantis / Redhat spat has been entertaining. And congratulations to HP for poaching from Rackspace. And, no, I don’t know what will happen to Rackspace and the private equity rumored to be circling them. What I do know is that none of the above really matters to the success of OpenStack and, most importantly, to the success of OpenStack users. What matters is the trajectory of innovation both for OpenStack and for OpenStack users. And adopting DevOps approaches, tools, collaboration and, yes, empathy (see Jeff Susanna’s blog [here][2]) is the wave that at times has carried OpenStack along and that now threatens to roll right by OpenStack like a killer wave shedding a surfer.
  * Impact for OpenStack: OpenStack has gotten better at marketing itself.  I love the Superuser campaign for example. However, it can do better by talking about concrete outcomes for enterprises that include driving up the productivity of under stress development teams and, specifically, that embrace DevOps. Also we need to up our game with developers both as contributors and as consumers of OpenStack. And the journalists that cover the space need to dig a little deeper. We need journalists to hold those of us in the OpenStack to the highest standards – we should require OpenStack itself move forward at a DevOps pace and that it retain a focus on enabling a fundamentally better approach to IT.

<ol start="4">
  <li>
    <strong>We need to recommit to openness</strong>
  </li>
</ol>

  * Despite all of the above, open approaches historically have provided an unmatched combination of innovation, affordability and safety – eventually. The ever more important developers amongst us must be willing to pay the tax of working on and consuming OpenStack. Some months ago I wrote a somewhat [plaintive cry][3] to those developers that received a lot of traffic so I won’t repeat that here – basically arguing that we should all use OpenStack based clouds more. I think we’d all agree that if OpenStack starts to operate at the pace of a standards body we are all in trouble.
  * Impact for OpenStack: Elect a board that will treat OpenStack like the young startup it is. One specific idea is to auto-escalate to someone on the technical committee any commits that languish for more than 2 days without review. Another is to continue to invest yet more in the Continuous Improvement / Continuous Delivery testing and QA environment. Another specific idea is to actively encourage projects to be more than OpenStack specific. A core tenant of DevOps approaches is small services that are loosely coupled; and we see that in OpenStack – but too often projects are insular in their outlook and see OpenStack as the entire universe in which they might operate, which closes them off from the more powerful, rapid, and, yes, competitive current of innovation happening in the broader DevOps community.

In conclusion, our four-year old project has show great potential and progress. OpenStack is a force for good, but it’s always smart to take a step back and evaluate where we are, to ensure we continue achieving success.

The next year will be telling for OpenStack. We will see more adoption and many metrics will move up and to the right. And, yet, we may well see the locus of innovation move on to smaller, more DevOps friendly projects like Docker. Let’s focus on what really matters – innovation and getting the competition / cooperation dynamics right to support innovation in the trunk and by our OpenStack developer users.

[<img loading="lazy" class="alignnone size-medium wp-image-693" src="http://stackstorm.com/wp/wp-content/uploads/2014/07/openstack-logo-300x300.jpg" alt="openstack-logo" width="300" height="300" />][4]

 [1]: http://stackstorm.com/2014/07/10/press-release-stackstorm-co-host-openstack-online-meetup-automation-tools/
 [2]: http://blog.ingineering.it/post/72964480807/empathy-the-essence-of-devops
 [3]: http://opensource.com/business/14/5/towards-open-cloud-with-openstack
 [4]: http://stackstorm.com/wp/wp-content/uploads/2014/07/openstack-logo.jpg