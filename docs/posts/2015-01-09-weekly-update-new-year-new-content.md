---
title: 'Weekly Update: New Year, New Content!'
author: st2admin
type: post
date: 2015-01-09T20:29:49+00:00
excerpt: '<a href="http://stackstorm.com/2015/01/09/weekly-update-new-year-new-content/">READ MORE</a>'
url: /2015/01/09/weekly-update-new-year-new-content/
dsq_thread_id:
  - 3406098831
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Blog
  - Community
  - Home

---
**January 9, 2015**

_by Patrick Hoolboom_

It has been a couple weeks since we posted an update but don’t worry, we’ve kept plenty busy! The StackStorm office has been buzzing preparing for our upcoming release and we have seen a fair bit of new content added to StackStorm Exchange.

###### COMMUNITY

### STABLE

Changes to <a href="https://exchange.stackstorm.org" target="_blank">StackStorm Exchange</a> include:

**GitHub**

We are really excited about the new GitHub pack. It adds a Github repository sensor that emits triggers for new issues, issue comments, forks, or repository stars. In addition to the standard GitHub events there are also actions to gather GitHub traffic and clone statistics. This works fantastic in conjunction with the Librato pack mentioned below. For actions you can now add comments to an issue or pull request as well as status to a commit.

<!--more-->

**Slack**

StackStorm is a huge proponent of ChatOps, so you’ll frequently see us updating our various chat integrations. This past week the slack post_message action was updated to allow posting to any channel. We also added a Slack sensor that monitors Slack for activity and dispatches a trigger for each message which is posted to a channel.

**linux**

We have added pkill, wait\_for\_ssh, and dig actions. This is a particular area where we expect to see lots of contributions over the next few weeks &#8211; every sysadmin needs these kinds of actions and now some are even starting to contribute them 🙂

###### IN DEVELOPMENT INTEGRATIONS

Changes to our development integration repo: <a href="https://github.com/StackStorm/st2incubator" target="_blank">st2incubator</a>, include:

**Librato**

Data collection, for the win! Collecting metrics is a vital part of any automation. The Librato pack is a great way to start collecting some of these metrics as part of your automations. New actions include the ability to list, get, or delete metrics as well as submit counters or gauges.

**st2cd**

As you can probably guess, we use Stackstorm to build Stackstorm. Automation inception, if you will. Quite a bit of work has gone into the pack used for the internal StackStorm CI/CD pipeline. We now have full support for deploying to multiple environments as well as st2 integration testing. We also now support manipulating the StackStorm datastore via an action. Rules have also been added to conditionally chain the workflows together.

**CI/CD Canary Pipeline**

In addition to our own CI/CD pipeline we have also created a set of actions, rules and workflows that are more generic. This could apply to any number of applications. It uses the concept of a canary host to validate releases before pushing to production. A detailed blog post on this will follow but you can already find a lot of the code in the st2incubator repository.

###### PLATFORM

**Upcoming Release**

We have been hard at work on our upcoming 0.7.0 release which will be coming out quite soon. Please stay tuned for a separate blog post outlining all of the awesome features we have included there!

###### EVENTS

StackStorm has participated in a number of events over the past few weeks. Don’t worry if you missed them, you can check out the related videos below.

  * **January 8, 2015:** OpenStack Online Meetup: StackStorm & Moogsoft &#8211; Automated Remediation &#8211; Video coming soon!
  * **January 7, 2015:** <a href="https://www.youtube.com/watch?v=IhzxnY7FIvg" target="_blank">San Francisco DevOps Meetup: Everything ChatOps with StackStorm and Big Panda</a>
  * **December 11, 2014:** <a href="http://youtu.be/JY3ko5qgspc" target="_blank">Hangops Virtual Hangout &#8211; StackStorm vs. AWS Lambda</a>

If you haven’t already, we invite you to check out our product by <a href="http://docs.stackstorm.com/install/index.html" target="_blank">installing StackStorm</a> and following the <a href="http://docs.stackstorm.com/start.html" target="_blank">quick start</a> instructions — it will take less than 30 minutes to give you a taste of our automation. Share your thoughts and ideas via [stackstorm@googlegroups.com][1], <a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">#stackstorm on irc.freenode.net</a> or on Twitter <a href="https://twitter.com/Stack_Storm" target="_blank">@Stack_Storm</a>.

 [1]: https://groups.google.com/forum/#!forum/stackstorm