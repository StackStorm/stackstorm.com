---
title: February Update
author: st2admin
type: post
date: 2018-03-03T22:35:52+00:00
url: /2018/03/03/february-update/
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
_March 2, 2018_  
_by Lindsay Hill_

A short month, so not so many updates to [StackStorm Exchange][1] this month. But there&#8217;s still a few things going on with Kubernetes, OpenStack, Fortinet, ServiceNow and Microsoft Exchange. Plus some CircleCI news. Here&#8217;s the details:

<!--more-->

## New and Updated Packs This Month

  * [Kubernetes][2]:Lots of changes here. No longer dynamically generating actions from Swagger, instead using `requests()` to connect to the API directly. Also includes support for client certificate-based authentication, . 
      * [Fortinet][3]: [Fortinet][4] make a great range of firewalls, and now you can add Fortinet into your auto-remediation workflows. 
          * [Microsoft Exchange][5]: We fixed a few small bugs that affected users who do not use autodiscovery. 
              * [OpenStack][6]: Neutron and Aodhclient actions are now included, thanks to [Hanxi Liu][7]. 
                  * [ServiceNow][8]: A few small cleanups, related to recent updates to pysnow. Make sure you&#8217;re using the latest version of this pack. </ul> 
                    ## CircleCI 2.0 Migration
                    
                    CircleCI is [sunsetting][9] CircleCI 1.0 on August 31, 2018. StackStorm Exchange packs are using 1.0 right now, so we&#8217;ll migrate those to CircleCI 2.0 in the next few weeks. Should be zero impact to anyone contributing packs. With a bit of luck we might be able to speed up checks. Worst-case, no-one will notice the change.

 [1]: https://exchange.stackstorm.org
 [2]: https://github.com/StackStorm-Exchange/stackstorm-kubernetes
 [3]: https://github.com/StackStorm-Exchange/stackstorm-fortinet
 [4]: https://www.fortinet.com
 [5]: https://github.com/StackStorm-Exchange/stackstorm-msexchange
 [6]: https://github.com/StackStorm-Exchange/stackstorm-openstack
 [7]: https://github.com/apolloliu
 [8]: https://github.com/StackStorm-Exchange/stackstorm-servicenow
 [9]: https://circleci.com/blog/sunsetting-1-0/