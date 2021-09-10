---
title: 'Weekly Update: CI / CD Canary Pipeline'
author: st2admin
type: post
date: 2015-01-20T18:45:14+00:00
excerpt: '<a href="http://stackstorm.com/2015/01/20/weekly-update-continuous-integration-continuous-delivery-canary-pipeline/">READ MORE</a>'
url: /2015/01/20/weekly-update-continuous-integration-continuous-delivery-canary-pipeline/
dsq_thread_id:
  - 3438970973
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Blog
  - Community
  - Home

---
**January 20, 2015**

_by James Fryman_

We&#8217;re off with a bang this week, starting to roll out several new core platform features, and showing off how StackStorm can integrate into systems of all types.

###### SOLUTIONS

We love showing off our platform, and this week we&#8217;re releasing the Continuous Integration/Continuous Delivery Canary Pipeline. How about that for a title? We&#8217;ve just been lovingly calling it &#8216;the canary&#8217;. The aim of showing this is to demonstrate the flexibility of StackStorm as it integrates into many different tools and workflows. The code itself is pretty opinionated about how it works, but much of this code is built to be reusable, and we&#8217;re including all of the infrastructure components necessary to build and deploy the pipeline itself so you can take a look. We&#8217;re hoping it gets your imagination going, so please <a href="http://stackstorm.com/2015/01/20/continuous-integration-and-delivery-the-stackstorm-way/" target="_blank">check it out</a>, and let us know your thoughts.

<!--more-->

###### PLATFORM

This week, we&#8217;re <a href="http://stackstorm.com/2015/01/20/stackstorm-0-7-is-here/" target="_blank">pleased to announce the release of StackStorm v0.7.0</a>! Several notable features to mention with this release:

  * It is now possible to add metadata to Actions and Rule definitions. These can be used to classify and group together like actions in a workflow or to pass small bits of data around between workflows. We&#8217;re excited and interested to see how these will be used in the community.
  * Save State from Sensors: Sensors now have the ability to read and write to StackStorm&#8217;s internal Key/Value store. This allows users to write stateful sensors by storing session or index data. An example of this can be seen in our <a href="https://github.com/StackStorm-Exchange/stackstorm-twitter/" target="_blank">Twitter Integration Pack</a>.

Cannot forget to mention all the fun stability improvements this release. Grab the latest code from the backpacks of our panda friends* at <a href="http://stackstorm.com/start-now/" target="_blank">http://stackstorm.com/start-now/</a>.

###### INTEGRATION DEVELOPMENT

### Community

We are kicking off this week the beginning of a series of actions around Automated Troubleshooting. Over the next several weeks, additional actions specifically focused on gaining introspection into a system will be finding their way toward our repositories.

  * Server Lifecycle Workflows: This week has the introduction of many generic workflows that address a server node lifecycle. Create a server, give it additional resources, and send it to /dev/null&#8230; all with StackStorm. These resources help show how to adapt StackStorm to be used to manage fleets of servers across many clouds. Read more about how we do that at <a href="http://stackstorm.com/2015/01/14/managing-aws-instance-lifecycle-with-stackstorm/" target="_blank">http://stackstorm.com/2015/01/14/managing-aws-instance-lifecycle-with-stackstorm/</a>, and check out the code at <a href="https://exchange.stackstorm.org" target="_blank">StackStorm Exchange</a>
  * Generic Actions: A few generic Linux actions to aid in server management were added to the repositories this week. Take a look at those at <a href="https://github.com/StackStorm-Exchange/stackstorm-linux" target="_blank">https://github.com/StackStorm-Exchange/stackstorm-linux</a>

### Incubator

  * Voodoo Pack Generator: Hate having to write scaffolding? Us too! Our own Patrick Hoolboom has created up a nifty tool to automatically generate packs from Python modules. In addition, it can now generate empty pack scaffolding while developing new packs. Learn more about Voodoo at <a href="https://github.com/StackStorm/st2incubator/tree/master/etc/voodoo" target="_blank">https://github.com/StackStorm/st2incubator/tree/master/etc/voodoo</a>.
  * Mistral DSL Transformer: StackStorm and Mistral get even closer together this week. With the DSL transformer, users can now use native StackStorm actions within Mistral. No more messy \`st2.action\` calls, make your flows cleaner with this new pack.  Check that out at <a href="https://github.com/StackStorm/st2incubator/tree/master/packs/mistral" target="_blank">https://github.com/StackStorm/st2incubator/tree/master/packs/mistral</a>.

### Events

We mentioned these last week, but always worth repeating! We&#8217;ve been busy out and about over the last few weeks, and recorded some videos for you to enjoy in your favorite office chair or home recliner.

  * **January 8, 2015:** <a href="https://www.youtube.com/watch?v=uhUgd5PiDOU" target="_blank">OpenStack Online Meetup: StackStorm & Moogsoft – Automated Remediation</a>
  * **January 7, 2015: **<a href="https://www.youtube.com/watch?v=IhzxnY7FIvg" target="_blank">San Francisco DevOps Meetup: Everything ChatOps with StackStorm and Big Panda</a>
  * **December 11, 2014: **<a href="http://youtu.be/JY3ko5qgspc" target="_blank">Hangops Virtual Hangout – StackStorm vs. AWS Lambda</a>

In addition to all of the above, we are continuing to work with partners on integrations of StackStorm tailored to their specific use-cases, learning more about the power of our platform and ways we can continue to grow  it. If you haven’t already, we invite you to check out our product by [installing StackStorm][1] and following the [quick start][2] instructions — it will take less than 30 minutes to give you a taste of our automation. Share your thoughts and ideas via <a href="https://groups.google.com/forum/#!forum/stackstorm" target="_blank">stackstorm@googlegroups.com</a>, <a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">#stackstorm on irc.freenode.net</a> or on Twitter <a href="https://twitter.com/Stack_Storm" target="_blank">@Stack_Storm</a>, and stay updated on big news by <a href="http://stackstorm.com/subscribe-to-newsletter/" target="_blank">signing up for our newsletter</a>!

Until Next Time!

_* No animals were harmed during the release of this software_

 [1]: http://docs.stackstorm.com/install/index.html
 [2]: http://docs.stackstorm.com/start.html