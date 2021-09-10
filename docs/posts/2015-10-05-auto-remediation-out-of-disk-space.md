---
title: 'Auto-remediation by example: handling out-of-disk-space.'
author: Dmitri Zimine
type: post
date: 2015-10-05T22:59:54+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/10/05/auto-remediation-out-of-disk-space/
dsq_thread_id:
  - 4197918885
tcb2_ready:
  - 1
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Tutorials
tags:
  - Auto-remediation
  - tutorial

---
**October 5, 2015**  
_by Dmitri Zimine, Patrick Hoolboom_

A host is running out of disk space. What follows is a routine pager panic and rush in cleaning things up, at best. At worst, downtime. It is silly, but it happens much more than most of us care to admit.

This, and many other annoying events like this can, and shall be auto-remediated. The &#8220;classic&#8221; pattern of wiring monitoring to and paging is simply not good enough, and know it when you&#8217;re paged at 3am to clean the disk on production server.

And to those of you who hard-wire their remediation scripts into Nagios/Sensu event handlers, Splunk alert scripts and NewRelic web hooks: it is plain wrong there&#8217;s a better way.

In this blog, we show how StackStorm auto-remediation platform helps you hand out-of-disk case, with step-by-step walk-through and a working automation sample to kick-start your auto-remediation.

<!--more-->

If you&#8217;re in the hurry, grab the automation code in [st2_demos][1] and run it on your StackStorm instance.

<pre class="EnlighterJSRAW" data-enlighter-language="null">st2 pack install https://github.com/StackStorm/st2_demos
</pre>

For the rest, let’s walk through the three steps of setting auto-remediation with StackStorm. First, configure the integrations with monitoring and paging system, Second, define your auto-remediation workflow, “runbook as code”. Third, create a rule mapping event to auto-remediation.

### 1. Set up the integrations.

Install [sensu][2] and [victorops][3] pack from [StackStorm Exchange][4]:

<pre class="EnlighterJSRAW" data-enlighter-language="null">st2 pack install sensu victorops
</pre>

Configure to point to your Sensu and Victorops `/opt/stackstorm/configs/sensu.yaml` and `/opt/stackstorm/configs/victorops.yaml.`Or just run `st2 pack config sensu` and `st2 pack config victorops`, and answer the questions. Follow the detailed instructions on [sensu pack][2] to send Sensu events to StackStorm. If you are on Nagios, NewRelic, Splunk, or other monitoring &#8211; pick the integration for your tool. New integrations are easy to build, we welcome and support your contributions. Likewise, if you happen to use PagerDuty &#8211; grab and configure [pagerduty pack][5].

In this example ChatOps with Slack is used to post updates and fire commands. If you&#8217;re on HipChat or IRC or some other chat, or still prefer Email or SMS or JIRA for notifications &#8211; adjust accordingly.

### 2. Design your auto-remediation action.

This is yours to define. Our example here is &#8220;if disk is filled up with log files, just prune them, if it&#8217;s something else, wake me up&#8221;. Read the workflow code from [diskspace_remediation.yaml][6], it&#8217;s self-explanatory. Note that action results are passed down the flow.

<pre class="EnlighterJSRAW" data-enlighter-language="null">---
version: '1.0'
input:
  - hostname
  - directory
  - file_extension
  - threshold
  - event_id
  - check_name
  - alert_message
  - raw_payload
tasks:
  silence_check:
    action: sensu.silence
    input:
      client: &lt;% ctx().hostname %&gt;
      check: &lt;% ctx().check_name %&gt;
    next:
      - when: '{{ succeeded() }}'
        do:
          - check_dir_size
      - when: '{{ failed() }}'
        do:
          - post_error_to_slack
  check_dir_size:
    action: st2_demos.check_dir_size
    input:
      hosts: &lt;% ctx().hostname %&gt;
      directory: &lt;% ctx().directory %&gt;
      threshold: &lt;% ctx().threshold %&gt;
    next:
      - when: '{{ succeeded() }}'
        do:
          - post_error_to_slack
      - when: '{{ failed() }}'
        do:
          - remove_files
  remove_files:
    action: core.remote_sudo
    input:
      hosts: &lt;% ctx().hostname %&gt;
      cmd: rm -Rfv &lt;% ctx().directory %&gt;/*&lt;% ctx().file_extension %&gt;
    next:
      - when: '{{ succeeded() }}'
        do:
          - validate_dir_size
      - when: '{{ failed() }}'
        do:
          - post_error_to_slack
  validate_dir_size:
    action: st2_demos.check_dir_size
    input:
      hosts: &lt;% ctx().hostname %&gt;
      directory: &lt;% ctx().directory %&gt;
      threshold: &lt;% ctx().threshold %&gt;
    next:
      - when: '{{ succeeded() }}'
        do:
          - post_success_to_slack
      - when: '{{ failed() }}'
        do:
          - post_error_to_slack
  post_success_to_slack:
    action: chatops.post_message
    input:
      channel: '#demos'
      message: "DemoBot has pruned &lt;% ctx().directory %&gt; on &lt;% ctx().hostname %&gt; due to a monitoring event.  ID: &lt;% ctx().event_id %&gt;\nhttps://st2demo004/#/history/&lt;% ctx().st2.action_execution_id %&gt;/general"
  post_error_to_slack:
    action: chatops.post_message
    input:
      channel: '#demos'
      message: "Something has gone wrong with DemoBot - check https://st2demo004/#/history/&lt;% ctx().st2.action_execution_id %&gt;/general"

</pre>

Define your workflow your way. Your environment, tools and run books are special. You may want to move files to s3 instead of deleting. Or provision and attach an extra volume. Or check for few other suspects before paging. And your logic will differ dependent on server role. Please yourself, mix and match your scripts with existing building blocks in the workflow that works for your case.

If you are on [StackStorm Enterprise][7]: the workflow graphical editor, Workflow Designer, will help create and visualize the workflows. Here is how the our sample diskspace remediation looks in Workflow Designer:

[<img loading="lazy" width="1314" height="853" class="alignnone wp-image-4629" src="http://stackstorm.com/wp/wp-content/uploads/2015/10/flow_diskspace_remediation.png" alt="flow_diskspace_remediation" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/10/flow_diskspace_remediation.png 1314w, https://stackstorm.com/wp/wp-content/uploads/2015/10/flow_diskspace_remediation-300x195.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/10/flow_diskspace_remediation-1024x665.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/10/flow_diskspace_remediation-1080x701.png 1080w" sizes="(max-width: 1314px) 100vw, 1314px" />][8]

![Editing diskspace_remediation.yaml in Flow][8] 

### 3.Create a rule.

Create a rule: if monitoring event triggers, fire the remediation action. The rule definition code shown below. Note that the trigger payload is parsed, used in criteria, and passed in action input.

<pre class="EnlighterJSRAW" data-enlighter-language="null">---
# rules/diskspace_remediation.yaml
    name: "diskspace_remediation"
    pack: "st2_demos"
    description: "Clean up disk space on critical monitoring event."
    enabled: true
    trigger:
        type: "sensu.event_handler"
    criteria:
        trigger.check.status:
            pattern: 2
            type: "equals"
        trigger.check.name:
            pattern: "demo_diskspace"
            type: "equals"
    action:
        ref: "st2_demos.diskspace_remediation"
        parameters:
            hostname: "{{trigger.client.name}}"
            directory: "{{system.logs_dir}}"
            threshold: "{{system.logs_dir_threshold}}"
            event_id: "{{trigger.id}}"
            check_name: "{{trigger.check.name}}"
            alert_message: "{{trigger.check.output}}"
            raw_payload: "{{trigger}}"
</pre>

If you like StackStorm&#8217;s slick UI, you can use it to create the rule. Or use CLI:

<pre class="EnlighterJSRAW" data-enlighter-language="null">st2 rule create rules/diskspace_remediation.yaml
</pre>

### Profit!

Create a large file (an action in our sample pack does this for you), and see how StackStorm fires the actions. If you create the large file somewhere else, check that you&#8217;ll get an incident in VictorOps. Now that you know it works, enjoy: this irritating &#8220;out-of-disk space&#8221; problems will be auto-fixed before the page would even reach you.

And one more key thing: Manage your automation as code. Create an automation pack &#8211; just as we did with [st2_demos][1], commit to git, review, and deploy by `st2 pack install`. Or share it on github and exchange auto-remediation patterns and run books with your fellow devops &#8211; as code!

Hope this gives you a good start on the path to auto-remediation. At first, setting up StackStorm just for the sake of one simple integration may seem an overkill. But now that you have it all set up, adding automations is easy, almost addictive. Soon you&#8217;ll enjoy the compound value of rich action library, automation control plain under source control, and auto-remediations that keep your pager from going off at night.

And did you drink ChatOps cool-aid? Check what it can do for your operations, like [these guys did][9], and stay tuned for our next blogs!

 [1]: https://github.com/StackStorm/st2_demos
 [2]: https://github.com/StackStorm-Exchange/stackstorm-sensu
 [3]: https://github.com/StackStorm-Exchange/stackstorm-victorops
 [4]: https://exchange.stackstorm.org
 [5]: https://github.com/StackStorm-Exchange/stackstorm-pagerduty
 [6]: https://github.com/StackStorm/st2incubator/blob/master/packs/st2-demos/actions/workflows/diskspace_remediation.yaml
 [7]: https://stackstorm.com/product/#enterprise
 [8]: http://stackstorm.com/wp/wp-content/uploads/2015/10/flow_diskspace_remediation.png
 [9]: https://stackstorm.com/2015/08/14/user-story-stackstorm-workflows-and-chatops/