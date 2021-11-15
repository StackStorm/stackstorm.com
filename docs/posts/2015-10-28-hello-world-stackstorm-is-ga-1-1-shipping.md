---
title: Hello World – StackStorm is GA (1.1 shipping)
author: st2admin
type: post
date: 2015-10-28T21:02:54+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/10/28/hello-world-stackstorm-is-ga-1-1-shipping/
dsq_thread_id:
  - 4268885241
categories:
  - Blog
  - Community
  - Home

---
**October 28, 2015**  
_by Evan Powell_

<span style="font-weight: 400;">Time </span>_<span style="font-weight: 400;">flies</span>_<span style="font-weight: 400;">.</span>

<span style="font-weight: 400;">Over two years ago we got StackStorm going.  And today we announce the general availability of StackStorm, both the Enterprise Edition and the Community Edition.  </span>

<span style="font-weight: 400;">We have made StackStorm generally available because it is now ready, having proven itself at Netflix, WebEx and with thousands of other users.  Maybe more importantly, we are announcing general availability because </span>**we** <span style="font-weight: 400;">are ready, with commercial license subscriptions, 24&#215;7 support, and more.  </span>

<span style="font-weight: 400;">We’ve learned a lot over the last couple of years thanks to countless conversations with automators and operators and thanks to discussions amongst what I strongly believe is the best core technical team in the overall DevOps market.  All that learning shows up in StackStorm &#8211; a solution that is different than earlier automation in a number of ways:</span>

<li style="font-weight: 400;">
  <b>Event-driven automation:</b><span style="font-weight: 400;">  Let’s start with the fundamentals.  StackStorm is built from the ground up to wire together heterogeneous environments and to then allow you to take actions based on what is occurring.  Do that between two systems – with middling reliability and, well, </span><i><span style="font-weight: 400;">meh</span></i><span style="font-weight: 400;">.  The chewing gum scripts between your monitoring and your configuration management works well enough.  But tie together many systems reliably so that you can, for example, serve the world streaming video (thanks Netflix!) and that’s </span><b>hard</b><span style="font-weight: 400;"> to do.  StackStorm has helped create the event-driven automation category – learning from the likes of Facebook, LinkedIn and others.</span>
</li>

<li style="font-weight: 400;">
  <b>Rapid time to value:  </b><span style="font-weight: 400;">We did not want to fall into the trap of the old approaches to autonomic computing, including runbook automation, that could only deliver closed loop computing after months and months of bespoke integrations and coding.  We put a lot of work into making the authoring of integrations – and of course automations – simple.  And for Enterprise Edition users, that means making it as easy as drag and drop via Flow. Also, there are lots of integrations included with over 1500 total sensors and actions available in the StackStorm community.  Actually there are even more as you can snap in your Ansible, Chef, Puppet or Salt, and start leveraging all the actions you’ve got there.</span>
</li>

<!--more-->

<li style="font-weight: 400;">
  <b>The reliability and scalability that a control plane requires</b><span style="font-weight: 400;">:  We have a different background than many DevOps tools.  Yes, we have uber sys admins on our team &#8211; and they are invaluable.  And we have folks that have help build services like AWS.  However we add to that folks that have actually built and shipped product used by thousands of enterprises &#8211; including Dmitri who led engineering at one of the leaders of the old runbook automation space and who ran a big chunk of vSphere engineering as well.  We built StackStorm with a team and an architecture that enables it to scale horizontally and that leverages what is now widely recognized as the most powerful reliable open source workflow available.  Cool fast utilities that are hard to scale and nearly impossible to run reliably are great in support roles where building for scale could even be overkill.  For the maestro – for event driven automation &#8211; you need the kind of experienced team we’ve built to dedicate years of effort to get to where we are now – reliably running environments like parts of WebEx and Netflix.</span>
</li>

<li style="font-weight: 400;">
  <b>Workflow</b> <b>is the transmission</b><span style="font-weight: 400;">:  We anticipated a trend that is now widely acknowledged (again) – workflow is a useful component of solutions that tie together operational environments.  Over two years ago Dmitri, my co-founder, and Renat Akhmerov, a senior engineer at Mirantis met and kicked off a collaboration that is yet another example of the power of open source based development.  Mistral – the workflow they and fellow contributors designed and built – is now upstream as a core OpenStack project and is thriving with contributors from Alcatel, Huawei and many others.  StackStorm builds upon the highly reliable and flexible Mistral, making it easier to use thanks to the rest of StackStorm.  </span>
</li>

<li style="font-weight: 400;">
  <b>IFTTT for Ops:</b><span style="font-weight: 400;">  At some point in the last couple of years, a user called us &#8220;If this then that for Ops “– and the tag line stuck.  We even tweaked the open source GUI so the rules engine literally reads IF and THEN.  With StackStorm you use rules to interpret events your sensors have noticed; for example, you see that an application is throwing errors, and your rules see that and fire off a troubleshooting workflow to pinpoint why that may be, while updating the humans; based on the results of that workflow you may decide to run another that fixes or remediates the issue.</span>
</li>

<li style="font-weight: 400;">
  <b>ChatOps</b><span style="font-weight: 400;">:   We embrace ChatOps because for humans to accept powerful automation that automation must be </span><i><span style="font-weight: 400;">transparent</span></i><span style="font-weight: 400;">.  Today we believe we are the only product that truly productizes ChatOps.  In fact, if you want ChatOps – grab StackStorm and you’ll get it plus all the power of the underlying StackStorm platform.</span>
</li>

<li style="font-weight: 400;">
  <b>OpenSource:  </b><span style="font-weight: 400;">Enterprises and other operators are simply tired of being locked into control planes from either proprietary vendors or from the last hipster engineer who built it using some cool stuff.</span>
</li>

<li style="font-weight: 400;">
  <b>Power plus ease of use: </b><span style="font-weight: 400;">Our first users, like WebEx, grabbed StackStorm for its abilities to control and leverage their existing automation well before we ever developed and then open sourced our GUI.  Since that time we have built improved ease of use both via the GUI and the Flow automation authoring utility mentioned above.  If you have not checked out Flow &#8211; you really should &#8211; here is a GIF of this utility which allows you to visually compose workflows while keeping infrastructure as code.</span>
</li>

<img loading="lazy" class="wp-image-4616 size-full aligncenter" src="http://stackstorm.com/wp/wp-content/uploads/2015/10/remediation-cassandra.gif" alt="remediation cassandra" width="837" height="518" /> 

<li style="font-weight: 400;">
  <span style="font-weight: 400;">And there is more, much more, including features that are hard to appreciate until you start using StackStorm.  For example, with StackStorm the result of every action can be an event that itself can easily be used to trigger another action. And those actions can be workflows.  So the Lego analogy of building ever more powerful automations over time, by snapping them together, actually holds.</span>
</li>

<span style="font-weight: 400;">Well, those are at least some of the reasons that StackStorm has emerged as a leader of event-driven automation.  Take it out for a drive – with StackStorm 1.1 we are releasing an improved all in one installer that includes a GUI if you are so inclined and that will install either the Community Edition or the Enterprise Edition.     </span>

<span style="font-weight: 400;">Just go to </span><span style="font-weight: 400;"><a href="http://docs.stackstorm.com/install/all_in_one.html" target="_blank">http://docs.stackstorm.com/install/all_in_one.html</a>. </span><span style="font-weight: 400;">Please note that to grab Flow &#8211; and other Enterprise Edition capabilities &#8211; you&#8217;ll need to register on our front page and you&#8217;ll get an automated email with once again a link to this installer and, importantly, a license key to unlock those capabilities.  </span>

<span style="font-weight: 400;">Lastly – what’s next?  We will be accelerating our development now and next year will be releasing a piece of software that we believe changes the game for operations – again. Maybe more important than that big bang will be the day to day to day work to make </span>_<span style="font-weight: 400;">every user successful</span>_<span style="font-weight: 400;">.  Find us on our community, ask us questions, and help us incrementally improve StackStorm.</span>

<span style="font-weight: 400;">Finally – I’m now talking to dozens of users and would be partners or competitors, all of whom are struggling with build vs. partner decisions.   You have a tough decision to make, do you struggle on with your existing solution or do you “pull a Netflix” and bet on StackStorm.   At they put in </span><a href="https://vimeopro.com/user35188327/cassandra-summit-2015/video/140949186" target="_blank"><span style="font-weight: 400;">their talk at the Cassandra Summit</span></a><span style="font-weight: 400;">, with StackStorm you get both a vendor committed to your success and a community adding capabilities to StackStorm and removing the specter of vendor lock-in.</span>

<span style="font-weight: 400;">We hope you’ll join us. Together we are making the sort of transformative efficiencies and agility delivered by event driven automation like Facebook’s FBAR available for all of us.</span>

<span style="font-weight: 400;">PS – </span>_<span style="font-weight: 400;">a shout out to our friends at PagerDuty and VictorOps – how do you make getting paged at 2am suck less?  You make sure you don’t get paged in the first place!</span>_