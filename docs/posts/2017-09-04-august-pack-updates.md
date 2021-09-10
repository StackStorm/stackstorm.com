---
title: August Pack Updates
author: st2admin
type: post
date: 2017-09-04T23:32:12+00:00
url: /2017/09/04/august-pack-updates/
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6120561333
categories:
  - Community
tags:
  - Community
  - exchange
  - slack

---
August has rolled on by, but our Northern Hemisphere users have not been taking a break over summer: StackStorm Exchange updates continue, with new packs and updates. This time, we also have a request for our AWS pack users.

<!--more-->

### AWS Pack: Your Input Needed

The [AWS pack][1] has had a lot of changes this year, and we&#8217;re now going through some growing pains. Challenges include pack size (over 3,500 actions!), and a mix of `boto2` and `boto3`. We have an open GitHub issue [discussing the future of this pack][2]. We would love to get input from more people using this pack &#8211; as always, we want to make things better for our users.

### New Pack: vRealize Automation

This new pack includes actions and ChatOps aliases for working with VMware&#8217;s [vRealize Automation][3]. Check out [this post][4] from Martez Reed. Thanks!

### Updates to Old Favorites

Here&#8217;s some updates and fixes to some existing packs:

  * [Napalm][5]: you can now specify the port as a configuration parameter. It was always an optional action parameter, but can now be supplied via configuration. 
  * [ActiveDirectory][6]: fixed an issue where module loading could confuse `pywinrm` into thinking an error had occurred. But it hadn&#8217;t. Now it doesn&#8217;t get confused anymore.
  * [Ansible][7]: pack install now includes the necessary dependencies to run playbooks against Windows hosts. 
  * [Tuleap][8]: New actions, and a change to the underlying Python library location. 
  * [Slack][9]: we fixed a bug we&#8217;d introduced when switching to new Slack APIs, and stopped logging potentially sensitive info.
  * [ACOS][10]: Updated version of the acos-client library to use AXAPI 3.0 for changing member status of a ServiceGroup.
  * [ActiveCampaign][11]: Fixed a bug with the webhook sensor, where it could block if receiving multiple requests. Could be a problem if you had a busy system.
  * [vSphere][12]: You can now set the VM IP address when creating a VM from template.

Thanks to all those that contributed with code and bug reports.

### More Contributions Always Welcome

Got an idea for a new pack? Or maybe you&#8217;ve written an internal pack, and you&#8217;d love to see your name beside so many other cool people at the [StackStorm Exchange][13]? Open a Pull Request against the [exchange-incubator][14] repo, and we&#8217;ll help you through the rest.

 [1]: https://github.com/StackStorm-Exchange/stackstorm-aws
 [2]: https://github.com/StackStorm-Exchange/stackstorm-aws/issues/55
 [3]: https://www.vmware.com/products/vrealize-automation.html
 [4]: http://www.greenreedtech.com/vra7-chatops-with-stackstorm/
 [5]: https://github.com/StackStorm-Exchange/stackstorm-napalm
 [6]: https://github.com/StackStorm-Exchange/stackstorm-activedirectory
 [7]: https://github.com/StackStorm-Exchange/stackstorm-ansible
 [8]: https://github.com/StackStorm-Exchange/stackstorm-tuleap
 [9]: https://github.com/StackStorm-Exchange/stackstorm-slack
 [10]: https://github.com/StackStorm-Exchange/stackstorm-acos
 [11]: https://github.com/StackStorm-Exchange/stackstorm-activecampaign
 [12]: https://github.com/StackStorm-Exchange/stackstorm-vsphere
 [13]: https://exchange.stackstorm.org
 [14]: https://github.com/StackStorm-Exchange/exchange-incubator