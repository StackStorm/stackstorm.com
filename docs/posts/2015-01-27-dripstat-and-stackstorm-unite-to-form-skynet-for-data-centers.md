---
title: DripStat And StackStorm Unite To Form SkyNet For Data Centers
author: st2admin
type: post
date: 2015-01-27T22:01:45+00:00
excerpt: '<a href="http://stackstorm.com/2015/01/27/dripstat-and-stackstorm-unite-to-form-skynet-for-data-centers/">READ MORE</a>'
url: /2015/01/27/dripstat-and-stackstorm-unite-to-form-skynet-for-data-centers/
dsq_thread_id:
  - 3461195453
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home

---
**January 27, 2015**

_Guest post by Prashant Deva, Founder and CTO of_ <a href="http://chrononsystems.com/" target="_blank"><i>Chronon Systems</i></a>_, parent company of_ <a href="https://dripstat.com/" target="_blank"><i>DripStat</i></a>

If you run an application on a JVM, it is inevitable that you are at some point going to run into issues such as:

  1. OutOfMemory exception
  2. High GC pause times

Since the above is inevitable, you want to ensure your infrastructure is set to automatically detect and deal with the above issues. Otherwise you _are_ looking at downtime sometime in the future.

With a combination of DripStat and StackStorm, we are moving in a world of fully automated data centers. Let’s see how we can use them to completely automate dealing with above issues so we don’t get any downtime.

<!--more-->

<a href="https://dripstat.com" target="_blank">DripStat</a> is an APM (Application Performance Management) solution for Java.

DripStat can automatically detect and alert you when:

  1. Your heap usage is close to max and you are _about to_ (but have not yet) run into an OutOfMemoryException
  2. You are running into high amounts of GC pauses

That covers the first portion of actually detecting issues in your application.

The next stage is where StackStorm comes in.

<a href="http://stackstorm.com/" target="_blank">StackStorm</a> is like IFTTT for Infrastructure Operations. StackStorm can listen to or poll for events and then take actions based on those events with the help of a rules engine and workflow.  In our example we will use StackStorm to automatically respond to issues DripStat identifies with a remediation that repairs segregated or failing services.

###### How does it all work?

StackStorm now has a DripStat ‘sensor.’ This sensor automatically detects the above alerts from DripStat and triggers ‘actions&#8217;.

StackStorm can integrate with many different internal and external applications with its powerful reactor system. <a href="http://docs.stackstorm.com/overview.html#how-it-works" target="_blank">Read more about its architecture</a>.

For example, it can automatically provision new servers in many clouds including: VMWare Virtual Center, Amazon Web Services, OpenStack, Rackspace, Digital Ocean, and any other libcloud compatible cloud, which is what we will need for our task today.

All you need is to configure StackStorm to perform the following actions:

**1. On high heap usage**

You know you are about to run OutOfMemory very soon.

Start draining the current node from the Load Balancer and then remove it entirely.

You just saved your users from seeing an OutOfMemoryException!

**2. On High GC**

Add a new node with a larger heap size.

Start draining the current node from the Load Balancer and then remove it entirely.

You just autoscaled your infrastructure based on load!

<a href="http://docs.stackstorm.com/install/index.html" target="_blank">StackStorm can be installed</a> in less than 30 minutes and it only takes a few more minutes to <a href="https://dripstat.com" target="_blank">install DripStat</a>. So you can basically take an extended coffee break and have fully automated infrastructure by the end of it!**  
** 

Check out the <a href="http://stackstorm.com/community" target="_blank">StackStorm community site</a> to learn more about the DripStat integration and more.  
&nbsp;