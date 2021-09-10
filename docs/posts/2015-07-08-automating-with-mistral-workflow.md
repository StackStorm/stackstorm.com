---
title: Automated Troubleshooting With StackStorm and Mistral
author: Dmitri Zimine
type: post
date: 2015-07-09T01:14:05+00:00
excerpt: '<a href="http://stackstorm.com/?p=3779" target="_blank">READ MORE</a>'
url: /2015/07/08/automating-with-mistral-workflow/
dsq_thread_id:
  - 3978396801
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Blog
  - Tutorials
tags:
  - tutorial

---
**July 08, 2015**  
_by Dmitri Zimine_

Recently someone on #stackstorm IRC asked how to build a simple troubleshooting automation: _&#8220;on cron, ping a server, and dump the stats to the log for analytics; post the failure to Slack immediately if the ping fails.&#8221;_ Our short answer was _&#8220;use Mistral workflow&#8221;._ In this post, I&#8217;ll use this simple case to walk you through the details of setting up a basic automation, powered by Mistral workflow.

[Mistral][1] is a workflow service that we help develop upstream in OpenStack. It gives features and reliability that are missing in simple workflows like our own ActionChain or Ansible&#8217;s (details in [&#8220;Return of workflows&#8221;][2]). Mistral comes embedded and supported with StackStorm.

The scenario I use here is obviously simplification: in a typical deployment, monitoring is set up to do heavy-lifting on issue identifications, and a variety of devops tools are used to troubleshoot and remediate issues. StackStorm gives a [fair bunch of lego-blocks][3] to integrate existing devops tools, and build more realistic automation workflows. Yet, the production development flow and the patterns are going to be just as in this simple example.

I&#8217;ll take an opportunity to go over some basics of using StackStorm. It&#8217;s all [documented][4], but doesn&#8217;t hurt to repeat some in context, and share my tips and tricks.

For you impatient kinds: the final version is available as a pack on GitHub, [made-ready to install][5].

<!--more-->

## Getting started.

Note: I am using version 0.12.dev. It relies on some recent fixes and may need adjustment to work on stable 0.11. If you can, do the same! StackStorm moves ahead fast. Live on the edge, use the &#8216;latest&#8217;, report problems, we&#8217;ll fix them!

The easiest way to hack around StackStorm is with [st2workroom][6]. Clone it and follow instructions to bring up `st2express`. To set up the &#8216;latest&#8217; version, be sure to specify it (e.g., 0.12dev) in `hieradata/workroom.yaml`. st2workroom takes ~10 minutes to set up at first, but the up-shot is it makes it easy to stay updated &#8211;`vagrant provision st2express` will get you the newest bits. Another convenience with st2workroom is the mapping of stackstorm content from /opt/stackstorm/packs to the host machine&#8217;s Vagrant folder under `artifacts`, so you I can use my favorite code editor while following along. Connect to the vm with `vagrant ssh st2express`, and fire a few commands from [Quick Start][7] to make sure everything is up and running. The WebUI should be available at [http://172.168.50.11:8080][8].

It&#8217;s perfectly fine to use StackStorm &#8220;all-in-one&#8221; [installation with `st2_deploy.sh latest`][9], or by other [supported ways][10].

A helpful idea is to [install examples][11]. It has a few tested Mistral workflows to use as a reference or a starting point.

## Install Slack pack

We will need a Slack action. Luckily, [Slack pack][12] is already among community integration packs, with good instructions. For those who&#8217;s not drunk Slack kool-aid, [IRC pack][13] is available; the whole example can be done with IRC instead of Slack.

Install the &#8220;Slack&#8221; pack.

    st2 pack install slack
    

Follow the [instructions][12], configure Slack plugin to talk to your room (I just used my token as suggested in his readme), and test it out:

    st2 run slack.post_message message="hey?"
    

## Create a simple Mistral workflow action

Let&#8217;s start by creating a simple Mistral workflow, with a single task, that runs `ping` to a single host via `core.local` action. I&#8217;ll do it in `default` pack.

#### 1. Create action meta data

    # opt/stackstorm/default/actions/ping.yaml
    ---
    name: ping
    pack: default
    description: Simple ping based diagnostic with Mistral.
    runner_type: mistral-v2 # Yes, the runner is Mistral
    entry_point: workflows/ping.yaml # Reference to workflow definition.
    enabled: True
    parameters:
      host: # We start with a single host
        required: true
        type: string
    

#### 2. Create a Mistral workflow definition file

We start with one step, simplest-possible Mistral workflow. It has one task, to ping the host, using out-of-box `core.local` action, which executes an arbitrary shell script.

    # opt/stackstorm/default/actions/workflows/ping.yaml
    version: '2.0'
    
    default.ping: # IMPORTANT: the name of the workflow must match the fully-qualified action ref
        description: st2 default.ping # Let's skip the description as I already put it in action meta.
        input:
            - host # This must match to action input.
    optimizing it.
        tasks:
            ping_host:
                action: core.local cmd="ping -c 4 -W 1 <% $.host %>"
    
    

Note that workflow name must match the fully qualified action ref, `default.ping` in our case. Also, the workflow input must match action input parameters.

#### 3. Register the action

    st2 action create ping.yaml
    

#### 4. Check that it all works

    st2 action list --pack=default
    st2 run default.ping host=mail.ru
    

#### Tips:

  * `st2 execution list -n 5` &#8211; list 5 last action executions. Note that workflows are marked with +; 
  * `st2 exectution get 5591bbc89c993801f5836dc3` &#8211; get info on specific execution, using execution ID from the previous command&#8217;s output.
  * `st2 exectution get -d -j 5591bbc89c993801f5836dc3` &#8211; prints out detailed workflow execution as JSON. It contains workflow execution task list and output. 
  * `st2 execution re-run 5591bbc89c993801f5836dc3` &#8211; re-runs execution with same input. Allows to modify selected input parameters. Not a biggie in our little example, but becomes really convenient when workflow takes more input parameters. (Ok, hopefully enough to make you motivated to explore command line options with `--help`, or going over [CLI 101][14]).
  * When it comes to inspecting history, WebUI comes handy with live updates, hierarchical view of executions, and quick navigation between tasks. 

## Add workflow steps

Good news: now that the action plumbing is setup, hacking the workflow is easy. Just edit the workflow file `actions/workflows/ping.yaml` and run the action! StackStorm validates, uploads, and executes the modified workflow. No need to update the action or reload the content, unless we change the action name, signature, or other metadata in `actions/ping.yaml`.

Let&#8217;s add two more tasks to the workflow. It will look like this:

    version: '2.0'
    
    default.ping: 
        description: st2 default.ping
        input:
            - host
    optimizing it.
        output:
            just_output_the_whole_worfklow_context: <% $ %>
            # Output defines what workflow action returns.
            # We'll figure later what output we'll need, if anything.
            # For now, just publish the whole workflow end-state. Helps debugging.
    
        tasks:
            ping_host:
                action: core.local cmd="ping -c 1 -w 1 <% $.host %>"
                publish:
                    ping_output: <% $.ping_host.stdout %>
                on-success: append_stats
                on-error:
                    - post_error_to_slack
                    - fail # Set workflow to "FAILED" explicitly.
    
            append_stats:
                action: core.local
                input:
                    cmd: printf "\n\n%s\n%s\n" "`date`" "<% $.ping_output %>" >> /tmp/ping.log
    
            post_error_to_slack:
                action: slack.post_message
                input:
                    message: |
                        No ping to <% $.host %>. Check it out:
                        http://172.168.50.11:8080/#/history/<% $.__env.st2_execution_id %>
    
    

If `ping_host` tasks succeeds, workflow moves to `append_status` task, which appends a timestamp and output of ping to a text file.

If `ping_host` tasks fails, workflow moves to `post_error_to_slack` task that posts a Slack message with the URL so that one can jump to the execution record of the failed action in WebUI. It also forces workflow to fail &#8211; a useful pattern to handle failures: it prevents workflow engine from scheduling more tasks if we had more, and marks it clear in the execution history that it was not desired path.

Run, play and experiment.

  * `st2 run default.ping host=mail.ru` &#8211; the ping shall likely succeed, and the record shall be added to the file.
  * `st2 run default.ping host=1.2.3.4` &#8211; the ping shall fail, and throw a link into a Slack channel.

#### More tips:

  * Note the two ways of passing parameters to action: inline, and with `input` keyword. Inline is handy for brevity; `input` comes handy when a complex parameter needs passing. 
  * **YAQL:** These expressions between `<% %>` brackets are YAQL, Yet Another Query Language. It&#8217;s used to refer the workflow context data. It&#8217;s basically JSONPath with extensions. We like it as it preserves the types, and allows to do stuff like this `<% $.results[0].vmlist.id %>`, which returns a list of vm IDs from vm. You will love it, once OpenStack folks will document it (they have been saying, &#8220;soon&#8221;).
  * Referencing data: `<% $ %>` points to the root of current context. Context contains workflow input (e.g. `<% $.host %>`, published variables `<% $.ping_output %>`, and task results, published under task as key: `<% $.ping_host.stdout %>`
  * YAQL Gotcha: equal is `=`, not `==`; `<% 1+1 = 3 %>` evaluates to False.
  * Tip: publish the full execution context, `<% $ %>`, into the workflow output, and inspect it in execution history. Good for learning and debugging. 
        ... 
        input:
            - host
        output:
            just_output_the_whole_worfklow_context: <% $ %>
        tasks:
        ...
        

  * Parameters.  
    There are multiple ways to set up parameters, like base URL, or log file location. Set them as parameters in action metadata. Or use st2 datastore, and make the first task of the workflow read and publis them ([here&#8217;s an example][15]).</p> 

## Create a rule

Let&#8217;s now run this workflow on timer, just like cron.

  * `st2 trigger list` &#8211; take a look of what triggers are available for use in a rule.
  * `st2 trigger get core.st2.CronTimer` &#8211; the CronTimer looks like the right one, let&#8217;s look at it. We&#8217;ll use it in a rule. Create a rule file under `/opt/stackstorm/packs/default/rules`. I&#8217;ll set it up to run just a bit ahead of time from the current time, using `date -u`. 

    # /opt/stackstorm/packs/default/rules/ping.hourly.yaml
    ---
    name: ping.on_cron
    pack: "default"
    description: Fire a ping diagnostic workflow regularly.
    trigger:
        type: core.st2.CronTimer
        parameters:
            timezone: "UTC"
            hour: 0
            minute: 10
            second: 0
    criteria: {}
    action:
        ref: default.ping
    enabled: true
    

  * `st2 rule create ping.hourly.yaml` &#8211; create the rule, and just wait a min till it fires an action. Or not&#8230; Stare at the web UI history page; it should appear there sooooon&#8230;. And here it goes!

Now I can set up the desired time, and get it running automatically, on schedule. Edit the file, set the desired cron pattern, and update the rule:

    st2 rule update default.ping.on_cron ping.hourly.yaml
    

![Create rule in Web UI][16] 

Note that the rule can be easily created and editing from the Web client. Watch me do it. Web client comes especially handy when , with live updates, fast navigation between executions and showing details on the results.

## Turn it into a pack

This seems longer than it is, for I am giving excruciating details. The truth is, making a packs is easy, the only hitch is updating all the names and references to the old pack name. Here it is, step-by-step:

  1. Create a new empty pack and initialize git: 
        cd /opt/stackstorm/packs/
        git init st2mistral101
        cd st2mistral101
        touch README.md
        

  2. Create pack definition file. 
        # /opt/stackstorm/st2101/pack.yaml
        ---
        name : st2101 # Name must match the folder name
        description : StackStorm samples and tutorials
        version : 0.1
        author : dzimine
        email : dz@stackstorm.com
        

  3. Copy the files: 
        cd /opt/stackstorm/packs/default
        mkdir ../st2mistral101
        cp --parents actions/ping.yaml ../st2mistral101/
        cp --parents actions/workflows/ping.yaml ../st2mistral101/
        cp --parents rules/ping.on_cron.yaml ../st2mistral101/
        

  4. Update the files, changeing the pack from `default` to `st2_101`: 
      * in `action/ping.yaml`, change to `pack: st2_101`.
      * in `action/workflows/ping.yaml` workflow definition, rename workflow from `default.ping` to `st2_101.ping`;
      * in `rules/ping.hourly.yaml`, change to `pack: st2_101`, and also rename the ping action reference: from `ref: default.ping` to `ref: st2_101.ping`.
  5. Get the context loaded, check it is there and working 
        st2ctl reload st2ctl reload --register-actions --register-rules
        st2 rule list --pack=st2_101
        st2 rule actions --pack=st2_101
        st2 run st2_101.ping host=mail.ru
        

  6. Add README.md. Seriously, any good pack requires good description.</p> 
  7. [Push to GitHub][17]

In the next step, let&#8217;s test that it all works. Uninstall the pack (it&#8217;ll do all unregistration, and delete local files).

    st2 run packs.uninstall packs=st2_101
    

Now get it from GitHub.

<a name="install_example"></p> 

<h2>
  Install this example pack from GitHub
</h2>

<p>
  </a>
</p>

<p>
  The full example can now be easily installed as a pack:
</p>

<pre><code>st2 run packs.install packs=st2_101 repo_url=https://github.com/dzimine/st2_101.git
</code></pre>

<p>
  That&#8217;s it! Note that <code>packs.install</code> doesn&#8217;t load the rules by default. You can either supply <code>register:all</code> key, or add rules later at your convenience with <code>st2 rule create</code>.
</p>

<h2>
  What&#8217;s next?
</h2>

<p>
  Congratulations, you have completed end-to-end workflow based automation with StackStorm! This should get you on the path of using Mistral workflows with StackStorm. And hopefully, it unleashes your imagination on how to build real automations for your operations, with actions, workflows, and rules.
</p>

<p>
  Be sure to check out &#8220;Actions of All Flavors&#8221;(http://stackstorm.com/2015/04/20/actions-of-all-flavors-in-stackstorm) or <a href="http://stackstorm.com/2014/12/22/monitor-twitter-and-fire-automations-based-on-twitter-keywords-using-stackstorm/">&#8220;Monitor Twitter and Fire an Action&#8221;</a> tutorials. More is coming up. Let us know about your experience &#8211; leave comments, or bring your questions and feedback:
</p>

<ul>
  <li>
    IRC: <a href="http://webchat.freenode.net/?channels=stackstorm">#stackstorm on freenode.org</a>
  </li>
  <li>
    StackStorm Slack channel <a href="https://stackstorm-community.slack.com">https://stackstorm-community.slack.com</a>
  </li>
  <li>
    <a href="mailto:support@stackstorm.com">support@stackstorm.com</a>
  </li>
</ul>

 [1]: https://github.com/openstack/mistral
 [2]: http://stackstorm.com/2015/04/10/the-return-of-workflows/
 [3]: https://exchange.stackstorm.org
 [4]: http://docs.stackstorm.com/latest/
 [5]: #install_example
 [6]: https://github.com/StackStorm/st2workroom/
 [7]: http://docs.stackstorm.com/start.html
 [8]: http://172.168.50.11:8080/
 [9]: http://docs.stackstorm.com/install/index.html#installation
 [10]: http://docs.stackstorm.com/install/index.html
 [11]: http://docs.stackstorm.com/start.html#deploy-examples
 [12]: https://github.com/StackStorm-Exchange/stackstorm-slack
 [13]: https://github.com/StackStorm-Exchange/stackstorm-irc
 [14]: http://docs.stackstorm.com/cli.html
 [15]: https://github.com/StackStorm/st2incubator/blob/master/packs/autoscale/actions/workflows/asg_deflate.yaml#L24-L31
 [16]: http://i.imgur.com/E4uM1U6.gif
 [17]: https://help.github.com/articles/adding-an-existing-project-to-github-using-the-command-line/