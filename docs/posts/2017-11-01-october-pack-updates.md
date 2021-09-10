---
title: October Pack Updates
author: st2admin
type: post
date: 2017-11-02T00:00:50+00:00
url: /2017/11/01/october-pack-updates/
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6257087271
categories:
  - Community
  - News
tags:
  - Community
  - exchange

---
_November 1, 2017_  
_by Lindsay Hill_

More packs, more updates, more goodness. Here&#8217;s October&#8217;s roundup of new & changed packs. Zabbix, Keycloak, Foreman, Solarwinds and more. Plus a couple of proposals for pack changes to Kubernetes and AWS, and a warning about upcoming Python action changes.

<!--more-->

## New Packs!

  * [Napalm Logs][1]: You&#8217;ve probably already heard of the [Napalm][2] network automation project &#8211; this is a sister project that aims to normalise network device syslog messages. This sensor lets you turn those logs into ST2 triggers.</p> 
  * [Keycloak][3]: Actions for working with [Keycloak][4], an Open Source Identity and Access Management system.

  * [Zabbix][5]: You have always been able to submit webhooks from Zabbix to ST2. But now we have an integration pack, and a well-documented story on how to raise triggers in ST2 when things happen in Zabbix.

## Noteworthy Updates

Here&#8217;s a few of the more interesting pack changes in October:

  * [Solarwinds Orion][6]: Added multiple new actions for querying agent information, deleting nodes, and allow setting nodes to be unmanaged for a specific time in future.</p> 
  * [Foreman][7]: Actions are now auto-generated from the Foreman API. Be warned: This is a breaking change. Read the [README][8]. We think the change is worth it.

  * [Rabbitmq][9] Fixed a long-standing bug where the sensor always returned the last queue name. This was a bit annoying if you were trying to monitor multiple queues.

## RFC #1: AWS Pack Changes

We have been having discussions [about the future of the AWS Pack][10]. One approach is to have a separate pack per AWS service. Andy Moore has generated a whole bunch of example PRs to show what this [looks like][11]. Got some feedback on this approach? Please weigh in.

## RFC #2: Kubernetes Pack

The Kubernetes API can change between versions. AndyMoore proposes that we [align our pack versions with the Kubernetes version][12]. So if you are running Kubernetes v1.4, you would install the v1.4 version of the ST2 pack with `st2 pack install kubernetes=1.4`. This seems sensible to me. Agree? Disagree? Let us know via that GitHub issue.

## Technical Note: Changed Action Import Path

If you are writing Python actions, pay attention to this change. We have changed the `Action` import path. Previously most Python actions would have this line:

    from st2actions.runners.pythonrunner import Action
    

This should now be:

    from st2common.runners.base_action import Action
    

Right now both styles will work, but we will remove the older option in StackStorm 2.7. We are in the process of updating all packs on the Exchange.

## Want to add your own pack?

No problem &#8211; just submit a PR against [exchange-incubator][13]. We&#8217;ll help you through the rest. It&#8217;s pretty easy, and we promise not to bite.

 [1]: https://github.com/StackStorm-Exchange/stackstorm-napalm_logs
 [2]: https://napalm.readthedocs.io/en/latest/
 [3]: https://github.com/StackStorm-Exchange/stackstorm-keycloak
 [4]: http://www.keycloak.org/
 [5]: https://github.com/StackStorm-Exchange/stackstorm-zabbix
 [6]: https://github.com/StackStorm-Exchange/stackstorm-orion/pull
 [7]: https://github.com/StackStorm-Exchange/stackstorm-foreman
 [8]: https://github.com/StackStorm-Exchange/stackstorm-foreman/blob/master/README.md
 [9]: https://github.com/StackStorm-Exchange/stackstorm-rabbitmq
 [10]: https://github.com/StackStorm-Exchange/stackstorm-aws/issues/55
 [11]: https://github.com/StackStorm-Exchange/exchange-incubator/pulls?utf8=%E2%9C%93&q=is%3Apr%20author%3AAndyMoore%20
 [12]: https://github.com/StackStorm-Exchange/stackstorm-kubernetes/issues/18
 [13]: https://github.com/StackStorm-Exchange/exchange-incubator