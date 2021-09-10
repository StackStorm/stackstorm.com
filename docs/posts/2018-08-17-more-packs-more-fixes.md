---
title: More Packs, More Fixes
author: st2admin
type: post
date: 2018-08-17T23:23:30+00:00
url: /2018/08/17/more-packs-more-fixes/
thrive_post_fonts:
  - '[]'
  - '[]'
  - '[]'
  - '[]'
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6455183675
categories:
  - Community
  - News
tags:
  - Community
  - exchange

---
_August 17, 2018_  
_by Lindsay Hill_

Time for another roundup of recent [StackStorm Exchange][1] pack updates. It&#8217;s easy to miss the new packs and updates to old ones. This month it&#8217;s Bolt, Backups, Slack, Jenkins and more. Read on for details.

<!--more-->

## New & Updated Packs

  * [Puppet Bolt][2]: [Bolt][3] is a new tool from Puppet for running ad-hoc tasks across your infrastructure. Now you can run those tasks as StackStorm actions.
  * [Slack][4]: The Slack pack has had a major overhaul. Previously all actions used HTTP GET. This _mostly_ worked&#8230;except when it didn&#8217;t. Now they use the Slack-preferred action &#8211; POST, PUT, etc. The pack has also been updated with the most recent changes to the Slack API.
  * [VMware vSphere][5]: new action `vsphere.vm_guest_info` added to retrieve details about a guest.
  * [Jenkins][6]: Two new actions, to rebuild the last job, and to list jobs by regex pattern. Because everyone loves regex, right?
  * [AWS Boto3][7]: A new `create_instance` workflow is a good example of a complete instance creation workflow.
  * [Terraform][8]: The pipeline workflow has been fixed.
  * [Redis][9]: New `redis.get` action.

## Napalm pack changes

I&#8217;ve been making a couple of changes to the Napalm network automation pack. You can now use a `secret` parameter, to pass in an `enable` password for those devices that need it.

I also have a [related PR][10] that supports the use of SSH keys for authentication, rather than passwords. This needs testing though. If you can, please install the pack with `st2 pack install napalm=ssh_key`, and test it out. If we get some reports that all is OK, I&#8217;ll merge it.

As always, thanks to all contributors.

 [1]: https://exchange.stackstorm.org/
 [2]: https://github.com/StackStorm-Exchange/stackstorm-bolt
 [3]: https://puppet.com/products/puppet-bolt
 [4]: https://github.com/StackStorm-Exchange/stackstorm-slack
 [5]: https://github.com/StackStorm-Exchange/stackstorm-vsphere
 [6]: https://github.com/StackStorm-Exchange/stackstorm-jenkins
 [7]: https://github.com/StackStorm-Exchange/stackstorm-aws_boto3
 [8]: https://github.com/StackStorm-Exchange/stackstorm-terraform
 [9]: https://github.com/StackStorm-Exchange/stackstorm-redis
 [10]: https://github.com/StackStorm-Exchange/stackstorm-napalm/pull/51