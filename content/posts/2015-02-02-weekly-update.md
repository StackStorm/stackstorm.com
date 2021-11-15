---
title: 'Weekly Update: Application Monitoring Packs And More'
author: st2admin
type: post
date: 2015-02-02T09:30:04+00:00
excerpt: '<a href="http://stackstorm.com/?p=2385">READ MORE</a>'
url: /2015/02/02/weekly-update/
dsq_thread_id:
  - 3470909987
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Blog
  - Community
  - Home

---
**February 2, 2015**

_by Manas Kelshikar_

This past week at StackStorm we pushed out changes to the core StackStorm platform and added more integration to packs in the community repo, all while trying to solve many real-world problems. Following a push into the CI/CD use case, we are now jumping into the application monitoring and remediation space &#8212; check out this awesome guest post about <a href="http://stackstorm.com/2015/01/27/dripstat-and-stackstorm-unite-to-form-skynet-for-data-centers/" target="_blank">forming SkyNet</a>.

<!--more-->

###### COMMUNITY

### STABLE

Changes to <a href="https://exchange.stackstorm.org" target="_blank">StackStorm Exchange</a>:

**Rackspace Pack**

  * New Rackspace pack to work with Cloud Server, Cloud LoadBalancers and Cloud DNS.

**Java JMX Pack**

  * A Java JMX pack that allows monitoring of applications such as Cassandra, Tomacat, Hadoop.

**DripStat Pack**

  * <a href="https://dripstat.com/" target="_blank">DripStat</a> integration pack which listens to alerts from DripStat.

**NewRelic Pack Improvements**

  * We added a NewRelic sensor so that alerts from NewRelic can be brought into StackStorm.

**Linux Pack Improvements**

  * Action to scan open ports.

###### IN DEVELOPMENT INTEGRATIONS

Changes to our development integration repo, <a href="https://github.com/StackStorm/st2incubator" target="_blank">st2incubator</a>, include:

**Mistral Pack**

Additional updates to the Mistral pack.

###### PLATFORM

Changes to the main repo, <a href="https://github.com/StackStorm/st2" target="_blank">StackStorm</a>, include:

As we work towards our next release we are busy adding new features and bug fixes. Some highlights from this week:

  * Can include authentication header in query params for all those times when providing headers in an HTTP request is not an option
  * Improvements around variable publishing and definition in ActionChain (our own very simple workflow)
  * Ability to list all webhooks that StackStorm currently knows about from the handy StackStorm CLI

**Mistral**

A week of active Mistral usage and getting some changes we previously talked about upstream. As Mistral matures we continue to push for its adoption.

**StackStorm Deployments**

We are glad to see StackStorm being deployed in the wild and folks jumping onto our IRC channel. Lots of interesting conversation brewing there and all-in-all good times working with folks who are deploying StackStorm to automate their infrastructure.

If you haven’t already, we invite you to check out our product by <a href="http://docs.stackstorm.com/install/index.html" target="_blank">installing StackStorm</a> and following the <a href="http://docs.stackstorm.com/start.html" target="_blank">quick start</a> instructions — it will take less than 30 minutes to give you a taste of our automation. Share your thoughts and ideas via [stackstorm@googlegroups.com][1], <a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">#stackstorm on irc.freenode.net</a> or on Twitter <a href="https://twitter.com/Stack_Storm" target="_blank">@Stack_Storm</a>.

 [1]: https://groups.google.com/forum/#!forum/stackstorm