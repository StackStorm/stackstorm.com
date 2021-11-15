---
title: Notes from Scale15x
author: Dmitri Zimine
type: post
date: 2017-03-06T22:56:51+00:00
url: /2017/03/06/notes-from-scale15x/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5608904153
categories:
  - Blog
  - Community

---
**Mar 03, 2017**  
_by Dmitri Zimine_

Hey, it’s Dmitri here, back from [Scale15x][1] with a short report of what I enjoyed the most.

**My talk 🙂** It was a bit symbolic for me. I spoke at [Scale13x][2], comparing and contrasting Enterprise Suites and OpenSource, and stated the free pillars of “Designed for DevOps”:

  * OpenSource
  * Infrastructure as code
  * Social coding and collaboration

In my talk this time, I reported back on how we put these three principles in practice with StackStorm, redefining Runbook automation for the time of clouds and Devops. The core of the talk was a live demo of StackStorm, auto-remediation, and ChatOps. Thank you who came for my talk on this late Sunday afternoon and gave me warm welcome and great questions. For the rest, here are the **[the slides][3] and [the video recording][4].**



<!--more-->

**The sessions:** they were were numerous, diverse, and mostly very good, ranged from compiling Linux kernel to political aspects of IoT data collections by municipalities. Video footage already posted to [Scale youtube channel][5]. I liked more than you have time to read about, note just a few:

[Joe Smith][6] from SlackHQ presented [SlackOps Automation Framework][7] &#8211; welcome to Auto-remediation club and looking forward for you sharing more at our AutoRemediation meetup, hopefully soon!

Nate DAmico and Rich Pelavin @ reactor8 &#8211; the authors of [DTK][8] &#8211; gave some insightful sessions. Rick talked on [“Declarative Management vs Procedural Workflows”][9] at rare depth of insides, Nate gave a non-superficial overview of container technologies, placed some bets of who’s gonna win the arms race, and dived into serverless frameworks.

Serverless is on top of everyone’s mind. It prompted me to make a new “StackStorm is like…”: I am convinced that StackStorm is a fair contender in Serverless space and can do at least as much as OpenWhisk, with all due respect to IBM folks. The topic is worth a dedicated blog, stay tuned.

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/03/StackStorm-like-lambda.png" alt="" width="755" height="404" class="aligncenter size-full wp-image-6663" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/03/StackStorm-like-lambda.png 755w, https://stackstorm.com/wp/wp-content/uploads/2017/03/StackStorm-like-lambda-150x80.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/03/StackStorm-like-lambda-300x161.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/03/StackStorm-like-lambda-80x43.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/03/StackStorm-like-lambda-220x118.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/03/StackStorm-like-lambda-187x100.png 187w, https://stackstorm.com/wp/wp-content/uploads/2017/03/StackStorm-like-lambda-280x150.png 280w, https://stackstorm.com/wp/wp-content/uploads/2017/03/StackStorm-like-lambda-445x238.png 445w, https://stackstorm.com/wp/wp-content/uploads/2017/03/StackStorm-like-lambda-750x401.png 750w" sizes="(max-width: 755px) 100vw, 755px" /> 

The Expo: RedHat booth attracted folks with geeky little micro racks of R-Pi’s and Intel Galileo Gen 2’s running k8s. I learned about [Atomic][10], the immutable OS, and re-learned what is OpenShift now, which is not what it was before. For those who like me missed the memo &#8211; it represent RedHat’s open and total shift from VMs and OpenStack to containers and K8n.

The people: Meeting with like-minded folks is the best part of any good conference, and scale15x was good to me. Fortunate to connect with the founders. Nice to meet Alexey Vladishev(@avladishev), the founder of Zabbix &#8211; hope this turns into partnership thanks to StackStorm’s synergy with monitoring tools , Great to hear [Kohsuke Kawaguchi][11] [“Hackers Gotta Eat: Building a Company Around an Open Source Project”][12]: the author of Jenkins shared the story of his journey from a hobby side-kick to the iconic CI/CD tool. A thoughtful and insightful talk on striking the right and fair balance between open source purity and lessons to to make the projects survive and sustain. A topic near to me as we lived the shared struggles to strike same balance, and left me thinking what’s the future sustainable model for open-source utility tools.

Overall, great conference. It grew tremendowsly in the past years, yet it still has this spirit of [freedom activism][13] keeping OpenSource what it is. Hat’s off for organizers &#8211; nearly invisible themselves, they managed to set it up perfectly and created this great atmosphere of diversity, breadth, depth, geekiness, and courage of intellectual inquiry.

For StackStorm, the main take-aways is “people get it when they see it”. We have built the right platform, that solves real problems, but have much work to do to make you folks aware of the awesome automations you can build with StackStorm. Have ideas for those automations to solve your problems? Join us &#8211; ping the team and community [on Slack][14] and let’s do it together.

 [1]: https://www.socallinuxexpo.org/scale/15x/
 [2]: https://www.socallinuxexpo.org/scale12x/presentations/openstack-vs-vmware-systems-administrator-perspective.html
 [3]: https://www.slideshare.net/DmitriZimine/stackstrom-ifthisthanthat-for-devops-automation
 [4]: https://youtu.be/3TjhBGshvvY?t=3h31m5s
 [5]: https://www.youtube.com/channel/UCN2nbMPLJWv3Y__4JuF_hMQ
 [6]: https://twitter.com/Yasumoto
 [7]: https://www.socallinuxexpo.org/scale/15x/presentations/slackops-automation-framework
 [8]: http://www.dtk.io/
 [9]: https://www.socallinuxexpo.org/scale/15x/presentations/declarative%C2%A0management%C2%A0vs-procedural-workflows
 [10]: http://www.projectatomic.io/
 [11]: https://twitter.com/kohsukekawa
 [12]: https://www.socallinuxexpo.org/scale/15x/presentations/hackers-gotta-eat-building-company-around-open-source-project
 [13]: https://en.wikipedia.org/wiki/Free_software_movement
 [14]: https://stackstorm.com/community-signup