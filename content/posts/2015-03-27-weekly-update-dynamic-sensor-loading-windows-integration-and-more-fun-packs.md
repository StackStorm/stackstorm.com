---
title: 'Weekly Update: Dynamic Sensor Loading, Windows Integration And More Fun Packs'
author: st2admin
type: post
date: 2015-03-27T22:21:53+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/03/27/weekly-update-dynamic-sensor-loading-windows-integration-and-more-fun-packs/
dsq_thread_id:
  - 3632814050
tcb2_ready:
  - 1
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home

---
**March 27, 2015**

_by Lakshmi Kannan_

It’s been another exciting week here at StackStorm. Feedback is pouring in and we are all busy addressing it and cranking out new features. Thank you for your wonderful input and appreciation. Here is a recap of what we did this week:

###### StackStorm Platform

We&#8217;ve turned on authentication by default for package based deployments. In <a href="https://github.com/StackStorm/st2express" target="_blank">st2express</a>, we have a simple file based auth as proof of concept. It might be a good time to read about <a href="http://docs.stackstorm.com/install/deploy.html" target="_blank">setting up auth</a> in StackStorm. We also improved the sensor container to automatically load/unload/reload sensors on sensor model create/delete/update events. You can now simply write a sensor, register it with StackStorm and the sensor is picked up automatically. Perhaps it&#8217;s time for you to <a href="http://docs.stackstorm.com/sensors.html" target="_blank">hack a sensor</a> and contribute to our growing list of packs in our <a href="https://exchange.stackstorm.org" target="_blank">StackStorm Exchange</a> 😉 Look out for some of these features that will be rolled out as part of our 0.9 release. A lot of bug fixes and user improvements went into the master. Check out the <a href="https://github.com/StackStorm/st2/blob/master/CHANGELOG.rst" target="_blank">changelog</a> for more info.

<!--more-->

###### Community & Content

We&#8217;ve had some awesome packs submitted to our <a href="https://exchange.stackstorm.org" target="_blank">StackStorm Exchange</a>:

**Rabbitmq pack &#8211;** A rabbitmq sensor that listens for messages in queue and emits a trigger for each message is now available (thanks to <a href="https://github.com/itxaka" target="_blank">@itxaka</a>).

**Trello pack &#8211;** Our own <a href="https://github.com/jfryman" target="_blank">James Fryman</a>, an avid user of trello, has contributed a neat trello pack. He is super organized now.

**Windows pack &#8211;** A new Windows pack with an action which allows you to query remote Windows systems for information over <a href="https://msdn.microsoft.com/en-us/library/aa394582%28v=vs.85%29.aspx" target="_blank">WMI</a> has been added.

WMI is very powerful and allows you to query a remote systems using WQL (Windows Query Language; similar to SQL) for information such as currently running processes, uptime, memory usage and much more. Find more sample WQL queries you can run in the <a href="https://github.com/StackStorm-Exchange/stackstorm-windows#sample-queries" target="_blank">README</a>.

**Google pack &#8211;** <a href="https://github.com/Kami" target="_blank">Tomaz Muraus</a> contributed a nifty google pack which includes an action that allows you to perform Google searches.

For one you can use this action in a combination with a rule to tie Google search into your chat system (think about the good old days of IRC bots and &#8220;!google <keyword>&#8221; commands).

In addition to that, you could also leverage this action to implement a simple workflow which notifies you if a search engine ranking position for a particular website changes.

**Urban dict pack &#8211;** Yes, we do like puns. Some require lookup. We want you to have more fun. Thanks to Tomaz for the pack.

###### Past Events

On March 11 our CEO Evan Powell was a guest on a FLOSS weekly podcast where he talked about StackStorm, operations automation, DevOps and more. If you haven’t already, go ahead and listen to this episode: <a href="http://twit.tv/show/floss-weekly/328" target="_blank">FLOSS Weekly 328 &#8211; StackStorm</a>.

###### Upcoming Events

In an <a href="https://cc.readytalk.com/cc/s/registrations/new?cid=e5wf407ltp3m" target="_blank">online meetup</a> on April 2 Patrick Hoolboom will talk about how we built a StackStorm automation for our own continuous integration and deployment (dog fooding). [Sign up][1] to hear all about it!

Tomaz Muraus will be talking at DevOps days in Ljubljana on April 3. <a href="http://www.devopsdays.org/events/2015-ljubljana/registration/" target="_blank">Register</a> and you will get to know about <a href="http://www.devopsdays.org/events/2015-ljubljana/proposals/Event%20driven%20infrastructure%20automation%20with%20StackStorm/" target="_blank">event driven automation with StackStorm</a>. If you want to search for Ljubljana, we do have the <a href="https://github.com/StackStorm-Exchange/stackstorm-google" target="_blank">Google pack.</a>

Oh yes, we are going to be at <a href="https://us.pycon.org/" target="_blank">PyCon 2015</a> in Montreal. This is going to be very exciting with so many hackers! To all you project leaders and hackers that will be at Pycon:  We would love to help you build not just an integration but an entire pipeline or workflow leveraging StackStorm. If you put an integration to your project into the bucket of legos we call our contrib repo, it’ll be used more and in more useful ways. There will be a StackStorm sprint April 13-16.  Read more about us at PyCon including this sprint <a href="http://stackstorm.com/2015/02/02/join-stackstorm-pycon-2015/" target="_blank">here</a>.

Don&#8217;t forget to file your taxes! How I wish filing taxes could be automated! 😉

For more details and information about other events, please visit the <a href="http://stackstorm.com/events/" target="_blank">events page</a> on our website. If you haven’t already, we invite you to check out our product by <a href="http://docs.stackstorm.com/install/index.html" target="_blank">installing StackStorm</a> and following the <a href="http://docs.stackstorm.com/start.html" target="_blank">quick start instructions</a> — it will take less than 30 minutes to give you a taste of our automation.

Share your thoughts and ideas via <a href="https://groups.google.com/forum/#!forum/stackstorm" target="_blank">stackstorm@googlegroups.com</a>, <a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">#stackstorm on irc.freenode.net</a> or on Twitter <a href="https://twitter.com/stack_storm" target="_blank">@Stack_Storm</a>.

&nbsp;

 [1]: https://cc.readytalk.com/cc/s/registrations/new?cid=e5wf407ltp3m