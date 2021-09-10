---
title: StackStorm 2.9.1 and Exchange Updates
author: st2admin
type: post
date: 2018-10-24T01:06:17+00:00
url: /2018/10/23/stackstorm-2-9-1-and-exchange-updates/
thrive_post_fonts:
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
_October 23, 2018_  
_by Lindsay Hill_

Late October already &#8211; where did the year go? Well at least part of it was spent making StackStorm better, and adding new packs and actions to the [StackStorm Exchange][1]. Read on for more details about StackStorm 2.9.1, and pack updates to ManageIQ, Jira, ServiceNow, InfluxDB, vSphere, and more:

<!--more-->

## StackStorm 2.9.1

StackStorm 2.9.1 is a minor bugfix release building on top of the work in [2.9][2].

Changes include:

  * Web UI fix for displaying Orquesta workflows
  * Fixed a race when there are multiple requests to resume a workflow
  * Pack registration speedups (more to come here)
  * `st2 pack install` works with local git repos that use a specific git revision

This is a recommended update for all users.

## New & Updated Packs

  * [ManageIQ][3]: New pack for working with the OSS management platform [ManageIQ][4].
  * [NGINX Plus][5]: New actions for working with all the NGINX Plus API endpoints.
  * [Jira][6]: OAuth is&#8230;tricky to get right. Now you can use Basic authentication instead.
  * [vSphere][7]: Now you can do things like shutdown a guest, copy files, and manipulate file paths.
  * [ServiceNow][8]: The team at ServiceNow have deprecated older methods for creating a record. No problem, the pack updates take care of this.
  * [Vault][9]: New action for reading from a defined mount and path.

As always, thanks to all contributors.

 [1]: https://exchange.stackstorm.org/
 [2]: https://stackstorm.com/2018/09/24/stackstorm-2-9-k8s-streaming-inquiries-windows/
 [3]: https://github.com/StackStorm-Exchange/stackstorm-manageiq
 [4]: https://manageiq.org/
 [5]: https://github.com/StackStorm-Exchange/stackstorm-nginxplus
 [6]: https://github.com/StackStorm-Exchange/stackstorm-jira
 [7]: https://github.com/StackStorm-Exchange/stackstorm-vsphere
 [8]: https://github.com/StackStorm-Exchange/stackstorm-servicenow
 [9]: https://github.com/StackStorm-Exchange/stackstorm-vault