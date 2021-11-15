---
title: Unifying disparate applications into the One System
author: st2admin
type: post
date: 2016-01-29T14:24:00+00:00
url: /2016/01/29/unifying-disparate-applications-one-system/
dsq_thread_id:
  - 4533843218
tcb2_ready:
  - 1
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Tutorials

---
**January 29, 2016**  
By James Fryman

_Originally published at <http://devops.com/2016/01/29/unifying-applications-into-one-system>_

Let&#8217;s talk about a real problem that all of us have faced at one point or another: keeping track of a single thread of work across many disparate tools. Regardless of the specific industry a company operates in, as a company grows, back-office applications in support of the business begin to accumulate. Many knowledge based companies have some sort of communication tool, some sort of project tracker, and some support tracker. These are tools that aim at being more effective with daily business process. Conversations suffice until they do not, and tools are implemented as the need arises. Every tool that was added has purpose, solves a critical need, and made you and/or your team more productive.

At some point however, this changes. Discovery starts to become a major issue as usage patterns between different tools leaves solos of data. It becomes hard to correlate the different company pipelines that ultimately drive your business: the pipeline to care and communicate for customers, the pipeline to deliver new features, and the human interfaces involved in each. This is only intensified by team members that work on different project with different tools and people, you introduce team members from a timezone not your own, the sheer quantity of work&#8230; how many ways can you name how not just conversations are lost, but _context_

<!--more-->

Commonly, teams attempt to solve this in a few ways:

  * Rules! Specific guidelines (sometimes suggestions, sometimes mandatory) on how and where to have conversations and to store data.
  * Integrate! Write data transforms to move necessary data from system X to system Y as necessary.
  * Go all in! Choose a suite of tools that takes care of all of these for you.
  * Make it &#8220;Future You&#8221;&#8216;s problem. It&#8217;s fine as is, and not really an issue.

At StackStorm, we ran into this problem. We have two ticketing systems (GitHub issues and Jira), a service desk tool (reamaze), and a chat client (Slack). The solution we use at StackStorm is one that I borrowed from my time at GitHub. One of my colleagues setup a really cool hook into Hubot that listened in our chat rooms for conversations we were having related to a GitHub Issue, a Pull Request, or even a code commit. When someone mentions one of these things, Hubot would grab a chat log plank, and cross-link the permalink to the Issue or Pull Request.

![http://stackstorm.com/wp/wp-content/uploads/2016/01/bf7487ce-9ebd-11e5-87cf-657e8d89cc32.png][1] 

But, that&#8217;s just GitHub. Context matters across all tools, and gives team members additional flexibly in learning and gaining knowledge on their own. So, we took our Support Tool, reamaze, and did the same thing!

![http://stackstorm.com/wp/wp-content/uploads/2016/01/687474703a2f2f692e696d6775722e636f6d2f6d4e37777851432e706e67.png][2] 

  * In times of speed, breadcrumbs allow you to piece together puzzles from where travelers have once voyaged. May not be the entire puzzle, but having background greatly helps.
  * In times of documentation, said breadcrumbs allow you to use the same investigative skills to assemble a better history.

This is one part of a set of behaviors that helps create a dynamic web of information. By seamlessly having a mechanism to associate conversations and issues/pr/tickets/whatever, it becomes much easier to have conversations happen whenever they need to (serendipitous interactions ftw) and still get context to team members when they&#8217;re available.

This matters because: [There is only one system][3].

## Before we get started&#8230;

Full disclosure: I am affiliated with StackStorm the company building StackStorm the tool. That being said, the ultimate goal here is to illustrate the pattern of how harness the recent chat culture change using an event-driven framework with the hopes of regaining just a modicum of sanity in your daily life. If you&#8217;re interested in learning more about StackStorm and how it ties into the overall automated troubleshooting and autoremeditaion space, take a look at our [ChatOps Pitfalls and Tips][4] by Dmitri Zimine. That should give you a good background on why we used StackStorm instead of say&#8230; just a small script.

Ok, on to business!

### The Sensor

This workflow begins with a sensor. Inside of the StackStorm-Slack integration is a sensor class connects to the Slack Real-Time Messaging API. The first place to begin is with Sensors. The official [Slack][5] pack contains a sensor. This sensor uses the Slack RTM to connect to Slack and listen for messages in rooms that it is associated with. Each message is then sent as an &#8220;event&#8221; to StackStorm which I can create rules that will trap certain events and kick off.

### Rules

Now that the sensor is emitting triggers into the system, I need to find a way to take an action when someone mentions an issue or ticket. The mechanism here is via a rule. Rules check triggers emitted into the system via sensors against a series of checks, and then executes an action or workflow if matched. A trigger can match to many rules.

Let&#8217;s create a rule to watch Slack for discussions related to reamaze



  * Source: [https://github.com/stackstorm-packs/st2-crosslink\_chat\_with_applications/blob/master/rules/crosslink-slack-to-reamaze.yaml][6]

The first element in the `criteria` block is `trigger.text`. In the rule, the trigger itself is just referred to as `trigger` as opposed to `slack.message.text`. We want to see if the `text` propery `contains` a pattern related to our reamaze issue tracker. I chose `contains` out of the [large list of comparison operators][7], and made sure the pattern matches what I&#8217;m looking for. Last but not least, the `action` block. This block is basically the next operation. Here, I can choose a single action or a workflow to kick off, and even grab data from the trigger payload to pass to the action. In this case, I opted to create a new workflow for my purposes here, and made sure to grab a few keywords that I needed to do processing.

At this point, I have a rule matching and now I need to create the action necessary to process the trigger.

### Actions and Workflows

Next, we get to creating the actions. The goal is to ensure that anytime a discussion randomly breaks out about a reamaze support ticket, that @estee-tew posts the Slack permalink to the support ticket. With the trigger payload extracted in the above rule, the workflow will need to:

  * Take the text of a user comment and extract reamaze issue URL
  * Calculate the Slack Permalink URL of the matched message from the collected data.
  * Post the Slack Permalink on the matched reamaze issue ticket.

Inside the [`reamaze` pack][8], I can see that I have the ability to `create_message`. This action takes three parameters: `slug`, `message`, and `visibility`. In our rule above, the action that was kicked off when the critera matched desired slack messages is `stackstorm.crosslink_slack_to_reamaze`. As of right now, this does not exist, so that is the next step. For brevity&#8217;s sake, you can take a look at the [action metadata][9] on GitHub.



  * Source: [https://github.com/stackstorm-packs/st2-crosslink\_chat\_with\_applications/blob/master/actions/workflows/crosslink\_slack\_to\_reamaze.yaml][10]

This is a simple Action Chain. In as much as it just does one task after another. The tasks here are designed to be small and portable so they can be re-used. Let&#8217;s quickly inspect each of the actions and walk through what it is that lies before us now.

#### Step 1: Permalink to chat history

The goal is to create a way to crosslink a Slack permalink, so let&#8217;s start there. This starts with the `get_permalink` action above. While the history permalink is not in the trigger payload (or even in the official API, for that matter), Slack permalinks are actually not too terribly difficult to figure out. The first action takes two parameters (`channel` and `timestamp`), and then spits us out our permalink. We know we&#8217;re going to publish the `permalink` variable that can now be globally used in the workflow in the future. In additon, the next step takes us to the `sanitize_message` task. You can take a look at the [python code][11] for this action upstream.

#### Step 2: Get support issue data

The next step actually happens in two tasks: `sanitize_message` and `get_reamaze_slug`. The immediate next step, `sanitize_message`, is necessary to clean up the output from Slack. In the message payload, URL data is sent to us as a special [&#8220;escape sequence&#8221;][12] which doesn&#8217;t do the rest of the actions much good. This action, detailed below, is simple enough to be reused in several other workflows. Again, take a look at the [action itself][13] The `run()` method in this `python-runner` task is the entry point from StackStorm, and this cleans up the text and returns it back as a plain URL which we can then pass to the next action, `get_reamaze_slug`. This returned information gets us what we need in order to call our final action, `reamaze.create_message`. We&#8217;re able to publish the permalink slug that was shared and discussed in chat. Now we know _what_ is being discussed.

#### Step 3: Post the crosslink

In this step, a the link is actually created. Here we are! The finish line! Woot! The only thing that is essential to do is to make sure we only set the note as an _Internal Only_ note to avoid sending weird links to our friends. The next step is the `crosslink_slack_to_reamaze` action. At this point, we have all the data we need, so it&#8217;s just execution.

Permalink from Slack. Crosspost to reamaze

![http://stackstorm.com/wp/wp-content/uploads/2016/01/687474703a2f2f692e696d6775722e636f6d2f6d4e37777851432e706e67.png][2] 

### and now, with GitHub&#8230;

The premise is simple enough. Included in the upstream repository also includes examples for how to setup similar context mapping with StackStorm. Take a look at https://github.com/stackstorm-packs/st2-crosslink\_chat\_with_applications. Same process, code reuse, and the same end effect.

![http://stackstorm.com/wp/wp-content/uploads/2016/01/687474703a2f2f692e696d6775722e636f6d2f6d4e37777851432e706e67.png][2] 

# Unknowns

  * This workflow is not for everyone.
  * We expose internal-only links that are unaccessible by users, and it may be confusing to see random links in issues around GitHub. Why?! What are they?!
  * Aliens!?

There are many more that will come up, but the key facter to address here is that it&#8217;s not difficult to put this together, and it&#8217;s not that difficult to change. And that&#8217;s ok. We&#8217;ll have questions to be answered, but being able to try something out _super quickly_ was indeed satisfying. (In truth, the workflow went up faster than the blog. :P)

# Wrap up

For many reasons, it is unfeasable to capture many fluid conversations in many different tools. The answer is not to move data around, but to leverage humans and provide them a helping hand. This is by no mean a solution, but it begins to provide less friction in the daily work. Over time, add enough of these friction reducers, and then suddenly&#8230; it&#8217;s no longer a panic. This also reinforces the idea that there is not a collection of systems, but rather a single system. The single company. The tools you selected are obviously necessary as we defined at the beginning, but tools should not be dictating the communication structures of your teams, but rather informing them. Removing the ability for silos to form allows data in both bits and ideas to flow and move around. This can even be expanded to do much more&#8230;

Until next time!

 [1]: http://stackstorm.com/wp/wp-content/uploads/2016/01/bf7487ce-9ebd-11e5-87cf-657e8d89cc32.png
 [2]: http://stackstorm.com/wp/wp-content/uploads/2016/01/687474703a2f2f692e696d6775722e636f6d2f6d4e37777851432e706e67.png
 [3]: https://youtu.be/vEpXJRPITN0?t=10m44s
 [4]: https://stackstorm.com/2015/12/10/chatops_pitfalls_and_tips/
 [5]: https://github.com/StackStorm-Exchange/stackstorm-slack
 [6]: https://github.com/stackstorm-packs/st2-crosslink_chat_with_applications/blob/master/rules/crosslink-slack-to-reamaze.yaml
 [7]: https://docs.stackstorm.com/rules.html#critera-comparision
 [8]: https://github.com/StackStorm-Exchange/stackstorm-reamaze/tree/master/actions
 [9]: https://github.com/stackstorm-packs/st2-crosslink_chat_with_applications/blob/master/actions/crosslink_slack_to_reamaze.yaml
 [10]: https://github.com/stackstorm-packs/st2-crosslink_chat_with_applications/blob/master/actions/workflows/crosslink_slack_to_reamaze.yaml
 [11]: https://github.com/stackstorm-packs/st2-crosslink_chat_with_applications/blob/master/actions/script/get_slack_message_permalink.py
 [12]: https://api.slack.com/docs/formatting
 [13]: https://github.com/stackstorm-packs/st2-crosslink_chat_with_applications/blob/master/actions/script/sanitize_slack_message.py