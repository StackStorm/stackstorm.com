---
title: Ensuring Network Configuration Consistency with StackStorm + NAPALM
author: st2admin
type: post
date: 2017-04-11T18:35:04+00:00
url: /2017/04/11/ensuring-network-configuration-consistency-stackstorm-napalm/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5716999352
categories:
  - Blog
  - News

---
**Apr 11, 2017**  
_by Matt Oswalt_

If you’ve been paying attention to the news around new StackStorm integrations, you may have noticed the [NAPALM pack][1] was created a few weeks ago. For those unfamiliar with [NAPALM][2], it’s a Python library that provides a **multi-vendor** abstraction layer for interacting with network devices like routers and switches (for those not working in the network industry, you can think of NAPALM as &#8220;libcloud&#8221; for your network).  This is really useful for doing network automation, because it means you only need to write a script (or a StackStorm action) once, targeting this library, and it’s immediately usable against the 10+ network vendors supported by NAPALM (a list that is growing all the time).

<!--more-->

<p dir="ltr">
  This provided a great opportunity for us to bring event-driven automation into the network space in a big way. We started developing a pack for this, and the community really ran with it. Community member <a href="https://github.com/robwwd">Rob Woodward</a> responded to our initial pull request with a bunch of new actions and workflows that covered a huge portion of the functionality in the NAPALM library. This was merged a few weeks ago, and while we’re still considering the pack to be in the “beta” stages for now, this made a huge step towards mature multi-vendor network automation with StackStorm. Thanks, Rob!
</p>

<p dir="ltr">
  The presence of this pack means the worlds of multi-vendor network automation and event-driven automation are finally coming together. NAPALM already provides a lot of great features on its own, such as vendor-agnostic retrieval of operational data (like routing and neighbor tables), as well as pushing configuration changes to network devices. What&#8217;s really exciting about linking this up with the event-driven automation of StackStorm is that we can now trigger these activities in response to interesting events elsewhere, such as in your network monitoring system.
</p>

<p dir="ltr">
  Check out the pack’s <a href="https://github.com/StackStorm-Exchange/stackstorm-napalm/blob/master/README.md">README</a> for a full summary, but I’ll spoil a few of the goodies that are currently included in this pack:
</p>

<li dir="ltr">
  Rules to automatically react to common network events, like a topology change, or a configuration update
</li>
<li dir="ltr">
  Actions for retrieving network state, like ARP, BGP, and IPv6 neighbor tables, as well as actions for making changes, like running one-off commands, or installing full or partial configurations
</li>

<p dir="ltr">
  Also, we&#8217;re not just talking about a handful of actions; right now the NAPALM pack supports just about everything that is exposed by the NAPALM library itself!
</p>

<p dir="ltr">
  <a href="https://stackstorm.com/wp/wp-content/uploads/2017/04/napalm_actions.png"><img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/04/napalm_actions.png" alt="" width="1055" height="705" class="size-full wp-image-6746 aligncenter" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/04/napalm_actions.png 1055w, https://stackstorm.com/wp/wp-content/uploads/2017/04/napalm_actions-150x100.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/04/napalm_actions-300x200.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/04/napalm_actions-768x513.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/04/napalm_actions-1024x684.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2017/04/napalm_actions-80x53.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/04/napalm_actions-220x147.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/04/napalm_actions-224x150.png 224w, https://stackstorm.com/wp/wp-content/uploads/2017/04/napalm_actions-356x238.png 356w, https://stackstorm.com/wp/wp-content/uploads/2017/04/napalm_actions-621x415.png 621w, https://stackstorm.com/wp/wp-content/uploads/2017/04/napalm_actions-729x487.png 729w, https://stackstorm.com/wp/wp-content/uploads/2017/04/napalm_actions-890x595.png 890w" sizes="(max-width: 1055px) 100vw, 1055px" /></a>
</p>

<p dir="ltr">
  Again, all of these features are inherently multi-vendor because of the NAPALM library. If you want to use the “get_lldp_neighbors” action to retrieve LLDP neighbors on a Juniper firewall, and use the retrieved info to create a BGP configuration and push to a Cisco router using the “loadconfig” action, that’s now possible!
</p>

<h3 dir="ltr">
  Checking Configuration Consistency
</h3>

<p dir="ltr">
  Ever since the very first version of the pack was published, we’ve been thinking of ways to add to the pack, specifically focusing on problems that network engineers have to solve every day, in an effort to make their lives easier. One important challenge in any network, especially when starting to automate, is the task of ensuring the network is configured the way you think it is.
</p>

<p dir="ltr">
  To that end, we recently added an action to the NAPALM pack called “check_consistency”. This action will connect to the network device you specified, using the NAPALM library, and retrieve its configuration. Then it will compare it to a “golden configuration” that you’ve stored in a Git repository, and let you know if there are any deviations.
</p>

<p dir="ltr">
  Oh, and it’s chatops-enabled, so you can do all this from the comfort of Slack or HipChat! Check out the video below for a quick walkthrough of this specific feature:
</p>

<div style="text-align: center;">
</div>

<p dir="ltr">
  This is just one example of what you can do with the NAPALM pack. We&#8217;ll be producing all kinds of interesting network automation demos with this and related functionality, all aimed at improving the operational capabilities of the network engineer.
</p>

<p dir="ltr">
  We’re not finished &#8211; this pack is going to get a lot of love in the near future, so if you have any interest in network automation, put it through its paces and let us know what you think! For those that are either already sold on NAPALM, or are already using it, but haven&#8217;t gotten into StackStorm yet, check out our <a href="https://docs.stackstorm.com/overview.html">StackStorm Overview</a> to become familiar with the concepts and get started! If you want to know more about NAPALM, check out the <a href="https://github.com/napalm-automation/napalm">project&#8217;s Github page</a>.
</p>

<p dir="ltr">
  Happy automating!
</p>

 [1]: https://github.com/StackStorm-exchange/stackstorm-napalm
 [2]: https://github.com/napalm-automation/napalm