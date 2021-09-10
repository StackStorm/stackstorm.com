---
title: Getting Started With StackStorm and SaltStack
author: st2admin
type: post
date: 2015-07-29T13:23:55+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/07/29/getting-started-with-stackstorm-and-saltstack/
dsq_thread_id:
  - 3983178634
tcb2_ready:
  - 1
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Tutorials
tags:
  - tutorial

---
_Guest post by Jurnell Cockhren, CTO and Founder of [SophicWare][1]_

## Our Journey

The task at hand is to connect Stackstorm to your pre-existing Saltstack infrastructure. Why? Well, by doing this you can turn all of your existing Salt actions into StackStorm actions, allowing you to use StackStorm for your overall event driven automation while Salt remains focused on remote execution and other use cases. This is a pattern we are increasingly seeing &#8211; so let&#8217;s try it out!

This blog covers both proper configuration of Saltstack NetAPI allowing for Stackstorm usage as well as how to install and configure the salt pack within StackStorm. This tutorial covers [Scenario 2 listed on the Salt pack README][2].

<!--more-->

### Minimum Requirements

  * Saltstack (2014.7+)
  * a Stackstorm ready Vagrant (or VPS, if you&#8217;re courageous)

### Step 1. Setup NetAPI

Saltstack&#8217;s NetAPI allows for remote execution of salt module functions. This feature proved most beneficial when developing deep integration between Stackstorm and Saltstack.

On your salt master, install the `salt-api` package using your typical means for updating or install Saltstack for your organization.

On Ubuntu, you could run:

`apt-get install salt-api`

Create a file named: `/etc/salt/master.d/salt-api.conf` filled with the following:

<pre><code class="yaml">rest_cherrypy:
port: 8000
host:
debug: True
ssl_crt: /etc/nginx/certs/server.crt
ssl_key: /etc/nginx/certs/server.key
</code></pre>

Let&#8217;s examine what&#8217;s what:

  * `port`: What port to have cherrypy listen on.</p> 
  * `host`: The IP address of your interface to listen on. In production environments I like to not expose cherrypy directly to the world. Instead use nginx as the frontend allowing you to have more controls over the SSL ciphers and protocols.

  * `debug`: Setting this to `True` is generally a good idea.
  * `ssl_crt` and `ssl_key`: For this post, let&#8217;s allow cheerypy to handle SSL communications. Remember, use nginx for your frontend in production.

### Step 2: Setup Access Control List

It makes good sense to be deliberate while choosing which users can authenticate with Saltstack and which modules they&#8217;re authorized to use. ACLs and `external_auth` are [outside the scope of this post][3], but it pays off to know what is what during initial setup.

Suppose you have a non-root user called `stackstorm` that will be making the NetAPI on the behalf of stackstorm. Feel free to use [any supported external authenticaion backend][4]. In this example, we&#8217;re going with plain ol&#8217; PAM.

Somewhere in your Saltstack master config add:

<pre><code class="yaml">external_auth:
pam:
stackstorm:
- '@runner'
-'*':
- test.*
- service.*
- pkg.*
- state.sls
</code></pre>

The above configuration allows your `stackstorm` user to execute:  
1. All runner functions.  
2. All functions in the `test`, `service`, `pkg` execution modules and the `state.sls` function on **any** minion.

Restart the `salt-api` and `salt-master` daemons to put your new settings into effect.

{WOULD SOME SORT OF DRAWING SHOWING THE INTEGRATION BE POSSIBLE?}

### Step 3: Installing Stackstorm

You can install Stackstorm with the following commands:

<pre><code class="shell">curl -s https://downloads.stackstorm.net/releases/st2/scripts/st2_deploy.sh latest

sudo bash st2_deploy.sh stable
</code></pre>

Ensure Stackstorm is running with

<pre><code class="shell">sudo st2ctl status
</code></pre>

and it should look like the following:

![Check Status][5] 

If any of the components aren&#8217;t running, executing `sudo st2ctl restart` will quickly get Stackstorm is a usable state.

### Step 4: Readying the Saltstack Pack

Given the salt pack requires some configuration, it&#8217;s wise to avoid the `packs.install` action.

[From the docs][6], you should:

<pre><code class="shell">st2 run packs.download packs=salt

st2 run packs.setup_virtualenv packs=salt
</code></pre>

Assuming the default `base_path`, the salt pack will be installed at `/opt/stackstorm/packs/salt`. Fill the empty `config.yaml` file with the credentials of the `stackstorm` user from Step 2:

<pre><code class="yaml">api_url: https://salt.example.com:8080
username: stackstorm
password: _some_password_
eauth: pam
</code></pre>

Register all actions contained in the pack:

<pre><code class="shell">st2 run packs.load register=all
</code></pre>

Note: Ideally, you&#8217;d execute the above commands as part of a salt state. It&#8217;s best practice to generate `config.yaml` from a template and retrieve your `stackstorm` user credentials from an encrypted pillar.

Let&#8217;s take a look at the available actions:

<pre><code class="shell">st2 action list --pack=salt
</code></pre>

![view action list][7] 

There are a lot of actions! Don&#8217;t fret, just remember that Stackstorm actions map to Saltstack module functions along the following rules:

  1. Actions prefixed with `runner_` map to runner module functions (i.e. commands ran with `salt-run`).
  2. Actions prefixed with `local_` map to execution module functions (i.e. commands ran with `salt`).

Those aren&#8217;t the only module functions you can execute. Using the `salt.runner` and `salt.local` generic actions, you can execute any runner or execution functions, respectively!

Given we&#8217;ve authorized the `stackstorm` user to execute any runner function in Step 2, executing the following will return your living Saltstack minions:

<pre><code class="shell">st2 run salt.runner_manage.up
</code></pre>

## Done Done.

You&#8217;ve successully configured Stackstorm to use the Saltstack pack. Stay tuned for another post on how to add ChatOps to the mix. Leveraging Stackstorm, we can add easily add ChatOps to your Saltstack Infrastructure!

 [1]: http://sophicware.com/
 [2]: https://github.com/StackStorm-Exchange/stackstorm-salt#scenario-2-st2-using-salt-netapi
 [3]: https://docs.saltstack.com/en/2014.7/ref/configuration/master.html#external-auth
 [4]: https://docs.saltstack.com/en/2014.7/ref/auth/all/index.html
 [5]: http://stackstorm.com/wp/wp-content/uploads/2015/07/check-status.gif
 [6]: http://docs.stackstorm.com/packs.html#getting-a-pack
 [7]: http://stackstorm.com/wp/wp-content/uploads/2015/07/action-list.gif