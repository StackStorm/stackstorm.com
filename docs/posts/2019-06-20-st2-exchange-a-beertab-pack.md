---
title: ST2 Exchange – A BeerTab Pack??
author: st2admin
type: post
date: 2019-06-20T20:06:56+00:00
url: /2019/06/20/st2-exchange-a-beertab-pack/
thrive_post_fonts:
  - '[]'
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
_June 20, 2019_  
_by Lindsay Hill_

StackStorm can&#8217;t pour you a beer. But now it can keep track of who owes you a beer! Read on for more info about the new [beertab][1] pack, and other new packs & interesting [StackStorm Exchange][2] updates.

<!--more-->

<!--more-->

## BeerTab: Who Owes You a Beer?

Ever find yourself chatting to your colleagues on Slack, you do them a favor, and they say &#8220;Hey, thanks for that, I owe you a beer&#8221;? But then you can&#8217;t remember whose round it is next time you&#8217;re at the pub?

[Nick Maludy][3] often finds himself in this situation. He helps a lot of people, I think we all owe him a drink or two.

So he wrote the [BeerTab][1] pack to help track this. Using ChatOps aliases and the StackStorm [Datastore][4], you can add beers to people&#8217;s tabs, and find out who owes you what:

<img loading="lazy" src="https://raw.githubusercontent.com/StackStorm-Exchange/stackstorm-beertab/master/img/screenshot_add_alias.png" width="658" height="238" class="aligncenter size-full" scale="0" /> 

<img loading="lazy" src="https://raw.githubusercontent.com/StackStorm-Exchange/stackstorm-beertab/master/img/screenshot_get_alias.png" width="661" height="215" class="aligncenter size-full" scale="0" /> 

Nifty, eh?

## What Else is Happening?

On a more serious note, here&#8217;s some other interesting updates to the StackStorm Exchange:

  * [Cohesity][5]: The good people at Cohesity have contributed a pack for working with the [Cohesity DataPlatform][6]. Check it out if you&#8217;re a Cohesity user.
  * [TheHive][7]: Open Source Security Incident Response platform TheHive now works with ST2! We know many ST2 users have security use-cases &#8211; this might help you respond better to incidents.
  * [NS1][8]: Using [NS1][9] DNS services? This new pack provides a heap of actions for working with NS1.

Bugfixes and smaller updates &#8211; check out [Terraform][10], [ManageIq][11], [vSphere][12], [Napalm][13], [GitHub][14], [Kafka][15], and [Zabbix][16] packs &#8211; these have all had small enhancements and bugfixes.

## Lint fluff cleanup

We bumped the `pylint` and `flake8` versions we use as part of our [Exchange CI][17]. This picked up a few linting issues. I&#8217;ve been tidying those up. You may see a couple more small PRs come through. These will be coding style cleanups only, no changes to functionality. No need to immediately update your installations. Any new PRs will use the new rules, as usual: CI must pass before any PR will be merged!

As always, thank you to you: our users & contributors who help keep making StackStorm better.

 [1]: https://github.com/StackStorm-Exchange/stackstorm-beertab
 [2]: https://exchange.stackstorm.org/
 [3]: https://github.com/nmaludy
 [4]: https://docs.stackstorm.com/datastore.html
 [5]: https://github.com/StackStorm-Exchange/stackstorm-cohesity
 [6]: https://www.cohesity.com/products/data-platform/
 [7]: https://github.com/StackStorm-Exchange/stackstorm-thehive
 [8]: https://github.com/StackStorm-Exchange/stackstorm-nsone
 [9]: https://ns1.com/
 [10]: https://github.com/StackStorm-Exchange/stackstorm-terraform
 [11]: https://github.com/StackStorm-Exchange/stackstorm-manageiq
 [12]: https://github.com/StackStorm-Exchange/stackstorm-vsphere
 [13]: https://github.com/StackStorm-Exchange/stackstorm-napalm
 [14]: https://github.com/StackStorm-Exchange/stackstorm-github
 [15]: https://github.com/StackStorm-Exchange/stackstorm-kafka
 [16]: https://github.com/StackStorm-Exchange/stackstorm-zabbix
 [17]: https://github.com/StackStorm-Exchange/ci/blob/master/.circle/requirements-dev.txt