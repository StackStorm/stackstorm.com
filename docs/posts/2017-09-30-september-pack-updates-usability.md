---
title: 'September Pack Updates: Usability'
author: st2admin
type: post
date: 2017-09-30T22:54:48+00:00
url: /2017/09/30/september-pack-updates-usability/
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6185046952
categories:
  - Community
  - News
tags:
  - exchange
  - integration packs

---
Time for our monthly roundup of new packs on the [StackStorm Exchange][1]. This time it&#8217;s a new pack for Extreme Networks devices, and usability improvements to the Email, Ansible, Sensu and Napalm packs.

<!--more-->

### New Pack: EXOS

StackStorm will soon become part of [Extreme Networks][2]. As just a little taste of what&#8217;s to come, we now have an [EXOS pack][3] for running commands on EXOS devices.

Expect to see tighter integration with Extreme Networks devices in future.

### Usability Improvements

Here&#8217;s a few fixes and changes to make it easier to use some of the existing packs

  * [Email][4]: Some elements of the configuration were really confusing. It didn&#8217;t really make sense to use accounts under &#8220;imap_mailboxes&#8221; for outbound email. We&#8217;ve overhauled the pack to make things clearer. NB: You **must** update your configuration to use the new pack. We&#8217;re sure the migration will be worth it.
  * [Ansible][5]: Handling of JSON values in `--extra-vars` now works properly.
  * [Sensu][6]: The core pack itself hasn&#8217;t changed, but now the Sensu handler code is distributed as a Sensu plugin. This means you can install it using `sudo sensu-install -p stackstorm` on your Sensu server. Much simpler, and easier to automate.
  * [Napalm][7]: Improved exception handling, in particular better error messages for when you&#8217;ve forgotten to configure the pack, or load the configuration. 

Thanks to all those that contributed with code and bug reports.

### More Contributions Always Welcome

Got an idea for a new pack? Or maybe you&#8217;ve written an internal pack, and you&#8217;d love to see your name beside so many other cool people at the [StackStorm Exchange][1]? Open a Pull Request against the [exchange-incubator][8] repo, and we&#8217;ll help you through the rest.

 [1]: https://exchange.stackstorm.org
 [2]: http://www.extremenetworks.com
 [3]: https://github.com/StackStorm-Exchange/stackstorm-exos
 [4]: https://github.com/StackStorm-Exchange/stackstorm-email
 [5]: https://github.com/StackStorm-Exchange/stackstorm-ansible
 [6]: https://github.com/StackStorm-Exchange/stackstorm-sensu
 [7]: https://github.com/StackStorm-Exchange/stackstorm-napalm
 [8]: https://github.com/StackStorm-Exchange/exchange-incubator