---
title: Rapid Integration Development With StackStorm
author: st2admin
type: post
date: 2015-04-03T22:06:53+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/04/03/rapid-integration-development-with-stackstorm/
dsq_thread_id:
  - 3653025163
tcb2_ready:
  - 1
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home
  - Tutorials
tags:
  - tutorial

---
**April 3, 2015**

_by James Fryman_

Day in and day out, the team at StackStorm is building tools that take away pain from the daily lives of Operations and Developers in IT Departments everywhere. We do this by focusing our efforts on absorbing all the Glue Code, the small snippets of code that tie together tools in your organization, and relieving the developer and operator of much of the traditional management overhead associated with automations. We also need to make sure that the tools we provide _around_ StackStorm are equally enjoyable and frictionless to use. To that end, I would like to share with you how to rapidly build integrations with our integrated development environment, `st2workroom`.

###### What is StackStorm?

If you&#8217;re just getting started with StackStorm, or are curious what it is, we have a <a href="http://docs.stackstorm.com/overview.html" target="_blank">great primer</a> on the product&#8230; Take a moment, head over there, and give it a quick read or watch. We&#8217;ll be right here when you get back.

In a nutshell, StackStorm provides Event Driven Automation. StackStorm integrates with your various tools, and manages orchestration based on events that occur in your environment.

<!--more-->

###### st2workroom

The st2workroom is a self-contained project that has some custom additions that allow us to quickly and easily prototype infrastructures of all types and sizes. This project can be downloaded from our GitHub repository at <a href="https://github.com/StackStorm-Exchange" target="_blank">https://github.com/StackStorm-Exchange</a>. In this project, there are a few primary components:

  * **Vagrant** &#8211; This project needs little introduction. Vagrant allows us to ship a consistent Dev Platform, regardless of the Host Operating System.
  * **Stacks** &#8211; This addition to Vagrant allows us to quickly and easily define many nodes in a Vagrant environment.
  * **Guard** &#8211; This ruby project keeps watch on changes to the filesystem and manages restarts as necessary.

Using this project, we can quickly and easily set up a fresh StackStorm server, associate our code with that node, and rapidly prototype/develop. Let&#8217;s build our first pack.

###### Pre-Work

In this example, I am going to work on the trello integration with StackStorm. I have a few things already set up on my host computer. These steps really should only have to be done one time. Let&#8217;s go over them:

  * **Download and Install Vagrant:** This is a manual step currently. Head to <a href="https://www.vagrantup.com/downloads.html" target="_blank">https://www.vagrantup.com/downloads.html</a> and download the latest version for your OS/Architecture.
  * **Download and Install VirtualBox/VMWare Fusion (Optional):** If you prefer to do all development on your local machine, you&#8217;ll want to get one of these Virtual Machine executors. We&#8217;ll go over how to develop with StackStorm if your local machine isn&#8217;t suited to run Virtual Machines.
  * **StackStorm Exchange projects are downloaded to my computer:** These projects are where we keep our main packs. We encourage community members to submit Pull Requests against this repository. To learn more about Pull Requests, head over to <a href="https://help.github.com/articles/fork-a-repo/" target="_blank">https://help.github.com/articles/fork-a-repo/</a>.
  * **\`st2workbench\` project is downloaded to my computer:** This is the actual place work will be done.

###### Setup

Now, in this example, let&#8217;s work on developing the `trello` pack. What we&#8217;ll want here is to set up `st2workroom` to allow us to develop on our local machine with all of our environment settings, but still run the code in our clean-room development environment. This consists of two steps: the first, to tell `st2workroom` where the pack files are located, and the second, to optionally configure any configuration for the integration itself.

**Setting up the Pack File Location**

In this example, I&#8217;ll be contributing to the `trello` repository. Let&#8217;s take advantage of our Stacks and tell the development environment where it can expect to find our `trello` pack files, which on my computer is located at `/Users/jfryman/stackstorm/stackstorm-trello`.

  * Navigate to the \`st2workbench\` directory: \`cd ~/stackstorm/st2workbench\`
  * Edit the file \`stacks/st2.yaml\` and add the file-mount to the \`st2express\` key. We want to target the pack directory to \`/opt/stackstorm/packs/trello\`.

<p class="normal">
  <p>
    <
  </p>
  
  <p>
    pre>
  </p>
  
  <h2>
    # stacks/st2.yaml
  </h2>
  
  <h1>
    Defaults can be defined and reused with YAML anchors
  </h1>
  
  <p>
    defaults: &defaults<br /> domain: stackstorm.net<br /> memory: 1024<br /> cpus: 1<br /> box: puppetlabs/ubuntu-14.04-64-puppet<br /> st2express: <<: *defaults hostname: st2express sync_type: nfs puppet: facts: role: st2express mounts: - “/opt/stackstorm/packs/trello:/Volumes/Repositories/stackstorm-trello” 
    
    <ul>
      <li>
        Save the file and exit.
      </li>
    </ul>
    
    <p>
      Note: By default in the <code>st2workroom</code>, the <code>st2</code> stack is loaded up (<code>stacks/st2.yaml</code>). If you want to create your own infrastructure definitions, simply create a new Stack, and change the environment variable <code>stack</code> to your newly named stack. For example, if I wanted to create a new stack called <code>frymanio</code>, I would create a new file <code>stacks/frymanio.yaml</code>, and update my environment variable. See the file STACKS.md in the root of the <code>st2workbench</code> repository for more information.
    </p>
    
    <p>
      <b>Setting Pack Configuration</b>
    </p>
    
    <p>
      To bootstrap StackStorm, <code>st2workbench</code> leverages our Puppet module. (https://github.com/StackStorm/puppet-st2). Because of this, we can leverage Hiera to set configuration variables about our packs that will be downloaded. The benefit here is that once you are done developing against this repository, the hiera data is easily portable to a production environment, reinforcing the Infrastructure as Code concept.
    </p>
    
    <p>
      In the <code>trello</code> pack, we have determined before hand that we need two configuration variables: <code>api_key</code> and <code>token</code>. Let&#8217;s set those now.
    </p>
    
    <ul>
      <li>
        Navigate to the `st2workbench` directory: `cd ~/stackstorm/st2workbench`
      </li>
      <li>
        Edit the `hieradata/workbench.yaml` file, and add the pack configuration to the `st2::packs` key.
      </li>
    </ul>
    
    <pre># hieradata/workbench.yaml

st2::packs:
  trello:
    ensure: present
    config:
      api_key: ""
      token: ""
</pre>
    
    <p>
      <b>Cloud Configuration</b>
    </p>
    
    <p>
      This is an optional step. However, if you find yourself wanting to develop on StackStorm, but your local computing environment is not up to the challenge? No fear, you can quickly and easily get a quick development environment setup.
    </p>
    
    <p>
      <b>Digital Ocean</b>
    </p>
    
    <p>
      To enable Digital Ocean support, you&#8217;ll need to do the following:
    </p>
    
    <p>
      1) Install the Digital Ocean Vagrant plugin: vagrant plugin install <code>vagrant-digitalocean</code>
    </p>
    
    <p>
      2) Add the following environment variables to the file <code>.env</code> at the root of the <code>st2workroom</code> directory.
    </p>
    
    <pre>
# .env

DO_SSH_KEY_PATH=XXX # Path to the SSH Key to be used for installation. (e.g.: ~/.ssh/id_rsa)

DO_TOKEN=YYY        # Digital Ocean API Token

sync_type=rsync     # Copies all bootstrap items to the Digital Ocean node, and provisions.

</pre>
    
    <p>
      3) Make sure the attribute <code>sync_type: nfs</code> is removed from the file <code>stacks/st2.yaml</code>.
    </p>
    
    <p>
      You can get your Digital Ocean API Token from <a href="https://cloud.digitalocean.com/settings/applications" target="_blank">https://cloud.digitalocean.com/settings/applications</a> and generate a new token.
    </p>
    
    <p>
      Proceed to <code>Start it up!</code>, paying specific attention to the <code>--provisioner</code> parameter.
    </p>
    
    <p>
      <b>AWS</b><br /> To enable AWS support, you&#8217;ll need to do the following:
    </p>
    
    <p>
      1) Install the AWS Vagrant Plugin: <code>vagrant plugin install vagrant-aws</code><br /> 2) Download the <code>dummy</code> AWS box: <code>vagrant box add dummy &lt;a href="https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box" target="_blank"&gt;https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box&lt;/a&gt;</code><br /> 3) Setup a New Keypair in AWS. Download this keypair and store it locally.<br /> 4) Add the following environmental variables to the file <code>.env</code> at the root of the <code>st2workroom</code> directory.
    </p>
    
    <pre>
# .env

AWS_ACCESS_KEY_ID=XXX     # AWS Access Key

AWS_SECRET_ACCESS_KEY=YYY # AWS Secret Access Key

AWS_SSH_KEY_PATH=ZZZ      # Path to the SSH Key Generated in Step #3 (e.g.: ~/.ssh/aws_ssh)

AWS_KEYPAIR_NAME=NNN      # Use the keypair generated in Step #3

sync_type=rsync           # Copies all bootstrap items to the Digital Ocean node, and provisions.

</pre>
    
    <p>
      5) Make sure the attribute <code>sync_type: nfs</code>is removed from the file <code>stacks/st2.yaml</code>.
    </p>
    
    <p>
      Head to the AWS Web Console and look for the &#8220;Security Credentials&#8221; page. You may need to get in touch with your administrator for key.
    </p>
    
    <p>
      Proceed to <code>Start it up!</code>, paying specific attention to the <code>--provisioner</code> parameter.
    </p>
    
    <blockquote>
      <p>
        Note: By default, this provisions an Ubuntu 14.04 node in <code>us-west-2</code>. If you would like to change this, set the <code>AWS_REGION</code> and “AWS_AMI<code>variables in</code>.env<code>as detailed above.&lt;br />
  &lt;h6&gt;Start it Up!&lt;/h6&gt;&lt;br />
  At this point, we're all set to get started! Go ahead and spin up</code>st2express<code>via the workroom, and let's get started. You can do this with the</code>vagrant up<code>command in the root of the</code>st2workroom` directory.
      </p>
    </blockquote>
    
    <pre>
$ cd ~/stackstorm/st2workroom

$ vagrant up st2express (--provisioner &lt;provision>)
</pre>
    
    <p>
      Note: If you are leveraging the DO/AWS Cloud Provisoner, take note of the provisioner parameter. You will need to supply this. Use the <code>--provisioner digital_ocean</code> for DO, and <code>--provisioner aws</code>.
    </p>
    
    <p>
      If this is your first time booting, it will take a few minutes depending on the speed of your computer and internet connection. On average, first boot takes approximately ~5 minutes. During this process, StackStorm is being downloaded to the latest version, setup on your computer in the development environment, and validated. It is rare that you&#8217;ll need to re-create the <code>st2workbench</code> after the first boot.
    </p>
    
    <h6>
      Start Guard
    </h6>
    
    <p>
      Guard is our Filesystem monitor. Its job is to monitor the <code>/opt/stackstorm</code> directory (and children, which in this case includes our new <code>trello</code> pack) for filesystem changes and automatically reloads. Anytime that you save a file in your pack directory, Guard will automatically restart the appropriate components of StackStorm to have your changes live loaded.
    </p>
    
    <p>
      To do this, log into your new StackStorm box, and click on <code>guard</code>.
    </p>
    
    <pre>
$ cd ~/stackstorm/st2workroom

$ vagrant ssh st2express

$ cd /opt/puppet

$ bundle exec guard -i -w /opt/stackstorm/packs

</pre>
    
    <p>
      This will now automatically restart the appropriate component of StackStorm as you save files to the filesystem. Focus on development!
    </p>
    
    <h6>
      Start Developing!
    </h6>
    
    <p>
      The hard work is over! We now have a full fledged development environment to work with. If you happen to be on OSX, or have the <code>avahi</code> tool installed on your Linux box, you can head over to https://st2express.local:9101 and gain access to the WebUI. Likewise, you now have access to the StackStorm <code>st2express</code> environment, and can kick off commands from there.
    </p>
    
    <p>
      Head over to our documentation website at http://docs.stackstorm.com, and read up on creating Actions and Sensors. From here, you can begin creating all the integrations that you desire.
    </p>
    
    <p>
      In coming articles, we&#8217;ll have tutorials and walk throughs on developing your first action, developing ActionChain workflows, developing Mistral workflows, sensor development and more! In the meantime, be sure to take a look at our existing community packs online at https://exchange.stackstorm.org for example packs.
    </p>
    
    <p>
      Until next time!
    </p>