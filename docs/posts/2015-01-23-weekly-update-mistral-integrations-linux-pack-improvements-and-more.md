---
title: 'Weekly Update: Mistral Integrations, Linux Pack Improvements and More'
author: st2admin
type: post
date: 2015-01-23T23:49:47+00:00
excerpt: '<a href="http://stackstorm.com/?p=2321">READ MORE</a>'
url: /2015/01/23/weekly-update-mistral-integrations-linux-pack-improvements-and-more/
dsq_thread_id:
  - 3449961046
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Blog
  - Community
  - Home

---
**January 23, 2015**

_by Lakshmi Kannan_

This week was crazy good at StackStorm. We blogged about the <a href="http://stackstorm.com/2015/01/20/stackstorm-0-7-is-here/" target="_blank">0.7 release</a>. Though our main focus was around the release, we managed to get some nifty changes in our integrations and platform.

<!--more-->

###### COMMUNITY

### STABLE

Changes to <a href="https://exchange.stackstorm.org" target="_blank">StackStorm Exchange</a> include:

**Linux Pack Improvements**

  * We added a scp action that helps you securely copy files.
  * We added a traceroute action (thanks to contribution from Aamir Raza) to linux pack. This will help debug network issues.
  * We added a file watch sensor to linux pack. This helps emit a trigger whenever content is added to a file.

###### IN DEVELOPMENT INTEGRATIONS

Changes to our development integration repo, <a href="https://github.com/StackStorm/st2incubator" target="_blank">st2incubator</a>, include:

**Mistral Pack**

StackStorm-mistral integration is something we are constantly working on. Some of these integrations are now captured as actions in the mistral pack. We&#8217;ll be adding more such actions in the future.

**CI/CD Pack**

We are an agile team and we iterate fast. With 0.7 release, we added some platform features (like referring to keys in key-value store in action chain). CI/CD pack was updated to use some of the 0.7 features and also got some bug fixes.

###### PLATFORM

**RHEL packages**

We are constantly working towards increasing the number of platforms we support. In this vein, we now release RHEL packages of st2.

**Mistral**

We are active contributors to mistral. This week, we added support of complex YAQL expressions in mistral workflows that allows for more sophisticated branching conditions and complex calculation of inputs, outputs, and published variables. We improved StackStorm-Mistral integration. st2 now captures the workflow output from mistral and saves it in the st2 database. So when you kickoff mistral workflow via st2, you get all the task results as well as the workflow output. This allows for multiple workflows to be chained together. We also fixed some critical bugs.

**Distributed Deployment**

We have an architecture that allows us to scale across multiple virtual or physical servers. We have users actually doing that with us now, and we are polishing this design as we go.

If you haven’t already, we invite you to check out our product by <a href="http://docs.stackstorm.com/install/index.html" target="_blank">installing StackStorm</a> and following the <a href="http://docs.stackstorm.com/start.html" target="_blank">quick start</a> instructions — it will take less than 30 minutes to give you a taste of our automation. Share your thoughts and ideas via [stackstorm@googlegroups.com][1], <a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">#stackstorm on irc.freenode.net</a> or on Twitter <a href="https://twitter.com/Stack_Storm" target="_blank">@Stack_Storm</a>.  
&nbsp;

 [1]: https://groups.google.com/forum/#!forum/stackstorm