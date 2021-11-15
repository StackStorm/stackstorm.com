---
title: On Beginning Software Delivery Acceleration
author: st2admin
type: post
date: 2015-05-20T18:07:08+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/05/20/on-beginning-software-delivery-acceleration/
dsq_thread_id:
  - 3780304958
categories:
  - Blog
  - Community
  - Home
tags:
  - devops

---
**May 20, 2015**

_by James Fryman_

Time and time again, we hear of companies achieving rapid acceleration with DevOps. Companies are touting success with the metric of deploys/day, sharing new baselines of 10, 50 or even 100 deploys/day. In more mature organizations the likes of LinkedIn, Netflix, Etsy, Facebook and others, this number is a startling 1,000+ number. But, what does this even mean?

Unpacking this number is often one IT leaders stumble on, and is the greatest source of pushback when talking about rapid acceleration. How stable is the software being delivered? How many of these deployments are successful? What constitutes a deployment?

These questions and more often end up creating analysis paralysis, and nothing changes. In fact, the most common response starts with, “There is no way we could implement something like that at my company because…” We know this to be false. Companies who have traditionally delivered in a waterfall fashion with a single, bloated deploy per month or quarter are successfully transitioning to rapid deployment posting similar baseline numbers as other teams.

How then can you be successful in beginning software delivery? There is no single silver bullet or magic wand, but there is a fairly prescriptive methodology for achieving our goal of rapid delivery. Let’s dive in and take a look on how to get started.

<!--more-->

## Ground Rules

Let’s set the stage with some key principles that will light the path ahead. They are:

  * Embrace failure
  * Blamelessly analyze failures<sup>1</sup>
  * Quickly repair failures when understood
  * Always be iterating

In a nutshell, the goal should be to **Deploy Fast, Fail Fast, Learn Fast, and Improve Fast.** This is a never-ending task, and it is important to consider it as such. Too many times, a project is spun up to start working on these tasks, and inevitably that project ends. Unless continual improvement becomes a core tenant of delivery, any efforts risk falling apart at the seams over time.

With these rules in mind, let’s continue.

## How is software developed?

The first stop is incidentally not within the delivery organization, but rather the development organization. This is where the **empathy** that is so often discussed alongside DevOps will come in; we first need to ensure the developers who are delivering features are equipped for success.

How is software developed? What does it really mean to get into the flow of production? Ask yourself questions like: how is code introduced into the source tree? What does acceptance of that code look like? (For example: are there code formatting guidelines, are tests needed, etc).

Once this is understood, the key is the gate that exists to advance code to the next stage of delivery. This is where bottlenecks often exist, and often have valid historic cases for existing. Usually, this is to try and improve quality by introducing checkpoints, but these checkpoints are often human driven, and will invariably contain defects of their own.

It is important to make the distinction around delivery of code or delivery of features versus the delivery of the software itself. Both are important as illustrated in the next section, but two sides of the same coin that are often separated duties. In the context of the entire system, the need is the same: identify opportunities to reduce friction by either removing steps from process (non-value add unnecessary, vestiges of old days) or introducing automation to move things along.

These conversations are **always** enlightening, as it will become pretty apparent where the slowdowns occur after some initial conversations. Keep those brain juices flowing, and let’s continue.

**Keep in mind:**

  * Who can write software? Everyone?
  * What is the **barrier** to entry associated with learning how to write software?
  * How difficult is it to demonstrate working code to a colleague?
  * How difficult is it for a colleague to run your demonstration code?
  * Who can deploy the software?
  * What is the barrier to entry associated with learning how to ship the software?
  * Where is work being assigned?
  * Where are feature discussions happening?

## Kicking things into high gear

By this point, it is possible that you have a laundry list of things you have already identified as areas to improve. But, where do you focus? The default tendency is to clean up shop first, and then go work with external teams to try and integrate better. However, that is actually the least ideal thing to do, because it ends up creating silos of isolation. Possibly against your better judgment, plan on integrating first.

Your first steps should be focused on two objectives. The first of which is to embed yourself into the development work stream… get work items from development via their existing process and find yourself an advocate. This advocate will be your “first follower,” and will help you understand what changes are working and which are not, and will provide valuable and honest feedback that may not come from other members not because they don’t care, but as their energy is focused on other things. It is almost a necessity to start small.

The point of **empathy** that comes up most times DevOps is mentioned will come into major play here. No matter what efforts that you make to try to improve things, any friction introduced into the life of a developer will dramatically affect your success in any real change. For example: It may be advantageous for you to change the underlying ticketing platform for you all to communicate better, but if you disrupt the existing delivery pipeline, the odds of making new friends may go down a bit.

Work with your advocate to firm up how development reports issue to your team and vice versa, and run **it** through the gauntlet. Do not forget to apply ground rules… **Deploy Fast, Fail Fast, Learn Fast, and Improve Fast.** Fix easy process holes quickly. Do be mindful of the amount of change that is being introduced at any given time, don’t be afraid to make changes, but also be consistent and measured with this change. This will set the appropriate tone for sustained and long-term process improvement.

Likewise, do a real project via this first process. One early victory can be to ensure that developers have the ability to run any version of code (git checkout, major version, doesn’t matter) with minimal effort. This allows me to run other colleagues’ code to test out fixes, confirm bugs, or whatnot. By having the ability to run arbitrary code, collaboration speeds up closest to the code, and the number of problems that bubble up to later phases of deployment are cleaned up much earlier. This may mean staging environments; this may mean local development environments. But, solving the smaller task of how developers can run code becomes a test bed for how a production delivery pipeline may behave.

When you find failures in both process and tooling, it is essential to be blameless while analyzing and working through failures. Early on, there will be many, and it is essential to set tone early on. John Allspaw talks about this in his article when he discusses incentives.

<p style="padding-left: 30px;">
  <em>Because an engineer who thinks they’re going to be reprimanded are disincentivized to give the details necessary to get an understanding of the mechanism, pathology, and operation of the failure. This lack of understanding of how the accident occurred all but guarantees that it will repeat. If not with the original engineer, another one in the future. – Allspaw</em>
</p>

Another often-overlooked concern is how these solutions are implemented. Repair of these processes cannot be driven by a single person or in a top-down fashion. Rather, all members of the team must be a part of owning the solution. Time and encouragement will go a tremendous length.

Finally, deploy. The entire point of this project is to deploy code. The work done up to this point largely will focus on the interaction between Development and Operations, but assuredly there is work to be done on both sides. Until you are able to deploy daily without any breakage, that should be your target. Every day, attempt a code deploy regardless if you know the outcome already. Pick one of two things to fix daily: a failure in the process, or a manual step. Repeat this until you can deploy each day with a minimal number of commands (best case: single command).

## The Path Ahead is Dangerous, Take These!

As you go along this path, there will be two themes that appear to come up time and time again. The first has to do with communication. Processes to deploy may get faster or more streamlined over time, but there are always ways that communication roadblocks cause challenges for the best of teams.

The second always has to do with tool disparity. Once engineers get wind that tools need to be implemented, all people and process concerns become secondary. This typically becomes a quagmire, as these tools need to actually participate in the communication streams within the organization to facilitate software delivery.

To this end, there are two tools that are very beneficial to keep in mind as you go down this path: ChatOps<sup>2</sup> and Workflow<sup>3,4</sup>. Both of these topics deserve entire sections dedicated to their own right, but in a nutshell, here are the two things that should whet your palette.

<p style="padding-left: 30px;">
  <em>ChatOps brings the context of the work you are already doing into the conversations you are already having. – James Fryman</em>
</p>

<p style="padding-left: 30px;">
  <em>Human readable, machine scriptable language for declaring workflow is not just convenience. It’s a necessity for dynamic creation, uploading and updating workflows on a live system, and for treating “infrastructure-as-code.” – Dmitri Zimine</em>
</p>

Just remember: it’s not about one tool. These tools are a means to an end. The people and process have to be part of this conversation. ChatOps enables the communication and collaboration that creates and drives the development. Workflow enables collaboration around infrastructure process. Both of these will become essential.

## Closing

To succeed, we as technologists need to know what’s going on in our organization, how technology efforts are helping delivery, and how the technology being deployed is being consumed and by whom. Without this understanding, we’re just throwing tools at a problem and often wind up complicating matters. These tools can jam things up or become shelf ware because nobody is ready to implement them. And in the rapidly moving, lean businesses of today, there is no time for breakdowns.

Do you know how your teams deliver and collaborate around software? Do you have a tight feedback loop established between your teams and those you provide services to? Are you moving fast, and fixing even faster?

How teams deliver software today is quickly being recognized as a market differentiator. This journey is neither easy nor quick, but will enable your organization to be prepared for the next phase of rapid growth in the industry.

Until next time!

* * *

&nbsp;

<sup>1</sup>https://codeascraft.com/2012/05/22/blameless-postmortems/

<sup>2</sup>https://speakerdeck.com/jfryman/chatops-technology-and-philosophy

<sup>3</sup>http://stackstorm.com/2015/04/10/the-return-of-workflows

<sup>4</sup>https://www.slideshare.net/slideshow/embed_code/key/cHCIlAlU4Xb1Lw

&nbsp;