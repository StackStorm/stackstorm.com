---
title: Actions Of All Flavors In StackStorm
author: st2admin
type: post
date: 2015-04-20T13:00:04+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/04/20/actions-of-all-flavors-in-stackstorm/
dsq_thread_id:
  - 3690617066
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
**April 20, 2015**

_by James Fryman_

In order to unleash the true power of StackStorm, a good first step is to learn about actions. Actions are the cornerstone of the StackStorm system, representing what we commonly refer to as &#8216;lego bricks&#8217;. Actions are what StackStorm ties together to compose complex workflows to drive even the most complex cases.

Today, we will explore actions within StackStorm. By the end of this article, you&#8217;ll have a great understanding of how&#8230;

  * to understand and create action metadata files.
  * and when to use each of the action runner types.
  * to create actions that execute code in any language.
  * to create actions using native Python hooks.

Ready to start your automation journey? Buckle up, and let&#8217;s dive in!

<!--more-->

NOTE: Check out our up-to-date [documentation for Actions][1] that can always be found on our docs site.

###### What is StackStorm?

Maybe this is the first time you&#8217;re hearing about StackStorm. No worries, welcome! In a nutshell, StackStorm is IFTTT for IT Operations. It responds to events from tools in your environment via Integrations, and using our Rules Engine, can orchestrate complex workflows. We&#8217;ve put together a great [getting started overview][2] for your reference.

###### Getting Setup

Before you get started, it&#8217;s essential to have a solid development environment to rapidly iterate. The easiest way to get started with writing action integrations is to use our `st2workbench` development environment. Check out our [blog post][3] that will show you all the necessary steps to get a dev environment up and running in minutes.

###### Hello, World!

As with any programming environment, it is traditional to begin with the all-present &#8220;Hello, World!&#8221; example. We&#8217;ll use this simple command to begin our introduction to the first part of an action, the _action metadata_.

Let&#8217;s begin with a completed Action Metadata file, and we&#8217;ll break it down in sections.

    # walkthrough/actions/hello_world.yaml
    ---
    name: hello_world
    runner_type: "run-local"
    description: "Example 'Hello, World!' action"
    enabled: true
    parameters:
      cmd:
        default: "echo Hello, World!"
    

A metadata file has several main attributes within to be defined. Each of these sections provides a bit of information to StackStorm in terms of integration to various subsystems. Help is automatically populated based on descriptions provided in this file. The integration method for how StackStorm will execute actions in the form of `runners` is also defined here.

For now, let&#8217;s create this example on your StackStorm installation and watch it work. First, create a your first pack directory, and then navigate to the `actions` directory of your new pack. Packs are created in the `/opt/stackstorm` directory.

    $ cd /opt/stackstorm/packs
    $ sudo mkdir -p walkthrough/{actions,rules,sensors}
    $ cd walkthrough/actions
    

Create a new file named `hello_world.yaml` with your favorite text editor, and copy the contents of the above example into that file. Once that is done, reload StackStorm to register the new action.

    $ sudo st2ctl reload --register-all
    

NOTE: This step may be unnecessary if you are using the setup instructions in the Rapid Integration blog and are using the built in Guard watcher. Guard should automatically register new actions as they are written to the filesystem.

Now, run your command, and bask in the goodness that is your first action.

    $ st2 run walkthrough.hello_world
    

You should see the result of the action pop up very shortly. Something like this:

    id: 553125c09c99384a4eaa6f9b
    status: succeeded
    result:
    {
      "failed": false,
      "stderr": "",
      "return_code": 0,
      "succeeded": true,
      "stdout": "Hello, World!
    "
    }
    

Huzzah! Congrats, you&#8217;ve created your first action! Great though, but what happened. Why go through the effort of creating this metadata? We&#8217;ll, let&#8217;s talk about one of the first benefits of the metadata file, documentation.

**Documentation**

Some people love documentation, others really hate it. But, the challenge is creating documentation that is both relevant because it is up-to-date and accurate. By leveraging StackStorm and leaning into the &#8220;Infrastructure as Code&#8221; paradigm, it is possible to greatly reduce the friction associated with documentation management by baking it into the actions being executed, close to the code, and contextually relevant. So, lets access this information.

You can access this via the CLI:

    root@st2express:/opt/stackstorm/packs/walkthrough/actions# st2 run walkthrough.hello_world -h
    
    Example 'Hello, World!' action
    
    Optional Parameters:
    cmd
    Default: echo Hello, World!
    
    cwd
    Working directory where the command will be executed in
    Type: string
    
    env
    Environment variables which will be available to the command(e.g.
    key1=val1,key2=val2)
    Type: object
    
    kwarg_op
    Operator to use in front of keyword args i.e. "--" or "-".
    Type: string
    Default: --
    
    sudo
    The command will be executed with sudo.
    Type: boolean
    Default: False
    
    timeout
    Action timeout in seconds. Action will get killed if it doesn't finish in timeout seconds.
    Type: integer
    Default: 60
    
    

or via the Web UI:

<img loading="lazy" class="alignleft size-large wp-image-3117" src="http://stackstorm.com/wp/wp-content/uploads/2015/04/james-blog-image-4.20.15-1024x761.png" alt="james blog image 4.20.15" width="1024" height="761" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/04/james-blog-image-4.20.15-1024x761.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/04/james-blog-image-4.20.15-300x223.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/04/james-blog-image-4.20.15-1080x803.png 1080w, https://stackstorm.com/wp/wp-content/uploads/2015/04/james-blog-image-4.20.15.png 1235w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

&nbsp;

Take note that the actions shown here are much more than we&#8217;ve defined in our metadata file. This is because each runner type has some built in attributes that can be set at runtime, or overwritten in the action metadata file. In our first example, the `cmd` attribute is actually an attribute of the `run-local` runner.

What is a runner? Well, that&#8217;s a good segue, so let&#8217;s take it!

###### Action Runners

Internal to StackStorm, we employ multiple ways to execute different types of actions. An action in StackStorm can be either a single command, or a workflow. Furthermore, actions may be run on the machine that StackStorm workers execute or they may be executed remotely on many servers. In order to account for the various contexts that an action may execute, we provide a pluggable action runner system behind actions. At a very high level, the types of runners that we support include:

  1. \`run-local\` &#8211;  This is the local runner. Actions are implemented as scripts. They are executed on the same hosts where StackStorm components are running.
  2. \`run-remote\` &#8211; This is a remote runner. Actions are implemented as scripts. They run on one or more remote hosts provided by the user.
  3. \`run-python\` &#8211; This is a Python runner. Actions are implemented as Python classes with a run method. They run locally on the same machine where StackStorm components are running.
  4. \`http-runner\` &#8211; HTTP client which performs HTTP requests for running HTTP actions.
  5. \`action-chain\` &#8211; This runner supports executing simple linear work-flows. For more information, please refer to the [_Workflows_][4] and [_ActionChain_][5] section of documentation.
  6. \`mistral-v1\`, \`mistral-v2\` &#8211; Those runners are built on top of the Mistral OpenStack project and support executing complex work-flows. For more information, please refer to the [_Workflows_][4] and [_Mistral_][6] section of documentation.

Check out the [full list of available runners][7] detailing how they are used and the parameters that they take.

**Shell Based Runners**

Now that we have created a basic action, and walked through some of the description of them, let&#8217;s do some real stuff with it and create some examples. A very common scenario is: I have this great automation script, and I want to make it available as an action. Let&#8217;s start with wrapping a shell script.

Shell scripts usually come in two flavors usually. Some shell scripts take arguments in a chain after a command. Something like this:

    $ ./my_awesome_script ~/filea.txt ~/fileb.txt
    

In this case, we&#8217;re not providing any data about how each parameter is being used. In this case, the order they are supplied to the script matters. We refer this to as &#8216;positional arguments&#8217;, and provide a way to specify which order commands are entered into an application. Here is an action metadata that shows integration with a script like this.

    ---
    name: traceroute
    runner_type: run-remote
    description: "Traceroute a Host"
    enabled: true
    entry_point: 'traceroute.sh'
    parameters:
      host:
        type: string
        description: host name to traceroute
        required: true
        position: 1
      hops:
        type: integer
        description: Limit of maximum number of hops
        default: 30
        position: 2
      queries_to_hop:
        type: integer
        description:  No. of queries to each hop
        default: 3
        position: 3
      hosts:
        default: "localhost"
    

In this example `traceroute` command, take note of the `position` attribute for each of the parameters. These directly correspond to the position of the argument as it is passed into the shell command to be executed as part of this action. The `entry_point` specifies where the action should look when it goes to execute a command.

Source: <https://github.com/StackStorm/st2/blob/master/contrib/linux/actions/traceroute.yaml>  
Script: <https://github.com/StackStorm/st2/blob/master/contrib/linux/actions/traceroute.sh>

**What about Ruby?**

Shell based runners can also run code in pretty much any language. In this example, I have a small ruby application that uses `optparse` to take command line input. So, I want to make sure that my metadata file takes the arguments for my Ruby application and passes them through properly. Let&#8217;s take a look at the action metadata for this ruby application.

    ---
    name: pack
    runner_type: run-remote-script
    description: Action to perform pack deployments via Git branch deploys
    enabled: true
    entry_point: pack.rb
    parameters:
      pack:
        type: string
        description: Name of the pack to be deployed
        required: true
      repo:
        type: string
        description: Location where to retrieve remote pack from
        required: true
      subtree:
        type: boolean
        description: Flag to determine whether pack is nested within a repository, or is stand-alone
      branch:
        type: string
        description: git branch to deploy
        default: 'origin/master'
      info:
        type: boolean
        description: Get information about deployed pack
      debug:
        type: boolean
        description: Provide additional debug informat
      delete:
        type: boolean
        description: Delete a pack
      force:
        type: boolean
        description: Force a destructive action
      sudo:
        default: true
    

In this example, the `position` argument is missing. However, the Ruby application takes what we call &#8220;named parameters&#8221;. This might look on the command line like this:

    $ ./deploy.rb --branch test --repo StackStorm/st2
    

Each of the parameter names as defined in the action metadata directly corresponds with the parameter of the command. For example, the `branch` parameter will pass through the `--branch XXX` with the specified argument at runtime.

However, sometimes, shell commands don&#8217;t use the double-dash `--` identifier to label its parameters. In this case, there is an attribute in the action metadata that you can overwrite, and that is the `kwarg_op` parameter. For example, if your command takes only a single dash like:

    $ ./deploy -branch test -repo StackStorm/st
    

Simply adjust the `kwarg_op` attribute in your action metadata like this:

      ...
      parameters:
        kwarg_op:
          default: "-"
    

Source: <https://github.com/StackStorm/st2incubator/blob/master/packs/deploy/actions/pack.yaml>  
Ruby File: <https://github.com/StackStorm/st2incubator/blob/master/packs/deploy/actions/pack.rb>

**JSON Passing**

One of our favorite things to talk about is how JSON is our common language internal to StackStorm. In the context of Shell runners, this means that if I output JSON to `STDOUT` via any script, StackStorm will automatically parse that output as an object for use in workflows. Forget about worrying about passing data between different systems&#8230; output JSON and we&#8217;ll take care of the less.

`puts result.to_json` makes my day, every day I use it. Write very small and focused scripts in the language you&#8217;re most comfortable with, emit JSON, and we&#8217;ll take care of all the rest. Magic!

**Templating**

Action metadata also uses the Jinja templating engine behind it. We&#8217;ve been playing with a few patterns, and have come up with some creative ways to wrap existing UNIX commands into StackStorm with relative ease. For example, here is an example wrapping up the `apt-get` command in a StackStorm action.

    ---
    name: apt_get_install
    description: Install a package from APT
    runner_type: run-remote
    enabled: true
    entry_point: ''
    parameters:
      package:
        type: string
        description: Name of the package to be installed
        required: true
        position: 1
      version:
        type: string
        description: Version of the package to be installed
        position: 2
      sudo:
        immutable: true
        default: true
      env:
        default:
          DEBIAN_FRONTEND: noninteractive
        immutable: true
      cmd:
        type: string
        default: 'apt-get -y install {{package}}{% if version %}={{version}}{% endif %}'
        immutable: true
    

Source: [https://github.com/StackStorm/st2incubator/blob/master/packs/debian/actions/apt\_get\_install.yaml][8]

Using Jinja, it&#8217;s possible to do variable interpolation and even conditional logic as shown here.

**Python Based Runners**

Python based runners are pretty awesome as well! Our entire system is written in Python on the backend, so it&#8217;s only natural that we make Python a first-class citizen when it comes to writing actions. Let&#8217;s take a look at an easy example action metadata from another one of our packs.

    ---
    name: extract_ips
    runner_type: run-python
    description: Extract IP addresses from RAX payload
    enabled: true
    entry_point: 'shell/extract_ips.py'
    parameters:
      nodes:
        type: object
        description: RAX Payload from `rackspace.list_vms`
        required: true
      count:
        type: integer
        description: Optionally decide to limit the number of IPs to return
    

At this point, nothing in the action metadata should be out of the ordinary. Instead, lets dive into the Python action itself to show the difference.

    from st2actions.runners.pythonrunner import Action
    
    class ExtractIPs(Action):
        def run(self, nodes, count):
            ips = []
            for node in nodes:
                ips.append(node['public_ip'][1])
    
            if count:
                return ips[0:count]
            else:
                return ips
    

What you see here is a very basic Python action. In our action, we import the Action runner, and create a new class with the Action parent class. From here, any of the parameters that are defined in the action metadata are automatically passed as named parameters to the `run` function. From there, you can run normal python in your action, and return values as you see fit.

Take careful note of the `object` type specified in this example action metadata. This is a special schema type that allows you to pass in a raw object to the application, avoiding the need to serialize if you leverage a Python runner.

Source: <https://github.com/StackStorm/st2incubator/blob/master/packs/autoscale/actions/extract_ips.yaml>

Script: [https://github.com/StackStorm-Exchange/stackstorm-rackspace/blob/master/actions/create\_dns\_record.py][9]

###### More examples!

Hopefully this is enough to get you started. If you haven&#8217;t guessed by now, writing actions is very super easy. We&#8217;re working to make a ton of these action integrations available out of the box, so if you wan to browse what you can download and get started with today, or read some code for inspiration, you can check out our pack repositories located at <https://exchange.stackstorm.org>. We even have articles on how to contribute your code upstream to share with everyone! We&#8217;re all stronger together, and we want to make it easy to share infrastructure integrations and patterns.

###### What&#8217;s next?

I hope that you&#8217;re able to use your new knowledge to create new action integrations for your use-cases. Going even further, we&#8217;d love to have you contribute any new content to our pack repositories. We have even more articles coming to help you get started with StackStorm. We&#8217;ll go over things like creating Sensors and Rules, creating your first workflows with ActionChain and Mistral, and other [tutorials][10]. Stay tuned!

Until next time!

 [1]: http://docs.stackstorm.com/actions.html
 [2]: http://docs.stackstorm.com/overview.html
 [3]: http://stackstorm.com/2015/04/03/rapid-integration-development-with-stackstorm/
 [4]: http://docs.stackstorm.com/workflows.html
 [5]: http://docs.stackstorm.com/actionchain.html
 [6]: http://docs.stackstorm.com/mistral.html
 [7]: http://docs.stackstorm.com/runners.html
 [8]: https://github.com/StackStorm/st2incubator/blob/master/packs/debian/actions/apt_get_install.yaml
 [9]: https://github.com/StackStorm-Exchange/stackstorm-rackspace/blob/master/actions/create_dns_record.py
 [10]: http://stackstorm.com/category/tutorials