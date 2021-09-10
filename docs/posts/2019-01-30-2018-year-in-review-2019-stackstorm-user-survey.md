---
title: '2018 Year in Review & 2019 StackStorm User Survey'
author: Tomaz Muraus
type: post
date: 2019-01-30T15:05:58+00:00
url: /2019/01/30/2018-year-in-review-2019-stackstorm-user-survey/
thrive_post_fonts:
  - '[]'
  - '[]'
  - '[]'
  - '[]'
categories:
  - Community
  - News
tags:
  - release
  - release announcement

---
**Jan 30, 2019**  
_By Tomaz Muraus_

2018 is behind us and first of all we would like to thank all of our users, community members and customers for supporting us and making 2018 a successful year.

In this post we would like to have a look at the various things we have released and important milestones we have reached in 2018.

In addition to that, we would like to ask you to spare 10 minutes of your time by completing the [StackStorm 2019 User Survey][1]. Completing the survey will give us a better idea on how you use StackStorm. This will help us prioritize our feature development for 2019, make StackStorm better and help you become more successful.

<!--more-->

### 2018 in Numbers

To get things started, first some interesting numbers and statistics.

  * Number of StackStorm releases: 11 (out of those 6 major ones)
  * Number of commits to StackStorm/st2 repository: 2679
  * Numbers of issues closed in StackStorm/st2 repository: 201
  * Number of pull requests closed in StackStorm/st2 repository: 351
  * Number of Travis CI test builds runs: 1500+
  * Number of messages sent on #community channel our public Slack instance: 50.000+

### Release of our new Orquesta Workflow Engine

July marked an important milestone because we [released a new StackStorm native Workflow Engine called Orquesta][2] which will replace Mistral in the future.

Unlike Mistral, Orquesta is directly integrated into StackStorm. This offers a simpler deployment model (no more PostgreSQL, mistral-api and mistral-server services have been replaced with the new st2workflowengine service), better and more user-friendly experience, easier and faster debugging, better performance and more.

Currently Orquesta is still in beta, but we are in the process of bridging the Mistral feature gap and incorporating feedback from our users. We would encourage you to [have a look and try it out][3].

### Improved WebUI (st2web)

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-300x145.png" alt="" width="600" height="291" class="aligncenter wp-image-7973" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-300x145.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-150x73.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-768x372.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-1024x496.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-80x39.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-220x107.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-206x100.png 206w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-280x136.png 280w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-491x238.png 491w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-750x363.png 750w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-975x473.png 975w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-1190x577.png 1190w" sizes="(max-width: 600px) 100vw, 600px" /> 

Last year we released multiple improvements to our web interface. The biggest one was [new and improved triggers tab][2]. With this new and redesigned triggers tab, it’s now much easier to see if a trigger matched a rule (and which one) and if that match resulted in an action execution. This makes end to end tracing of triggers through the whole system much easier.

For more information, please refer to the [release announcement][2].

### Beta support for Python 3 and Ubuntu Bionic packages

In December we announced a preview of [Ubuntu Bionic StackStorm packages][4] which run all the StackStorm services under Python 3.6.

This is an important milestone for us. We started to work on Python 3 support early on in the life of the project, but we have finally reached a phase in the middle of the last year where we now have all the unit, integration and end to end tests running and passing under Python 3.

Currently we are in the process of testing StackStorm under Python 3 at scale and incorporating any user feedback and bugs which might be discovered.

If you are interested in how the future will look like, we would encourage you to try out those new packages.

If we don’t uncover any blockers, we plan to have GA packages out and ready either first or second quarter of this year.

### Kubernetes Blueprint for scale-out HA deployments (Helm Charts)

Late last year we released beta version of Kubernetes Blueprint (Helm Charts) for the [community][5] and [enterprise][6] version of StackStorm.

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/09/stackstorm-enterprise-ha-300x225.png" alt="" width="300" height="225" class="aligncenter wp-image-8272 size-medium" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/09/stackstorm-enterprise-ha-300x225.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/09/stackstorm-enterprise-ha-150x113.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/09/stackstorm-enterprise-ha-768x576.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/09/stackstorm-enterprise-ha-80x60.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/09/stackstorm-enterprise-ha-220x165.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/09/stackstorm-enterprise-ha-133x100.png 133w, https://stackstorm.com/wp/wp-content/uploads/2018/09/stackstorm-enterprise-ha-200x150.png 200w, https://stackstorm.com/wp/wp-content/uploads/2018/09/stackstorm-enterprise-ha-317x238.png 317w, https://stackstorm.com/wp/wp-content/uploads/2018/09/stackstorm-enterprise-ha-553x415.png 553w, https://stackstorm.com/wp/wp-content/uploads/2018/09/stackstorm-enterprise-ha-649x487.png 649w, https://stackstorm.com/wp/wp-content/uploads/2018/09/stackstorm-enterprise-ha-793x595.png 793w, https://stackstorm.com/wp/wp-content/uploads/2018/09/stackstorm-enterprise-ha.png 800w" sizes="(max-width: 300px) 100vw, 300px" />][7]

[Helm Charts][7] allow you to run StackStorm at scale in an HA manner using Docker and Kubernetes. It takes care of things such as automatic failover, load-balancing, scaling, HA setup for all the components and services (replication setup for MongoDB, master-master setup and queue mirroring for RabbitMQ, etc.) and more.

It removes a lot of burden and work from the operator which makes running and operating a distributed HA StackStorm deployment much cheaper and easier.a.html

### New Windows Runners (WinRM)

In StackStorm v2.9.0 we announced new [WinRM based Windows runners][8]. Those runners will replace old winexe based Windows runners in the near future.

Unlike old winexe based Windows runners, those runners are much easier to get started with (no need to install winexe binary anymore). In addition to that, they are also much more robust and stable because they utilize native Windows Remote Management (WinRM) protocol.

Special thanks to our long time user and contributor [Nick Maludy][9] who has contributed this feature.

### Community Forums

We have nurtured a very vibrant and active community of helpful users on our community Slack instance, but one thing Slack is missing is permanence. Slack is great for asking quick questions and debating things in real-time, but since it’s real-time, most of the information is of an ephemeral nature.

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2019/01/community_forums-300x207.png" alt="" width="600" height="414" class="aligncenter wp-image-8719" srcset="https://stackstorm.com/wp/wp-content/uploads/2019/01/community_forums-300x207.png 300w, https://stackstorm.com/wp/wp-content/uploads/2019/01/community_forums-150x104.png 150w, https://stackstorm.com/wp/wp-content/uploads/2019/01/community_forums-768x530.png 768w, https://stackstorm.com/wp/wp-content/uploads/2019/01/community_forums-1024x707.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2019/01/community_forums-80x55.png 80w, https://stackstorm.com/wp/wp-content/uploads/2019/01/community_forums-220x152.png 220w, https://stackstorm.com/wp/wp-content/uploads/2019/01/community_forums-145x100.png 145w, https://stackstorm.com/wp/wp-content/uploads/2019/01/community_forums-217x150.png 217w, https://stackstorm.com/wp/wp-content/uploads/2019/01/community_forums-345x238.png 345w, https://stackstorm.com/wp/wp-content/uploads/2019/01/community_forums-601x415.png 601w, https://stackstorm.com/wp/wp-content/uploads/2019/01/community_forums-705x487.png 705w, https://stackstorm.com/wp/wp-content/uploads/2019/01/community_forums-862x595.png 862w, https://stackstorm.com/wp/wp-content/uploads/2019/01/community_forums.png 1144w" sizes="(max-width: 600px) 100vw, 600px" />][10]

To support our community and users better we launched new StackStorm community forum &#8211; <https://forum.stackstorm.com>. On the forum users can ask questions and exchange ideas. Unlike Slack, answers to those questions and ideas will be archived, indexed and available to other users who might be facing the same issues.

If you haven’t already, go check out our new forums &#8211; <https://forum.stackstorm.com>.

### OVA, Virtual Appliance and Vagrant

To allow users to try out StackStorm easier and faster and to better support deployments in an isolated air-gapped environments, we released a new OVA based Virtual Appliance. Community edition is available as a VirtualBox image, but enterprise version is also available in other formats such as VMWare.

In addition to the Virtual Appliance, we also launched a new Vagrant image which allows users to quickly and easily try out StackStorm.

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-300x179.png" alt="" width="480" height="287" class="aligncenter wp-image-7779" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-300x179.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-150x90.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-768x459.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-80x48.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-220x131.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-167x100.png 167w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-251x150.png 251w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-398x238.png 398w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-695x415.png 695w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover.png 800w" sizes="(max-width: 480px) 100vw, 480px" />][11]

You can learn more in the [release announcement blog][12] and and in the [documentation][11].

### 2019 StackStorm User Survey

To be able to make 2019 even more successful we would like to learn more how you use StackStorm. This will allow us to prioritize features based on the actual user needs and make you more successful in the end.

If you have 10 minutes to spare we would ask you to please complete our first user survey available at https://www.surveymonkey.com/r/st2-2019-user-survey.

By default the survey is fully anonymous and we don’t collect any personal identifiable data.

If you want to receive StackStorm stickers for completing the survey or if you are fine with us reaching out to you for any follow up questions we might have, you can chose to leave your email we can use to contact you.

 [1]: https://www.surveymonkey.com/r/st2-2019-user-survey
 [2]: https://stackstorm.com/2018/07/10/stackstorm-2-8-ui-changes-new-workflow-engine-and-more/
 [3]: https://docs.stackstorm.com/orquesta/index.html
 [4]: https://stackstorm.com/2018/12/14/pre-change-freeze-stackstorm-2-10/
 [5]: https://stackstorm.com/2018/10/10/stackstorm-ha-in-kubernetes-beta-community-update/
 [6]: https://stackstorm.com/2018/09/26/stackstorm-enterprise-ha-in-kubernetes-beta/
 [7]: https://docs.stackstorm.com/install/k8s_ha.html
 [8]: https://stackstorm.com/2018/09/24/stackstorm-2-9-k8s-streaming-inquiries-windows/
 [9]: https://github.com/nmaludy
 [10]: https://forum.stackstorm.com/
 [11]: https://docs.stackstorm.com/install/vagrant.html
 [12]: https://stackstorm.com/2018/05/20/announcing-stackstorm-vagrant-ova/