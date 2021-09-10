---
title: StackStorm v1.1.1 has been released
author: Tomaz Muraus
type: post
date: 2015-11-16T17:23:20+00:00
url: /2015/11/16/stackstorm-v1-1-1-has-been-released/
categories:
  - Blog

---
**November 16, 2015**  
_by Tomaz Muraus_

Slightly more than 2 weeks after the [StackStorm v1.1.0 release][1] we are happy to announce that we have just released StackStorm v1.1.1.

As you can guess from the version identifier (since v1.1.0 release we are following [semantic versioning][2]), this is minor release which means there are no breaking or backward incompatible changes and the release mostly includes smaller improvements and bug fixes.

<!--more-->

## StackStorm v1.1.0 recap

Before we dive into v1.1.1, here is a quick recap of new features which were released in StackStorm v1.1.0.

**New (graphical) installer**

StackStorm v1.1 introduced a new graphical based installer which allows you to easily install and configure StackStorm on a single server.

<div id="attachment_4797" style="width: 610px" class="wp-caption aligncenter">
  <img aria-describedby="caption-attachment-4797" loading="lazy" class="wp-image-4797" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/st2installer_step_1.png" alt="st2installer_step_1" width="600" height="552" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/st2installer_step_1.png 1147w, https://stackstorm.com/wp/wp-content/uploads/2015/11/st2installer_step_1-300x276.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/st2installer_step_1-1024x943.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/st2installer_step_1-1080x994.png 1080w" sizes="(max-width: 600px) 100vw, 600px" />
  
  <p id="caption-attachment-4797" class="wp-caption-text">
    First page of the installer where hostname SSL certificate and enterprise license key is configured.
  </p>
</div>

In addition to the graphical mode, installer also allows user to providers “answers” file (YAML file with configuration options) and run in unattended mode.

The goal of the installer is to reduce the barrier to entry and make it easier and faster to get up and running with StackStorm.

**Enterprise Edition with RBAC, Flow, LDAP authentication backend and more**

In addition to many other new features and improvements, StackStorm v1.1 was also the first release which brings our [Enterprise Edition][3].

The StackStorm v1.1 Enterprise Edition builds on top of the community edition which is fully free and open source and adds some additional features which come handy especially in large enterprise environments.

**Flow**

Flow is a one of a kind graphical workflow editor which fully embraces and integrates with the infrastructure as code approach.

<div id="attachment_4800" style="width: 760px" class="wp-caption aligncenter">
  <img aria-describedby="caption-attachment-4800" loading="lazy" class="wp-image-4800" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/remediation-cassandra.gif" alt="remediation-cassandra" width="750" height="464" />
  
  <p id="caption-attachment-4800" class="wp-caption-text">
    Flow with an opened disk auto remediation workflow.
  </p>
</div>

The goal of flow is to make it easier for users to build, visualize and share workflows. This comes especially handy for complex workflows with many tasks and transitions.

Flow also differentiates itself from legacy workflow editors by running in the browser (no need to install resource hungry Java applications) and by being built on open-source technologies such as d3 and react.

In addition to that, Flow fully embraces an infrastructure as code approach &#8211; all the changes you make in the graphical editor are immediately visible in the right pane which contains “source” code (easy to read YAML) for that workflow. Embracing infrastructure as code means that workflows are the same as any other source code or configuration files &#8211; you can version control them, review them, etc.

The right pane with source code is also editable which means you can quickly switch between “drag and drop” and text based editing.

**Role Based Access Control (RBAC)**

The Enterprise Edition also comes with Role Based Access Control (RBAC) which allows you to restrict user access to particular operations.

<div id="attachment_4801" style="width: 708px" class="wp-caption aligncenter">
  <img aria-describedby="caption-attachment-4801" loading="lazy" class="wp-image-4801" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/Selection_299.png" alt="Selection_299" width="698" height="162" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/Selection_299.png 789w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Selection_299-300x70.png 300w" sizes="(max-width: 698px) 100vw, 698px" />
  
  <p id="caption-attachment-4801" class="wp-caption-text">
    An error which is displayed when a user doesn’t have a permission to run (execute) an action (in this case this is “core.local” action).
  </p>
</div>

RBAC is an essential feature for large teams and organizations where you have many people working on different projects. RBAC allows you to organize permissions into roles and assign those roles to the StackStorm users.

My favorite example of this is a user who has a powerful automation called “bootstrap datacenter” &#8211; for obvious reasons, they’d rather not have everyone who has access to StackStorm able to run this automation.

Another example is limiting which actions StackStorm users can view and run . You can lock parameters for a particular action (e.g. if you have “create_vm” action you could limit “region” parameter to a particular set of approved regions).

That’s a quick recap. For a deeper dive and more information about v1.1.0 and the [Enterprise Edition][3], please check the following post &#8211; [StackStorm v1 is out][1].

## StackStorm v1.1.1

And now back to the shiny new v1.1.1.

**Improved CLI experience**

We have optimized the speed of the CLI and now performing operations such as listing executions (st2 execution list) and retrieving particular execution details (st2 execution get) is much faster. This is especially noticeable for users with a lot of executions which contain large results.

In our build server case where we have many executions with large results, running time of “st2 execution list” went from 8 seconds down to 0.5 seconds.

Another improvement we made to the st2 execution list is displaying elapsed / running time for all the executions which are currently in the “running” state.

<div id="attachment_4813" style="width: 710px" class="wp-caption aligncenter">
  <img aria-describedby="caption-attachment-4813" loading="lazy" class="wp-image-4813" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/Selection_2981.png" alt="Output of “st2 execution list -n5” command." width="700" height="366" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/Selection_2981.png 950w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Selection_2981-300x157.png 300w" sizes="(max-width: 700px) 100vw, 700px" />
  
  <p id="caption-attachment-4813" class="wp-caption-text">
    Output of “st2 execution list -n5” command.
  </p>
</div>

This makes it easier to see, at a glance, how long a particular action has been running. This is also useful for helping you identify outliers and actions which are potentially stuck and will result in a timeout.

**Improved action-chain workflow validation**

We’ve made some improvements to the action-chain workflows so some validation such as task existence, etc. is done immediately when the workflow runs. Previously, some of that validation happened only when the task was about to run. This means that in cases where you have many long running tasks it could take many minutes to identify some common errors such as a typo in the referenced task name.

Detecting common validation errors as early as possible is very important since it speeds up the whole “develop-test/run” feedback loop. Imagine if you need to wait for 10 minutes for tasks to finish to notice that you have made a typo in one of the referenced tasks &#8211; that’s not very pleasant and you lose motivation and context.

It’s also worth pointing out that because of the dynamic nature of the workflows (e.g. using jinja expressions in the task names, etc.) some validation can only be performed during actual run-time.

## Conclusion

That’s it for the highlights. You can find the whole list of changes [here][4]. We encourage you to go [try it out][5] and join us at our [Slack community channel][6] (or #stackstorm on freenode) if you are an IRC person) where you can leave your feedback and chat with other stormers and StackStorm users.

 [1]: https://stackstorm.com/2015/11/02/stackstorm-v1-is-out/
 [2]: http://semver.org/
 [3]: https://stackstorm.com/product/#enterprise
 [4]: http://docs.stackstorm.com/changelog.html#november-13-2015
 [5]: http://docs.stackstorm.com/install/all_in_one.html
 [6]: https://stackstorm.com/community-signup