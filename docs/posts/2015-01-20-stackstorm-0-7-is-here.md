---
title: StackStorm 0.7 Is Here!
author: st2admin
type: post
date: 2015-01-20T18:42:36+00:00
excerpt: '<a href="http://stackstorm.com/2015/01/20/stackstorm-0-7-is-here/">READ MORE</a>'
url: /2015/01/20/stackstorm-0-7-is-here/
dsq_thread_id:
  - 3438964100
categories:
  - Blog
  - Community
  - Home

---
**January 20, 2015**

_by Lakshmi Kannan_

With the new year comes a <a href="http://stackstorm.com/start-now/" target="_blank">new release</a>! Highlights of StackStorm v0.7 are below (you can read our v0.6 release notes <a href="http://stackstorm.com/2014/12/08/stackstorm-0-6-is-here/" target="_blank">here</a>).

###### CONTENT IMPROVEMENTS

### Sensors

Sensors can be long running. If sensors are written to poll external sources (for example, we blogged about our <a href="http://stackstorm.com/2014/12/22/monitor-twitter-and-fire-automations-based-on-twitter-keywords-using-stackstorm/" target="_blank">Twitter sensor</a>), it would be awesome to store state information in some place to de-dupe already processed events or even save markers (say, timestamps) to know what events have already been processed. Our &#8220;dogfooding&#8221; experience helped us take a user centric view and with that, we introduced a way for sensors to save state to key value store.

<!--more-->

### Rules

Rules in StackStorm are awesome. They allow you to work on incoming events intelligently. The intelligence comes from smarter criteria that users can apply on parameters in those incoming events. With 0.7, we added a bunch of new criteria operators viz. iequals, contains, icontains, ncontains, incontains, startswith, istartswith, endswith, iendswith etc. Note all of these operators are string operators. We hope to add more in future releases. We&#8217;d love your feedback in this area.

### Actions

Remote actions can be long running. Our users wanted a way to kill actions if they exceeded a certain time. All remote actions now can take a timeout parameter. The timeout can be provided at an individual action level. This provides users with more control on actions and how long they run. Of course, when timeout is breached, StackStorm kills the action and marks it as failed.

With the 0.7 release, we also have a shell runner for local actions. Previously, all local actions were executed via SSH. The reasoning was to avoid more code to maintain. However, this required setting up of SSH keys which is an user level overhead and an extra detail to grok. So we introduced a local shell runner which does not have the aforementioned overhead. The local runner also makes it easier to debug local actions.

###### PLATFORM CHANGES

### Key-Value Store

Key-value store in StackStorm allows you to save parameters that can be used in rules, actions or action chains. With 0.7, users can now set TTL (time-to-live) for individual keys.

### Authentication

We added a little more flexibility to our authentication story. In what we call &#8216;standalone&#8217; mode (to indicate that auth is not handled at apache layer), users can write custom auth backend modules that StackStorm can use. This allows for a more flexible auth model when deployments want to use existing identity providers like LDAP.

### Tags

With 0.7, we took our first stab at tagging content. Tags are key-value pairs that are essentially metadata on content. For now, tags are passive, i.e. we do not do anything interesting with them (yet), but it is only natural that we should. This is something to look out for in the future releases.

###### OPERATIONAL IMPROVEMENTS

### Debugging rules

We use our system a lot ourselves. We felt the pain when we had to debug rules. We introduced a rule tester that helps with debugging rules. This is super useful as a content author.

### Bug fixes and refactoring

Numerous bug fixes went into the release. Please see the <a href="https://github.com/StackStorm/st2/blob/master/CHANGELOG.rst" target="_blank">changelog</a> for a list of them. One of the major fixes is action validation. Actions registered using st2ctl reload are now validated against the schema for actions. This provides for a way to validate that the actions comply with StackStorm requirements.

We also promoted timers to be run as part of the rules engine. Now you can see logs of timer invocations and rules they invoked in st2 logs for rules engine. This is a major refactor in 0.7. We also refactored a lot of other code and added more tests, so contributing to StackStorm is easier and more fun. We look forward to more community involvement in design and development.

Some fun facts of 0.7 include:

  * StackStorm was used to automate the release process
  * We are on the verge of hitting 1000 pull requests in st2 github repo

<a href="http://stackstorm.com/start-now/" target="_blank">Download our 0.7 release today</a>, and let us know what you think! Share your thoughts and ideas via <a href="https://groups.google.com/forum/#!forum/stackstorm" target="_blank">stackstorm@googlegroups.com</a>, <a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">#stackstorm on irc.freenode.net</a> or on Twitter <a href="https://twitter.com/Stack_Storm" target="_blank">@Stack_Storm</a>, and stay updated on the latest news by <a href="http://stackstorm.com/subscribe-to-newsletter/" target="_blank">signing up for our newsletter</a>!  
&nbsp;