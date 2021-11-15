---
title: Chatops Pitfalls and Tips
author: Dmitri Zimine
type: post
date: 2015-12-11T02:05:47+00:00
url: /2015/12/10/chatops_pitfalls_and_tips/
dsq_thread_id:
  - 4401120251
tcb2_ready:
  - 1
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
tags:
  - chatops

---
**December 11, 2015**  
_by Dmitri Zimine_

You are starting with ChatOps.

You have already watched [Jesse Newland][1], [Mark Imbriaco][2] and our own [James Fryman][3] and [Evan Powell][4] preaching it. You&#8217;ve read the [links on reddit][5], and skimmed ChatOps blogs from [PagerDuty][6] and [VictorOps][7]. You&#8217;ve studied [ChatOps for Dummies][8]&#8230;

Congratulation and welcome to the journey, ChatOps is awesome way to run development and operations. I&#8217;ll spare repeating why ChatOps is good &#8211; you&#8217;ve eager to get going. I&#8217;d rather focus on few common pitfalls and misconceptions that can get you off the track.

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/12/chatops-pile.png" alt="chatops-pile" width="391" height="334" class="aligncenter size-full wp-image-5044" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/12/chatops-pile.png 391w, https://stackstorm.com/wp/wp-content/uploads/2015/12/chatops-pile-300x256.png 300w" sizes="(max-width: 391px) 100vw, 391px" /> 

<!--more-->

### TL;DR

This is a loooooong blog posts&#8230; so here are topics, jump right in if you&#8217;d like:

  * [**Coffee? JS? Ruby? Python? A Fallacy of False Choice**][9] &#8211; the right answer is &#8220;any&#8221;, I tip my hand
  * [**Bot or Not**][10] &#8211; you DO need a bot, but not for the reason you think you do
  * [**Best Chat for Chatops, or Is Slack eating everything?**][11] &#8211; even if it does, what to do about it?
  * [**It&#8217;s a duplex, dummy**][12] &#8211; how to make a bot act like a human with two-way integration
  * [**Towards a smarter bot**][13] &#8211; wouldn&#8217;t it be cool if&#8230; 
  * [**Chatops, StackStorm way**][14] &#8211; just a short pitch at the end 🙂

# <a name="1_coffee"></a>Coffee? JS? Ruby? Python? A Fallacy of False Choice.

One of the first things you learn about ChatOps is &#8220;Bots&#8221;. There are bots, quite a few of them. Hubot Lita, and Err are the often cited as the most popular, but there are many more. They are important, and you (tend to believe) need to think carefully about selecting your bot, because this choice defines the programming language you&#8217;ll use for ChatOps and other aspects of your implementation.

> &#8220;Your preference on programming languages may determine which bot you ultimately choose.&#8221;  
> _Jason Hand, ChatOps for Dummies_ 

There is a problem, though: this line of thinking leads to a naive implementation of ChatOps which I have seen far too often. Teams often select a bot based on a preferred language to write ChatOps commands. They then go ando implement these actions as Bot plugins. To add another command &#8211; add another CoffeeScripts (or JS, or Ruby, or Python, etc)&#8230; **Warning: This is the Wrong Way.**

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/12/wrong_way-300x225.jpg" alt="wrong_way" width="200" height="150" class="aligncenter size-medium wp-image-5049" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/12/wrong_way-300x225.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2015/12/wrong_way.jpg 400w" sizes="(max-width: 200px) 100vw, 200px" /> 

Let me detail it on a concrete example: provision a VM on cloud. When ChatOps-ed, it would look something like this:

          > user: ! help create vm 
          < bot: create vm {hostname} on { provider: aws | rackspace } 
          > user: ! create vm web001 on aws
          < bot: on it, your execution id 5636fac02aa8856cc3f102ec 
          ... < some chatter here > ...
          < bot: hey @user your vm is ready: 
                 web001 (i-f99b4320) https://us-west-2...
    

What is under the hood? The VM creation is likely 4-7 steps calling low-level scripts (create VM, wait for `ssh` to come up, add to DNS, etc). Times N, where N is a number of providers and the steps may differ slightly. Just for one command. Do you want to place this stuff all under the Bot? And make the bot your &#8220;automation server&#8221;, your control plane? Which leads you to deal with security, availability, logging and other aspects that Lita, Hubot, Err, don’t bring out of box. Or do you consider putting these scripts somewhere else and write a coffee-script to make it ChatOpsy with the help and human-talk-like syntax? Which leads to two smoking piles of scripts, a maintenance nightmare to keep all that smoke in sync?

Don&#8217;t fall into the fallacy of false choice here. The right choice is: &#8220;base Chatops on the Automation Library, expose actions to scripts with no extra code&#8221;.

The Automation Library is a core Operational Pattern that states that the operations against the infrastructure comprise an automation library that can be written in any language and versioned, reviewed, and available to ops and developers with fine-grain access control on who can run what and where. This automation library becomes your control plane. As such, it must be secure, reliable and highly available not only from ChatOps but from API, CLI, and hopefully GUI.

If you do use an Automation Library, you can then expose actions easily to chatops. A good solution will provide chat friendly syntax, help, and other goodies with no need for extra code on the Bot side. Bots are a part of the ChatOps solution, but they are like wheels, not the whole car, thus their choice is an internal implementation detail.

We have learned that those who are doing ChatOps right, do it this way. Take GitHub: they have a library of automation scripts, some of which are exposed to Hubot, with no extra Coffee on Hubot side ([this part of their Chatops solution][15] is not open sourced yet). Or take the devops folks from Oscar Insurance who presented [their impressive ChatOps solution][16] on [Atlassian Summit][17]. Or take WebEx Spark (StackStorm user!) &#8211; they [have spoken][18] about how they use Spark for ChatOps with StackStorm underneath as automation library and more.



<table>
  <tr>
    <td style="background: #02b2e3;color: #fff;font-size: 40px;width: 120px;">
      Tip:
    </td>
    
    <td>
      <strong>Build your automation library first. Than expose some actions to Chatops. Stay in control what actions you expose and what you keep.</strong>
    </td></table> 
    
    <h1>
      <a name="2_bot"></a>Bot or Not
    </h1>
    
    <p>
      What about the other extreme? For example, take the off-the-shelf integrations from services like Slack or HipChat&#8230; are you now doing ChatOps? Are 88 plugins by Slack not enough to do what I want? What about 112 HipChat integrations?
    </p>
    
    <p>
      No, it won’t be enough.
    </p>
    
    <p>
      Yes, there are great integrations and it is practical to leverage them here and there. Our team is on Slack, where we happily use Travis-CI, re:amaze, a bunch of configured email integrations. We absolutely love to <code>/hangout</code> when we need to talk.
    </p>
    
    <p>
      But when it comes to a full ChatOps solution, you&#8217;ll quickly find that the exact integration you need are either: 1) not there 2) not doing what you need or 3) not doing it the way I want it.
    </p>
    
    <ul>
      <li>
        Not there: NewRelic and Nagios happen to be in Slack, but Sensu, Logstash and Splunk integrations are not.
      </li>
      <li>
        Not doing what you need: It&#8217;s fine that Slack&#8217;s Jira integration posts issues and updates. But what I really want is to create JIRA issue from my chat. It is not possible today. Even a <a href="https://blog.hipchat.com/2015/04/22/assign-discuss-done-a-revamped-hipchat-jira-integration/">revamped HipChat Jira integration</a>&#8221; is not doing it &#8211; you may think they would, coming from the same company?
      </li>
    </ul>
    
    <p>
      And what can YOU do about it? Complain? File a feature request? Hack up a slash command one-off? I move that you stay in control of your integrations, on what tools are being integrated, and how exactly they are integrated. Some of the integrations, incidentally, will be custom scripts against proprietary endpoints. Supporting it natively is a stretch for Slack, HipChat, or any chat service. A bot gives you that level of control, and integrates smoothly with the Chat services.
    </p>
    
    <blockquote>
      <p>
        &#8220;Some could argue that a chatbot isn’t absolutely essential to begin your journey into ChatOps. All chat clients >outlined in Chapter 2 offer a wide range of third‐party integrations that can allow users to begin querying >information and interacting with services without the help of a bot. It wasn’t until teams began building more >complicated scripts that chatbots became an important piece of ChatOps. Nowadays, to take full advantage of >ChatOps, you really need a chatbot to execute commands that are specific to your own organization’s infrastructure >and environment.&#8221;<br /> <br /> <em>Jason Hand, &#8220;ChatOps for Dummies&#8221;</em>
      </p>
    </blockquote>
    
    <table>
      <tr>
        <td style="background:#02b2e3;color:#fff;font-size:40px;width:120px;">
          Tip:
        </td>
        
        <td>
          <strong>Don&#8217;t limit yourself to what&#8217;s out of box in your Chat platform. Own your ChatOps commands. Use a bot to expose your automation library to a chat platform.</strong>
        </td></table> 
        
        <p>
          Slack&#8217;s <a href="https://api.slack.com/slash-commands">slash commands</a> and <a href="https://api.slack.com/incoming-webhooks">incoming webhooks</a> give a solid foundation for a custom Chatops solution, to the extent you are fine with exposing a [part of] your control plane over public REST endpoint. It by far beats a “naive approach”. And doesn’t require a bot. So, should you lock in with Slack? That brings me to my next point.
        </p>
        
        <h1>
          <a name="3_slack"></a>Best Chat for Chatops, or Is Slack eating everything?
        </h1>
        
        <p>
          While on the topics of Chat platforms and services: how do you choose one? Which one should you choose and why? Should you look for a more &#8220;ChatOps friendly&#8221; chat if you&#8217;re already using an established service? What about when you hear the claim that &#8220;the XXX Chat is a true ChatOps platform&#8221;, do you believe it?
        </p>
        
        <p>
          The truth is ChatOps works with ANY chat platform, with any chat client. So the choice of a chat platform is entirely your team&#8217;s choice.
        </p>
        
        <p>
          While Slack is a favorite of today with an incredible 1.7M users, history teaches us that favorites change. It was HipChat and Flowdock two years ago, Campfire 4 years, and IRC remains steady at ~300,000 users, a timeless favorite for many hardcore ops. New chat platforms grow like mushrooms after the rain, including opensource &#8220;Slack alternatives&#8221;: <a href="http://www.mattermost.org/">Mattermost</a> <a href="https://github.com/kandanapp/kandan">kandan</a> <a href="https://zulip.org/">Zulip</a> -these are only a few that have come up on my radar recently.
        </p>
        
        <p>
          Think of a chat. Pick any. Got one? Good, now, here&#8217;s a secret: there are a few teams that WILL NOT BE USING IT, for reasons beyond our reasonings or control. &#8220;Must be on prem&#8221; policy. A lead Architect hates non-OSS software. A team is writing their own chat. Someone took this [anti-slack debate](Debates https://news.ycombinator.com/item?id=10486541) too close to one&#8217;s heart. Any of 1,000 other reasons.
        </p>
        
        <p>
          There will always be different chats out there to choose from. It&#8217;s a choice that your team should make, or likely have already made, based on the merits of the Chat itself. Chatops can live on any platform, and when it’s frictionless, and makes people’s job easier, they won’t care if it’s graphical, text, or what-so-ever. The right ChatOps solution will support the chat of your choice. It will take advantage of a given chat platform, like leverage HipChat or Slack syntax formatting, while gracefully degrading to text for IRC. That&#8217;s where bots come in place: they provide an interface for a variety of chat platforms, giving a layer of abstraction and customization. That, not a programming language for commands, is the basis to pick a bot for your DIY chatops. That is how we leverage bots in StackStorm.
        </p>
        
        <p>
        </p>
        
        <table>
          <tr>
            <td style="background: #02b2e3;color: #fff;font-size: 40px;width: 120px;">
              Tip:
            </td>
            
            <td>
              <strong>Stay in control of what chat platform to use. It&#8217;s the choice of your team. Turn away from solutions forcing their own chat on you. Use a bot, to make your ChatOps solution support a chat client you team loves today or will love tomorrow.</strong>
            </td></table> 
            
            <h1>
              <a name="4_duplex"></a>It&#8217;s a duplex, dummy
            </h1>
            
            <p>
              How do you like a team member who only responds to requests, never says a thing or cracks a joke? Same applies to your ChatOps Bot. Just firing up the commands from the chat is not good enough; it goes in both directions: when something happens with your infrastructure, the bot should notify the chat room. With the proper two-way integrations your ChatOps will rock like GitHub&#8217;s. Here is a fictional example based on watching GitHub Ops team in their devops lair in Nashville (<a href="https://youtu.be/NST3u-GjjFw?t=16m38s">glimpse here</a>):
            </p>
            
            <pre><code>      &gt; bot: twitter says "we are down"
      &lt; user: @bot shut up twitter
      &gt; bot: twitter silenced for 15 min, get busy fixing stuff fast!
      &gt; bot: Nagios alert on web301: CRITICAL, high CPU over 95%
      &lt; user: @bot nagios ack web301 
      &lt; user: @bot graph me io,net on web301
      &gt; bot: @user Here's your graph: https://mygraph.example.net/web301?show=io,net
      &gt; other_user: looks like it's just high load. Let's add couple of nodes!
      &lt; user: @bot autoscale add 2 nodes to cluster-3
      &gt; bot: @user On it, your execution is 5636fac02aa8856cc3f102ec 
             check the progress at https://st2.example.net/history/5636fac02aa8856cc3f102ec
</code></pre>
            
            <p>
              In this short dialog, a bot acts as a two-way relay between the infra and the chat. It reports events and responses to user&#8217;s commands. Under the hood, a solution wires in various sources of events, like Nagios, NewRelic, or Twitter (true, GitHub users Twitter as a monitoring tool), and relays them to chat by some rules. A <code>shut up twitter</code> may disable a rule for a period of time; a <code>nagios ack</code> may call Nagios to silence an alert. Other commands call actions which do as little as forming and posting a URL, or as much as launching a full-blown mutli-step auto-scaling workflow.
            </p>
            
            <pre><code>      StackStorm chatops two-way implementionation:

             Infra ---&gt; st2 Sensors ---&gt; st2 Rules ----------&gt; Chat
             Infra &lt;--- st2 Actions &lt;--- st2 API   &lt;-- Bot &lt;-- Chat

</code></pre>
            
            <p>
              Again, don&#8217;t trap yourself in believing that out-of-box integrations from Slack, HipChat, or &#8220;the Next Big Chat&#8221;, will be enough. Not just vendor lock-in, not just lack of code to control/update/edit settings. Think about your behind-firewall logstash and graphite, or posting collectd charts when Sensu events fire. Think Your toolbox will always be ahead of the mainstream. Design for that, and stay in control of your integrations with your infra and tools.
            </p>
            
            <p>
              There is another trap when it comes to incoming integrations: it&#8217;s too easy to have it spread out all over your tool set. It&#8217;s tempting to post alarm <a href="https://github.com/sensu/sensu-community-plugins/blob/master/handlers/notification/slack.rb">straight from Sensu handler to Slack</a>. To use the stock &#8220;Splunk &#8211; New Relic&#8221; integration. To add &#8220;post to HipChat&#8221; block to the end of your provisioning script. At the beginning it looks fine. <strong>Warning: Wrong Way.</strong>
            </p>
            
            <p>
              <img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/12/wrong_way-300x225.jpg" alt="wrong_way" width="200" height="150" class="aligncenter size-medium wp-image-5049" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/12/wrong_way-300x225.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2015/12/wrong_way.jpg 400w" sizes="(max-width: 200px) 100vw, 200px" />
            </p>
            
            <p>
              This approach gets messy very fast. As fast as <code>n*(n-1)</code>, where <code>n</code> is how many tools used by your team. And NO, it&#8217;s <strong>not</strong> <code>n*(n-1)/2</code>, as integrations are two way. For each integrated, you need both incoming and outgoing integration. Triggers and actions. Sensu sends alert (incoming, trigger) and Sensu silence alert (outgoing, action). Jira update ticket (action) and Jira on ticket update (trigger). Once you beyond two or three tools, it quickly spirals into unmanageable, unmaintainable spaghetti. Where is all my automation? How do I turn it off?
            </p>
            
            <p>
              Just like a consolidated, shared library of actions, you need a shared, consolidated library of &#8220;rules&#8221;, defining what gets posted to chat on which events and how. And just like a library of actions, these rules better be readable, scriptable code under version control, with API, CLI and other goodies. <em>If this reads like a shameless plug for StackStorm, it is because our team believes in this so much that we made it we&#8217;ve made it the center of our design.</em>
            </p>
            
            <p>
              Tip: Design ChatOps for two-way communications. Build a consolidated control plane for the event handlers to provide visibility and control of what events are posted to the chat.
            </p>
            
            <h1>
              <a name="5_future"></a> Towards a smarter bot
            </h1>
            
            <p>
              This came up off the recent conversation with folks implementing Chatops with StackStorm. We begin to brainstorm how to make Bot act more like a human. One idea that came up is &#8220;carrying the context of a conversation&#8221;. That means that bot asks a question and I can just answer &#8220;@bot yes&#8221;, and just like a human, the bot will be smart enough to know what I am saying &#8220;yes&#8221; to. Or may be careful enough to ask clarification questions:
            </p>
            
            <pre><code>     &gt; bot: @dzimine you mean "yes" to "should I restart web301 ? If so, say "pink martini"
     &gt; dzimine: @bot pink martini
     &gt; bot: ok @dzimine, on it, your execution is 5636fac02aa8856cc3f102ec
...
</code></pre>
            
            <p>
              Another example of a smarter bot is providing two-factor command authorization, when two people should +1 an action. This comes handy on when launching some mission-critical automations. Surely it requires some workflow capabilities on the script side, but it can be done.
            </p>
            
            <p>
              More brainstorming on smarter bot is happening on our chat, at stackstorm-community.slack.com. Please join and bring up your thoughts and ideas.
            </p>
            
            <h1>
              <a name="3_stackstorm"></a>Chatops, StackStorm way
            </h1>
            
            <p>
              Time for a good StackStorm plug: we deliver an Automation Library, with turn-key ChatOps solution out of the box. We have taken these lessons, and more, and turned them into code. With StackStorm&#8217;s ChatOps, you choose your chat, implement actions in the language of your choice, and use <a href="https://exchange.stackstorm.org">community integrations</a> with dozens of devops and infra tools. StackStorm guides you to the &#8220;right way&#8221;: start with automation library, then turn any action to chatops commands just by giving it an alias; 2) consolidate event routing with sensors, than route any event to ChatOps just by adding a rule.
            </p>
            
            <p>
              We think of ChatOps as not a sidekick, but an integral part of your control plane. Invest upfront, profit over time. With StackStorm, you progress from simple commands like “create Jira ticket” or “deploy VM” to more powerful ones, by combining them into workflows of many actions underneath and turning these workflow actions into chatops commands. For how it works, check out a <a href="http://www.cybera.ca/news-and-events/tech-radar/stackstorm-workflows-and-chatops/">journey towards Chatops from Cybera</a>.
            </p>
            
            <p>
              This week we released <a href="https://stackstorm.com/2015/12/08/stackstrom-1-2-release-announcement/">StackStorm 1.2</a>; Chatops is a highlight of the release, with so many new things and improvements that that the blog describing them is called <a href="https://stackstorm.com/2015/12/08/stackstorm-1-2-0-the-new-chatops/">“The New Chatops”</a>. Please check it out, <a href="https://stackstorm.com/#try-now">give StackStorm’s Chatops solution a try</a>, <a href="https://stackstorm.com/community/#comm-engage">send us feedback</a>, and Happy ChatOpsing!
            </p>

 [1]: http://www.youtube.com/watch?v=NST3u-GjjFw
 [2]: https://www.youtube.com/watch?v=pCVvYCjvoZI
 [3]: https://www.youtube.com/watch?v=37LmuHToYjQ
 [4]: http://www.slideshare.net/EvanPowell/some-chat-ops-what
 [5]: https://reddit.com/r/chatops
 [6]: https://www.pagerduty.com/blog/what-is-chatops
 [7]: https://victorops.com/blog/getting-started-chatops-step-step-guide/
 [8]: https://victorops.com/chatops-for-dummies/
 [9]: #1_coffee
 [10]: #2_bot
 [11]: #3_slack
 [12]: #4_duplex
 [13]: #5_future
 [14]: #6_stackstorm
 [15]: https://youtu.be/NST3u-GjjFw?t=27m30s
 [16]: https://youtu.be/zwWDQyKQDQs?t=16m00s
 [17]: https://de.atlassian.com/company/about/events/summit/2015/videos/enhance/chatops-automating/
 [18]: http://www.meetup.com/Auto-Remediation-and-Event-Driven-Automation/events/223793392/