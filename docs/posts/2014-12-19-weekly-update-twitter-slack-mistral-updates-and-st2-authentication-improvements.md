---
title: 'Weekly Update: Twitter, Slack, Mistral, And St2 Authentication Improvements'
author: st2admin
type: post
date: 2014-12-19T21:44:25+00:00
excerpt: '<a href="http://stackstorm.com/2014/12/19/weekly-update-twitter-slack-mistral-updates-and-st2-authentication-improvements/">READ MORE</a>'
url: /2014/12/19/weekly-update-twitter-slack-mistral-updates-and-st2-authentication-improvements/
dsq_thread_id:
  - 3341295955
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Blog
  - Community
  - Home

---
**December 19, 2014**

_by Patrick Hoolboom_

As promised, the weekly StackStorm update! The team has been hard at work on platform improvements, getting the web interface squared away as we worked towards releasing it, as well as cleaning up some loose ends in the community repo and adding new integrations.

We are seeing some more feedback and even contributions &#8211; thank you for those, and please keep them coming!

This blog will be on hiatus next week unless Santa delivers an amazing new integration I’m not expecting.

<!--more-->

###### COMMUNITY

### STABLE

Changes to our main community repo, <a href="https://exchange.stackstorm.org/" target="_blank">StackStorm Exchange</a>, include:

**Twitter**  
A new Twitter integration pack was introduced that includes a sensor for fetching tweets that match certain keywords. Ever wanted to trigger your automations with tweets? Well this is the pack for you. Also included is a sample rule for posting these tweets directly to Slack.

**Slack**  
The initial Slack integration pack gives an action to post messages to Slack channel. We use Slack quite heavily at StackStorm so we are excited to start leveraging this integration.

**libcloud**  
Improved support for exoscale was added to the libcloud pack. Special thanks to <a href="https://twitter.com/sebgoa" target="_blank">@sebgoa</a> for contributing these additions &#8212; and for some excellent ongoing feedback and direction.

**Bug Fixes:**

  * JIRA sensor registration

### IN DEVELOPMENT INTEGRATIONS

Changes to our development integration repo: <a href="https://github.com/StackStorm/st2incubator" target="_blank">st2incubator</a>, include:

**freight**  
Updates have been made to the freight pack to support adding multiple packages with a single action call and making the cache update action more concise.

**st2cd**

We have begun to release the internal build and delivery tools used by StackStorm to build StackStorm (automation inception). The initial pack includes actions for testing and packaging StackStorm as well as workflows to replicate the build pipeline on AWS. There will be a detailed blog coming in the next week or so that outlines how StackStorm solves this use case for us.

**AWS**  
Additional output filters have been added to the AWS pack. Output is now cleaner for the following:

  * Instance Objects
  * Volume Objects
  * Reservation Objects

###### PLATFORM

### UPCOMING RELEASE

**Webhook Visibility**  
It’s now easy to see all registered webhooks by making an API call. GET /v1/webhooks/.

**MISTRAL**  
A new version of the OpenStack related workflow engine Mistral was released today: 2015.1.0b1

Many updated features include but are not limited to ‘join’ and ‘pause-resume’. For more details please see <a href="https://pypi.python.org/pypi/mistral/2015.1.0b1" target="_blank">https://pypi.python.org/pypi/mistral/2015.1.0b1</a>: Mistral is part of the st2 distribution and is installed when you get StackStorm.

If you haven’t already, we invite you to check out our product by [install][1]ing StackStorm and following the <a href="http://docs.stackstorm.com/start.html" target="_blank">quick start</a> instructions — it will take less than 30 minutes to give you a taste of our automation. Share your thoughts and ideas via [stackstorm@googlegroups.com][2],<a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">#stackstorm on irc.freenode.net</a> or on Twitter <a href="https://twitter.com/Stack_Storm" target="_blank">@Stack_Storm</a>.

 [1]: http://docs.stackstorm.com/install/index.html
 [2]: https://groups.google.com/forum/#!forum/stackstorm