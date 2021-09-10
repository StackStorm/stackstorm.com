---
title: StackStorm at OpenStack Barcelona
author: Dmitri Zimine
type: post
date: 2016-11-03T08:09:35+00:00
url: /2016/11/03/stackstorm-at-openstack-barcelona/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5274798032
categories:
  - Blog
  - Community
tags:
  - Auto-remediation
  - event-driven automation
  - openstack

---
**Nov 01, 2016**  
_by Dmitri Zimine_

Lights flashing at the StackStorm-Brocade booth made event-driven automation feel real with the IoT demo entertaining enterprise and DevOps crowds alike. Mirantis’ talk about auto-healing Symantec OpenStack cloud with StackStorm sparkled hallway conversations about auto-remediation. Our guerrilla hacking challenge was success, unveiled that the best hackers are all co-located&#8230;(guess where, anyone?)

Read on for details.  
<!--more-->

OpenStack Barcelona was a few intense and exciting days. News, presentations, rumors and talks over drinks, tech dives, marketplace booths, meeting old friends and making new &#8211; it all creates this unique and exciting atmosphere of intense learning and elevated thinking. OpenStack’s direction and destiny deserves a dedicated post.

For us, the best part was to sense StackStorm awareness and adoption. You could hear people dropping StackStorm and “auto-remediation” here and there in lounges, lunches, and hallways. Many of our booth visitors started with “we know you”, and some with “we use StackStorm”.

### Booth

Our booth, although modest by corporate marketing standards, was definitely one of the most entertaining.  
Now I regret not taking a video of @bigmstone flashing the lights to demonstrate event driven automation…so just look at the photo and use your imagination.

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_6999.jpg" alt="img_6999" width="4032" height="3024" class="aligncenter size-full wp-image-6236" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_6999.jpg 4032w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_6999-150x113.jpg 150w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_6999-300x225.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_6999-768x576.jpg 768w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_6999-1024x768.jpg 1024w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_6999-80x60.jpg 80w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_6999-220x165.jpg 220w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_6999-133x100.jpg 133w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_6999-200x150.jpg 200w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_6999-317x238.jpg 317w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_6999-553x415.jpg 553w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_6999-649x487.jpg 649w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_6999-793x595.jpg 793w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_6999-400x300.jpg 400w" sizes="(max-width: 4032px) 100vw, 4032px" /> 

The line of lights was controlled by R-PI via REST API. Another R-PI was paired with the color selector. You select a color using nice dials, press a big button, and StackStorm instance takes it from there: a sensor fires a trigger, a workflow cranks and an action turns the lights to the selected color. The setup withstood 3 days of intense use: we only kicked it down twice, and in spite of the little challenge it took to keep the line of lights from sagging down, the lights stood on.

When the lights flashed vividly in an instant response to a visitor tweet about #Stack_Storm, the light bulbs went off in our visitors’ minds: that’s event-driven! And now I may use twitter to trigger troubleshooting workflows in my infrastructure. Joke? Get this: GitHub relies on twitter as a monitoring tool &#8211; when unhappy with service performance, developers tweet.

Whether it was due to the IoT demo connecting the dots on event-driven automation, the state of DevOps evolution and adoption, or the growing need for dealing with Day-2 operations, my impression is that we had much more in-depth and detailed conversations on troubleshooting, auto-remediation and other event-driven use-cases, compared to previous years at the OpenStack Summit. Insightful talks with Accenture, Walmart, VW, RedHat, Cisco, NVF players and many others.

### Mirantis talk

Mirantis&#8217; presentation hit the the right nerve with the Ops crowd. It was a good joke to schedule “Sleep better at night” talk at 9 am in the morning, but attendance was quite high despite the early hour. As DevOps automation progresses beyond puppet-chef-orchestration and CI/CD, people recognize the need for Day-2 automation and understand that auto- remediation is not limited to root-cause analysis as the problem. The demo, though recorded, was so realistic that it felt live: it killed a network path on a host, simulating a partial hardware failure; Zabbix monitoring triggered an auto-remediation workflow that migrated VMs, opened Jira ticket for a hardware issue, and sent email so that an operator checks the case when he gets up. More use cases presented at the level of detail that only comes from field experience, which led to good hallway after-talk discussions.  
[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7065-1024x768.jpg" alt="img_7065" width="1024" height="768" class="aligncenter size-large wp-image-6237" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7065-1024x768.jpg 1024w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7065-150x113.jpg 150w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7065-300x225.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7065-768x576.jpg 768w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7065-80x60.jpg 80w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7065-220x165.jpg 220w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7065-133x100.jpg 133w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7065-200x150.jpg 200w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7065-317x238.jpg 317w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7065-553x415.jpg 553w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7065-649x487.jpg 649w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7065-793x595.jpg 793w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7065-400x300.jpg 400w" sizes="(max-width: 1024px) 100vw, 1024px" />][1]

### Hacking challenge<picture hacking picture> 

The Hacking Challenge was not something one notices by corporate enterprise, or be mentioned from a big stage. But among the life hackers, who still luckily have a good presence at the summit, it was a killer hit. The challenge was a last minute improvisation: I grabbed prizes on the way to the airport, Matt, Winson, and Ed hacked it en-route to Barcelona, we made up flyers and found a printing shop on the morning of the opening. And oh my, it worked! It has been a parallel reality, with cryptic messages flying around on twitter and guys whispering about saving kitties at our booth…While the first two stages didn’t require much effort, the last stage required some serious hacking. To our excitement someone solved it, and got a GoPro camera! The other GoPro and a bunch of Raspberry-PI starter kits were raffled between the rest of the players.

Here is a full list of winners:

[@oLeksee][2] &#8211; Grand Prize for 1st to complete &#8211; GoPro  
[@ngubenko][3] &#8211; completed the challenge &#8211; GoPro  
[@The_cloudguru][4] &#8211; stage 4 &#8211; rpi  
[@John_studarus][5] &#8211; stage 2 &#8211; rpi  
[@DatkoSzymon][6] &#8211; stage 2 &#8211; rpi  
[@e0ne][7] &#8211; stage 1 &#8211; rpi

<div id="attachment_6238" style="width: 1034px" class="wp-caption aligncenter">
  <a href="https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7076.jpg"><img aria-describedby="caption-attachment-6238" loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7076-1024x768.jpg" alt="StackStorm hacking challenge winners" width="1024" height="768" class="size-large wp-image-6238" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7076-1024x768.jpg 1024w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7076-150x113.jpg 150w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7076-300x225.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7076-768x576.jpg 768w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7076-80x60.jpg 80w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7076-220x165.jpg 220w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7076-133x100.jpg 133w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7076-200x150.jpg 200w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7076-317x238.jpg 317w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7076-553x415.jpg 553w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7076-649x487.jpg 649w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7076-793x595.jpg 793w, https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7076-400x300.jpg 400w" sizes="(max-width: 1024px) 100vw, 1024px" /></a>
  
  <p id="caption-attachment-6238" class="wp-caption-text">
    StackStorm hacking challenge winners
  </p>
</div>

Can’t help conspiracy jokes when Russians from Mirantis beat all statistical distributions, winning both GoPro’s and 3 out of 7 prizes total. And NO, we didn’t stack the deck: all the challenge code is on github.

Congratulations guys and come play again!

### StackStorm, Mistral, and Tosca at Design summit.

Sensing some confusion around the relationship between Mistral and StackStorm, I gave a talk where I shared the history of Mistral/StackStorm growing together, shed light on a common question of “why did we have to re-invent a workflow system” (hint: devops!) and make it clear when to use Mistral, and when to go for StackStorm. Slides are [posted here][8], and by popular demand I plan to sum it up in another blog to help equip users to make informed choices.

TOSCA was another discussion topic. I am pragmatically skeptical on standards, but here I see a case where a user can be a winner: make TOSCA recommend Mistral workflow definition language for defining process models. Why now? NFV gravitates to TOSCA, and, at the same time, proved to heavily rely on solid workflow automation. Nokia-Alcatel use Mistral in their NFV solution, Tacker is picking Mistral for workflow integration, Ericsson, AT&T, and some others are exploring it as a natural solution. The current TOSCA tongue-in-cheek recommendation of BPEL/BPMM is inadequate, and Mistral DSL is a natural and timely choice. We have started the conversation and likely pass the lead to our Tacker friends to drive it to a proposal.

Overall, another great OpenStack Summit for StackStorm team; now back home, energized with some new ideas for building more exciting stuff for your day 2 operations, and beyond.

 [1]: https://stackstorm.com/wp/wp-content/uploads/2016/11/IMG_7065.jpg
 [2]: https://twitter.com/oLeksee
 [3]: https://twitter.com/ngubenko
 [4]: https://twitter.com/the_cloudguru
 [5]: https://twitter.com/john_studarus
 [6]: https://twitter.com/DatkoSzymon
 [7]: https://twitter.com/e0ne
 [8]: http://www.slideshare.net/DmitriZimine/mistral-and-stackstorm