---
title: StackStorm Connects DripStat And PagerDuty
author: st2admin
type: post
date: 2015-06-11T16:00:31+00:00
excerpt: '<a href="http://stackstorm.com/2015/06/11/stackstorm-connects-dripstat-and-pagerduty/">READ MORE</a>'
url: /2015/06/11/stackstorm-connects-dripstat-and-pagerduty/
dsq_thread_id:
  - 3840503187
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home

---
**June 11, 2015**

_Guest post by Prashant Deva, Chief Dripper and CTO of_ <a href="http://chrononsystems.com/" target="_blank" rel="noopener noreferrer"><em>Chronon Systems</em></a>_, parent company of_ [_DripStat_][1]_. Earlier this year, Prashant demonstrated_ <a href="http://stackstorm.com/2015/01/27/dripstat-and-stackstorm-unite-to-form-skynet-for-data-centers/" target="_blank" rel="noopener noreferrer"><em>automated responses</em></a> _to OutofMemory exceptions and high GC pause times with StackStorm.  _

A common request among users of the <a href="https://dripstat.com/" target="_blank" rel="noopener noreferrer">DripStat</a> APM is to get their alerts inside PagerDuty. Today we will show how using StackStorm, one can connect DripStat to PagerDuty.  So why bother using StackStorm? Well, StackStorm gives you thousands of integrations plus the ability to tie them together with a rules engine, workflow, audit, a GUI and CLI, API, and more.

StackStorm is like an &#8220;If This, Then That&#8221; but for your operating environment.

Once DripStat informs you that something has gone wrong with the system, you can use StackStorm to automate more and more of your responses to such events and conditions. Thus making a self healing data center.

<!--more-->

## Install StackStorm

Installing StackStorm is easy.  Just enter the following commands on your console and in a few minutes StackStorm will be fully installed.

`curl –q –k –O` `https://downloads.stackstorm.net/releases/st2/scripts/st2_deploy.sh`  
`chmod +x st2_deploy.sh`  
`sudo ./st2_deploy.sh`

`st2 auth testu –p testp`

The above step will output an auth token. Replace its value in the command below:

`export ST2_AUTH_TOKEN=0e51e4d02bd24c2b9dac45e313e9f748`

## Install The DripStat And PagerDuty Packs

StackStorm has the concept of ‘packs’, which are units of functionality specific to a service. Let’s install the packs from DripStat and PagerDuty since we will be connecting them together.

`st2 pack install dripstat,pagerduty`

`cd /opt/stackstorm`

**Edit DripStat Pack config:**

`vi configs/dripstat.yaml`

Enter API key from your DripStat Account

**Edit PagerDuty config:**

`vi configs/pagerduty.yaml`

Enter the API Key and Service Key in this file.

## Create Pack To Connect DripStat To PagerDuty

Now lets create a pack that will hold our script that takes DripStat alerts and forwards them to PagerDuty.

`cd packs`  
`mkdir monitoring`  
`cd monitoring`  
`mkdir actions rules sensors`

**Create file:**

`vi rules/dripstat_alerts_to_pagerduty.yaml`

**Enter the following contents:**

<code class="YAML">name: dripstat_alerts_to_pagerduty&lt;br />
description: “Take all incoming alerts from DripStat and automatically notify on-call person via PagerDuty”&lt;br />
enabled: true&lt;br />
trigger:&lt;br />
type: dripstat.alert&lt;br />
criteria: {}&lt;br />
action:&lt;br />
ref: pagerduty.launch_incident&lt;br />
parameters:&lt;br />
details: “Alert ({{trigger.app_name}}: {{trigger.alert_type}} on {{trigger.jvm_host}} {{trigger.started_at_iso8601}}”&lt;br />
description: “Alert triggered from DripStat on Application – {{trigger.app_name}} started at {{trigger.started_at_iso8601}}. Affected host: {{trigger.jvm_host}}. Alert message: {{trigger.alert_type}}”&lt;br />
</code>

**Now just do:**

`st2ctl reload --register-all`

And that’s it. You are good to go!

## And More…

Within just a few minutes you now have <a href="https://dripstat.com/" target="_blank" rel="noopener noreferrer">DripStat</a> alerts going into PagerDuty. You can use the knowledge in this tutorial to connect DripStat with all the other services that StackStorm supports too. For example, you can have it:

  * Create an issue in Jira upon alert trigger
  * Attach the exact github commit of the deploy that caused the alert
  * Alert folks on SMS using Twilio
  * Move your application automatically to a bigger box
  * As <a href="http://stackstorm.com/2015/01/27/dripstat-and-stackstorm-unite-to-form-skynet-for-data-centers/" target="_blank" rel="noopener noreferrer">explained</a> earlier this year, auto remediate OutOfMemory exceptions and highGC pause times
  * Use ChatOps &#8211; StackStorm <a href="http://stackstorm.com/2015/06/08/enhanced-chatops-from-stackstorm/" target="_blank" rel="noopener noreferrer">recently released some capabilities</a> that should make ChatOps easier to manage and extend.

And much, much more. The more you automate, the more robust your infrastructure and your application.  With StackStorm it is simple to implement high degrees of automation without the sense of a giant basket of technical debt hanging over you.

Take a look.  Feedback welcome. Check out <a href="https://dripstat.com/" target="_blank" rel="noopener noreferrer">DripStat</a>, if you haven’t already.  I’m at <a href="https://twitter.com/pdeva" target="_blank" rel="noopener noreferrer">@pdeva</a>  &#8211; and we can also be reached at [@dripstat][2].

If you have questions about <a href="http://stackstorm.com/" target="_blank" rel="noopener noreferrer">StackStorm</a> there is an active community on Slack at [#community][3], over on IRC on Freenode at <a href="http://webchat.freenode.net/?channels=#stackstorm" target="_blank" rel="noopener noreferrer">#StackStorm</a>.  Or email them on <a href="mailto:support@stackstorm.com" target="_blank" rel="noopener noreferrer">support@stackstorm.com</a>  or ping them on <a href="https://twitter.com/Stack_Storm" target="_blank" rel="noopener noreferrer">@stack_storm</a> (note the underscore).

&nbsp;

 [1]: https://dripstat.com/
 [2]: https://twitter.com/dripstat
 [3]: https://stackstorm-community.slack.com/messages/C066APT88/