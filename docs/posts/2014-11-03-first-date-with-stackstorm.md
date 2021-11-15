---
title: 'First Date With StackStorm (Setup & Action Library)'
author: st2admin
type: post
date: 2014-11-03T04:53:31+00:00
excerpt: '< a href="/2014/11/02/first-date-with-stackstorm/">READ MORE</a>'
url: /2014/11/03/first-date-with-stackstorm/
dsq_thread_id:
  - 3184422804
categories:
  - Blog
  - Community
  - Home

---
**November 3, 2014**

_By Patrick Hoolboom_

### Setup and Connect

For this I&#8217;ll be using Virtualbox and Vagrant.  To use the same environment, just clone this repo:

<a href="https://github.com/StackStorm/st2express" target="_blank">St2Express</a>

Once you do, you simply run:

<pre>vagrant up</pre>

It takes a few minutes for this to fully provision, but one it does you can connect to the host with the vagrant ssh command.

<pre>vagrant ssh</pre>

<!--more-->

### Basic Usage

There are two main commands to use with the system. One being a &#8216;supervisor&#8217; like script:

<pre>vagrant@st2express:~$ st2ctl
Valid actions: start|stop|restart|restart-component|reload|clean|status
</pre>

Once you have the system up and running you have access to the StackStorm system via the other command, &#8216;st2&#8217;

<pre>vagrant@st2:~$ st2 -h
usage: st2 [-h] [--url BASE_URL] [--auth-url AUTH_URL] [--api-url API_URL]
           [--cacert CACERT]
           {auth,key,trigger,rule,action,runner,run,execution} ...

CLI for Stanley, an automation platform by StackStorm. http://stackstorm.com

positional arguments:
  {auth,key,trigger,rule,action,runner,run,execution}
    auth                Authenticate user and aquire access token.
    key                 Key value pair is used to store commonly used
                        configuration for reuse in sensors, actions, and
                        rules.
    trigger             An external event that is mapped to a stanley input.
                        It is the stanley invocation point.
    rule                A specification to invoke an "action" on a "trigger"
                        selectively based on some criteria.
    action              An activity that happens as a response to the external
                        event.
    runner              Runner is a type of handler for a specific class of
                        actions.
    run                 A command to invoke an action manually.
    execution           An invocation of an action.

optional arguments:
  -h, --help            show this help message and exit
  --url BASE_URL        Base URL for the API servers. Assumes all servers uses
                        the same base URL and default ports are used. Get
                        ST2_BASE_URLfrom the environment variables by default.
  --auth-url AUTH_URL   URL for the autentication service. Get
                        ST2_AUTH_URLfrom the environment variables by default.
  --api-url API_URL     URL for the API server. Get ST2_API_URLfrom the
                        environment variables by default.
  --cacert CACERT       Path to the CA cert bundle for the SSL endpoints. Get
                        ST2_CACERT from the environment variables by default.
                        If this is not provided, then SSL cert will not be
                        verified.
</pre>

The &#8216;st2&#8217; CLI provides access to the triggers, rules, actions, and action executions in the system. Any information you may need about any integrations or automations can be retrieved via the command line

### Beginner&#8217;s Guide to the Action Library

The action library is essentially the muscles of the system. It shows all actions that have been installed from integration packs, as well as anything that has been added to the system ad-hoc. Just like the other areas of the system it is accessed through the &#8216;st2&#8217; command

For instance, to see a list of currently registered actions, you run:

<pre>vagrant@st2express:~$ st2 action list
+-------------------------+-------+-------------------+---------------------------------------------+
| ref                     | pack  | name              | description                                 |
+-------------------------+-------+-------------------+---------------------------------------------+
| core.http               | core  | http              | Action that performs an http request.       |
| core.local              | core  | local             | Action that executes an arbitrary Linux     |
|                         |       |                   | command on the localhost.                   |
| core.local_sudo         | core  | local_sudo        | Action that executes an arbitrary Linux     |
|                         |       |                   | command on the localhost.                   |
| core.remote             | core  | remote            | Action to execute arbitrary linux command   |
|                         |       |                   | remotely.                                   |
| core.remote_sudo        | core  | remote_sudo       | Action to execute arbitrary linux command   |
|                         |       |                   | remotely.                                   |
| core.sendmail           | core  | sendmail          | This sends an email                         |
| core.stormbot_say       | core  | stormbot_say      | This posts a message to StormBot            |
| packs.delete            | packs | delete            | Deletes the pack from local content         |
|                         |       |                   | repository.                                 |
| packs.download          | packs | download          | Downloads packs and places it in the local  |
|                         |       |                   | content repository.                         |
| packs.install           | packs | install           | Installs packs from st2-contrib into local  |
|                         |       |                   | content repository. Will download pack,     |
|                         |       |                   | load the actions, sensors and rules from    |
|                         |       |                   | the pack. Note that install require reboot  |
|                         |       |                   | of some st2 services.                       |
| packs.load              | packs | load              | Action that reloads all st2 content.        |
| packs.restart_component | packs | restart_component | Action that restarts st2 service.           |
| packs.uninstall         | packs | uninstall         | Uninstalls packs from local content         |
|                         |       |                   | repository. Removes pack and content from   |
|                         |       |                   | st2. Note that uninstall require reboot of  |
|                         |       |                   | some st2 services.                          |
| packs.unload            | packs | unload            | Unregisters all content from a pack.        |
+-------------------------+-------+-------------------+---------------------------------------------+
</pre>

These are the core actions that come with a minimum install of the system. Let&#8217;s try out the local action. It executes an arbitrary shell command on the box where St2 is running.

<pre>vagrant@st2express:~$ st2 run core.local date
.
+-----------------+--------------------------------------------------+
| Property        | Value                                            |
+-----------------+--------------------------------------------------+
| id              | 545287dc9c99383ec8a66f2f                         |
| context         | {                                                |
|                 |     "user": null                                 |
|                 | }                                                |
| parameters      | {                                                |
|                 |     "cmd": "date"                                |
|                 | }                                                |
| status          | succeeded                                        |
| start_timestamp | 2014-10-30T18:47:56.929000Z                      |
| result          | {                                                |
|                 |     "localhost": {                               |
|                 |         "failed": false,                         |
|                 |         "stderr": "",                            |
|                 |         "return_code": 0,                        |
|                 |         "succeeded": true,                       |
|                 |         "stdout": "Thu Oct 30 18:47:57 UTC 2014" |
|                 |     }                                            |
|                 | }                                                |
| action          | core.local                                       |
| callback        |                                                  |
+-----------------+--------------------------------------------------+
</pre>

The output shows a great deal of information about the action invocation but of particular interest to us is the &#8216;result&#8217; field. It shows us information about the action on a per host basis (more on this later). For instance, since we executed the &#8216;date&#8217; command on localhost, we see the output of &#8216;date&#8217; in the &#8220;stdout&#8221; field.

This particular example isn&#8217;t all that interesting. Let&#8217;s try it on some remote hosts.  Before we can access the hosts we need to create the stanley user and copy his public key out to these hosts.  The public key can be found at &#8216;/home/stanley/st2_rsa.pub&#8217;. I generally use Puppet for this.

<pre>vagrant@st2express:~$ st2 run core.remote hosts=localhost,st2stage001,st2stage002,st2stage003 date
.
+-----------------+--------------------------------------------------+
| Property        | Value                                            |
+-----------------+--------------------------------------------------+
| id              | 545288419c99383ec8a66f31                         |
| context         | {                                                |
|                 |     "user": null                                 |
|                 | }                                                |
| parameters      | {                                                |
|                 |     "cmd": "date",                               |
|                 |     "hosts": "localhost,st2stage001,st2stage002, |
|                 | st2stage003"                                     |
|                 | }                                                |
| status          | succeeded                                        |
| start_timestamp | 2014-10-30T18:49:37.273000Z                      |
| result          | {                                                |
|                 |     "localhost": {                               |
|                 |         "failed": false,                         |
|                 |         "stderr": "",                            |
|                 |         "return_code": 0,                        |
|                 |         "succeeded": true,                       |
|                 |         "stdout": "Thu Oct 30 18:49:38 UTC 2014" |
|                 |     },                                           |
|                 |     "st2stage001": {                             |
|                 |         "failed": false,                         |
|                 |         "stderr": "",                            |
|                 |         "return_code": 0,                        |
|                 |         "succeeded": true,                       |
|                 |         "stdout": "Thu Oct 30 18:49:38 UTC 2014" |
|                 |     },                                           |
|                 |     "st2stage002": {                             |
|                 |         "failed": false,                         |
|                 |         "stderr": "",                            |
|                 |         "return_code": 0,                        |
|                 |         "succeeded": true,                       |
|                 |         "stdout": "Thu Oct 30 18:49:38 UTC 2014" |
|                 |     },                                           |
|                 |     "st2stage003": {                             |
|                 |         "failed": false,                         |
|                 |         "stderr": "",                            |
|                 |         "return_code": 0,                        |
|                 |         "succeeded": true,                       |
|                 |         "stdout": "Thu Oct 30 18:49:38 UTC 2014" |
|                 |     }                                            |
|                 | }                                                |
| action          | core.remote                                      |
| callback        |                                                  |
+-----------------+--------------------------------------------------+
</pre>

Now things start to get a little interesting. We see that we can not only execute the same command on multiple hosts but we can do it in parallel. Greatly reducing convergence time.

We can also look at the entire execution history

<pre>vagrant@st2express:~$ st2 execution list
+--------------------------+-------------+--------------+-----------+-----------------------------+
| id                       | action      | context.user | status    | start_timestamp             |
+--------------------------+-------------+--------------+-----------+-----------------------------+
| 54527f379c99383d6f02c5d8 | core.local  |              | scheduled | 2014-10-30T18:11:03.992000Z |
| 545287dc9c99383ec8a66f2f | core.local  |              | succeeded | 2014-10-30T18:47:56.929000Z |
| 5452883b9c99383ec8a66f30 | core.remote |              | failed    | 2014-10-30T18:49:31.452000Z |
| 545288419c99383ec8a66f31 | core.remote |              | succeeded | 2014-10-30T18:49:37.273000Z |
| 545288d79c99383ec8a66f32 | core.remote |              | succeeded | 2014-10-30T18:52:07.997000Z |
+--------------------------+-------------+--------------+-----------+-----------------------------+
</pre>

Or get th results of a single, previously run execution.

<pre>vagrant@st2express:~$ st2 execution get 545287dc9c99383ec8a66f2f
+-----------------+--------------------------------------------------+
| Property        | Value                                            |
+-----------------+--------------------------------------------------+
| id              | 545287dc9c99383ec8a66f2f                         |
| action          | core.local                                       |
| callback        |                                                  |
| context         | {                                                |
|                 |     "user": null                                 |
|                 | }                                                |
| parameters      | {                                                |
|                 |     "cmd": "date"                                |
|                 | }                                                |
| result          | {                                                |
|                 |     "localhost": {                               |
|                 |         "failed": false,                         |
|                 |         "stderr": "",                            |
|                 |         "return_code": 0,                        |
|                 |         "succeeded": true,                       |
|                 |         "stdout": "Thu Oct 30 18:47:57 UTC 2014" |
|                 |     }                                            |
|                 | }                                                |
| start_timestamp | 2014-10-30T18:47:56.929000Z                      |
| status          | succeeded                                        |
+-----------------+--------------------------------------------------+
</pre>

For the above example, I pulled up the original local date command we ran.

If you happen to forget the parameters of a given action you can always check with this command:

<pre>vagrant@st2express:~$ st2 run core.sendmail -h

This sends an email

Required Parameters:
    to
        Recipient email address.
        Type: string

    subject
        Subject of the email.
        Type: string

    body
        Body of the email.
        Type: string

Optional Parameters:
    kwarg_op
        Operator to use in front of keyword args i.e. "--" or "-".
        Type: string
        Default: --
</pre>

This gives you both the required and optional parameters for this action. Some of these, such as kwarg_op, I will cover later on during the action authoring section.

The action library by itself is a powerful tool to preload your technical expertise in the form of actions, share those actions with your team, and then see the full history of when they were run and what/who triggered them.

This makes for a perfect segway in to Part II of this introductory blog.  
&nbsp;