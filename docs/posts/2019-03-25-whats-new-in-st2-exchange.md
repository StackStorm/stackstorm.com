---
title: What’s new in ST2 Exchange?
author: st2admin
type: post
date: 2019-03-26T03:03:13+00:00
url: /2019/03/25/whats-new-in-st2-exchange/
thrive_post_fonts:
  - '[]'
  - '[]'
  - '[]'
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
  - release
  - release announcement

---
_March 25, 2019_  
_by Lindsay Hill_

Hey folks, been a little while since we&#8217;ve done a roundup of new & interesting pack updates. This time it&#8217;s Telegram, vSphere, Terraform, Napalm, Icinga2 and more. We&#8217;ve also been doing some background preparation work for Python 3. Read on for the full details.

<!--more-->

## New & Updated Packs

  * [Nexus3][1]: A new pack! Support for the [Sonatype Nexus repository][2].
  * [Napalm][3]: Running really old Cisco Nexus gear, but you&#8217;re also into automation? That&#8217;s a tough Venn Diagram intersection, but it&#8217;s OK: you can now use the `nxos_ssh` driver with Napalm.
  * [Infoblox][4]: CRUD actions for handling HOST records have been added.
  * [Terraform][5]: More actions for importing objects, and more options for `plan` and `apply`.
  * [vSphere][6]: More actions for assigning tags & custom attributes, and finding the path of a VM&#8217;s folder.
  * [Icinga2][7]: Your beloved author wrote some so-so code to get rid of `pycurl` from the Icinga2 pack, replacing it with `requests()`-based code. Much simpler install, much better for handling Unicode, Python3, etc.
  * [Telegram][8]: I was shocked, shocked! to find out we didn&#8217;t support emojis in the Telegram pack. This has been resolved. Phew.

<img src="https://user-images.githubusercontent.com/33657518/54494414-c6eb4300-48b8-11e9-874e-e1647a252668.png" scale="0" /> 

## Python 3 CI

Python 2.7 goes End of Life on [January 1, 2020][9]. We&#8217;re making preparations, getting everything in order for running all of StackStorm with Python 3. The observant amongst you will notice that we&#8217;ve updated our [CircleCI configuration][10] to run checks against both Python 2.7 **and** 3.6. Python 3.6 CI failures are non-fatal today, but this will change in future.

The `master` branch of StackStorm now supports a `python_versions`parameter in `pack.yaml`. In future this will be used to determine if Python 2/3 CI checks should be fatal.

We&#8217;ve also updated our CircleCI configs to perform weekly CI runs, in addition to the checks performed at every PR and merge to master. This will help us pick up anything that might have crept in along the way, e.g. updated `flake8` or `pylint` rules, or changes to unpinned upstream libraries.

As always, thank you to you: our users & contributors who help keep making StackStorm better.

 [1]: https://github.com/StackStorm-Exchange/stackstorm-nexus3
 [2]: https://www.sonatype.com/nexus-repository-oss
 [3]: https://github.com/StackStorm-Exchange/stackstorm-napalm
 [4]: https://github.com/StackStorm-Exchange/stackstorm-infoblox
 [5]: https://github.com/StackStorm-Exchange/stackstorm-terraform
 [6]: https://github.com/StackStorm-Exchange/stackstorm-vsphere
 [7]: https://github.com/StackStorm-Exchange/stackstorm-icinga2
 [8]: https://github.com/StackStorm-Exchange/stackstorm-telegram
 [9]: https://pythonclock.org/
 [10]: https://github.com/StackStorm-Exchange/stackstorm-st2/blob/master/.circleci/config.yml#L49