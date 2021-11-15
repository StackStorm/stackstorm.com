---
title: StackStorm 0.6 Is Here!
author: st2admin
type: post
date: 2014-12-08T16:22:53+00:00
excerpt: '<a href="http://stackstorm.com/2014/12/08/stackstorm-0-6-is-here/">READ MORE</a>'
url: /2014/12/08/stackstorm-0-6-is-here/
dsq_thread_id:
  - 3310266460
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home

---
**December 8, 2014**

_by Dmitri Zimine_

It’s been one month and 5 days since we open sourced StackStorm during the OpenStack summit in Paris. Since then, our team has had our heads down developing the software, checking off the items on the roadmap, and applying learnings from the field and feedback from community users to our product.

I am happy to share that we’ve just released a new version of StackStorm &#8212; <a href="http://stackstorm.com/start-now/" target="_blank">v0.6.0</a>.

**What’s new?** 

**1. YAML for all content**

Moving to YAML for all content was the top ask from the community: many found dealing with JSON a bit cumbersome. Now all StackStorm content artifacts &#8212; rules, action and trigger definitions, and ActionChain workflows – are defined as YAML. JSON is supported for backward compatibility.

<!--more-->

**2. Sensor redesign**

Sensors (the inbound integration plugins that watch for external events) were substantially redesigned. On the surface, it is a more convenient interface. New base classes Sensor and PollingSensor makes sensors easier to author, as the platform does more of the plumbing. Trigger types fired by sensors are now defined using the same YAML syntax as action definitions.

Under the hood, the architecture has evolved. The sensor container and rule engine are now separate services, talking over the message queue. Sensors are run in isolation. The components may scale independently, and reliability is substantially improved.

**3.** **New dependency management for Python plugins**

The most exciting feature is the innovative dependency management for plugins – sensors and Python actions. In fact, we wrote a dedicated blog post about this feature, which you can view <a href="http://stackstorm.com/2014/12/09/stackstorm-v0-6-0-introducing-integration-pack-content-sandboxing-and-isolation/" target="_blank">here</a>. In a nutshell, StackStorm now automatically manages Python requirements for each plugin pack, and runs sensors and Python actions as separate processes, in dedicated virtual environments. No more “dependency hell” for pack writers! This is the first time we’ve seen this done in similar systems and are pretty excited about how it helps users deal with potentially hundreds of pieces of content such as rules, sensors and actions.

There are a few other changes, bug fixes, and improvements; see our [CHANGELOG][1] for details. The content of integrations and automations on the [community][2] repo is accelerating, too.

I am happy with the direction and fast pace of StackStorm’s development. Now we are  focused on releasing the WebUI (request early access [here][3]), improving workflow and pack management, and providing better operational supportability. We are excited to see more and more folks trying StackStorm and finding that it is the right tool for their automation needs.

Check it out – [install][4] StackStorm and follow the [quick start][5] instructions &#8212; it will take less than 30 minutes to give you a taste of automation. Share your thoughts and ideas via [stackstorm@googlegroups.com][6] or <a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">#stackstorm on irc.freenode.net</a> or on Twitter <a href="https://twitter.com/Stack_Storm" target="_blank">@Stack_Storm</a>.

 [1]: http://docs.stackstorm.com/changelog.html
 [2]: http://stackstorm.com/community
 [3]: mailto:support@stackstorm.com
 [4]: http://docs.stackstorm.com/install/index.html
 [5]: http://docs.stackstorm.com/start.html
 [6]: https://groups.google.com/forum/#!forum/stackstorm