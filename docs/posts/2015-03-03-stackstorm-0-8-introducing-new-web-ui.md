---
title: 'StackStorm 0.8: Introducing Our Web UI!'
author: st2admin
type: post
date: 2015-03-04T04:08:23+00:00
excerpt: '<a href="http://stackstorm.com/2015/03/03/stackstorm-0-8-introducing-new-web-ui/">READ MORE</a>'
url: /2015/03/03/stackstorm-0-8-introducing-new-web-ui/
dsq_thread_id:
  - 4402638235
categories:
  - Blog
  - Community
  - Home

---
**March 3, 2015**

_by James Fryman_

Time flies when you&#8217;re having fun, or better yet, when you&#8217;re shipping new features! We are pleased to announce for general release <a href="http://docs.stackstorm.com/install/index.html" target="_blank">version 0.8 of StackStorm</a>, our biggest release to date! This version contains a ton of platform improvements, user feature requests, new packs and much more.

###### FEATURES

**Web UI**

Yes, that&#8217;s right! We are pleased to announce our inaugural release of the StackStorm Web UI.  We have had the UI in a limited beta release for about 2 months now, and have been responding to feedback as it comes in. This is easily one of our more common user requests, so we&#8217;re excited that it&#8217;s now ready to start sharing with the world.

With the brand new UI, we now have three views to consume: Actions, History, and Rules.

<!--more-->

**Actions**

<img loading="lazy" class="alignnone size-full wp-image-2801" src="http://stackstorm.com/wp/wp-content/uploads/2015/03/actions.gif" alt="actions" width="1290" height="837" /> 

From the Actions page, users now see an entire list of all actions that have been registered on a StackStorm install. Actions are sorted into logical categories based on the packs they belong to. It is easy to see the name of actions, the type of runner that is used to execute an action/workflow, and overview descriptions of each of the actions. From this view, it is easy to filter the list of actions based on name to quickly narrow down searches for actions.

All actions from this view are also able to be executed directly from the Web UI! Once an action is selected, the list of parameters and their respective descriptions are displayed on the right, along with a RUN button that will kick off asynchronously any command you choose! A history item is created for a given action, and you can view the execution history on an action-by-action basis.

It is also possible to inspect the code of any action or workflow directly from the WebUI.

**History**

<img loading="lazy" class="alignnone size-full wp-image-2807" src="http://stackstorm.com/wp/wp-content/uploads/2015/03/history1-960.gif" alt="history1-960" width="960" height="599" /> 

The history view now shows a real-time outline of all actions that have been executed and their status, and any actions that are currently running.  Workflows are logically grouped, and expanding a workflow to inspect sub-tasks is only a click away.

From this view, it is possible to view the output of any action, and perform introspection on how a given action/workflow was executed by inspecting the parameters passed in a given execution. Upon inspection of an action or workflow, information on the workflow itself is presented on the right-hand pane.  This view is slightly different if an action has been kicked off as an individual action, or the result of a rule execution. In the case of a manual execution, all the parameter details are shown for historic purposes. Likewise for a rule execution, all parameter details are shown as well as any triggers data that is attributed to the spawning of action/workflow execution.

Finally, any history item allows you to inspect the output directly from the engine as code. This view makes it simple to review workflows during troubleshooting.

**Rules**

<img loading="lazy" class="alignnone size-full wp-image-2803" src="http://stackstorm.com/wp/wp-content/uploads/2015/03/rules.gif" alt="rules" width="1289" height="804" /> 

Quick and easy viewing of all registered rules can also be performed via the WebUI. From this view, it is possible to inspect a rule showing the name and any parameters of a sensor, the list of criteria necessary to match against a given rule, and the resulting action/action parameters used in subsequent execution.

As are with Actions, It is also possible to inspect the code of any action or workflow directly from the WebUI.

The release of our WebUI is a major milestone for us, and we look forward to hearing how it helps teams out with usability. This is only the first set of features that we are releasing, and we have many more in queue, including rule creation and editing, graphical representation of workflows, and more. Keep an eye on this space as we expand the UI over the upcoming months.

**Workflows, Workflows, Workflows!**

Say it three times fast, and magic starts to happen. In this release, we&#8217;ve made several improvements to our workflow engines. Now within ActionChain, StackStorm&#8217;s native workflow engine, you can now assign variables to be used throughout workflows. Save some typing time and DRY up your code with this change. You can also now also publish variables from a given action within ActionChain to streamline and make workflows even easier to consume.

On the Mistral side of the house, we have now even better integration! Actions in Mistral can now call native StackStorm actions without proxying through a meta-action. This gives Mistral a much more native feel. The Mistral workflow DSL has also changed on how to delimit YAQL expressions, and Mistral workflows that are written for 0.7 needs to be updated by wrapping YAQL with \`<% % >\`. If you happen to have older Mistral workflows, we have a migration tool that you can use to upgrade to be compatible with 0.8. \`upgrade-mistral-wf-0.8\` can be found at <a href="https://github.com/StackStorm/st2/tree/master/tools" target="_blank">https://github.com/StackStorm/st2/tree/master/tools</a>.

Workflows are very important to us, and we have spent a lot of time making them easier to use and consume this release. We also made major improvements to the CLI to inspect workflow executions. Execution list queried from the CLI only returns top-level actions, reducing the noise while introspecting workflows. It is also possible to show all actions using the \`&#8211;show-all\` flag at the command line. Furthermore, if the action is a workflow, you can inspect the task with \`st2 execution get <id> &#8211;tasks\`.

**Action Changes**

Fresh out in 0.8 includes the ability to specify default parameters for action execution. These values can be stored in our internal Key/Value store, and provides a great way to provide sane defaults for commonly used actions. You can also now change the user information (username/password/private key) used for remote configuration on an action-by-action basis. We&#8217;ve added the ability for StackStorm to inherit ENV variables, and made it  possible for data types other than string to be used in action execution. Local and Remote runners also now have the ability to change the working directory before action execution. Finally, it&#8217;s now possible to &#8216;re-run&#8217; an action with the command of the same name. This replays an action with the same parameters as previously run.

**Sensors And Key/Values**

Our internal Key/Value store continues to expand in versatility, and this release is no exception. Hot off the press is the ability to now manipulate the K/V store (\`get\`/\`set\`/\`delete\`) straight from a sensor. Likewise, it is also possible to list all keys in the store and filter based on key prefix.

We continue to build and expand on our Key/Value store to provide additional context across multiple alerts. These new features make it significantly easier to manage state across events of many disparate actions.

**Configuration Changes**

New in this version is the ability to better specify where Packs are installed on your system. Using the new \`packs\_base\_paths\` setting, you can now specify multiple directories where packs can be managed on the filesystem. Manage the packs on your system however you&#8217;d like! Likewise, it is now possible to specify the path where Python is on your system.

**Refactoring and Bug Fixes**

There is a lot to be excited about, including several bug fixes and refactors that have landed in this release. It&#8217;s equally important to us that with each release we not only ship new features, but continue to hone our platform to make it easier to develop against and improve stability at the same time. Take a look at our <a href="https://github.com/StackStorm/st2/blob/master/CHANGELOG.rst" target="_blank">CHANGELOG</a> to see what we&#8217;ve been up to in this regard.

###### GIVE IT A SHOT

There are many ways you can get started with StackStorm today. You can find documentation for StackStorm at <a href="http://docs.stackstorm.com" target="_blank">http://docs.stackstorm.com</a>. Here you&#8217;ll find information on how StackStorm is architected, how to manage an installation, what it takes to author new integrations, and much more. For those looking to try us out, take a look at our <a href="https://github.com/stackstorm/st2express" target="_blank">st2express project</a> where we have both Docker containers and Vagrant images ready for you to fire up and play with. You can also grab our <a href="https://github.com/stackstorm/puppet-st2" target="_blank">Puppet module</a> or <a href="https://github.com/StackStorm/chef-stackstorm" target="_blank">Chef cookbook</a> and get started today.

**We <3 Feedback**

We love it when new users give our software a shot, and even more when they tell us what they like or how we can improve our platform. If you have some feedback, we&#8217;re keen to hear about it. Share your thoughts and ideas via <stackstorm@googlegroups.com>, <a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">#stackstorm on irc.freenode.net</a> or on Twitter <a href="https://twitter.com/Stack_Storm" target="_blank">@Stack_Storm</a>. Our goal is to make this platform the best way to glue together your infrastructure, so be sure to let us know how it&#8217;s helping you and what more we can add to further improve your daily life. We love hearing how folks are using StackStorm!

###### MORE TO COME

It&#8217;s still early in our company, and there is so much more coming. There is no shortage of ideas coming from the Pandas on our crew and our community partners. This fly-wheel is really starting to get moving, so watch out in this space for even more in the upcoming weeks. Also, don&#8217;t forget to <a href="http://stackstorm.com/subscribe-to-newsletter/" target="_blank">sign up for our newsletter</a> to stay abreast of all the happenings we have going on.

Until next time!