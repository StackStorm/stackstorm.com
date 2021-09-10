---
title: 'StackStorm project updates: Autumn 2020'
author: Eugen C.
type: post
date: 2020-11-30T19:49:13+00:00
url: /2020/11/30/stackstorm-project-updates-autumn-2020/
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - News
tags:
  - Community
  - news
  - releases
  - roadmap
  - updates

---
**Nov 30, 2020**  
_by Eugen Cusmaunsa ([@armab][1])_

Hello Automation folks!  
We would like to quickly update StackStorm community about the project progress, releases, plans and roadmap. Here is the overview.

<!--more-->

### ⭐ 4K Github Stars

<div class="css-1dbjc4n">
  <div dir="auto" class="css-901oao r-18jsvk2 r-1qd0xha r-1b43r93 r-16dba41 r-ad9z0x r-bcqeeo r-bnwqim r-qvutc0" id="tweet-text" lang="en">
    <span class="css-901oao css-16my406 r-1qd0xha r-ad9z0x r-bcqeeo r-qvutc0">StackStorm Open Source Event-driven Automation project</span><span class="css-901oao css-16my406 r-1qd0xha r-ad9z0x r-bcqeeo r-qvutc0"> hit ⭐ </span><span class="css-901oao css-16my406 r-1qd0xha r-ad9z0x r-bcqeeo r-qvutc0"> 4000 Github stars last month!</span><span class="css-901oao css-16my406 r-1qd0xha r-ad9z0x r-bcqeeo r-qvutc0"> Thanks to our stellar </span><span class="css-901oao css-16my406 r-1qd0xha r-ad9z0x r-bcqeeo r-qvutc0">community for all the support during these years! </span>Every piece of your help is highly appreciated. If you didn&#8217;t give us a star yet, here is the link: <span class="css-901oao css-16my406 r-1qd0xha r-ad9z0x r-bcqeeo r-qvutc0"><a href="https://github.com/StackStorm/st2">https://github.com/StackStorm/st2</a><br /></span>
  </div>
</div>



### StackStorm v3.3.0 Released

v3.3.0 went out in October. In this release Mistral was deprecated in favor of Orquesta, the workflow engine designed specifically for StackStorm. [Chef][2] was removed as a deployment method and Hipchat deleted from the list of chatops providers. By adding CentOS/RHEL 8 support in st2 v3.2.0, CentOS/RHEL 6 is also decommissioned as part of the OS flavor rotation. Thanks to our contributors from **@DELL**, one of the StackStorm adopters, [docker-compose][3] deployment had a full major overhaul and now relies on the same Docker images as K8s. MongoDB 4.0 is now the currently supported version across all the platforms. Check out <a href="https://stackstorm.com/2020/10/22/stackstorm-v3-3-0-released/" data-ac-default-color="1" target="_blank" rel="noopener noreferrer">v3.3.0 Release Announcement</a> by [Nick Maludy][4] from [Encore Technologies][5] for more details.



### StackStorm ChatOps Future

There are ongoing discussions about transitioning chatops to the new framework. We have gathered some good <a href="https://github.com/StackStorm/discussions/issues/48" data-hovercard-type="issue" data-hovercard-url="/StackStorm/discussions/issues/48/hovercard" data-ac-default-color="1">community feedback on our ChatOps roadmap</a> for how to <a href="https://github.com/StackStorm/discussions/issues/8" data-hovercard-type="issue" data-hovercard-url="/StackStorm/discussions/issues/8/hovercard" data-ac-default-color="1">rewrite ChatOps in Python</a> for better integration into the rest of StackStorm (who wanted ChatOps RBAC?). We also met for a <a href="https://github.com/StackStorm/discussions/issues/56" data-ac-default-color="1">ChatOps Roadmap Meeting</a> in November organized by [@blag][6] and discussed possible project direction. If you&#8217;re interested to get involved, please join us in _#chatops_ StackStorm Slack channel. Use cases, testing, evaluation, design ideas, implementation, feedback, &#8211; there are so many ways to help the StackStorm pushing this story forward.



### UK Automation & Orchestration Community Meetup

In November <a href="https://www.meetup.com/infra-orchestration-automation-uk/events/273795132/" data-ac-default-color="1" target="_blank" rel="noopener noreferrer">UK Infrastructure Automation Meetup</a> was organized with some interesting talks about the StackStorm history, StackStorm OSS Community and ChatOps & AWS demo by [Amanda McGuinness][7] of [Ammeon Solutions][8]. It&#8217;s great to see such events happening around StackStorm and hope we&#8217;ll find more meetups in the future that will share the journey of automating all the things! Spreading the word out is great and if you&#8217;d like to share your story, use case, write a guest blog post, case study or maybe just highlight the technical difficulty you solved with st2, &#8211; please reach out to us! We&#8217;d love to highlight it from StackStorm side.



### 3 months release cadence

It took more than expected time to cut the v3.3.0 and StackStorm maintainer team decided to switch to a periodic 3 months release cadence. This means depending on what landed in the codebase during these three months, we&#8217;ll release a minor _vA.**B**.C_ version if there are any important features ready for production. Otherwise, in case of small bugfixes and enhancements just a patch version like _vA.B.**C**_ will be released instead. This will help us to establish the project release heartbeat and shape better expectations from our community.



### StackStorm v3.4.0 Roadmap

Following the new 3 months release cadence, we plan new StackStorm version 3.4.0 by the end of January, 2021. Python 2 deprecation and integrating previously Enterprise features are the biggest items, but there are many other smaller fixes and enhancements available to pick up. If you want to contribute, take a look at Github projects: [[ 1 ]][9], [[ 2 ]][10], [[ 3 ]][11]. Join our _#development_ channel in StackStorm Community Slack and just ask where help is needed.



### Python 2 Deprecation Plan

Python 2 officially has reached EOL and StackStorm will be deprecating it in the future version, moving the platform core to Python 3 only. Project Maintainers and Contributors had several <a href="https://github.com/StackStorm/discussions/issues/40" data-ac-default-color="1" target="_blank" rel="noopener noreferrer">discussions</a> and <a href="https://github.com/StackStorm/discussions/issues/53" data-ac-default-color="1" target="_blank" rel="noopener noreferrer">meetups</a> to talk about the technical details and we&#8217;ve updated our community about the plan and the migration path. Check out: [Python 2 Deprecation Plan: Say goodbye to python 2][12] b_<span>y</span>_ [Amanda McGuinness][7] of [Ammeon Solutions][8]. Get ready!



### RBAC, LDAP, Workflow Designer integration

As you may heard <a href="https://stackstorm.com/2020/05/27/extreme-networks-donates-ewc-to-linux-foundation/" data-ac-default-color="1" target="_blank" rel="noopener noreferrer">Extreme Networks open sourced the code</a> that was previously part of the paid EWC aka StackStorm Enterprise. However while the repositories are open, the integration into the core still needed to be done. StackStorm Open Source project Maintainers and Contributors are working on including these features in the upcoming v3.4.0 release. We also want to thank the [Orchestral.ai][13] and **@Starbucks** SRE team, one of the StackStorm adopters for helping with the ongoing RBAC/LDAP integration into st2 core and would like to invite other Adopters using StackStorm in production to help us driving the project forward, together.



### ❤️ Sponsoring StackStorm

As previously Enterprise features are becoming available for free, we&#8217;d like to remind everybody that StackStorm is maintained by the committee of Open Source volunteers during their spare time. You can help us supporting the project too by <a href="https://stackstorm.com/donate/" data-ac-default-color="1" target="_blank" rel="noopener noreferrer">donating a small amount</a>. The funds will be used for sustaining the project infrastructure (see [expenses][14]), which is critical for shipping the releases to you, our users.



Thank you all for your interest and support of StackStorm so far!

Cheers,  
<a href="https://github.com/StackStorm/st2/blob/master/OWNERS.md" data-ac-default-color="1" target="_blank" rel="noopener noreferrer">StackStorm Team</a>

 [1]: https://github.com/armab
 [2]: https://github.com/stackstorm/chef-stackstorm
 [3]: https://github.com/stackstorm/st2-docker
 [4]: https://github.com/nmaludy
 [5]: http://www.encore.tech/
 [6]: https://github.com/blag
 [7]: https://github.com/amanda11
 [8]: https://www.ammeonsolutions.com/
 [9]: https://github.com/orgs/StackStorm/projects/19
 [10]: https://github.com/orgs/StackStorm/projects/14
 [11]: https://github.com/orgs/StackStorm/projects/15
 [12]: https://stackstorm.com/2020/11/15/python-2-deprecation-plan-say-goodbye-to-python-2/
 [13]: https://orchestral.ai/
 [14]: https://github.com/StackStorm/discussions/issues/36