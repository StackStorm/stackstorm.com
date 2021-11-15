---
title: 'Weekly Update: Platform Improvements And New Functionality, New Chef Pack, PyCon And More'
author: st2admin
type: post
date: 2015-02-07T05:10:13+00:00
excerpt: '<a href="http://stackstorm.com/?p=2482">READ MORE</a>'
url: /2015/02/06/weekly-update-platform-improvements-new-functionality-new-chef-pack-pycon/
dsq_thread_id:
  - 3492301384
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Blog
  - Community

---
**February 6, 2015**

_by Tomaz Muraus_

Another busy week is behind us. Follow along this post to see what we have been up to.

###### COMMUNITY AND CONTENT

**JMX Pack**

Java <a href="https://github.com/StackStorm-Exchange/stackstorm-jmx" target="_blank">JMX pack</a> now includes a new **invoke_method** action. This action allows you to invoke arbitrary MBean method that is exposed over a JMX interface.

<!--more-->

Many popular Java applications, such as Cassandra, Hadoop, Tomcat, Solr and others, expose a lot of the management and operational functionality over JMX (e.g. see a <a href="http://wiki.apache.org/cassandra/JmxInterface" target="_blank">list of operations exposed</a> by Cassandra) that makes this action very powerful.

To give you some idea, if you are a Cassandra user, you can now combine other packs and triggers together with this one and automatically:

  * <a href="http://wiki.apache.org/cassandra/JmxInterface#org.apache.cassandra.service.StorageService.Operations.clearSnapshot" target="_blank&quot;">Clear old snapshot</a> when disk is becoming full.
  * <a href="http://wiki.apache.org/cassandra/JmxInterface#org.apache.cassandra.service.StorageService.Operations.forceTableCompaction" target="_blank">Force a major compaction</a> if data for a particular key range is being read from an excessive number of stables.
  * And much more &#8211; combining other events and packs together gives you almost unlimited flexibility.

**Chef Pack**  
New <a href="https://github.com/StackStorm-Exchange/stackstorm-chef" target="_blank">chef pack</a> has been merged into master. This pack includes actions which allow you to install chef-client on a remote node, perform a chef-client run on a remote node and perform a chef-solo run on a remote node.

**Rackspace Pack**  
<a href="https://github.com/StackStorm-Exchange/stackstorm-rackspace" target="_blank">Rackspace pack</a> includes new actions and functionality, such as the ability to assign metadata to a node, ability to retrieve nodes which contain particular metadata, find node by id and more.

**IRC Pack**

IRC sensor inside an <a href="https://github.com/StackStorm-Exchange/stackstorm-irc" target="_blank">IRC pack</a> now also emits a trigger when a user joins and parts a channel.

###### PLATFORM (_Sneak Peak Into Master_)

The platform has received many new features, improvements and bug-fixes. Below you can find a couple of highlights.

**Ability to specify environment variables which are accessible to the actions**

User can now specify environment variables which are accessible to the actions executed by all the runners (local, remote and Python). Environment variables can be specified using **env** runner attribute, of if you are using the CLI you can use **st2 action run &#8211;inherit-env** flag which will cause CLI to automatically inherit and include all the variables which are accessible to the CLI user.

See <a href="https://github.com/StackStorm/st2/pull/1033" target="_blank">#1033</a> and <a href="https://github.com/StackStorm/st2/pull/1036" target="_blank">#1036</a> for more details.

**Ability to override SSH connection information on per action basis**

When executing remote actions on the servers, StackStorm by default tries to authenticate with the username and private key which is specified in the config.

Now this can be overridden on per action basis &#8211; you can specify which username, password or private key to use to authenticate when running remote actions.

See <a href="https://github.com/StackStorm/st2/pull/1036" target="_blank">#1036</a> for more details.

**Unified result format for Mistral workflow and action-chain actions**

The result returned by the mistral workflow and action chain actions now follows the same unified format. This makes it easier to display workflow results with resulting to branching depending on the runner.

###### EVENTS

**SCALE 13x**

Between February 19th to 22nd, we are attending <a href="http://www.socallinuxexpo.org/scale/13x" target="_blank">Scale</a> in Los Angeles, California, where stormer James will give a talk titled <a href="http://www.socallinuxexpo.org/scale/13x/presentations/devops-day-2-people-and-process" target="_blank">“Lessons Learned in the DevOps Journey”</a>. In addition to James’ talk, we will also have a booth (#76) in the exhibit hall, so please stop by and say hi.

**DevOps Day Ljubljana 2015**

We are happy to announce that we are sponsoring <a href="http://www.devopsdays.org/events/2015-ljubljana/" target="_blank">DevOps Day Ljubljana</a>, which will take place between the 3rd and 4th of April in Ljubljana, Slovenia.

If you are in the area, you are very welcome to join us (Tomaz will be present at the event).

**PyCon NA 2015**

Between April 10th and 16th Evan, Patrick and Tomaz will be attending <a href="https://us.pycon.org/2015/" target="_blank">PyCon NA</a>, the largest annual gathering of Python users and developers in Montreal, Canada.

You are welcome to visit us in the exhibit hall at booth #607, or stop by at our development sprint that will take place after the main part of the conference.

For more information about PyCon and sprint details, please visit our blog post titled <a href="http://stackstorm.com/2015/02/02/join-stackstorm-pycon-2015/" target="_blank">Join StackStorm At PyCon 2015</a>.

For more details and information about other events, please visit the <a href="http://stackstorm.com/events/" target="_blank">events page</a> on our website.

###### Other

  * <a href="http://docs.stackstorm.com/latest/webhooks.html" target="_blank">New documentation section</a> for webhooks.
  * <a href="http://docs.stackstorm.com/latest/cli.html" target="_blank">New documentation section</a> which explains common gotchas and how to use CLI more effectively.
  * <a href="https://github.com/StackStorm/st2express/tree/master/docker" target="_blank">Docker setup</a> includes some fixes and improvements.

If you haven’t already, we invite you to check out our product by <a href="http://docs.stackstorm.com/install/index.html" target="_blank">installing StackStorm</a> and following the <a href="http://docs.stackstorm.com/start.html" target="_blank">quick start</a> instructions — it will take less than 30 minutes to give you a taste of our automation. Share your thoughts and ideas via [stackstorm@googlegroups.com][1], <a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">#stackstorm on irc.freenode.net</a> or on Twitter <a href="https://twitter.com/Stack_Storm" target="_blank">@Stack_Storm</a>.

 [1]: https://groups.google.com/forum/#!forum/stackstorm