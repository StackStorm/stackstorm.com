---
title: Enhanced ChatOps From StackStorm
author: st2admin
type: post
date: 2015-06-08T23:58:47+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/06/08/enhanced-chatops-from-stackstorm/
dsq_thread_id:
  - 3832799630
categories:
  - Blog
  - Community
  - Home

---
**June 8, 2015**

_by James Fryman_

I am pleased to announce the availability of our new platform feature, ChatOps.

It&#8217;s true, yes. We have had ChatOps support for quite some time. However, a while back after receiving user feedback, we decided to give what we had built a good once over. To that end, ChatOps is dead. Long Live ChatOps! What we are releasing today is the result of these efforts.

## What Is ChatOps?

ChatOps is a new operational paradigm where work that is already happening in the background today is brought into a common chatroom. In doing so, you are unifying the communication about what work should get done with actual history of the work being done. Deploying code from chat, viewing graphs from a TSDB or logging tool, or creating new Jira tickets are all examples of tasks that can be done via ChatOps.

<!--more-->

Not only does ChatOps reduce the feedback loop of work output, it also empowers others to accomplish complex, self-service tasks that they otherwise would not be able to do. Combining ChatOps and StackStorm is an ideal combination, where from Chat users will be able to execute actions and workflows to accelerate the IT delivery pipeline. In the same way, the ChatOps/st2 combination also enhances user adoption of automation through transparency and consistent execution.

The end result is improved agility and enhanced trust between teams. What&#8217;s not to love about this? It&#8217;s the reason we as a company are devoted to including it as a core part of our product.

## Great, But Don&#8217;t We Have ChatOps Already?

We absolutely do! There are some fantastic projects out there that have ushered in this movement. Namely, the three major bots: Hubot, Lita, and Err. Each of these projects has several fantastic integrations with popular services and applications already. Our goal is not to replace these, but rather integrate.

What StackStorm brings to the table to enhance the current ChatOps experience:

  * Stable and scalable architecture. Go beyond cute kittens and get real work done.
  * History and Audit. Learn and understand _how_ people are consuming the automation via ChatOps. Enhance your understanding.
  * Workflow. Get real with workflow. Go beyond linear bash scripts and upgrade to parallel task execution.
  * BYOL. Each bot comes with it&#8217;s own requirement to learn their language. Forget that mess! Bring the tools that make you productive.

And coming soon:

  * Role Based Access Control. Fine grained controls on action execution in and out of ChatOps.
  * Analytics. Do something with that data you&#8217;re collecting. Become Smarter.

Our goal is to make ChatOps approachable by every team in every circumstance. This means an understanding of how teams of all sizes run, in many different types of verticals. Issues like compliance, security, reliability&#8230; these issues are on our mind when we think about what ChatOps means to us, and how, in turn, it provides real-world value to you.

To be specific, today we released the [`hubot-stackstorm`][1] plugin. This plugin allows a new or existing Hubot installation to natively interact with StackStorm via Hubot commands. We will be releasing other bot plugins in the upcoming weeks.

## How To Get Started

Ok, enough of that! I just wanna get started&#8230;

We have two ways for you to get started with StackStorm + ChatOps today. The first of which is via our `st2workroom` project. This project is designed to help you get started with StackStorm and ChatOps within minutes. If you have [Vagrant][2] and [VirtualBox][3], you can get started immediately:

    cd ~/
    git clone https://github.com/StackStorm/st2workroom
    cd st2workroom
    [Edit hieradata/workroom.yaml, see https://github.com/stackstorm/st2workroom#chatops]
    vagrant up st2express
    

This will provision and start up StackStorm + Hubot connected to your configured Chat Service. From there, you do any and all of the things we&#8217;ve shared with you today.

Want to learn more about the `st2workroom` project? Take a look at [the README][4] and a [blog post][5] on examples of how to use the workroom to do ChatOps and Workflow Development.

We also have instructions for setting up ChatOps with an existing StackStorm installation installed via `st2_deploy.sh`, our [Puppet Module][6], or our [Chef Module][7]. Take a look at the install instructions located at https://github.com/StackStorm/st2/blob/master/instructables/chatops.md. Pay special attention to the environment variables for Hubot and the packs needed to be installed in StackStorm

If you need any help, please don&#8217;t hesitate to reach out to us via [IRC][8] or [email][9]. We&#8217;ll be happy to help you out!

## Getting Started Is As Easy As&#8230;.

Once you&#8217;re all set up, and you have your bot set up, it&#8217;s time to set up your first ChatOps command. Let&#8217;s do the first one together. I&#8217;m going to start with something easy. How about a troubleshooting command. Let&#8217;s take a command from the Linux pack and enable it to be used in ChatOps. We&#8217;ll do it using ChatOps commands too!

### Step 1: Create New Alias Commands

Create a new pack! This is super easy. Just fork our [pack template repo][10] and get started. Once that&#8217;s done, create a new YAML in the `aliases` folder with a name, the StackStorm action you want to execute, and the ChatOps Aliases you want them exposed as.

<img loading="lazy" class="alignnone size-full wp-image-3541" src="http://stackstorm.com/wp/wp-content/uploads/2015/06/chatops_step_1.gif" alt="chatops_step_1" width="1299" height="710" /> 

### Step 2: Deploy Code To StackStorm Server

Once this is done, make sure the code is committed to your source code repository. Then, head back to your fresh new ChatOps and deploy your new pack to your server.

    !pack deploy st2-google repo_url=jfryman/st2-google
    

<img loading="lazy" class="alignnone size-full wp-image-3542" src="http://stackstorm.com/wp/wp-content/uploads/2015/06/chatops_step_2.gif" alt="chatops_step_2" width="1299" height="710" /> 

### Step 3: Use Your New Alias!

Reload StackStorm, and in a few moments, Hubot will update itself and have access to the new alias. The command is ready to run in ChatOps.

    !google stackstorm
    

<img loading="lazy" class="alignnone size-full wp-image-3543" src="http://stackstorm.com/wp/wp-content/uploads/2015/06/chatops_step_3.gif" alt="chatops_step_3" width="1299" height="710" /> 

That&#8217;s it. Really! One of the things we tried to do is to make this as easy as possible to get started. You&#8217;re busy &#8211; we get it. We want this tool to help provide you actual value, and that means ensuring it is easy to use and get started.

## Resources

We have a lot of resources that we&#8217;ve put together showing off StackStorm and ChatOps, and sharing our general philosophy in more depth about ChatOps and why we think it&#8217;s important. Take a look at any of these resources to learn more.

  * Demonstration: [See StackStorm + ChatOps in action][11]
  * Book: [ChatOps for Dummies, published by VictorOps][12]
  * Presentation: [Event Driven Automation &#8211; ChatOps][13]
  * [ChatOps on Reddit][14]
  * [ChatOps conversation on IRC][15]

## Bringing It Home

We firmly believe in the power of ChatOps as it pertains to so many facets of automation adoption and integration, and today&#8217;s feature release is our statement of commitment to these ideas. Over the coming days and weeks, we&#8217;ll be releasing additional articles showing off the power of ChatOps and how it can make your daily operations easier, less stressful, and dare I say&#8230; fun!

We also have several additional features and plans coming up as we gear up for our 1.0 release later this year, including Role Based Access Control and Analytics. Be sure to take a look at our [Roadmap][16] and stay subscribed to our [blog][17]

Of course, we at StackStorm absolutely love talking about ChatOps, Event Driven Automation, and Automation in general! If you find yourself wanting to ask questions or chat with us, you can always find us on IRC at [#stackstorm][8] where we hang out. There you can give us feedback, ask us questions about ChatOps, or just come and hang out and be merry! Likewise, follow us on Twitter at<a href="https://twitter.com/Stack_Storm" target="_blank">@Stack_Storm</a>, or get involved with the discussion with the hashtag <a href="https://twitter.com/hashtag/StackStorm?src=hash" target="_blank">#stackstorm</a>. You can also send us an email at <a href="mailto:support@stackstorm.com" target="_top">support@stackstorm.com</a>.

On a personal note: I am not bashful in sharing my joy for ChatOps and how it can transform how you get things done. We did our best to capture all that makes ChatOps wonderful in this release. My hope is that you find similar joy with the tools that we are building.

Until next time!

 [1]: https://www.npmjs.com/package/hubot-stackstorm
 [2]: https://www.vagrantup.com
 [3]: https://www.virtualbox.org
 [4]: https://github.com/StackStorm/st2workroom/blob/master/README.md
 [5]: http://stackstorm.com/2015/04/03/rapid-integration-development-with-stackstorm/
 [6]: https://forge.puppetlabs.com/stackstorm/st2
 [7]: https://supermarket.chef.io/cookbooks/stackstorm
 [8]: http://webchat.freenode.net/?channels=#stackstorm
 [9]: email:support@stackstorm.com
 [10]: https://github.com/stackstorm/st2-pack-template
 [11]: https://www.youtube.com/watch?v=fUpSaEOS_BA
 [12]: http://stackstorm.com/2015/04/23/stackstorm-and-chatops-for-dummies/
 [13]: https://www.youtube.com/watch?v=37LmuHToYjQ
 [14]: http://www.reddit.com/r/chatops
 [15]: http://webchat.freenode.net/?channels=##chatops
 [16]: http://docs.stackstorm.com/roadmap.html
 [17]: http://stackstorm.com/blog/