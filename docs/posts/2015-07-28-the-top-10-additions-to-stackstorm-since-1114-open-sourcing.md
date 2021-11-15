---
title: The Top 10 Additions To StackStorm Since 11/14 Open Sourcing
author: st2admin
type: post
date: 2015-07-28T17:54:10+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/07/28/the-top-10-additions-to-stackstorm-since-1114-open-sourcing/
dsq_thread_id:
  - 3981183852
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Blog
  - Community
  - Home

---
**July 28th, 2015**  
_by Evan Powell_

I’m extremely proud of the pace and quality of development ongoing here at StackStorm and in the broader community.

Lets take a look at a couple of metrics that imperfectly capture the vitality of the project and the amount of development being done. If you look at the graph below you can see that the number of commits per month is quite similar to Docker and Ansible. The source for this graph is [OpenHub.Net][1]

<img loading="lazy" class="aligncenter size-full wp-image-3882" src="http://stackstorm.com/wp/wp-content/uploads/2015/07/Commits-7-28.jpg" alt="Commits 7 28" width="541" height="447" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/07/Commits-7-28.jpg 541w, https://stackstorm.com/wp/wp-content/uploads/2015/07/Commits-7-28-300x248.jpg 300w" sizes="(max-width: 541px) 100vw, 541px" /> 

<!--more-->

Another view of overall project vitality is the lines of code . Take a look:

<img loading="lazy" class="aligncenter size-full wp-image-3883" src="http://stackstorm.com/wp/wp-content/uploads/2015/07/Lines-of-code.jpg" alt="Lines of code" width="541" height="450" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/07/Lines-of-code.jpg 541w, https://stackstorm.com/wp/wp-content/uploads/2015/07/Lines-of-code-300x250.jpg 300w" sizes="(max-width: 541px) 100vw, 541px" /> 

(Incidentally, have we reached peak Docker?! &#8211; :))

And &#8211; what’s more &#8211; the most recent release, <a href="http://stackstorm.com/2015/07/22/stackstorm-0-12-is-released/" target="_blank">StackStorm version 0.12</a> &#8211; shows that the community is stepping up to help as well with commitments to core capabilities including managing actions (thanks Netflix), plugging in other workflow engines (thanks HP), and improving our ability to integrate with and control windows machines (thanks again <a href="https://github.com/jamiees2" target="_blank">James Sigurðarson</a>).

Meanwhile our core workflow engine, Mistral &#8211; which is upstream in OpenStack &#8211; is itself gathering more contributors.  We make Mistral much easier to use and more useful by tying it into the overall StackStorm platform to deliver event driven automation.

All of this progress caused me to want to take a step back and parse this progress a bit.  Yes, we see much more code and contributions hitting the <a href="https://github.com/StackStorm/st2-community" target="_blank">StackStorm community</a>.  But &#8211; so what?

Just as I recently reviewed the <a href="http://stackstorm.com/2015/07/21/the-most-popular-recent-how-to-blogs-on-stackstorm-com/" target="_blank">top 10 how to blogs </a>in terms of traffic over the last several months I thought it worth reviewing the top 10 features and capabilities added in the last several months as well.

What’s changed?  What is inside that line up and to the right?  And what do you think?

With that in mind, let’s take a look at those top 10 improvements, some of which will be obvious and others of which you may want to click through to better understand.

### 1.  GUI

<p style="padding-left: 30px;">
  As many of you know, we open sourced without having a GUI.  In 0.8 we launched the GUI with some key capabilities explained <a href="http://stackstorm.com/2015/03/03/stackstorm-0-8-introducing-new-web-ui/" target="_blank">here</a>.  And more is on the way, see the roadmap below.
</p>

### 2.  Native ChatOps support:  ChatOps simplified and improved

<p style="padding-left: 30px;">
  StackStorm introduced the concept of <a href="http://docs.stackstorm.com/aliases.html" target="_blank">Aliasing</a> for ChatOps and much else, including ChatOps (and other) notifications <a href="http://stackstorm.com/2015/06/08/enhanced-chatops-from-stackstorm/" target="_blank">with the 0.11 release</a>.  We are seeing tremendous uptake here as it turns out that without a StackStorm-like event-driven automation solution under your ChatOps you quickly run into the N squared issue of many to many to many integrations plus you are faced with how to parse commands into human readable form, which our Aliasing capabilities addresses.
</p>

### 3.  Visual design of rules

<p style="padding-left: 30px;">
  We added visual design of rules in 0.9.  While this is a GUI feature I thought it worth emphasizing.  Once again, more on the way.
</p>

### 4.  Rules should be part of a pack and other content management improvements

<p style="padding-left: 30px;">
  Continuing on the same theme, we want rules not just to be easier to author, we wanted managing this content to be easier as well.  We are continuing to simplify the management of content including in large scale out systems.  This one simply added Rules to our <a href="http://docs.stackstorm.com/reference/packs.html" target="_blank">Pack definition</a>.
</p>

### 5.  Windows support

<p style="padding-left: 30px;">
  Windows support is a big endeavor and we made huge strides in the last few months.  0.9 added a new windows-cmd and windows-script runners for executing commands and PowerShell scripts on Windows hosts.  Example Windows integrations available <a href="https://github.com/StackStorm-Exchange/stackstorm-windows#sample-queries" target="_blank">here</a>.
</p>

### 6.  Variety of CLI improvements

<p style="padding-left: 30px;">
  Examples include support for filtering by timestamp and status in executions list as well as adding “showall”. And many more.  Keep the ideas coming please!  Take a look at the CLI 101 <a href="http://docs.stackstorm.com/reference/cli.html" target="_blank">here</a>.
</p>

### 7.  Pluggable authentication

<p style="padding-left: 30px;">
  In v.012 we added support for pluggable authentication and more.  You can learn more including some <a href="http://docs.stackstorm.com/authentication.html" target="_blank">clear diagrams here</a>.
</p>

### 8.  No dependency hell for integration packs

<p style="padding-left: 30px;">
  One challenge we have seen older run book automation systems as well as home made event-driven automation systems is how to deal with lower level dependencies so that, for example, multiple flavors of Python and other based actions can be integrated into a single remediation.  We have done a lot under the covers to solve this problem and to make the implementation of actions and sensors much easier.  You can read about this technology <a href="http://stackstorm.com/2014/12/09/stackstorm-v0-6-0-introducing-integration-pack-content-sandboxing-and-isolation/" target="_blank">here</a>.
</p>

### 9.  Salt, Ansible, Chef and Puppet

<p style="padding-left: 30px;">
  StackStorm integration with Chef, Puppet, Salt and Ansible have all improved recently.  These integrations typically include both integrating with StackStorm &#8211; deploying StackStorm with Chef and Puppet for example &#8211;  as well as ingesting actions from platforms such as Ansible and Salt directly into StackStorm.  One great example of this is a <a href="http://stackstorm.com/2015/06/24/ansible-chatops-get-started-%F0%9F%9A%80/" target="_blank">recently enhanced Ansible integration</a> &#8211; focused particularly on ChatOps &#8211; contributed to the community.
</p>

### 10.  Docker deployment and more options

<p style="padding-left: 30px;">
  We continue to of course drive Docker environments.  This is not about that, this is about deploying StackStorm on top of Docker in a 12 factor way.  We are are also about to launch a support AWS AMI for StackStorm deployments as well.
</p>

So you know I’m incredibly proud of the progress of the StackStorm code base.  We are really cranking.  And I think the above is a decent summary of recent progress.  However &#8211; what do you think?  What would you like have seen?

Care to help order or add to our <a href="http://docs.stackstorm.com/roadmap.html" target="_blank">roadmap</a>?  Please do dive in and let us know what you’d like to see.  We now have many tens of thousands of downloads and yet we only hear from, well, many of you but not as many as we’d like.  If you are part of the silent majority, tell us on Slack (register <a href="https://stackstorm.com/community-signup" target="_blank">here</a> for public channel) or even <a href="https://twitter.com/stack_storm" target="_blank">@Stack_Storm</a> how we are doing and what you’d like us and the community to work on next!

 [1]: https://www.openhub.net/p/compare?project_0=docker&project_1=StackStorm&project_2=Ansible&submit_2=Go