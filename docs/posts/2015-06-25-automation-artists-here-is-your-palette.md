---
title: Automation Artists, Here Is Your Palette 🎨
author: st2admin
type: post
date: 2015-06-25T21:27:30+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/06/25/automation-artists-here-is-your-palette/
dsq_thread_id:
  - 3879745288
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home

---
**June 25, 2015**  
_by Evan Powell and Patrick Hoolboom_

These days StackStorm is used in so many ways by users big and small from CI/CD through to auto scaling and auto remediation that sometimes the most basic of use cases can get over-looked.

As folks like WebEx recently have explained, the first value they got out of StackStorm was pretty straight forward.

StackStorm enabled them to pull together all their existing automations &#8211; i.e. scripts &#8211; and to have them managed in one place.

As a user put it:

<p style="text-align: center;">
  <em> “now my scripts have an API! Now my scripts have a CLI and a GUI.” </em>
</p>

And with over 1500 integrations, whether those are north bound passive and active sensors, or south bound actions including full support for Salt, Ansible, Chef and Puppet, your own scripts can be augmented with a huge variety of additional colors.

Before you know it you’ll be painting a beautiful picture. “That’s it, just some nice clouds here now.”

<img loading="lazy" class=" size-medium wp-image-3718 aligncenter" src="http://stackstorm.com/wp/wp-content/uploads/2015/06/bob-ross-joy-of-painting-300x217.jpg" alt="bob-ross-joy-of-painting" width="300" height="217" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/06/bob-ross-joy-of-painting-300x217.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2015/06/bob-ross-joy-of-painting.jpg 479w" sizes="(max-width: 300px) 100vw, 300px" /> 

<!--more-->

You should be able to get StackStorm running for this initial use case in under 15 minutes. If not, we did something wrong. Get on our StackStorm-community Slack channel (get invite <a href="https://stackstorm.com/community-signup" target="_blank">here</a>) and be a squeaky wheel. Drop some emoji on us too.

Let’s get started.

**Step 1.** Download and install StackStorm. Pick your poison / elixir. The quickest way to get up and running is our rapid prototyping environment, <a href="https://github.com/stackstorm/st2workroom" target="_blank">st2workroom</a>, but we do support many other deployment methods. If you are a Chef or Puppet user you may want to grab the recipes that do the download and installation for you. Chef users can look <a href="https://supermarket.chef.io/cookbooks/stackstorm/versions/0.2.2" target="_blank">here</a>. And Puppet users can look <a href="https://forge.puppetlabs.com/stackstorm/st2" target="_blank">here</a>. We have other options including Docker and of course installing from the packages. Learn more <a href="http://docs.stackstorm.com/install/index.html" target="_blank">here</a>. Keep in mind that if you encounter any roadblocks, we and other community members are here to help on the community channel on Slack (again, get invite <a href="https://stackstorm.com/community-signup" target="_blank">here</a>)  or at #StackStorm on IRC freenode.

**Step 2.** To follow along and use the examples provided below, clone the st2-sample-scripts repo to a location on the StackStorm instance.  
``

<pre>mkdir /home/st2

cd /home/st2
git clone https://github.com/StackStorm/st2-sample-scripts.git
</pre>

**Step 3.** Write your first action metadata file! Don’t worry, this is quite easy. Let me start by showing you an example from one of the sample scripts.  
``

<pre>---
name: "hello_world"
runner_type: "run-local-script"
description: "hello_world"
enabled: true
entry_point: "/home/st2/st2-sample-scripts/scripts/hello_world.sh"
parameters:
  person:
  type: "string"
  position: 0
  required: true
</pre>

Save this file in: `/opt/stackstorm/packs/default/actions/hello_world.yaml` and that’s it! That is all the information StackStorm needs to register your action. The only thing you need to change in this example is the ‘entry_point’ to make sure it points to your script. We are using an example script from the st2-example-scripts repo, but this could apply to any script on the instance running StackStorm.

**Step 4.**   Now register your shiny new action in the system by running:  
``

<pre>st2ctl reload
</pre>

**Step 5.**   Let’s say hello to your action (formerly known as a script) via the web UI. Navigate to:  
``

<pre>http://REPLACEME:8080/#/actions
</pre>

NOTE: Remember to replace REPLACEME with your StackStorm instance’s IP address or hostname.

Since we put the action in the Default pack, you will want to navigate to the Default pack on the left of the GUI and expand it to see the actions. You should be able to find “hello_world”. Click on it. Notice that the details of this script are available on the right of the GUI where you can also execute the script if you’d like.

Enter a person’s name in the “Person” field on the right and go ahead and execute that action. now click the “Run” button (you may have to scroll down a bit to see it). You’ll then immediately see a new line appear under “Executions”. That is the run of your new action! Click the arrow on the left to expand it and you should see the message it printed it out! (“PERSON says, Hello World!).

**Step 6.**   Say hello to your script and possible actions via the CLI. In some cases the CLI is going to be the fastest way to work. Take a few minutes and drop into the CLI and do as follows to take a look at them.  Expert note &#8211; if authentication is turned on you will need to export your auth token before running st2 commands; take a look [here][1] to learn more about authentication and the use of the auth_token. With your username and password in hand, you can use this command:

<pre>export ST2_AUTH_TOKEN=`st2 auth USERNAME -p PASSWORD -t`
</pre>

Now run your action.  
``

<pre>st2 run default.hello_world person=REPLACEME -a
</pre>

Once again, put in a name of your choosing for REPLACEME. The output should be similar to what you saw in the web UI

**Step 7.**   You can set up syslog by following the steps here. If you have not set up syslog yet, you can find your execution in the actionrunner logs located in /var/log/st2/. Search through them for your action execution using grep:

<pre>grep ‘default.hello_world’ /var/log/st2/st2actionrunner*
</pre>

**Step 8.**   Hello world via the API. We provide a very hand mechanism for viewing the curl command for the different actions you would perform against the API by simply using the ‘&#8211;debug’ flag with the ‘st2’ CLI tool. To see what it would look like for the hello_world execution, run it like so:

<pre>st2 --debug run default.hello_world person=REPLACEME -a
</pre>

Each of the API requests the CLI makes to invoke the action, or retrieve the results of the execution are shown in the debug output as curl commands. The point here is to show that the actions you now have available within StackStorm are all readily accessible via an API, making them easy to tie into your other systems.

We will stop right there. In typically much less than 30 minutes, you have gotten going with StackStorm providing CLI, GUI, API, and logging for at least some of your most useful scripts.

Once you add your actions &#8211; and community actions in StackStorm &#8211; you can start to combine them with the help of rules and workflows into complete paintings. But that’s a topic for another day.

Please give us feedback on this and other blogs and on StackStorm itself. I hope this got you up and running on the most basic use case of all &#8211; using StackStorm to manage existing and community automations.

You can ping us on support@stackstorm.com as well as the Community Slack channel mentioned above; one last time, you can register [here][2]. Plus we do pay attention to our IRC channel #stackstorm on freenode as well.

 [1]: http://docs.stackstorm.com/start.html#authenticate
 [2]: https://stackstorm.com/community-signup