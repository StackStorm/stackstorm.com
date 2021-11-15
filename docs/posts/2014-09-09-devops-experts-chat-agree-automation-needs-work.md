---
title: DevOps Experts Chat And Agree That Automation Needs Work
author: Dmitri Zimine
type: post
date: 2014-09-09T16:41:18+00:00
excerpt: '<a ref="/2014/09/09/devops-experts-chat-agree-automation-needs-work/">READ MORE</a>'
url: /2014/09/09/devops-experts-chat-agree-automation-needs-work/
dsq_thread_id:
  - 3184706427
thrive_post_fonts:
  - '[]'
categories:
  - Blog

---
**September 9, 2014**

_by Evan Powell_

Last week StackStorm had a great group of folks online for a one hour [Crowdchat][1] about DevOps, and comments were fast and furious. As expected, Cote from the 451 group ([@cote][2]) helped lead the discussion, as well as James Fryman from GitHub ([@jfryman][3]), Carmine Rimi from Workday ([@carminerimi][4]), and StackStorm’s own Patrick Hoolboom ([@phool_stormer][5]). We were also joined by some great guest stars including Andi Mann ([@AndiMann][6]) from CA.

**A quick summary:**

With over 1,229 views of the Crowdchat, participants rated the question, “_Is Automation in a place that is good, or is there more work needed?”_ as the top question asked.

And the top rated response to this question suggested that we still have a long way to go with automation. James Fryman’s answer was:

_“There is so much more work needed. We are a lot further along than we were, say 10 years ago, but there are still serious challenges with parts of the stack still not having good API access, humans are still doing too much manual work, etc.”_

<!--more-->

  * We at StackStorm heartily agree! We did nothing to bias the answers or the participants. So it was great confirmation to hear that actually we are still not where we could be in automation.
  * We tend to see a lot of bespoke, custom automation built on top of existing configuration management and also on top of Jenkins for continuous integration.

The second rated response to this question was from yours truly. I had said:

_“Yes 🙂 Without automation ‘it’ does not happen. But we have seen automation become a runaway nightmare. Step one troubleshooting for example – ‘turn off the automation’.” _ 

  * Here I was trying to give credit to the automation that exists. Yes, there must be more automation. And to get there the automation has to be better trusted, easier to author, more scalable, safer and so forth. However, we have also made tremendous progress with OpenStack, AWS, and other infrastructure stacks being entirely API driven; and projects like Chef and Puppet have shown us all the potential that exists for DevOps centric tools to assist in automation.

Perhaps at least as notable, within the thread of responses to this question Cote asked: “_Can someone define ‘orchestration’ in this __[#DevOps][7]__ context? I&#8217;m curious what people think it is beyond/above ‘automation’.&#8221;_

  * This generated a lot of responses. I found the question (or sub question) to be a great one. We hear orchestration thrown around by software providers whose software we have never seen in use as the overall control plane of a DevOps environment. From StackStorm’s perspective, while there is a lot of (incomplete) automation, the overall control plane is often hand written by operators who are forced to write some fairly complex software to tie together monitoring, configuration management, collaboration, software repositories, staging environments, and more. Notable examples that have been written about include both Facebook’s FBAR and Microsoft’s AutoPilot.

Other topics that we covered that received a lot of positive feedback included: “_Are enterprises truly embracing DevOps?”, “What does a DevOps person look like?”,_ and “_Why the heck is DevOps happening?”_

If you are interested in DevOps, you will find the transcript really interesting. If I were you I would follow everyone who participated in the [Crowdchat][1] on Twitter – and call us out, continue the conversation, and share your opinion.

One last thought – in my opinion you cannot read that transcript, or participate in the Crowdchat as I did – without being convinced that DevOps is real, that many thought leaders agree that automation is an area in need of additional attention, and that together through discussions like this Crowdchat we are making great progress.

_Follow me [@epowell101][8] and let me know on Twitter or in the below comments what you think._

[<img loading="lazy" class="alignnone size-large wp-image-740" src="http://stackstorm.com/wp/wp-content/uploads/2014/09/crowdchat_logo_with_bkd-1024x395.png" alt="crowdchat_logo_with_bkd" width="625" height="241" />][9]

 [1]: https://www.crowdchat.net/devops
 [2]: http://www.twitter.com/cote
 [3]: http://www.twitter.com/jfryman
 [4]: http://www.twitter.com/carminerimi
 [5]: http://www.twitter.com/phool_stormer
 [6]: http://www.twitter.com/AndiMann
 [7]: https://twitter.com/#!/search?q=%23DevOps
 [8]: http://www.twitter.com/epowell101
 [9]: http://stackstorm.com/wp/wp-content/uploads/2014/09/crowdchat_logo_with_bkd.png