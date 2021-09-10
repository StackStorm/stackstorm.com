---
title: StackStorm and ChatOps Actions with confirmation
author: st2admin
type: post
date: 2016-01-21T17:28:39+00:00
url: /2016/01/21/stackstorm-and-chatops-actions-with-confirmation/
dsq_thread_id:
  - 4511268464
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community

---
**January 21, 2016**  
by Igor Cherkaev aka eMptywee

Originally published at <http://emptywee.blogspot.com/2016/01/stackstorm-and-chatops-actions-with.html>

Before moving to Openstack integration I’d like to post a short article about highly demanded feature, which is going to be implemented and supported natively out of the box by StackStorm one day, – Chatops Action Confirmation.

In short, some actions, requested from chatops, may indeed be dangerous and typo errors or incorrectly entered values may harm your system or lead to unexpected, unpredictable and undesirable results. That being said, it would be really nice to ask the user who issued the command to confirm his or her intentions to execute it.

So for now we have to do it on our own. And I’ll tell you what – it is not really difficult. We will examine two chatops aliases and I will elucidate on the things happening under the hood when these aliases are triggered.

<!--more-->

Let’s begin and design our **confirmation** action and wrap it into the appropriate action-alias. If you want to quickly deploy the pack with all the actions and aliases right away, you can do so by running the following command:

    st2 packs.install packs=st2chat_confirm register=all
    repo_url=https://github.com/emptywee/st2chat_confirm.git
    

### confirm_exec.meta.yaml (metadata file)

When I was experimenting with it, I tried different approaches and initially it was an action-chain. Perhaps, there’s a better way to directly execute `st2.kv.set` action from the alias, but I haven’t found it yet. Either it’s impossible to do, or it’s poorly documented. All we need to do is pass username of the person who executes the action (triggers the alias). So, we will use a simple action-chain with only one action designed to construct a proper key for the StackStorm data store.

    ---
    # Action definition metadata
    name: "confirm_exec"
    description: "Confirm action execution"
    runner_type: "action-chain"
    enabled: true
    entry_point: "workflows/confirm_exec.yaml"
    parameters:
    exec_id:
    type: string
    required: true
    description: "Action execution to confirm"
    skip_notify:
    default:
    - save_key
    

We will pass one parameter to the action-chain, which in its turn will pick our chatname and stick it all together as a key. We need to do that because we do not want somebody else to confirm actions that were fired by you.

### confirm_exec.yaml (action-chain)

The action chain itself is pretty simple:

    ---
    chain:
        -
            name: "save_key"
            ref: "st2.kv.set"
            params:
                key: "{{action_context.parent.api_user}}_{{exec_id}}"
                value: "confirmed"
                ttl: 60
    

That is it for now. The action chain will set a key in the data store for 60 seconds. Now let’s wrap it up with an alias.

### confirm_exec.yaml (alias)

The alias definition is also very simple.

    ---
    name: test.confirm_exec
    enabled: true
    action_ref: st2chat_confirm.confirm_exec
    description: Confirm potentially dangerous execution
    formats:
    - display: "confirm <execution id="">"
    representation:
    - "confirm {{exec_id}}"
    ack:
    format: "Confirming action!"
    append_url: false
    result:
    enabled: false
    ```</execution>
    
    Feel free to adjust to your own needs here, don’t forget it’s just an example. This alias will trigger the action-chain once you give a command similar to `! confirm 56a01f468e326f6c51a3d4a9`. Of course you can go ahead and replace execution id with some random number or magic word. It doesn’t really matter.
    
    Now, let’s design our potentially dangerous action! I will use mistral workflow as an example, but there should be no problem to use the same approach for _action-chains_. Or should be, since a simple action-chain doesn’t really have mechanisms to implement waiting on user actions. But this is up to you to explore.
    
    ### wf_with_confirm.meta.yaml (metadata)
    
    Here’s our metadata for the potentially dangerous action!
    
    

* * *

description: &#8220;test wf with confirm from chatops&#8221;  
runner_type: &#8220;mistral-v2&#8221;  
tags: []  
enabled: true  
pack: &#8220;st2chat_confirm&#8221;  
entry\_point: &#8220;workflows/wf\_with_confirm.yaml&#8221;  
uid: &#8220;action:st2chat\_confirm:wf\_with_confirm&#8221;  
parameters:  
hostlist:  
required: true  
type: &#8220;string&#8221;  
description: &#8220;a list of hosts&#8221;  
param1:  
default: &#8220;&#8221;  
type: &#8220;string&#8221;  
description: &#8220;Some parameter&#8221;  
ref: &#8220;st2chat\_confirm.wf\_with_confirm&#8221;  
name: &#8220;wf\_with\_confirm&#8221;

    <br />In this example we are doing something (literally **doing something**!) to a list of hosts. Therefore, we will need to confirm it! We will pass a list of host names as hostlist and some arbitrary parameter `param1`.
    
    The workflow itself is represented on the diagram below.
    
    ![http://stackstorm.com/wp/wp-content/uploads/2016/01/flow_diagram.jpg](http://stackstorm.com/wp/wp-content/uploads/2016/01/flow_diagram.jpg)
    
    Let’s go step by step over the workflow.
    
    * First step here is to publish a few variables which we’ll refer to later, this step is optional and is placed here only for convenience. We publish `chat_user`, `source_channel`, and `exec_id` variables here. You will see why later;
    * Second step is there to throw a message into the channel asking the user to confirm the action execution;
    * Next, we wait for about 30 seconds for the action to get confirmed, and if it’s confirmed we take the execution one way, if it’s not – the other way;
    
    Yes, it’s that simple. This workflow can be used a starting point for every dangerous action you design. I think that we can even pass a name of the desired workflow to get executed **after** confirmation. That way we won’t have to copy and paste the same code in each such action. Code re-use is a really good thing to always keep it in mind.
    
    ### wf_with_confirm.yaml (workflow)
    
    The mistral workflow itself is quite simple as well:
    
    

* * *

version: &#8216;2.0&#8217;

e\_playground.wf\_with_confirm:  
type: direct  
input:  
&#8211; hostlist  
&#8211; param1  
tasks:  
publish_data:

# [297, 28]

action: core.noop  
publish:  
chat_user: <% env().get('_\_actions').get('st2.action').st2\_context.parent.api_user %>  
source_channel: <% env().get('_\_actions').get('st2.action').st2\_context.parent.source_channel %>  
exec_id: <% env().get('_\_actions').get('st2.action').st2\_context.parent.execution_id %>  
on-success:  
&#8211; post\_confirm\_message  
post\_confirm\_message:

# [286, 163]

action: chatops.post_message  
input:  
channel: &#8216;<% $.source_channel %>&#8216;  
message: &#8216;@<% $.chat_user %>, the action you have requested is dangerous. Please, confirm by issuing &#8220;! confirm <% $.exec_id %>&#8221; command. You have 30 seconds to confirm it.&#8217;

on-success:  
&#8211; wait\_for\_confirmation  
wait\_for\_confirmation:

# [286, 304]

action: st2.kv.get  
input:  
key: &#8216;<% $.chat\_user %>\_<% $.exec_id %>&#8216;

retry:  
count: 10  
delay: 3

on-error:  
&#8211; post\_not\_confirmed  
on-success:  
&#8211; post_confirmed  
post\_not\_confirmed:

# [456, 434]

action: chatops.post_message  
input:  
channel: &#8216;<% $.source_channel %>&#8216;  
message: &#8216;@<% $.chat_user %>, I have not received confirmation from you within 30 seconds. The execution has been aborted.&#8217;

post_confirmed:

# [97, 445]

action: chatops.post_message  
input:  
channel: &#8216;<% $.source_channel %>&#8216;  
message: &#8216;@<% $.chat_user %>, The action is confirmed. Proceeding&#8230;&#8217;

    <br />Take a look at the first task there. Notice the long path to the variables we need. Perhaps, there’s a better way to get to them and store them, but I couldn’t figure it out yet. If you did, please, share in the comments section below.
    
    Key aspect here (why we actually use mistral workflow) is the `retry` section of the `wait_for_confirmation task`. Mistral allows you to retry the task for a set amount of attempts. Thus, setting 10 attempts with a 3-second delay gives us about 30 seconds to confirm the action.
    
    Last touch would be wrapping it up in an `action-alias`.
    
    ### test.yaml (alias)
    
    

* * *

name: st2chat\_confirm.wf\_with_confirm  
enabled: true  
action\_ref: st2chat\_confirm.wf\_with\_confirm  
description: Test workflow with confirm. Starting point.  
formats:  
&#8211; display: &#8220;do_something with <hostlist> <param1>&#8221;  
representation:  
&#8211; &#8220;do_something with {{hostlist}} {{param1}}&#8221;  
result:  
format: |  
Execution ID {{ execution.id }} complete.  
&#8220;\`</param1></hostlist>

### In the end

Reloading everything and trying to fire up the potentially dangerous action we have just created!  
To reload actions and aliases metadata simply issue the following command:

    st2ctl reload --register-all
    

![http://stackstorm.com/wp/wp-content/uploads/2016/01/chat_example.jpg][1] 

Ta-dam!

GitHub repository is located here: <https://github.com/emptywee/st2chat_confirm>

Feel free to ask questions if you have any. As always, you are welcome to join the friendly and super-fast responding Stackstorm community at <https://stackstorm.com/community/>

Also, I’d recommend trying the StackStorm Enterprise Edition. It gives you that beautiful visual workflow editor and support from the StackStorm core team.

 [1]: http://stackstorm.com/wp/wp-content/uploads/2016/01/chat_example.jpg