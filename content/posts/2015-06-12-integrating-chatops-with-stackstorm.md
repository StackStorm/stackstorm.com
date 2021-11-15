---
title: Integrating ChatOps With StackStorm
author: st2admin
type: post
date: 2015-06-12T17:00:50+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/06/12/integrating-chatops-with-stackstorm/
dsq_thread_id:
  - 3843461121
categories:
  - Blog
  - Community
  - Home
  - Tutorials
tags:
  - tutorial

---
**June 12, 2015**

_by James Fryman_

With our recent announcement of our ChatOps integration and of our commercial support for ChatOps and ChatOps related dev ops professional services, we thought it would be fun to take a moment and share our insights into the design decisions that we made while developing this feature. Several core platform changes were introduced, including Action-Aliases and Notifications, to enable ChatOps. So, grab some popcorn, get cozy, and we let’s dive in!

## Grand Overview

![stackstorm-chatops_1024][1] 

<!--more-->

They always say, a picture is worth a thousand words. In this flow, we want to show how the interaction works between the various subcomponents of our implementation of ChatOps on top of StackStorm. There are three main components:

  * A Robot Framework</p> 
  * An Action-Alias

  * A Notification

## The Robot

First, we begin with the robot. During our initial design of this feature, we debated back and forth several times on whether we would require a bot or not in order to enable ChatOps with our platform. On the pro-bot side, we found benefits like a large installation base, and users familiar with bot paradigms. Likewise, many chat platform integrations like Slack, IRC, Hipchat, Flowdock, and more, came for free with a bot framework. This also gives us an opportunity to contribute back to the community with additional chat adapters as we find uses for them.

For our first release, we have focused only on Hubot support. We have plans on our roadmap to add support for other popular bots (like Lita and Err), while currently we are learning what works and what does not work with Hubot.

### Action Aliases

So, what is an Action Alias, and why should I care? An Action Alias is simplified and human readable representation of actions in StackStorm which are useful in text based interfaces like ChatOps.

As you know if you know much about StackStorm, these actions can be just about _anything_.  Actions include:

  * Your scripts, ingested easily.
  * The thousands of actions already in the StackStorm community (simple Linux commands, almost all AWS, Azure, and Libcloud commands, and much more).
  * Workflows &#8211; that combine many actions together into an entire pipeline.
  * Salt, Ansible, Puppet and Chef driven actions, where StackStorm is integrated with those tools as well.

With the action Alias we intend to make yet more human readable our command structure &#8211; so a StackStorm powered ChatOps is friendlier to the humans.  Plus &#8211; the Alias’ are themselves easy to maintain as they are a simple mapping.

The code for an Action Alias looks like:

<pre><code class="YAML">name: "google_query"
action_ref: "google.get_search_results"
formats:
  - "google {{query}} and return {{count}} results"
</code></pre>

The `formats` section contains string literals which can be used in text based interfaces to invoke actions. StackStorm will match a command string with known formats and translate that into an Action Execution. This simplification reduces the barrier to entry for users and makes it possible to build out ChatOps with StackStorm as the execution arm. Thus a command literal like `!google StackStorm and return 5 results` becomes something that can be typed into a chat client and have an action execute in StackStorm.

We believe that ChatOps will be the primary consumer Action Alias. However, the general approach lends nicely to any text based interface like SMS, messaging, email&#8230; &#8211; so many possibilities. StackStorm is purpose built to reduce sources of friction in DevOps adoption and Action Alias is yet another primitive designed with that goal in mind.

## Notifications

But, once an Action is executed, how does it get back to the chat client? Why, via Notifications!

Using StackStorm in our own event driven automation environment we noticed a recurring pattern of requiring to notify on the completion of an execution. For a while we hacked around that by injecting notify tasks in all our workflows, but eventually it got quite repetitive and we built notifications to make it simpler.  Our approach to notification allows StackStorm users to configure when, what and where to notify when an action or workflow execute.

The overarching idea is that any place in the StackStorm system that generates an Action Execution a user should be able to specify where and what to notify on completion of a notification.

<pre><code class="YAML">notify:
  on_complete: 
    message: "Action completed"
    data: {}
    channels:
      - "email"
  on_failure:
    message: "Oh no! Action has failed."
    data: {}
    channels:
      - "slack"
      - "email"
      - "bugtracker"
  on_success:
    message: "on_success"
    data: {}
    channels:
      - "slack"
      - "email"
</code></pre>

The above snippet of code shows what the typical notification looks like. Channels are StackStorm-wide endpoints like specific chat client, email etc. Channels are managed independently via appropriate rules offering useful control points and flexibility.

## Tying It All Together

Now that you understand the new Robot Framework, our concept of Action-Alias and the Notification Engine, the interoperation of the different layers should start to become clear.

At startup, Hubot will download a list of all setup Action Aliases. These become commands that can be executed within Chat.  Anytime a command is executed, an ActionExecution is automatically sent to StackStorm already automatically tagged with the appropriate NotificationChannel. These are seamless configurations. While you can explicitly consume the underlying Action Alias and Notification Subsystems, most of the wiring is taken care of for you automatically.

Our goal is to create tools that help you get things done in a fun and frictionless way. Of course, we at StackStorm absolutely love talking about ChatOps, Event Driven Automation, and Automation in general! If you find yourself wanting to ask questions or chat with us, you can always find us on IRC at <a href="http://webchat.freenode.net/?channels=#stackstorm" target="_blank">#stackstorm</a> where we hang out &#8211; and we are about to launch a public Slack channel so keep an eye out for that too. There you can give us feedback, ask us questions about ChatOps, or just come and hang out and be merry! Likewise, follow us on Twitter at <a href="https://twitter.com/Stack_Storm" target="_blank">@Stack_Storm</a>, or get involved with the discussion with the hashtag #ChatOps or #stackstorm. You can also send us an email at <a href="mailto:support@stackstorm.com" target="_blank">support@stackstorm.com</a>, and join our <a href="https://groups.google.com/forum/#!forum/stackstorm" target="_blank">Google Group</a>.

Last but not least &#8211; we are going to be at various meet-ups coming up in the crowd and/or speaking, including the <a href="http://www.meetup.com/Auto-Remediation-and-Event-Driven-Automation/" target="_blank">Event Driven Automation meet-up</a> one of our founders helps organize and the upcoming <a href="http://www.meetup.com/ChatOps-San-Francisco/events/222570655/" target="_blank">SF ChatOps</a> meet up too.

Until next time!

 [1]: https://cloud.githubusercontent.com/assets/20028/8009363/f481fdc2-0b6d-11e5-9660-dc9f56c3a016.png