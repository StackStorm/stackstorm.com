---
title: Recent Exchange Updates
author: st2admin
type: post
date: 2018-06-04T00:35:55+00:00
url: /2018/06/03/recent-exchange-updates/
thrive_post_fonts:
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
_June 3, 2018_  
_by Lindsay Hill_

Here&#8217;s a few of the recent updates to [StackStorm Exchange][1]. New packs for Check Point, Infoblox, Cisco ACI and vCloud Director, and CircleCI 2.0 migration complete. Here&#8217;s the details:

<!--more-->

## New Packs This Month

  * [Check Point][2]: [Check Point][3] firewalls have been a long-term staple in many datacenters. Your author once spent much of his life dealing with the &#8220;peculiar&#8221; challenges of Check Point firewalls. Now you can write StackStorm threat response workflows to block IP addresses using Check Point.
  * [Infoblox][4]: [Infoblox][5] is a very popular IPAM, DHCP, and DNS system. Thanks to [Anthony Shaw][6] and his colleagues at [Dimension Data][7] for this great contribution.
  * [Cisco ACI][8]: [Cisco ACI][9] provides software-defined data center networking. You can now write workflows to do things such as create Application Profiles, Endpoint Groups, VRFs, etc.
  * [vCloud Director][10]: VMware&#8217;s vCloud Director can be used to provision SDDC services. Thanks to Paul Mulvihill for this pack providing VCD actions.

## CircleCI 2.0

All Exchange packs have been switched to use CircleCI 2.0 for CI tests. Well ahead of the August 31 2018 1.0 sunset. Every pack has had its `circle.yml` file updated and moved to `.circleci/config.yml`. This change triggered a rebuild on all packs, which in turn identified linting issues in some packs. This is generally due to updated pylint/flake8 versions picking up a few new issues, sometimes its due to pip dependency changes. So if you&#8217;re paying attention, you will have seen quite a few minor linting changes to packs. This means a small version bump. We recommend updating your packs.

> PS: If you&#8217;re ever looking to boost your GitHub contributor score, making a change across all Exchange packs is a **great** way to do it. Or so I hear 🙂

As always, thanks to all contributors.

 [1]: https://exchange.stackstorm.org
 [2]: https://github.com/StackStorm-Exchange/stackstorm-checkpoint
 [3]: https://www.checkpoint.com/
 [4]: https://github.com/StackStorm-Exchange/stackstorm-infoblox
 [5]: https://www.infoblox.com/
 [6]: https://twitter.com/anthonypjshaw
 [7]: https://www.dimensiondata.com/
 [8]: https://github.com/StackStorm-Exchange/stackstorm-cisco_aci
 [9]: https://www.cisco.com/c/en/us/solutions/data-center-virtualization/application-centric-infrastructure/index.html
 [10]: https://github.com/StackStorm-Exchange/stackstorm-vcd