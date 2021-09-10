---
title: 'OpenStack v. Docker: It’s The DevOps, Stupid'
author: st2admin
type: post
date: 2015-03-13T20:16:05+00:00
excerpt: '<a href="http://stackstorm.com/?p=2838">READ MORE</a>'
url: /2015/03/13/openstack-v-docker-its-the-devops-stupid/
dsq_thread_id:
  - 3593076213
categories:
  - Blog
  - Community
  - Home

---
**March 13, 2015**

_by Evan Powell_

Too often industry pundits like myself make our names by screaming louder than the other pundit and by making outlandish projections in the hopes of cutting through the clutter, building our twitter followers, and otherwise achieving more pundit points.

Currently, I hear the extremists shouting about Chef vs. Docker and Docker vs. Rocket and Docker vs. OpenStack. I guess I hear a lot about Docker.

Last week, as an example, I heard folks clearly smarter than me making some pretty aggressive statements at the Pacific Crest Emerging Technology Summit, where I was one of the Mosaic experts PacCrest asked to speak to large institutional investors about cloud and trends in enterprise IT. I also heard some diatribes at Rackspace::Solve, where Rackspace demonstrated its use of StackStorm as a foundation of their DevOps services.

<!--more-->

Those in the Docker camp scream about immutable infrastructure, the wisdom of community models that follow benevolent dictators, and the efficiency of containers and more. They point to the undeniable momentum of Docker and proclaim the death of OpenStack.

Those in the OpenStack camp counter that OpenStack is real, it is running large infrastructures, it can embrace Docker, and it is much much more than simply compute. They point to Walmart’s announcement that their OpenStack compute layer is already 130,000 cores, with plans to add more. They say that Docker is simply a conglomeration of old technologies and that many users don’t like the particular flavors of containers, file systems, packaging and community that Docker prescribes.

While interesting, all of this bloviation is just so much noise, signifying nothing.

Software is eating everything because the agility of a well-run IT environment lends significant competitive advantage to companies. Just about every company in the world is looking over their shoulder now and seeing a company better at building and using software gaining on them. So they must run faster and faster – To. Build. And. Operate. Software.

The infrastructure wars are over. Cloud has won. Whether private or public, VM or container, does not matter as much as using it all to accelerate the ability of companies to respond to their customers and hence to beat off the unparalled competitive threats being faced.

What companies facing existential threats really want is to get their increasingly cloudy infrastructure, whether it’s with OpenStack, Docker, AWS, or anything else &#8211; plus the existing solutions they have that form the foundation of their enterprise &#8211; tied together and operating well and being more responsive. As you might guess – that is exactly what StackStorm does.

Take a look at a tier one bank. They likely have something like 10-100,000 applications working to move trillions of dollars through them a year.

Yes, they are working with Docker – or with their own flavor of Docker at least. And, yes, they have some production OpenStack running, although they also have quite a bit of AWS and especially a huge amount of vSphere.

In some cases like DeutscheBank – as they announced in late February &#8211; they’ve decided to <a href="http://blogs.wsj.com/cio/2015/02/25/deutsche-bank-h-p-divide-it-responsibility-in-cloud-deal/" target="_blank">get out of infrastructure</a> entirely. They are 100% focused on innovation and security, and as long as the infrastructure works and is getting less expensive over time, they are happy. If their provider – in this case HP – tells them that in addition to taking data centers and staff off their hands they will build up a new cloud and commit to SLAs for it – that’s fine with them. That it is OpenStack under the hood matters much less than the agility that DeutscheBank must achieve in order to stay relevant in today’s competitive banking world.

In short – “it’s the DevOps, stupid.” It’s about getting the right code built faster in order to make your customers happier. If more pundits used that lense with which to examine the competitive landscape, they’d get to a more nuanced, more accurate and more useful point of view, even if such a perpsective does not lead directly to more twitter followers.

Please let me know what you think. I can be found on Twitter <a href="https://twitter.com/epowell101" target="_blank">@epowell101</a>.

And of course, if you haven’t already, I invite you to check out our product by <a href="http://docs.stackstorm.com/install/index.html" target="_blank">installing StackStorm</a> and following the <a href="http://docs.stackstorm.com/start.html" target="_blank">quick start</a> instructions — it will take less than 30 minutes to give you a taste of our automation. Share your thoughts and ideas via [stackstorm@googlegroups.com][1], <a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">#stackstorm on irc.freenode.net</a> or on Twitter <a href="https://twitter.com/Stack_Storm" target="_blank">@Stack_Storm</a>.

 [1]: https://groups.google.com/forum/#!forum/stackstorm