---
title: 'StackStorm vs. AWS Lambda: Event-Driven Computing vs. Event-Driven Operations'
author: st2admin
type: post
date: 2014-11-20T20:08:50+00:00
excerpt: '<a href="http://stackstorm.com/2014/11/20/stackstorm-vs-aws-lambda-event-driven-computing-vs-event-driven-operations/">READ MORE</a>'
url: /2014/11/20/stackstorm-vs-aws-lambda-event-driven-computing-vs-event-driven-operations/
dsq_thread_id:
  - 3246121503
categories:
  - Blog
  - Community
  - Home

---
One of the highlights of <a href="https://reinvent.awsevents.com/" target="_blank">AWS re:Invent</a>, judging by the Twitter stream and the points emphasized in Amazon CTO Werner Vogel’s Day 2 <a href="https://www.youtube.com/watch?v=ZPbM2qGfH3s" target="_blank">keynote</a> and <a href="http://www.allthingsdistributed.com/2014/11/aws-lambda.html" target="_blank">blog post</a>, was the launch of Lambda.

In his blog announcing Lambda, Vogel calls the solution “the easiest way to compute in the cloud.” He goes on to describe it as both a way to run arbitrary code on AWS with complete abstraction away from the underlying infrastructure including EC2 instances, AND as a fundamentally better way to compose applications through the use of Lambda as an **event-driven** approach to intra-application behavior.

What struck us as interesting was Vogel calling Lambda “an **event-driven** computing service for dynamic applications.”

In his Twitter feed, he has <a href="https://twitter.com/Werner/status/533685541607186432" target="_blank">this to say about it</a>:

<!--more-->

<p class="p1">
  Most heard comment at <a href="https://twitter.com/hashtag/reinvent?src=hash"><span class="s1">#reinvent</span></a> &#8220;dude, lambda is the coolest shit, ever&#8221; <a href="http://t.co/b1DBbV8NMZ"><span class="s1">http://t.co/b1DBbV8NMZ</span></a>
</p>

<p class="p2">
  — Werner Vogels (<a href="https://github.com/Werner"><span class="s2"><b>@Werner</b></span></a>) <a href="https://twitter.com/Werner/status/533685541607186432"><span class="s1">November 15, 2014</span></a>
</p>

So Lambda is cool, and is getting a massive amount of interest. And it has a lot to do with being **event-driven**.

Some folks that are already paying attention to StackStorm – which has experienced 2,000 downloads since we open sourced a couple of weeks ago – have asked us, “How does Lambda compare to StackStorm?&#8221;

After all, StackStorm listens to events &#8212; or polls for events &#8212; and allows users to then take actions, using a built-in rules engine and workflow capability.

Therefore, StackStorm seems itself to be **event-driven**.

Besides the obvious (Lambda = AWS only, StackStorm = on premise open source software), what is similar and what is different?

The first point is that you, the user, know better than we do. Please let us know your thoughts.  Spend a few minutes on <a href="http://stackstorm.com/community" target="_blank">stackstorm.com/community</a> and look around. Ping us at #stackstorm on freenode with your input and feedback.

As a start, let’s break down the comparison across a couple of vectors.

  1. Technology: How does Lambda work vs. StackStorm’s technologies?
  2. Use cases: Given the above, how is StackStorm used and how is Lambda used?

**1. TECHNOLOGY COMPARISON**

**Deployment model:**

The easy and obvious comparison is that StackStorm is an Apache licensed, open source software project that is typically run on premise or by users on their public clouds, whereas Lambda is of course an AWS service.

**What events:**

AWS Lambda comes already able to listen to a few different publishers of events from within AWS – <a href="http://aws.amazon.com/lambda/details/" target="_blank">“either a particular Amazon S3 bucket, Amazon DynamoDB table, or Amazon Kinesis stream.”</a> However, it seems possible that it will extended by AWS and maybe by savvy users stretching current integrations in the future. By comparison, StackStorm is completely **agnostic:** <a href="http://docs.stackstorm.com/sensors.html#sensors" target="_blank">you just need a sensor</a>. And that sensor does not just wait and listen, it can also actively poll.

StackStorm comes with cron-like timers, webhooks, and integrations with common monitoring systems out of box. With pluggable sensor architecture users can hook to arbitrary events &#8212; just <a href="http://docs.stackstorm.com/sensors.html" target="_blank">build a custom sensor</a>.

So it could be said that  StackStorm is even more “**event-driven**” than Lambda; or maybe we are really overusing that term by now…

**Scheduling:**

AWS Lambda does not currently enable you to run events on a particular schedule, whereas StackStorm comes with such an ability built-in.

**What code:**

StackStorm can start with your existing scripts and can incorporate these as actions that you might want to take. These scripts can be in almost any language. StackStorm workflows and rules are described in easy to read and to share YAML. StackStorm has bindings for Python and JavaScript so it is fairly trivial to use for many developers active in operations. StackStorm itself is written in Python and thanks to the permissive licensing of Apache, you can borrow pieces of it and use them as you’d like.

Lambda today needs JavaScript / node.js; however, Amazon plans to add other run-times. Since Lambda is a service, no one cares, presumably, how AWS wrote it.  However, the JavaScript limitation is a real limitation right now.

**Method of execution: Workflow included or abstract?**

With both StackStorm and Lambda, you can call out to arbitrary pieces of code and have that code do something. You could then listen for events from that piece of code, and based on those results you could continue to daisy chain your code via events together.

StackStorm offers workflow that simplifies the chaining of actions together such that it is possible to pass results, or the state of these actions, between each action. Additionally, StackStorm’s workflow can execute many threads simultaneously. Again, you could do the same with Lambda; however, it would require you to write your own workflow within JavaScript, and the corner cases in workflows are unfortunately often \*exciting\* resulting in a lot of important code to write and maintain.

You might even use StackStorm to simplify your AWS Lambda workflow, working hand-in-hand with Lambda.  While I have not seen this done yet, we’d love to witness it in action.

**Speed of execution:**

Lambda is built to respond immediately to events it consumes. While StackStorm has a scalable architecture, the speed at which it consumes and processes those events depends on the infrastructure on which it is running. In addition, StackStorm typically hands off the execution of events to a system like, well, AWS. For example, when you see events of type X, confirm them, tell the humans, and move the VM from the ELB. In that flow, StackStorm is dependent not just on speed of ingesting events but also on AWS’ speed at making that change.

**Abstraction of underlying resources:**

Lambda enables you to auto scale and to not worry about what the underlying resources are when you run it: <a href="http://aws.amazon.com/lambda/details/" target="_blank">“AWS Lambda seamlessly deploys your code, does all the administration, maintenance, and security patches, and provides built-in logging and monitoring through Amazon CloudWatch.”</a>

By comparison, StackStorm is open source software. You can run it, and probably will run it in an autoscaling group, but then you have to manage that.

**Audit, access controls and integrations for free from a community and more:**

It seems a bit unfair to ding Lambda on stuff that may not fit into its use case. However, if you are looking for software to deliver event driven operations automation, you probably want audit, you want to do roles based access controls (not in StackStorm 0.5, but on the roadmap), you want a community sharing integrations and, crucially, operational patterns in the form of easy to share automations as well as the workflow capabilities and other capabilities mentioned above.

There are many, many other differences in technologies, but this blog should help give an overall comparison. Lambda is more limited in the types of AWS only events it processes (today), it is faster (presumably), and it has a lot to do with abstracting your code .and you really don’t have to worry about or pay for anything unless and until the Lambda connector code is needed. On the other hand, StackStorm is broad, has full workflow and more.  StackStorm is open source, installable on premise and adjustable for your liking. It can be extended on both events (with sensors) and actions implemented scripts in any language.

All of which points to AWS Lambda being used mostly for the wiring within event driven applications running specifically on AWS and StackStorm being used for **event-driven** operations, tying together your environment and managing your automations.

**2. USE CASES**

So given the above, what is the overlap in use cases and in which areas do Lambda and StackStorm shine?

First, Lambda seems to be targeted squarely at application developers who are already writing event-driven applications, and want that wiring within the application to be provided for them by AWS.

By comparison, StackStorm is used primarily by the authors of automations within environments who have some imperative flows they want to automate and manage without incurring the technical debt of writing their own scripts, tying them together, and sharing them across the organization. The goal is to evolve automation over time towards greater levels by building trust and transparency with the humans that build and operate large IT environments.

In summary, StackStorm is usually used for event-driven operations automation whereas Lambda is typically used for event driven applications. Of course, we believe that there is only one system (see the James White manifesto) and so the lines can easily blur; you can write applications whose wiring is StackStorm based and presumably hack on top of Lambda to enable it to do more of the sorts of ops things for which StackStorm is known.

Whereas you would use Lambda to tie a mobile application together with a responsive AWS only backend, you would typically use StackStorm to employ standard troubleshooting procedures when something goes awry.

Similarly, whereas Lambda could help you autoscale some intelligent intra-application code running on AWS, StackStorm might be used as wiring that ties your continuous integration and continuous deployment tools together &#8212; including updating related systems and even pausing to require human validation &#8212; irrespective of where those systems may be running.

In yet another example, StackStorm is used at times to respond to security events by triggering certain procedures that themselves can be shared as code, and of course code reviewed, whereas supporting or back-office set of capabilities presumably would be provided by AWS itself and for only the AWS environment.

We are publishing this post both on our blog and as a discussion point in our <a href="https://groups.google.com/forum/#!forum/stackstorm" target="_blank">Google groups</a>, and we look forward to your feedback, flames, insights, and beer.   Please send beer to the most active community members your see on our IRC (#stackstorm on freenode) – they deserve it!