---
title: OctopusDeploy Integration with StackStorm
author: st2admin
type: post
date: 2015-10-01T15:02:25+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/10/01/octopusdeploy-integration-with-stackstorm/
dsq_thread_id:
  - 4183832257
tcb2_ready:
  - 1
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home
tags:
  - actions
  - integrations
  - OctopusDeploy
  - StackStorm
  - workflows

---
**October 1, 2015**  
_Guest post by [Anthony Shaw][1], Head of Innovation, ITaaS at [Dimension Data][2]_

This blog post will take you through the [integration pack for OctopusDeploy][3] and give you some example actions and rules to integrate with other packs.

## What is OctopusDeploy?

[Octopus Deploy][4] is an automated deployment tool for .NET and Windows environments. It has gained significant popularity amongst the .NET development community for it&#8217;s ease of use and integration into the Microsoft development ecosystem. OctopusDeploy enables users to automate deployment of applications, packages and tools to Windows environments.

## Why integrate OctopusDeploy into StackStorm?

Octopus Deploy provides a rich system for Windows application deployments, but this is typically part of a wider DevOps process. Unlike StackStorm, it does not support closed-loop monitoring, remediation or infrastructure configuration and building, it does not integrate into configuration management tools (nor claim to). If you want to integrate OctopusDeploy from another tool, as part of a DevOps or environment tool you could <!--more-->write custom integrations from each tool to the Octopus API or you could simply use StackStorm as the go-between to join your systems together. Imagine the possible integration scenarios:

  * Configuring the Octopus Deploy agent as part of a new environment creation
  * Creating a new release when a git commit is detected
  * Calling a 3rd party system when a release or deployment is created in Octopus

The Octopus Deploy pack for StackStorm enables you to drive those scenarios with no additional development. StackStorm packs consist of 2 components:

  * **Actions** &#8211; Tasks that can be called from a trigger, e.g. &#8220;Create Release&#8221;
  * **Sensors** &#8211; Processes that run and detect events as _triggers_, e.g. &#8220;New Release&#8221;

### Supported Actions The following actions listed below are supported:

  * Create a new release &#8211; `create_release`
  * Deploy a release to an environment &#8211; `deploy_release`
  * Get a list of releases for a project &#8211; `get_releases`
  * Add a new machine to an environment(s) &#8211; `add_machine`

### Sensors Actions or workflows can be initialized automatically from these sensors:

  * Detect a new release being created &#8211; `new_release_sensor`
  * Detect a new deployment being created &#8211; `new_deployment_sensor`

## Installing the OctopusDeploy integration pack

From the StackStorm console, use the `packs.install` task to download and install the pack:

    st2 pack install octopusdeploy
    

StackStorm packs by _convention_ each have a configuration file for server-wide properties. The Octopus pack needs to be configured first, `update /opt/stackstorm/packs/octopusdeploy/config.yaml` to setup the connection to Octopus. You need to issue an Octopus Deploy API key to integrate the pack. The documentation for this is available on the [Octopus Website][5]. Within `config.yaml`, populate the example properties with your test instance

  * `api_key` &#8211; an API key generated in Octopus for your user
  * `host` &#8211; the hostname of your Octopus server e.g. octopus.mydomain.com
  * `port` &#8211; the port your API service is running on, 443 by default Now, restart the StackStorm services to reload the configurationst2ctl restart

Now you can test in the UI to get releases and versions. Select the actions pane and choose get_releases. Enter the project ID of one of your existing projects and execute the action.

![Screenshot of Octopus Integration][6] 

## A real life example

Got it? Ok, lets look at a more concrete example. Let&#8217;s create a basic rule that detects when a new release or deployment is raised and posts a message in Slack with some details. I&#8217;m going to assume you already have a Slack account, if you haven&#8217;t already installed the Slack pack you can do so now

<pre class="EnlighterJSRAW" data-enlighter-language="null">st2 pack install slack</pre>

Then update /opt/stackstorm/configs/slack.yaml with an authentication token from Slack [using the instructions here][7].

From the console, create a new rule definition using this format:

<pre class="EnlighterJSRAW" data-enlighter-language="null">{
   "name": "octopus_releases",
   "tags": [],
   "enabled": true,
   "trigger": {
       "type": "octopusdeploy.new_release",
       "parameters": {},
       "pack": "octopusdeploy"
    },
   "criteria": {},
   "action": {
       "ref": "slack.post_message",
       "parameters": {
           "username": "anthonypjshaw",
           "message": "{{trigger.author}} created a release {{trigger.version}} in octopus project {{trigger.project_id}} with notes {{trigger.release_notes}}",
           "channel": "#releases"
       } 
   }, 
   "pack": "octopusdeploy"
}</pre>

Import the rule into StackStorm by using the rule create command.

<pre class="EnlighterJSRAW" data-enlighter-language="null">st2 rule create release_rule.json</pre>

Back in the UI you will see your new rule,

![Completed Rule][8] 

When someone has created a new release, you will see the rule action in the History pane:

![Run history][9] 

To detect new deployments, create a new rule

<pre class="EnlighterJSRAW" data-enlighter-language="null">{
    "name": "octopus_deployments",
    "tags": [],
    "enabled": true,
    "trigger": {
         "type": "octopusdeploy.new_deployment",
         "parameters": {},
         "pack": "octopusdeploy"
    },
    "criteria": {},
    "action": {
          "ref": "slack.post_message",
          "parameters": {
                  "username": "anthonypjshaw",
                  "message": "{{trigger.author}} created a deployment {{trigger.version}} in octopus project {{trigger.project_id}}",
                  "channel": "#releases"
          }
    },
    "pack": "octopusdeploy"
}</pre>

And then in Slack you should see a live feed of new releases and deployments within the &#8220;Releases&#8221; channel.

![slack view][10] 

## What&#8217;s next

Now you&#8217;re familiar with the pack and the potential for other integration scenarios, check out some of the other actions you could run in packs like:

  * [Ansible][11], [Salt][12], [Chef][13], [Puppet][14] &#8211; Combining your Octopus workflows with other devops tools
  * [Git][15], [GitHub][16], [Jenkins][17] &#8211; Triggering new releases or deployments from build or source control events
  * [AWS][18], [Azure][19], [LibCloud][20] &#8211; Deploying Octopus tentacles as part of your infrastructure standup
  * [Twitter][21] &#8211; Want to automatically announce new releases of your product to the world?!

 [1]: https://twitter.com/anthonypjshaw
 [2]: http://dimensiondata.com
 [3]: https://github.com/StackStorm-Exchange/stackstorm-octopusdeploy
 [4]: http://www.octopusdeploy.com
 [5]: http://docs.octopusdeploy.com/display/OD/How+to+create+an+API+key
 [6]: http://stackstorm.com/wp/wp-content/uploads/2015/10/st_image2015_9_7_11_37_36.png
 [7]: https://github.com/StackStorm-Exchange/stackstorm-slack/blob/master/README.md
 [8]: http://stackstorm.com/wp/wp-content/uploads/2015/10/st_image2015_9_7_11_46_46.png
 [9]: http://stackstorm.com/wp/wp-content/uploads/2015/10/st_image2015_9_7_12_56_33.png
 [10]: http://stackstorm.com/wp/wp-content/uploads/2015/10/Stack_Slack.png
 [11]: https://github.com/StackStorm-Exchange/stackstorm-ansible
 [12]: https://github.com/StackStorm-Exchange/stackstorm-salt
 [13]: https://github.com/StackStorm-Exchange/stackstorm-chef
 [14]: https://github.com/StackStorm-Exchange/stackstorm-puppet
 [15]: https://github.com/StackStorm-Exchange/stackstorm-git
 [16]: https://github.com/StackStorm-Exchange/stackstorm-github
 [17]: https://github.com/StackStorm-Exchange/stackstorm-jenkins
 [18]: https://github.com/StackStorm-Exchange/stackstorm-aws
 [19]: https://github.com/StackStorm-Exchange/stackstorm-azure
 [20]: https://github.com/StackStorm-Exchange/stackstorm-libcloud
 [21]: https://github.com/StackStorm-Exchange/stackstorm-twitter