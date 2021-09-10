---
title: 'Thoughts From OpenStack Silicon Valley: Part 2'
author: Dmitri Zimine
type: post
date: 2014-09-19T15:19:23+00:00
excerpt: '<a href="/2014/09/19/thoughts-openstack-silicon-valley-part-2/">READ MORE</a>'
url: /2014/09/19/thoughts-openstack-silicon-valley-part-2/
dsq_thread_id:
  - 3184685807
thrive_post_fonts:
  - '[]'
categories:
  - Blog

---
**September 19, 2014**

_by Evan Powell_

Continuing from <a href="http://stackstorm.com/2014/09/18/thoughts-openstack-silicon-valley-part-1/" target="_blank">part 1</a> of my blog on the recent OpenStack Silicon Valley summit, let’s discuss some of the other companies present at the conference and some of my (cynical) observations.

VMware was there with a keynote being given by yet another Martin. There were six substantive talks before noon. Half of them had someone named Marten or Martin in it. I’m referring here of course to VMware’s networking CTO, Martin Casado who spoke passionately about policy based management as an El Dorado of IT management that is finally within reach. I kept flashing back to the Werner Herzog film “Aguirre: Wrath of God.” Much like Klaus Kinsky in that film (spoiler alert), the quest for the golden city does not end well.

<!--more-->

In IT, many waves of operations automators have set off thinking – lets bridge the gap between people, who think in terms of process (here’s how we get stuff done) with infrastructure, which surely can be taught to reliably follow commands. To do so we basically need a way of describing what we want done and then an infrastructure that will listen. Plus in between the two we need a bit of a compiler to take the process-based instructions and to turn them into commands for the infrastructure. Martin did a great job explaining in a techie way past technical barriers (distributed state management, a general and yet powerful abstraction layer, and what he called topology independence.) And his argument that OpenStack and overall advances have recently addressed these technical barriers to automation of all sorts, and specifically to policy based automation resonated with me since we often make similar points at StackStorm.

However, I really wonder whether the next piece of his thesis is correct: that now that we technically _should_ be able to use policy to control infrastructure that we _will actually successfully_ go from humans writing policies to infrastructure interpreting these policies and behaving in accordance with them. I recall some of the control theory reading I’ve done in an effort to speak intelligently with one of our advisors, Professor Alberto Sangiovanni-Vincentelli.

It turns out that there is a strain of thinking about control theory that strives to explicitly incorporate our actual limits as people. For example, maybe one reason that policy based automation has not worked all that well in the past is that once we describe policies completely – a difficult task often achieved with the help of KPMG and other expensive process consultants no doubt – these policies have either ossified and need to change or in fact have changed but we forgot to tell the policy automation project. State management of the desired state itself can be tricky once humans are involved.

Having said that, we at StackStorm are not so secret fans of Congress and the attempt to reduce a representation of the desired state into basically tables that can be lashed together and understood with the help of Datalog / Sql is hugely laudable. Keep in mind that while El Dorado was never found, the sheer amount of wealth extracted (aka stolen) from the New World is thought by some economic historians to have provided a monetary expansion that helped finance the modernization of Europe. There is a lot of good that Marten and VMware are already doing to help bring OpenStack and the overall approach of infrastructure as code – that itself is fully programmable – into the enterprise. If some of that is happening while on their way towards the mountain top El Dorado of policy automation, great.

Well, you now have at least a little bit of what this somewhat experienced and cynical observer saw at the OpenStack Silicon Valley; in short, a lot of smart people, massive investment, and a healthy skepticism.

One final point -> towards the end of the day I retweeted a the following from @Cloud_opinion:

<img loading="lazy" class="alignnone size-full wp-image-798" src="http://stackstorm.com/wp/wp-content/uploads/2014/09/tweet.png" alt="tweet" width="900" height="196" /> 

That tweet echoes a feeling I shared with a few friends today. Out of the 150+ discussions we have had at StackStorm with operators, we have met lots of operators (including our StackStorm beta users) whose DevOps knowledge as manifested in their ability to build and operate infrastructure much more productively is years and years ahead of the typical attendee at OpenStackSV today (including myself). These DevOps operators are already approaching the 10-100x agility and productivity boost of top organizations like Facebook or Google; and these operators are already disrupting and creating whole industries from Etsy to Uber to social networks and more; and these operators could care less about the underlying infrastructure as long as they can control it, and easily understand it, and it doesn’t suck. To his credit, Adrian Ionel, CEO of Mirantis <a href="https://www.mirantis.com/blog/mirantis-adrian-ionel-openstack-sv-gets-developers-wins/" target="_blank">touched on this theme</a>. However I don’t know that it really sunk in. It had better. “Developers, developers, developers.”