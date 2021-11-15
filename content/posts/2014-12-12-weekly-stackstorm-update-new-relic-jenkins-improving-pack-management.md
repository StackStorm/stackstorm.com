---
title: 'Weekly StackStorm Update: New Relic, Jenkins, & Improving Pack Management'
author: st2admin
type: post
date: 2014-12-12T20:37:22+00:00
excerpt: '<a href="http://stackstorm.com/2014/12/12/weekly-stackstorm-update-new-relic-jenkins-improving-pack-management/">READ MORE</a>'
url: /2014/12/12/weekly-stackstorm-update-new-relic-jenkins-improving-pack-management/
dsq_thread_id:
  - 3317712430
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Blog
  - Community
  - Home

---
**December 12, 2014**

_by Patrick Hoolboom_

At StackStorm, we want to enable our users to take advantage of everything our product has to offer, as well as provide feedback to us on the latest features as quickly as possible. In this spirit, we plan to share weekly updates regarding our progress, including new integration packs, improvements on existing packs, platform updates, and any tools created to help streamline the automation process. Our announcements will highlight both StackStorm-developed integrations as well as community contributions. We hope to be able to provide an overview of what has happened throughout the week as well as point out anything exciting that we see coming down the pipeline.

###### COMMUNITY

**Stable**  
Changes to our main community repo, <a href="https://exchange.stackstorm.org/" target="_blank">StackStorm Exchange</a>, include:

**New Relic**  
This week we introduced the first iteration of our New Relic integration pack. It comes with actions for getting alerts and metric data from the New Relic API.

<!--more-->

**libcloud**  
Our libcloud integration pack was augmented with additional actions related to object storage. Actions have been added to upload a file to an object store or retrieve the URL of an object from a store.

**linux**  
A generic rsync action was added to the linux integration pack.

**Bug Fixes:**

  * Nagios event handler support for new API structure
  * Sensu event handler support for new API structure

###### IN DEVELOPMENT INTEGRATIONS

We would also like to announce our new repository: <a href="https://github.com/StackStorm/st2incubator" target="_blank">st2incubator</a>.  It will be for integration packs and tools that are currently in development.  Some of the latest additions include:

**fpm**  
fpm support has initially been added with a number of out of the box actions for generating deb or rpm packages from a number of different sources including: rpm, deb, tarball, gem, or python packages.

**freight**  
The freight pack adds the following actions:

  * Add a package
  * Update cache

**Jenkins**  
The Jenkins action now available are:

  * running a Jenkins job
  * retrieving a list of currently running jobs

**consul**  
This pack provides support for the following actions:

  * put/get of key value pairs
  * listing nodes, datacenters, or services
  * querying nodes or services

**AWS**  
The AWS pack has continued to be under development in the st2incubator repo. Latest additions include support for all boto based EC2 actions and better output filtering for Instance objects. Much of the changes to this pack have come from the pack generation tool that is in development: Voodoo.

**Voodoo**  
We have begun working on a tool to auto-generate integration packs from python libraries. It is very new and still currently under development, but we have added it to the st2incubator. Documentation for this should follow in the next couple of days.

###### PLATFORM

With the <a href="http://stackstorm.com/2014/12/08/stackstorm-0-6-is-here/" target="_blank">release of 0.6 last week</a>, we had a number of improvements in various areas from sandboxing of python actions and sensors, to cleaner output formatting for actions.

Feedback has been positive on 0.6 and bug reports so far have been limited.

**0.6.0 Bug Fixes:**

  * Support st2 webhook in webhooks controller

If you haven’t already, we invite you to check out our product by <a href="http://docs.stackstorm.com/install/index.html" target="_blank">installing</a> StackStorm and following the <a href="http://docs.stackstorm.com/start.html" target="_blank">quick start</a> instructions — it will take less than 30 minutes to give you a taste of our automation. Share your thoughts and ideas via [stackstorm@googlegroups.com][1], [#stackstorm on irc.freenode.net][2] or on Twitter <a href="https://twitter.com/Stack_Storm" target="_blank">@Stack_Storm</a>.

 [1]: https://groups.google.com/forum/#!forum/stackstorm
 [2]: http://webchat.freenode.net/?channels=stackstorm