---
title: Ansible and ChatOps. Get started 🚀
author: Eugen C.
type: post
date: 2015-06-24T20:16:09+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/06/24/ansible-chatops-get-started-🚀/
dsq_thread_id:
  - 3875968587
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home
  - Tutorials
tags:
  - ansible
  - chatops
  - hubot
  - slack
  - vagrant

---
**June 25, 2015** <em style="float: right;">(Updated: February 21, 2017)</em>  
_Contribution by Integration Developer <a href="https://de.linkedin.com/pub/eugen-c/82/670/793" target="_blank" rel="noopener noreferrer">Eugen C.</a>_

![Ansible and ChatOps with StackStorm event-driven automation platform, Slack, Hubot][1] 

## What is ChatOps? {#what-is-chatops}

> ChatOps brings the context of work you are already doing into the conversations you are already having. <a href="https://twitter.com/jfryman" target="_blank" rel="noopener noreferrer">@jfryman</a>

ChatOps is still a fresh and uncommon thing in the DevOps world, where work is brought into a shared chat room. You can run commands directly from chat and everyone in the chatroom can see the history of work being done, do the same, interact with each other and even learn. The information and process is owned by the entire team which brings a lot of benefits.

<!--more-->

You may come up with operations such as deploying code or provisioning servers from chat, viewing graphs from monitoring tools, sending SMS, controlling your clusters, or just running simple shell commands. ChatOps may be a high-level representation of your really complex CI/CD process, bringing simplicity with chat command such as: `!deploy`. This approach does wonders to increase visibility and reduce complexity around deploys.

## ChatOps Enhanced {#chatops-enhanced}

<a href="https://stackstorm.com/" target="_blank" rel="noopener noreferrer">StackStorm</a> is an OpenSource project particularly focused on event-driven automation and ChatOps. The platform wires dozens of DevOps tools such as configuration management, monitoring, alerting, graphing and so on together, allowing you to rule everything from one control center. It is a perfect instrument for ChatOps, providing the opportunity to build and automate any imaginable workflows and operate any sets of tools directly from chat.

StackStorm has <a href="https://stackstorm.com/2015/06/05/new-in-stackstorm-ansible-integration/" target="_blank" rel="noopener noreferrer">Ansible integration</a> and during time added a lot of enhanced ChatOps features in [<1.0][2], [1.2][3] and [1.4][4] platform versions to help you with real work, not just display funny kitten pics from chat. Below, I will cover how to make ChatOps and Ansible possible with help of the StackStorm platform.

> By the way, StackStorm as Ansible is declarative, written in Python and uses YAML + Jinja, which will make our journey even easier.

## The Plan {#the-plan}

In this tutorial we&#8217;re going to install Ubuntu 14 control machine first, which will handle our ChatOps system. Then configure StackStorm platform, including Ansible integration pack. Finally, we&#8217;ll connect the system with Slack, and show some simple, but real examples of Ansible usage directly from chat in an interactive way.

So let&#8217;s get started and verify if we&#8217;re near to <a href="https://en.wikipedia.org/wiki/Technological_singularity" target="_blank" rel="noopener noreferrer">technological singularity</a> by giving root access to chat bots and allowing them to manage our 100+ servers and clusters.

## Step 0. Prepare Slack {#step-0}

As said before, let&#8217;s use <a href="https://slack.com/" target="_blank" rel="noopener noreferrer">Slack.com</a> <span class="gmw_">for chat. Register for a Slack account if you don&#8217;t have one yet. Enable <span class="gm_ gm_095f68db-2eb5-32bf-af4e-7cbd9d5f05c9 gm-spell">Hubot</span> integration in settings.</span>

> <a href="https://hubot.github.com/" target="_blank" rel="noopener noreferrer">Hubot</a> is GitHub&#8217;s bot engine built for ChatOps.

![Enable Hubot integration in Slack][5]  
Once you&#8217;re done, you&#8217;ll have an API Token:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-api-token-sh" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-shell  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-api-token-sh-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-api-token-sh-LC1" class="blob-code blob-code-inner js-file-line">
                  HUBOT_SLACK_TOKEN=xoxb-5187818172-I7wLh4oqzhAScwXZtPcHyxCu
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

Next, we&#8217;ll configure the entire StackStorm platform, show some useful examples as well as allow you to craft your own ChatOps commands.

But wait, there is a simple way!

## Lazy Mode! {#vagrant-demo}

For those who are lazy (most DevOps are), here&#8217;s a Vagrant repo which installs all the required tools within simple provision scripts, bringing you to the finish point and ready to write ChatOps commands in Slack chat: <a href="https://github.com/StackStorm/showcase-ansible-chatops" target="_blank" rel="noopener noreferrer">https://github.com/StackStorm/showcase-ansible-chatops</a>  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-0-vagrant-sh" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-shell  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-0-vagrant-sh-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-0-vagrant-sh-LC1" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-c"><span class="pl-c">#</span> replace with your token</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-0-vagrant-sh-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-0-vagrant-sh-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">export</span> HUBOT_SLACK_TOKEN=xoxb-5187818172-I7wLh4oqzhAScwXZtPcHyxCu
                </td>
              </tr>
              
              <tr>
                <td id="file-0-vagrant-sh-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-0-vagrant-sh-LC3" class="blob-code blob-code-inner js-file-line">
                  git clone https://github.com/StackStorm/showcase-ansible-chatops.git
                </td>
              </tr>
              
              <tr>
                <td id="file-0-vagrant-sh-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-0-vagrant-sh-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-c1">cd</span> showcase-ansible-chatops
                </td>
              </tr>
              
              <tr>
                <td id="file-0-vagrant-sh-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-0-vagrant-sh-LC5" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-0-vagrant-sh-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-0-vagrant-sh-LC6" class="blob-code blob-code-inner js-file-line">
                  vagrant up
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

For those who are interested in details &#8211; let&#8217;s switch to manual mode and go further. But remember if you get stuck &#8211; verify your results with examples provided in [ansible & chatops showcase repo][6].

## Step 1. Install StackStorm {#step-1}

It&#8217;s really as simple as one command:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-1-1-install-st2-sh" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-shell  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-1-1-install-st2-sh-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-1-1-install-st2-sh-LC1" class="blob-code blob-code-inner js-file-line">
                  curl -sSL https://stackstorm.com/packages/install.sh <span class="pl-k">|</span> sudo bash -- --user=demo --password=demo
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

> This one-liner is for demonstration purposes only, for prod deployments you should use [ansible playbooks][7] to install st2, verify signatures and so on. See <https://docs.stackstorm.com/install/deb.html> to understand what&#8217;s happening under the hood.

## Step 2. Install Ansible Integration pack {#step-2}

The idea of integration packs in StackStorm is that they connect system with external tools or services. We need Ansible pack here:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-2-1-install-ansible-sh" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-shell  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-2-1-install-ansible-sh-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-2-1-install-ansible-sh-LC1" class="blob-code blob-code-inner js-file-line">
                  st2 pack install ansible
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

  
Besides pulling [Ansible Integration pack][8], it installs ansible binaries into Python virtualenv located in `/opt/stackstorm/virtualenvs/ansible/bin`.

> See the full list of StackStorm Integration Packs at [exchange.stackstorm.org][9]. Between them: `AWS`, `GitHub`, `RabbitMQ`, `Pagerduty`, `Jenkins`, `Docker`, &#8211; overall more than 100+!

## Step 3. Configure ChatOps {#step-3}

Now you need to configure the `/opt/stackstorm/chatops/st2chatops.env` file to suit your needs. It worth taking a look at all variables, but make sure you edit the following envs first:

<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-3-1-st2chatops-env-sh" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-shell  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC1" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-c"><span class="pl-c">#</span> Bot name</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">export</span> HUBOT_NAME=stanley
                </td>
              </tr>
              
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">export</span> HUBOT_ALIAS=<span class="pl-s"><span class="pl-pds">'</span>!<span class="pl-pds">'</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC4" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-c"><span class="pl-c">#</span> StackStorm API key</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC6" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-c"><span class="pl-c">#</span> Use: `st2 apikey create -k` to generate</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-c"><span class="pl-c">#</span> Replace with your key (!)</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC8" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">export</span> ST2_API_KEY=<span class="pl-s"><span class="pl-pds">"</span>123randomstring789<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC9" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-c"><span class="pl-c">#</span> ST2 AUTH credentials</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-c"><span class="pl-c">#</span> Replace with your username/password (!)</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC12" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">export</span> ST2_AUTH_USERNAME=<span class="pl-s"><span class="pl-pds">"</span>demo<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">export</span> ST2_AUTH_PASSWORD=<span class="pl-s"><span class="pl-pds">"</span>demo<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC14" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC15" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-c"><span class="pl-c">#</span> Configure Hubot to use Slack</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">export</span> HUBOT_ADAPTER=<span class="pl-s"><span class="pl-pds">"</span>slack<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC17" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC18" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-c"><span class="pl-c">#</span> Replace with your token (!)</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-3-1-st2chatops-env-sh-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-3-1-st2chatops-env-sh-LC19" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">export</span> HUBOT_SLACK_TOKEN=<span class="pl-s"><span class="pl-pds">"</span>xoxb-5187818172-I7wLh4oqzhAScwXZtPcHyxCu<span class="pl-pds">"</span></span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

Restart `st2chatops` to apply the changes, and you&#8217;re ready to go:

<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-3-2-restart-st2chatops-sh" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-shell  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-3-2-restart-st2chatops-sh-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-3-2-restart-st2chatops-sh-LC1" class="blob-code blob-code-inner js-file-line">
                  sudo service st2chatops restart
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

## Step 4. First ChatOps {#step-4}

At this point you should see Stanley bot online in chat. Invite him into your Slack channel:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-4-1-first-chatops-txt" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-4-1-first-chatops-txt-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-4-1-first-chatops-txt-LC1" class="blob-code blob-code-inner js-file-line">
                  /invite @stanley
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

Get the list of available commands:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-4-2-first-chatops-txt" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-4-2-first-chatops-txt-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-4-2-first-chatops-txt-LC1" class="blob-code blob-code-inner js-file-line">
                  !help
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

I bet you&#8217;ll love [`shipit`][10]:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-4-3-first-chatops-txt" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-4-3-first-chatops-txt-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-4-3-first-chatops-txt-LC1" class="blob-code blob-code-inner js-file-line">
                  !ship it
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

After playing with existing commands, let&#8217;s continue with something serious.

## Step 5. Crafting Your Own ChatOps Commands {#step-5}

One of StackStorm features is the ability to create command aliases, simplifying your ChatOps experience. Instead of writing long command, you can just bind it to something more friendly and readable, simple sugar wrapper.

Let&#8217;s create our own StackStorm pack which will include all needed commands. Fork <a href="https://github.com/StackStorm/st2-pack-template" target="_blank" rel="noopener noreferrer">StackStorm pack template</a> in GitHub and touch our first Action Alias <a href="https://github.com/armab/st2_chatops_aliases/blob/master/aliases/ansible.yaml" target="_blank" rel="noopener noreferrer"><code>aliases/ansible.yaml</code></a> with the following content:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-50-aliases-ansible-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-50-aliases-ansible-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-50-aliases-ansible-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-50-aliases-ansible-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-50-aliases-ansible-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s"><span class="pl-pds">"</span>chatops.ansible_local<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-50-aliases-ansible-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-50-aliases-ansible-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action_ref</span>: <span class="pl-s"><span class="pl-pds">"</span>ansible.command_local<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-50-aliases-ansible-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-50-aliases-ansible-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Run Ansible command on local machine<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-50-aliases-ansible-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-50-aliases-ansible-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">formats</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-50-aliases-ansible-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-50-aliases-ansible-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">display</span>: <span class="pl-s"><span class="pl-pds">"</span>ansible <command><span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-50-aliases-ansible-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-50-aliases-ansible-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">representation</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-50-aliases-ansible-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-50-aliases-ansible-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s"><span class="pl-pds">"</span>ansible {{ args }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-50-aliases-ansible-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-50-aliases-ansible-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">result</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-50-aliases-ansible-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-50-aliases-ansible-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">format</span>: <span class="pl-s">|</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-50-aliases-ansible-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-50-aliases-ansible-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> Ansible command `{{ execution.parameters.args }}` result: {~}</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-50-aliases-ansible-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-50-aliases-ansible-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> {% if execution.result.stderr %}*Stdout:* {% endif %}</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-50-aliases-ansible-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-50-aliases-ansible-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> ```{{ execution.result.stdout }}```</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-50-aliases-ansible-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-50-aliases-ansible-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> {% if execution.result.stderr %}*Stderr:* ```{{ execution.result.stderr }}```{% endif %}</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-50-aliases-ansible-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-50-aliases-ansible-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"></span> <span class="pl-ent">extra</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-50-aliases-ansible-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-50-aliases-ansible-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">slack</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-50-aliases-ansible-yaml-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-50-aliases-ansible-yaml-LC17" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">color</span>: <span class="pl-s"><span class="pl-pds">"</span>{% if execution.result.succeeded %}good{% else %}danger{% endif %}<span class="pl-pds">"</span></span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/armab/b20fac606b0dde509952/raw/0c136caea12be6bd7bd20b87e796bb61f75ca1ba/50.aliases.ansible.yaml" style="float:right">view raw</a> <a href="https://gist.github.com/armab/b20fac606b0dde509952#file-50-aliases-ansible-yaml">50.aliases.ansible.yaml</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

> Note that this alias refers to <a href="https://exchange.stackstorm.org/#ansible" target="_blank" rel="noopener noreferrer">ansible st2 integration pack</a>

Now, push your changes into forked GitHub repo and you&#8217;re able to install just created pack. There is already a ChatOps alias to do that:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-50-deploy-chatops-pack-txt" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-50-deploy-chatops-pack-txt-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-50-deploy-chatops-pack-txt-LC1" class="blob-code blob-code-inner js-file-line">
                  !pack install https://github.com/armab/st2_chatops_aliases
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

Now we&#8217;re able to run a simple <a href="https://docs.ansible.com/intro_adhoc.html" target="_blank" rel="noopener noreferrer">Ansible Ad-hoc command</a> directly from Slack chat:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-50-chatops-command-txt" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-50-chatops-command-txt-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-50-chatops-command-txt-LC1" class="blob-code blob-code-inner js-file-line">
                  !ansible "uname -a"
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

![executing ansible local command - ChatOps way][11]  
which at a low-level is equivalent of:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-50-cmd-sh" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-shell  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-50-cmd-sh-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-50-cmd-sh-LC1" class="blob-code blob-code-inner js-file-line">
                  /opt/stackstorm/virtualenvs/ansible/bin/ansible all --connection=local --args=<span class="pl-s"><span class="pl-pds">'</span>uname -a<span class="pl-pds">'</span></span> --inventory-file=<span class="pl-s"><span class="pl-pds">'</span>127.0.0.1,<span class="pl-pds">'</span></span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

But let&#8217;s explore more useful examples, showing benefits of ChatOps interactivity.

### Use Case №1: Get Server Status {#case-1-server-status}

Ansible has simple <a href="https://docs.ansible.com/ping_module.html" target="_blank" rel="noopener noreferrer">ping module</a> which just connects to specified hosts and returns `pong` on success. Easy, but powerful example to understand servers state directly from chat in a matter of seconds, without logging into terminal.

To do that, we need to create another `action` for our pack which runs real command and `action alias` which is just syntactic sugar making possible this ChatOps command:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-51-chatops-txt" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-51-chatops-txt-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-51-chatops-txt-LC1" class="blob-code blob-code-inner js-file-line">
                  !status 'web'
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

Action <a href="https://github.com/armab/st2_chatops_aliases/blob/master/actions/server_status.yaml" target="_blank" rel="noopener noreferrer"><code>actions/server_status.yaml</code></a>:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-51-actions-server_status-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-51-actions-server_status-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s">server_status</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s">Show server status by running ansible ping ad-hoc command</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">runner_type</span>: <span class="pl-s">local-shell-cmd</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">entry_point</span>: <span class="pl-s"><span class="pl-pds">"</span><span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">enabled</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">parameters</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">sudo</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Run command with sudo<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s">boolean</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">kwarg_op</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">cmd</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Command to run<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC17" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s">string</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC18" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC19" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>: <span class="pl-s"><span class="pl-pds">"</span>/opt/stackstorm/virtualenvs/ansible/bin/ansible {{hosts}} --module-name=ping<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC20" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">hosts</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC21" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Ansible hosts to ping<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L22" class="blob-num js-line-number" data-line-number="22">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC22" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s">string</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-actions-server_status-yaml-L23" class="blob-num js-line-number" data-line-number="23">
                </td>
                
                <td id="file-51-actions-server_status-yaml-LC23" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">required</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/armab/b20fac606b0dde509952/raw/0c136caea12be6bd7bd20b87e796bb61f75ca1ba/51.actions.server_status.yaml" style="float:right">view raw</a> <a href="https://gist.github.com/armab/b20fac606b0dde509952#file-51-actions-server_status-yaml">51.actions.server_status.yaml</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

Action alias <a href="https://github.com/armab/st2_chatops_aliases/blob/master/aliases/server_status.yaml" target="_blank" rel="noopener noreferrer"><code>aliases/server_status.yaml</code></a>:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-51-aliases-server_status-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-51-aliases-server_status-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s">chatops.ansible_server_status</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action_ref</span>: <span class="pl-s">st2_chatops_aliases.server_status</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s">Show status for hosts (ansible ping module)</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">formats</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">display</span>: <span class="pl-s"><span class="pl-pds">"</span>status <hosts><span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">representation</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s"><span class="pl-pds">"</span>status {{ hosts }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s"><span class="pl-pds">"</span>ping {{ hosts }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">result</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">format</span>: <span class="pl-s">|</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> Here is your status for `{{ execution.parameters.hosts }}` host(s): {~}</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> ```{{ execution.result.stdout }}```</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"></span> <span class="pl-ent">extra</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">slack</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">color</span>: <span class="pl-s"><span class="pl-pds">"</span>{% if execution.result.succeeded %}good{% else %}danger{% endif %}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC17" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">fields</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC18" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">title</span>: <span class="pl-s">Alive</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC19" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">value</span>: <span class="pl-s"><span class="pl-pds">"</span>{{ execution.result.stdout|regex_replace('(?!SUCCESS).', '')|wordcount }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC20" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">short</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC21" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">title</span>: <span class="pl-s">Dead</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L22" class="blob-num js-line-number" data-line-number="22">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC22" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">value</span>: <span class="pl-s"><span class="pl-pds">"</span>{{ execution.result.stdout|regex_replace('(?!UNREACHABLE).', '')|wordcount }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L23" class="blob-num js-line-number" data-line-number="23">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC23" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">short</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L24" class="blob-num js-line-number" data-line-number="24">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC24" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">footer</span>: <span class="pl-s"><span class="pl-pds">"</span>{{ execution.id }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-51-aliases-server_status-yaml-L25" class="blob-num js-line-number" data-line-number="25">
                </td>
                
                <td id="file-51-aliases-server_status-yaml-LC25" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">footer_icon</span>: <span class="pl-s"><span class="pl-pds">"</span>https://stackstorm.com/wp/wp-content/uploads/2015/01/favicon.png<span class="pl-pds">"</span></span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/armab/b20fac606b0dde509952/raw/0c136caea12be6bd7bd20b87e796bb61f75ca1ba/51.aliases.server_status.yaml" style="float:right">view raw</a> <a href="https://gist.github.com/armab/b20fac606b0dde509952#file-51-aliases-server_status-yaml">51.aliases.server_status.yaml</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

Make sure you configured hosts in Ansible inventory file `/etc/ansible/hosts`.

After commited changes, don&#8217;t forget to reinstall edited pack from chat (replace it with your github repo):  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-51-chatops-deploy-txt" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-51-chatops-deploy-txt-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-51-chatops-deploy-txt-LC1" class="blob-code blob-code-inner js-file-line">
                  !pack install https://github.com/armab/st2_chatops_aliases
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

It&#8217;s pretty handy that you can keep all your ChatOps command configuration in remote repo as StackStorm pack and reload it after edits.

Let&#8217;s get server statuses:  
![show server statuses - chatops][12]  
It&#8217;s really powerful, anyone can run that without having server access! With this approach collaboration, deployment and work around infrastructure can be done from anywhere in chat: are you in the office or work remotely (some of us may work directly from the beach).

### Use Case №2: Restart Services {#case-2-restart-services}

Have you ever experienced when a simple service restart can solve the problem? Not ideal way of fixing things, but sometimes you just need to be fast. Let&#8217;s write a ChatOps command that restarts specific services on specific hosts.

We want to make something like this possible:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-52-chatops-txt" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-52-chatops-txt-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-52-chatops-txt-LC1" class="blob-code blob-code-inner js-file-line">
                  !service restart "rabbitmq-server" on "mq"
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

In previously created StackStorm pack touch <a href="https://github.com/armab/st2_chatops_aliases/blob/master/actions/service_restart.yaml" target="_blank" rel="noopener noreferrer"><code>actions/service_restart.yaml</code></a>:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-52-actions-service_restart-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-52-actions-service_restart-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s">service_restart</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s">Restart service on remote hosts</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">runner_type</span>: <span class="pl-s">local-shell-cmd</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">entry_point</span>: <span class="pl-s"><span class="pl-pds">"</span><span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">enabled</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">parameters</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">sudo</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Run command with sudo<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s">boolean</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">kwarg_op</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">cmd</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Command to run<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC17" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s">string</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC18" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC19" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>: <span class="pl-s"><span class="pl-pds">"</span>/opt/stackstorm/virtualenvs/ansible/bin/ansible {{hosts}} --become --module-name=service --args='name={{service_name}} state=restarted'<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC20" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">hosts</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC21" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Ansible hosts<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L22" class="blob-num js-line-number" data-line-number="22">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC22" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s">string</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L23" class="blob-num js-line-number" data-line-number="23">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC23" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">required</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L24" class="blob-num js-line-number" data-line-number="24">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC24" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">service_name</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L25" class="blob-num js-line-number" data-line-number="25">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC25" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Service to restart<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L26" class="blob-num js-line-number" data-line-number="26">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC26" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s">string</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-actions-service_restart-yaml-L27" class="blob-num js-line-number" data-line-number="27">
                </td>
                
                <td id="file-52-actions-service_restart-yaml-LC27" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">required</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/armab/b20fac606b0dde509952/raw/0c136caea12be6bd7bd20b87e796bb61f75ca1ba/52.actions.service_restart.yaml" style="float:right">view raw</a> <a href="https://gist.github.com/armab/b20fac606b0dde509952#file-52-actions-service_restart-yaml">52.actions.service_restart.yaml</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

Alias for ChatOps: <a href="https://github.com/armab/st2_chatops_aliases/blob/master/aliases/service_restart.yaml" target="_blank" rel="noopener noreferrer"><code>aliases/service_restart.yaml</code></a>:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-52-aliases-service_restart-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s">chatops.ansible_service_restart</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action_ref</span>: <span class="pl-s">st2_chatops_aliases.service_restart</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s">Restart service on remote hosts</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">formats</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">display</span>: <span class="pl-s"><span class="pl-pds">"</span>service restart <service_name> on <hosts><span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">representation</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s"><span class="pl-pds">"</span>service restart {{ service_name }} on {{ hosts }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">result</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">format</span>: <span class="pl-s">|</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> Service restart `{{ execution.parameters.service_name }}` on `{{ execution.parameters.hosts }}` host(s): {~}</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> {% if execution.result.stderr %}</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> *Exit Status*: `{{ execution.result.return_code }}`</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> *Stderr:* ```{{ execution.result.stderr }}```</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> *Stdout:*</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> {% endif %}</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC17" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> ```{{ execution.result.stdout }}```</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC18" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"></span> <span class="pl-ent">extra</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC19" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">slack</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC20" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">color</span>: <span class="pl-s"><span class="pl-pds">"</span>{% if execution.result.succeeded %}good{% else %}danger{% endif %}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC21" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">fields</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L22" class="blob-num js-line-number" data-line-number="22">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC22" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">title</span>: <span class="pl-s">Restarted</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L23" class="blob-num js-line-number" data-line-number="23">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC23" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">value</span>: <span class="pl-s"><span class="pl-pds">"</span>{{ execution.result.stdout|regex_replace('(?!SUCCESS).', '')|wordcount }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L24" class="blob-num js-line-number" data-line-number="24">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC24" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">short</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L25" class="blob-num js-line-number" data-line-number="25">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC25" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">title</span>: <span class="pl-s">Failed</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L26" class="blob-num js-line-number" data-line-number="26">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC26" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">value</span>: <span class="pl-s"><span class="pl-pds">"</span>{{ execution.result.stdout|regex_replace('(?!(FAILED|UNREACHABLE)!).', '')|wordcount }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L27" class="blob-num js-line-number" data-line-number="27">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC27" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">short</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L28" class="blob-num js-line-number" data-line-number="28">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC28" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">footer</span>: <span class="pl-s"><span class="pl-pds">"</span>{{ execution.id }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-52-aliases-service_restart-yaml-L29" class="blob-num js-line-number" data-line-number="29">
                </td>
                
                <td id="file-52-aliases-service_restart-yaml-LC29" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">footer_icon</span>: <span class="pl-s"><span class="pl-pds">"</span>https://stackstorm.com/wp/wp-content/uploads/2015/01/favicon.png<span class="pl-pds">"</span></span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/armab/b20fac606b0dde509952/raw/0c136caea12be6bd7bd20b87e796bb61f75ca1ba/52.aliases.service_restart.yaml" style="float:right">view raw</a> <a href="https://gist.github.com/armab/b20fac606b0dde509952#file-52-aliases-service_restart-yaml">52.aliases.service_restart.yaml</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

Let&#8217;s get our hands dirty now:  
![Restart nginx service on remote hosts in ChatOps way][13]  
And you know what? Thanks to the Slack mobile client, you can run those chat commands just from your mobile phone!

### Use case №3: Get currently running MySQL queries {#case-3-mysql-processlist}

We want simple slack command to query the mysql processlist from db server:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-53-chatops-txt" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-53-chatops-txt-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-53-chatops-txt-LC1" class="blob-code blob-code-inner js-file-line">
                  !show mysql processlist
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

Action <a href="https://github.com/armab/st2_chatops_aliases/blob/master/actions/mysql_processlist.yaml" target="_blank" rel="noopener noreferrer"><code>actions/mysql_processlist.yaml</code></a>:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-53-actions-mysql_processlist-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s">mysql_processlist</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s">Show MySQL processlist</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">runner_type</span>: <span class="pl-s">local-shell-cmd</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">entry_point</span>: <span class="pl-s"><span class="pl-pds">"</span><span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">enabled</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">parameters</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">sudo</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">kwarg_op</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">cmd</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Command to run<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s">string</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC17" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>: <span class="pl-s"><span class="pl-pds">"</span>/opt/stackstorm/virtualenvs/ansible/bin/ansible {{ hosts }} --become --become-user=root -m shell -a <span class="pl-cce">\"</span>mysql --execute='SHOW PROCESSLIST;' | expand -t 10<span class="pl-cce">\"</span><span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC18" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">hosts</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC19" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Ansible hosts<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC20" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s">string</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-actions-mysql_processlist-yaml-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-53-actions-mysql_processlist-yaml-LC21" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>: <span class="pl-s">db</span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/armab/b20fac606b0dde509952/raw/0c136caea12be6bd7bd20b87e796bb61f75ca1ba/53.actions.mysql_processlist.yaml" style="float:right">view raw</a> <a href="https://gist.github.com/armab/b20fac606b0dde509952#file-53-actions-mysql_processlist-yaml">53.actions.mysql_processlist.yaml</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

Action alias for ChatOps: <a href="https://github.com/armab/st2_chatops_aliases/blob/master/aliases/mysql_processlist.yaml" target="_blank" rel="noopener noreferrer"><code>aliases/mysql_processlist.yaml</code></a>:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-53-aliases-mysql_processlist-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-53-aliases-mysql_processlist-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-53-aliases-mysql_processlist-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-53-aliases-mysql_processlist-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-53-aliases-mysql_processlist-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s">chatops.mysql_processlist</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-aliases-mysql_processlist-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-53-aliases-mysql_processlist-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action_ref</span>: <span class="pl-s">st2_chatops_aliases.mysql_processlist</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-aliases-mysql_processlist-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-53-aliases-mysql_processlist-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s">Show MySQL processlist</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-aliases-mysql_processlist-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-53-aliases-mysql_processlist-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">formats</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-53-aliases-mysql_processlist-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-53-aliases-mysql_processlist-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">display</span>: <span class="pl-s"><span class="pl-pds">"</span>show mysql processlist <hosts=db><span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-aliases-mysql_processlist-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-53-aliases-mysql_processlist-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">representation</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-53-aliases-mysql_processlist-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-53-aliases-mysql_processlist-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s"><span class="pl-pds">"</span>show mysql processlist {{ hosts=db }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-aliases-mysql_processlist-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-53-aliases-mysql_processlist-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s"><span class="pl-pds">"</span>show mysql processlist on {{ hosts=db }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-aliases-mysql_processlist-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-53-aliases-mysql_processlist-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">result</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-53-aliases-mysql_processlist-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-53-aliases-mysql_processlist-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">format</span>: <span class="pl-s">|</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-aliases-mysql_processlist-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-53-aliases-mysql_processlist-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> {% if execution.status == 'succeeded' %}MySQL queries on `{{ execution.parameters.hosts }}`: ```{{ execution.result.stdout }}```{~}{% else %}</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-aliases-mysql_processlist-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-53-aliases-mysql_processlist-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> *Exit Code:* `{{ execution.result.return_code }}`</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-aliases-mysql_processlist-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-53-aliases-mysql_processlist-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> *Stderr:* ```{{ execution.result.stderr }}```</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-aliases-mysql_processlist-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-53-aliases-mysql_processlist-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> *Stdout:* ```{{ execution.result.stdout }}```</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-53-aliases-mysql_processlist-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-53-aliases-mysql_processlist-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> {% endif %}</span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/armab/b20fac606b0dde509952/raw/0c136caea12be6bd7bd20b87e796bb61f75ca1ba/53.aliases.mysql_processlist.yaml" style="float:right">view raw</a> <a href="https://gist.github.com/armab/b20fac606b0dde509952#file-53-aliases-mysql_processlist-yaml">53.aliases.mysql_processlist.yaml</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

Note that we made `hosts` parameter optional (defaults to `db`), so these commands are equivalent:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-53-1-chatops-txt" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-53-1-chatops-txt-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-53-1-chatops-txt-LC1" class="blob-code blob-code-inner js-file-line">
                  !show mysql processlist
                </td>
              </tr>
              
              <tr>
                <td id="file-53-1-chatops-txt-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-53-1-chatops-txt-LC2" class="blob-code blob-code-inner js-file-line">
                  !show mysql processlist 'db'
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

![show currently running MySQL queries ChatOps][14]  
Your DBA would be happy!

### Use case №4: Get HTTP Stats From nginx {#case-4-http-stats}

We want to show HTTP status codes, sort them by occurrence and pretty print to understand how much `200` or `50x` there are on specific servers, is it in normal state or not:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-54-chatops-txt" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-54-chatops-txt-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-54-chatops-txt-LC1" class="blob-code blob-code-inner js-file-line">
                  !show nginx stats on 'web'
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

Actual action which runs the command <a href="https://github.com/armab/st2_chatops_aliases/blob/master/actions/http_status_codes.yaml" target="_blank" rel="noopener noreferrer"><code>actions/http_status_codes.yaml</code></a>:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-54-actions-http_status_codes-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s">http_status_codes</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s">Show sorted http status codes from nginx logs</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">runner_type</span>: <span class="pl-s">local-shell-cmd</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">entry_point</span>: <span class="pl-s"><span class="pl-pds">"</span><span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">enabled</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">parameters</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">sudo</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">kwarg_op</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">cmd</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Command to run<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s">string</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC17" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>: <span class="pl-s"><span class="pl-pds">"</span>/opt/stackstorm/virtualenvs/ansible/bin/ansible {{hosts|replace('http://','')}} --become -m shell -a <span class="pl-cce">\"</span>awk '{print <span class="pl-cce">\\</span>$9}' /var/log/nginx/access.log|sort |uniq -c |sort -k1,1nr 2>/dev/null|column -t<span class="pl-cce">\"</span><span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC18" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">hosts</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC19" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Ansible hosts<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC20" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s">string</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-actions-http_status_codes-yaml-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-54-actions-http_status_codes-yaml-LC21" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">required</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/armab/b20fac606b0dde509952/raw/0c136caea12be6bd7bd20b87e796bb61f75ca1ba/54.actions.http_status_codes.yaml" style="float:right">view raw</a> <a href="https://gist.github.com/armab/b20fac606b0dde509952#file-54-actions-http_status_codes-yaml">54.actions.http_status_codes.yaml</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

Alias: <a href="https://github.com/armab/st2_chatops_aliases/blob/master/aliases/http_status_codes.yaml" target="_blank" rel="noopener noreferrer"><code>aliases/http_status_codes.yaml</code></a>  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-54-aliases-http_status_codes-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-54-aliases-http_status_codes-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-54-aliases-http_status_codes-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-54-aliases-http_status_codes-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-54-aliases-http_status_codes-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s">chatops.http_status_codes</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-aliases-http_status_codes-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-54-aliases-http_status_codes-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action_ref</span>: <span class="pl-s">st2_chatops_aliases.http_status_codes</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-aliases-http_status_codes-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-54-aliases-http_status_codes-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s">Show sorted http status codes from nginx on hosts</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-aliases-http_status_codes-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-54-aliases-http_status_codes-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">formats</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-54-aliases-http_status_codes-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-54-aliases-http_status_codes-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">display</span>: <span class="pl-s"><span class="pl-pds">"</span>show nginx stats on <hosts><span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-aliases-http_status_codes-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-54-aliases-http_status_codes-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">representation</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-54-aliases-http_status_codes-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-54-aliases-http_status_codes-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s"><span class="pl-pds">"</span>show nginx stats on {{ hosts }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-54-aliases-http_status_codes-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-54-aliases-http_status_codes-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">result</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-54-aliases-http_status_codes-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-54-aliases-http_status_codes-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">format</span>: <span class="pl-s"><span class="pl-pds">"</span>```{{ execution.result.stdout }}```<span class="pl-pds">"</span></span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/armab/b20fac606b0dde509952/raw/0c136caea12be6bd7bd20b87e796bb61f75ca1ba/54.aliases.http_status_codes.yaml" style="float:right">view raw</a> <a href="https://gist.github.com/armab/b20fac606b0dde509952#file-54-aliases-http_status_codes-yaml">54.aliases.http_status_codes.yaml</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

Result:  
![Show nginx http status codes on hosts - ChatOps way][15]  
Now it looks more like a control center. You can perform things against your hosts from chat and everyone can see the result, live!

### Use Case №5: Security Patching {#case-6-security-patching}

Imagine you should patch another critical vulnerability like [Shellshock][16]. We need to update `bash` on all machines with help of Ansible. Instead of running it as ad-hoc command, let&#8217;s compose a nice looking playbook, <a href="https://github.com/armab/st2_chatops_aliases/blob/master/playbooks/update_package.yaml" target="_blank" rel="noopener noreferrer"><code>playbooks/update_package.yaml</code></a>:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-55-playbooks-update_package-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">name</span>: <span class="pl-s">Update package on remote hosts, run on 25% of servers at a time</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">hosts</span>: <span class="pl-s"><span class="pl-pds">"</span>{{ hosts }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">serial</span>: <span class="pl-s"><span class="pl-pds">"</span>25%<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">become</span>: <span class="pl-c1">True</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">become_user</span>: <span class="pl-s">root</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">tasks</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">name</span>: <span class="pl-s">Check if Package is installed</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">command</span>: <span class="pl-s">dpkg-query -l {{ package }}</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">register</span>: <span class="pl-s">is_installed</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">failed_when</span>: <span class="pl-s">is_installed.rc > 1</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">changed_when</span>: <span class="pl-s">no</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">name</span>: <span class="pl-s">Update Package only if installed</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">apt</span>: <span class="pl-s">name={{ package }}</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s">state=latest</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC17" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s">update_cache=yes</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC18" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s">cache_valid_time=600</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-playbooks-update_package-yaml-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-55-playbooks-update_package-yaml-LC19" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">when</span>: <span class="pl-s">is_installed.rc == 0</span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/armab/b20fac606b0dde509952/raw/0c136caea12be6bd7bd20b87e796bb61f75ca1ba/55.playbooks.update_package.yaml" style="float:right">view raw</a> <a href="https://gist.github.com/armab/b20fac606b0dde509952#file-55-playbooks-update_package-yaml">55.playbooks.update_package.yaml</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

This playbook updates the package only if it&#8217;s already installed, and the operation will run in chunks, 25% of servers at a time, eg. in 4 parts. This can be good if you want to update something meaningful like nginx on many hosts. This way we won&#8217;t put down entire web cluster. Additionally, you can add logic to remove/add servers from load balancer.  
You can see that `{{ hosts }}` and `{{ package }}` variables in playbook are injected from outside, see StackStorm action <a href="https://github.com/armab/st2_chatops_aliases/blob/master/actions/update_package.yaml" target="_blank" rel="noopener noreferrer"><code>actions/update_package.yaml</code></a>:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-55-actions-update_package-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-55-actions-update_package-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s">update_package</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s">Update package on remote hosts</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">runner_type</span>: <span class="pl-s">local-shell-cmd</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">entry_point</span>: <span class="pl-s"><span class="pl-pds">"</span><span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">enabled</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">parameters</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">sudo</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">kwarg_op</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">timeout</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>: <span class="pl-c1">6000</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">cmd</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Command to run<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC17" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC18" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>: <span class="pl-s"><span class="pl-pds">"</span>/opt/stackstorm/virtualenvs/ansible/bin/ansible-playbook /opt/stackstorm/packs/${ST2_ACTION_PACK_NAME}/playbooks/update_package.yaml --extra-vars='hosts={{hosts|replace('http://','')}} package={{package}}'<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC19" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">hosts</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC20" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Ansible hosts<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC21" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s">string</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L22" class="blob-num js-line-number" data-line-number="22">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC22" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">required</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L23" class="blob-num js-line-number" data-line-number="23">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC23" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">package</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L24" class="blob-num js-line-number" data-line-number="24">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC24" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Package to upgrade<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L25" class="blob-num js-line-number" data-line-number="25">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC25" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s">string</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-actions-update_package-yaml-L26" class="blob-num js-line-number" data-line-number="26">
                </td>
                
                <td id="file-55-actions-update_package-yaml-LC26" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">required</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/armab/b20fac606b0dde509952/raw/0c136caea12be6bd7bd20b87e796bb61f75ca1ba/55.actions.update_package.yaml" style="float:right">view raw</a> <a href="https://gist.github.com/armab/b20fac606b0dde509952#file-55-actions-update_package-yaml">55.actions.update_package.yaml</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

And here is an action alias that makes possible to run playbook as simple chatops command,  
<a href="https://github.com/armab/st2_chatops_aliases/blob/master/aliases/update_package.yaml" target="_blank" rel="noopener noreferrer"><code>aliases/update_package.yaml</code></a>:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-55-aliases-update_package-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-55-aliases-update_package-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s">chatops.ansible_package_update</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action_ref</span>: <span class="pl-s">st2_chatops_aliases.update_package</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s">Update package on remote hosts</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">formats</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">display</span>: <span class="pl-s"><span class="pl-pds">"</span>update <package> on <hosts><span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">representation</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s"><span class="pl-pds">"</span>update {{ package }} on {{ hosts }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s"><span class="pl-pds">"</span>upgrade {{ package }} on {{ hosts }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">result</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">format</span>: <span class="pl-s">|</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> Update package `{{ execution.parameters.package }}` on `{{ execution.parameters.hosts }}` host(s): {~}</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> {% if execution.result.stderr %}</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> *Exit Status*: `{{ execution.result.return_code }}`</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> *Stderr:* ```{{ execution.result.stderr }}```</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> *Stdout:*</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC17" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> {% endif %}</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC18" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> ```{{ execution.result.stdout }}```</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC19" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"></span> <span class="pl-ent">extra</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC20" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">slack</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC21" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">color</span>: <span class="pl-s"><span class="pl-pds">"</span>{% if execution.result.succeeded %}good{% else %}danger{% endif %}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L22" class="blob-num js-line-number" data-line-number="22">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC22" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">fields</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L23" class="blob-num js-line-number" data-line-number="23">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC23" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">title</span>: <span class="pl-s">Updated nodes</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L24" class="blob-num js-line-number" data-line-number="24">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC24" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">value</span>: <span class="pl-s"><span class="pl-pds">"</span>{{ execution.result.stdout|regex_replace('(?!changed=1).', '')|wordcount }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L25" class="blob-num js-line-number" data-line-number="25">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC25" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">short</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L26" class="blob-num js-line-number" data-line-number="26">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC26" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">title</span>: <span class="pl-s">Executed in</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L27" class="blob-num js-line-number" data-line-number="27">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC27" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">value</span>: <span class="pl-s"><span class="pl-pds">"</span>:timer_clock: {{ execution.elapsed_seconds | to_human_time_from_seconds }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L28" class="blob-num js-line-number" data-line-number="28">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC28" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">short</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L29" class="blob-num js-line-number" data-line-number="29">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC29" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">footer</span>: <span class="pl-s"><span class="pl-pds">"</span>{{ execution.id }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-55-aliases-update_package-yaml-L30" class="blob-num js-line-number" data-line-number="30">
                </td>
                
                <td id="file-55-aliases-update_package-yaml-LC30" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">footer_icon</span>: <span class="pl-s"><span class="pl-pds">"</span>https://stackstorm.com/wp/wp-content/uploads/2015/01/favicon.png<span class="pl-pds">"</span></span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/armab/b20fac606b0dde509952/raw/0c136caea12be6bd7bd20b87e796bb61f75ca1ba/55.aliases.update_package.yaml" style="float:right">view raw</a> <a href="https://gist.github.com/armab/b20fac606b0dde509952#file-55-aliases-update_package-yaml">55.aliases.update_package.yaml</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

Finally:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-55-chatops-txt" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-55-chatops-txt-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-55-chatops-txt-LC1" class="blob-code blob-code-inner js-file-line">
                  !update 'bash' on 'all'
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

![Update packages on remote hosts with help of Ansible and ChatOps][17]  
A big part of our work as DevOps engineers is to optimize the processes by making developers life easier, collaboration in team better, problem diagnostics faster by automating environment and bringing right tools to make the company successful.  
ChatOps solves that in a completely new efficient level!

### Bonus Case: Holy Cowsay {#bonus-cowsay}

One more thing! As you know Ansible has a <a href="https://github.com/ansible/ansible/issues/10530" target="_blank" rel="noopener noreferrer">well known love</a> for the holy cowsay utility. Let&#8217;s bring it to ChatOps!

Install dependencies first:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-56-install-cowsay-sh" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-shell  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-56-install-cowsay-sh-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-56-install-cowsay-sh-LC1" class="blob-code blob-code-inner js-file-line">
                  sudo apt-get install cowsay
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

Action <a href="https://github.com/armab/st2_chatops_aliases/blob/master/actions/cowsay.yaml" target="_blank" rel="noopener noreferrer"><code>actions/cowsay.yaml</code></a>:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-56-actions-cowsay-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-56-actions-cowsay-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s">cowsay</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s">Draws a cow that says what you want</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">runner_type</span>: <span class="pl-s">local-shell-cmd</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">entry_point</span>: <span class="pl-s"><span class="pl-pds">"</span><span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">enabled</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">parameters</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">sudo</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">kwarg_op</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">cmd</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Command to run<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s">string</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>: <span class="pl-s"><span class="pl-pds">"</span>/usr/games/cowsay {{message}}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC17" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">message</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC18" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Message to say<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC19" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s">string</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-actions-cowsay-yaml-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-56-actions-cowsay-yaml-LC20" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">required</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/armab/b20fac606b0dde509952/raw/0c136caea12be6bd7bd20b87e796bb61f75ca1ba/56.actions.cowsay.yaml" style="float:right">view raw</a> <a href="https://gist.github.com/armab/b20fac606b0dde509952#file-56-actions-cowsay-yaml">56.actions.cowsay.yaml</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

Alias <a href="https://github.com/armab/st2_chatops_aliases/blob/master/aliases/cowsay.yaml" target="_blank" rel="noopener noreferrer"><code>aliases/cowsay.yaml</code></a>:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-56-aliases-cowsay-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-56-aliases-cowsay-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-56-aliases-cowsay-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-56-aliases-cowsay-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-56-aliases-cowsay-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s">chatops.cowsay</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-aliases-cowsay-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-56-aliases-cowsay-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action_ref</span>: <span class="pl-s">st2_chatops_aliases.cowsay</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-aliases-cowsay-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-56-aliases-cowsay-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s">Draws a cow that says what you want</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-aliases-cowsay-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-56-aliases-cowsay-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">formats</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-56-aliases-cowsay-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-56-aliases-cowsay-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">display</span>: <span class="pl-s"><span class="pl-pds">"</span>cowsay <message><span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-aliases-cowsay-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-56-aliases-cowsay-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">representation</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-56-aliases-cowsay-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-56-aliases-cowsay-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s"><span class="pl-pds">"</span>cowsay {{ message }}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-aliases-cowsay-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-56-aliases-cowsay-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">ack</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-56-aliases-cowsay-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-56-aliases-cowsay-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">enabled</span>: <span class="pl-c1">false</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-aliases-cowsay-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-56-aliases-cowsay-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">result</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-56-aliases-cowsay-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-56-aliases-cowsay-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">format</span>: <span class="pl-s">|</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-aliases-cowsay-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-56-aliases-cowsay-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> {% if execution.status == 'succeeded' %}Here is your cow: ```{{ execution.result.stdout }}``` {~}{% else %}</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-aliases-cowsay-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-56-aliases-cowsay-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> Sorry, no cows this time {~}</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-aliases-cowsay-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-56-aliases-cowsay-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> Exit Code: `{{ execution.result.return_code }}`</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-aliases-cowsay-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-56-aliases-cowsay-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> Stderr: ```{{ execution.result.stderr }}```</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-aliases-cowsay-yaml-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-56-aliases-cowsay-yaml-LC17" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> Hint: Make sure `cowsay` utility is installed.</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-56-aliases-cowsay-yaml-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-56-aliases-cowsay-yaml-LC18" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> {% endif %}</span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/armab/b20fac606b0dde509952/raw/0c136caea12be6bd7bd20b87e796bb61f75ca1ba/56.aliases.cowsay.yaml" style="float:right">view raw</a> <a href="https://gist.github.com/armab/b20fac606b0dde509952#file-56-aliases-cowsay-yaml">56.aliases.cowsay.yaml</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

Summon cows in a ChatOps way:  


<div id="gist23700314" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-56-chatops-txt" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-56-chatops-txt-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-56-chatops-txt-LC1" class="blob-code blob-code-inner js-file-line">
                  !cowsay 'Holy ChatOps Cow!'
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

![holy chatops cow!][18] 

> Note that all command results are available in StackStorm Web UI:  
> <a href="https://chatops/" target="_blank" rel="noopener noreferrer">https://chatops/</a> username: `demo` password: `demo`

## Don&#8217;t Stop Here! {#final-words}

These are simple examples. More complex situations when several DevOps tools are tied into dynamic workflows will be covered in future articles. This is where [StackStorm][19] shows its super power, making decisions about what to do depending on situation: event-driven architecture like self-healing systems.

Want new feature in StackStorm? Give us a proposal or <a href="https://github.com/StackStorm/st2" target="_blank" rel="noopener noreferrer">start contributing</a> to the project yourself. Additionally we&#8217;re happy to help you, &#8211; join our <a href="https://stackstorm.com/community-signup" target="_blank" rel="noopener noreferrer">public Slack</a> and feel free to ask any questions if you can&#8217;t find your answer in [our docs][20].

So don&#8217;t stop here. [Try it][6], think how you would use ChatOps? Share your ideas and stories (even crazy ones)!

 [1]: https://i.imgur.com/HWN8T78.png
 [2]: https://stackstorm.com/2015/06/08/enhanced-chatops-from-stackstorm/
 [3]: https://stackstorm.com/2015/12/08/stackstorm-1-2-0-the-new-chatops/
 [4]: https://stackstorm.com/2016/04/20/stackstorm-v1-4/
 [5]: https://i.imgur.com/fJ6DpBZ.png
 [6]: https://github.com/StackStorm/showcase-ansible-chatops
 [7]: https://github.com/stackstorm/ansible-st2
 [8]: https://github.com/StackStorm-Exchange/stackstorm-ansible
 [9]: https://exchange.stackstorm.org/
 [10]: https://github.com/hubot-scripts/hubot-shipit
 [11]: https://i.imgur.com/1TopcQh.png
 [12]: https://i.imgur.com/ZOZgGnz.png
 [13]: https://i.imgur.com/rNsHdtK.png
 [14]: https://i.imgur.com/RxePho1.png
 [15]: https://i.imgur.com/Wsvdx3W.png
 [16]: https://en.wikipedia.org/wiki/Shellshock_%28software_bug%29
 [17]: https://i.imgur.com/aOEApkR.png
 [18]: https://i.imgur.com/mCYHFM6.png
 [19]: https://stackstorm.com/
 [20]: https://docs.stackstorm.com/chatops/