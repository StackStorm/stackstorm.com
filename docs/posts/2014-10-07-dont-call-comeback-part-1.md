---
title: '“Don’t Call It A Comeback!” [Part 1]'
author: Dmitri Zimine
type: post
date: 2014-10-07T15:15:36+00:00
excerpt: '<a href="/2014/10/07/dont-call-comeback-part-1/">READ MORE</a>'
url: /2014/10/07/dont-call-comeback-part-1/
dsq_thread_id:
  - 3184654666
thrive_post_fonts:
  - '[]'
categories:
  - Blog

---
**October 7, 2014**

_by Evan Powell_

_**The third wave of operations automation – what’s the same, what’s different, and what’s next?**_

I’m a bit uncomfortable referencing a cultural meme to kick off a weighty subject mostly interesting to the “data center intelligencia.”<sup>1</sup> While Ben Horowitz has made it cool to refer to rap lyrics, he is a best-selling author and a billionaire and, conversely, I am decidedly neither.

Still, when I look at the wave of automation sweeping data centers and specifically hyperscale data centers, we face some questions not dissimilar from those that confronted LL Cool J so many years ago. So maybe I’m not totally crazy when those lyrics come to mind.  What’s new?  What’s rehashed?

We’ll begin by rolling the tape back to an era before DevOps, before AWS, and before VMware – even then time was already too short and systems were already too complex for humans alone to be left to our own devices.

<!--more-->

**Funky drummer came first**

Way before the current wave of OpenStack, DevOps, containers, IaaS, and PaaS, people were automating the heck out of their data centers.

Ben Horowitz earned his credibility in part as CEO of Opsware where they did a lot in the early 2000s to popularize the idea of run book automation. Opsware came to prominence before the era of VMware, and Horowitz reports that the company was sold in part due to the impact of VMware in his excellent book “<a href="http://www.amazon.com/Hard-Thing-About-Things-Building-ebook/dp/B00DQ845EA/ref=sr_1_1?s=books&ie=UTF8&qid=1407868657&sr=1-1&keywords=the+hard+thing+about+hard+things" target="_blank">The Hard Thing about Hard Things</a>.”

Earlier, as is often the case in IT, you can see close parallels to overall automation in approaches to mainframe management. The mainframes themselves would do some level of auto scaling and task / batch prioritization albeit on infinitesimal workloads and working sets compared to today’s hyperscale operators.

If we ignore mainframes, the first wave of operations automations crested with Opsware and Opalis – where StackStorm’s CTO and my co-founder ran engineering (Opalis is now owned by Microsoft where it became the foundation of System Center Orchestrator) – and others like RealOps (now owned by CA). VMware then came onto the scene with an approach that basically embedded aspects of automation into their products. Then DevOps and web scale operations hit and we are now seeing an incredible explosion of automation related projects, with <a href="https://www.linkedin.com/today/post/article/20140731182913-1437622-openstack-is-4-congrats-some-suggestions?trk=hb_ntf_MEGAPHONE_ARTICLE_POST" target="_blank">over twenty in OpenStack alone</a>.

Overall, the third wave brings us back to the future with a massively greater scale and a fundamentally different architecture than we had with the first wave. The second wave, dominated by VMware, was as similar to the mainframe world as it was to either the intermediate first wave world of “open systems” or the current DevOps-centric third wave. In many of VMware’s products, just as in mainframes, the black box takes care of many common automation tasks – like auto scaling – whereas in the prior and current wave these tasks are typically handled by a control plane including one or many automation services running separately from the stack.

<img loading="lazy" class="alignnone size-full wp-image-841" src="http://stackstorm.com/wp/wp-content/uploads/2014/10/Untitled1.png" alt="Untitled1" width="779" height="531" /> 

Stay tuned for <a href="http://stackstorm.com/2014/10/08/dont-call-comeback-part-2-2/" target="_blank">part two</a> where we’ll go into further detail on the third wave, including why we need a new wave.  Until then, we’d love to hear your feedback. Feel free to comment below, or tweet us [@Stack_Storm][1] or [@epowell101][2].

_<sup>1</sup> If you are a) reading this article and b) looking at footnotes – you are surely an important part of the Datacenter Intelligencia._

 [1]: https://twitter.com/Stack_Storm
 [2]: https://twitter.com/epowell101