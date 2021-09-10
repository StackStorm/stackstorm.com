---
title: StackStorm And “ChatOps For Dummies”
author: st2admin
type: post
date: 2015-04-23T16:24:13+00:00
excerpt: '<a href="http://stackstorm.com/2015/04/23/stackstorm-and-chatops-for-dummies/">READ MORE</a>'
url: /2015/04/23/stackstorm-and-chatops-for-dummies/
dsq_thread_id:
  - 3706503948
categories:
  - Blog
  - Community
  - Home

---
**April 23, 2015**

_by Evan Powell_

Our own James Fryman has written the foreword to a new book from VictorOps, titled _<a href="https://victorops.com/chatops-for-dummies/" target="_blank">ChatOps for Dummies</a>_. The book is described as “a high-level guide to understanding the origins of the practice, the benefits and tools needed to get started, and important examples and tips to remember as you begin to explore ChatOps for your team.”

What&#8217;s the connection between ChatOps and StackStorm, and why should you care? StackStorm is used as the automation platform underlying ChatOps implementations at companies as diverse as Rackspace and various large SaaS operators and financials.

These users benefit from StackStorm running underneath the actual bot delivering the integration to chat &#8211; typically HuBot. Instead of having the chat client or the underlying bot as yet another integration to be wired together NxN across the environment, StackStorm users simply plug ChatOps into StackStorm and they have immediate access to the several hundred integrations already available in the StackStorm community.

Via ChatOps, all of the systems into which StackStorm ties can be accessed &#8211; and can be automated. Also help, audit, redundancy and manageability are built into StackStorm, which further reduces the maintenance burden. Plus, users can actually &#8220;see&#8221; the execution of long running tasks, greatly simplifying troubleshooting.  
<!--more-->

In addition, the nature of ChatOps is to capture incrementally more automation requirements as chat is used. The ChatOps team looks at the chat and notices, &#8220;hmm, we tend to do this set of tasks a lot….&#8221; and the next step is to try to automate those tasks as well. Without StackStorm this would require dropping into coffee script if you are using HuBot and writing the required integration and any conditional logic and timing and help and so forth required. With StackStorm you likely already have the integration. You just need to combine that lego into an automation using the visual authoring of our rules engine and our workflow options, which are encoded in simple to read YAML. In short, not only can you maintain your environment much more easily &#8211; you can also extend your automations much, much faster.

While StackStorm is already used to support ChatOps, we have some additional ChatOps related features that will soon be released. If you&#8217;d like to try these features and give us feedback, please drop us a line at <support@stackstorm.com>, or <a style="color: #2ea3f2;" href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">find us on IRC on freenode at #stackstorm</a>.

So with that in mind, please enjoy the foreword from James:

###### FOREWORD

The concept of a bot sitting in a chat room is as old as I can remember. Old bots would pipe up and say funny things or maybe go and retrieve the weather if you asked them the right way. Over time, I began seeing fellow engineers start to push the bounds of how these bots were being used by slowly introducing more and more complex tasks. All of these followed a few simple rules: Keep the scripts small and focused and compose complex tasks out of small actions.

Eventually, I had the privilege of winding up in my professional career at GitHub, where the term ChatOps originated. This team had taken the concept to a whole new level, and began using its own internal bot (affectionately known as Hubot) to do everything from retrieve funny cat photos online to manage a fleet of SQL servers, and everything else in‐between. The moment that I saw and began working with ChatOps as they did, it quickly became apparent that there would be no other way I could work again. This was it.

ChatOps introduces a new concept of knowledge sharing and collection that is different than in days past. Today, we attempt to take pieces of information and stick them into pools where users can search and find them. This works great as long as individuals take effort to update documentation. The only problem with this is that in many cases, documentation is the last thing to be updated — if it is even updated at all. We still see that institutional knowledge is a concern that inhibits company scaling.

Instead, ChatOps leverages the human behavior that has been both consistent and inherit to our nature over the centuries — talking to each other. We naturally transmit knowledge to each other in conversational form, and in part of a larger context. ChatOps helps by creating the necessary hooks that allow users to talk to a bot as if to any other colleague. One that can go and get you data, do tasks for you, and more. All the while remembering every bit of it, and never being too upset you’ve asked for help about the same thing a dozen times.

I always have two favorite stories about folks using ChatOps to make both their own and their employers’ day‐to‐day easier (and dare I say, fun) that I love to share. The first is my colleague James White. One of his former employers had him interacting with the company customer support representative group often. These CSRs would come and ask him for the status of printers that his company sold and serviced &#8220;Were the machines online? Did they have enough stock?&#8221; and so on.

Over the next day or so, James took and implemented ChatOps around this simple task and began letting his bot provide the answer to the questions. In turn, he was able to reduce his own interruptions, allowing him to focus on his own deliverables while also enabling the CSRs to get the information they needed.

The second example is with my colleague Mark Imbriaco. On his way to a conference in 2014 to give a talk also on the power of ChatOps, his phone alerted him while he was in the taxi to the airport that the GitHub infrastructure was under attack by a DDoS. Instead of doing the traditional on‐call scramble, tearing out a laptop, calling folks up to respond, he calmly pulled out his phone, opened up the main chatroom, asked the bot to effectively “raise shields.” Within two minutes, the bot had opened a tracking issue, called up and notified team members in the company, updated the CORE ROUTING TABLES on our production routers to enable DDoS defenses (local and upstream scrubbing), and gave our customers a heads up that we knew the attack was underway and being dealt with. The rest of the ride to the taxi was probably spent between querying for graphs in ChatOps, seeing if the attack was over, and aimlessly playing a game.

These examples represent power, agility, and trust; all three of these ideas are core tenets of the DevOps movement. ChatOps represents a powerful new way to get things done, and have fun doing it. It represents a new way to capture the collective knowledge of a team and use it to drive real and big change in how products are delivered.

When Jason approached me and asked if I would write the foreword for this book, I could not have been more elated. Learning about and sharing ChatOps has been such a fundamental shift in how I and others I know approach work. The fact that momentum is building around capturing in a book how to implement and build a sustainable ChatOps practice is testimony to itself. The work contained in this book around how to get started and grow is invaluable to unleashing the power of your teams.

I hope you’re ready to change how you work. The fun is about to get started.

_James Fryman_  
_Senior DevOps Engineer at StackStorm_  
_Nashville, TN_  
&nbsp;