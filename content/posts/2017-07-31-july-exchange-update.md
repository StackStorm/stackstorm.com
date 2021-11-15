---
title: July Exchange Update
author: st2admin
type: post
date: 2017-07-31T17:00:24+00:00
url: /2017/07/31/july-exchange-update/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 6030867157
categories:
  - Blog
  - Community
tags:
  - Community
  - exchange
  - integrations

---
_July 31st, 2017_  
_by Lindsay Hill_

The StackStorm Exchange saw several new packs during July, along with some updates to old favorites. Read on for a roundup of interesting happenings:

<!--more-->

## New Kids on the Block:

  * [Men & Mice][1] &#8211; Actions for working with the [Men & Mice][2] IPAM
  * [Tuleap][3] &#8211; work with the [Tuleap][4] project management system
  * NSX & VDX Hardware VTEP deployment packs. Check the [README][5] for full details

## Updates to Existing Packs

  * [Acos][6] &#8211; Multiple new actions to make it easier to work with your A10 ADCs.
  * [Bitbucket][7] &#8211; now has a sensor for monitoring Bitbucket repositories. In a related move, the [Github][8] sensor now works properly with Enterprise Github servers.
  * [DigitalOcean][9] &#8211; the pack now converts the DigitalOcean objects into dicts & lists that st2 can work with.
  * [Email][10] &#8211; you can now specify multiple `To:` addresses. We’re also working on a complete overhaul of the pack configuration, to make it more intuitive.
  * [HPE ICSP][11] now includes actions for getting a list of currently registered servers, and deleting servers.
  * [Netbox][12] &#8211; new actions for getting next available IP.
  * [Sensu][13] pack has been cleaned up & updated, with updated Sensu libraries. 
  * [Slack][14] pack supports 51 new Slack API actions.
  * [Solarwinds Orion][15] &#8211; new actions to get node ID and asset inventory.
  * [Splunk][16] now returns structured search results, making it much easier to work with.

I’ve also been adding example configuration files to some of those packs that were missing them. This makes it a little easier to understand the configuration, and it improves our testing coverage.

## Review & Upgrade

If you’re using any of the above packs, we encourage you to update to the latest fixes & features. Pay attention to any configuration or usage changes &#8211; you may need to update your workflows.

Don’t forget about the move to `config.schema.yaml`. If you have older pack versions using `config.yaml` files, you must migrate to the [new configuration style][17]. The old style will not work with the upcoming StackStorm 2.4. All packs in the Exchange support this new style.

Thanks as always to those Community members who contributed packs and fixes.

Thinking about submitting a new pack? We’d love to see it! Just open a PR against [github.com/StackStorm-Exchange/exchange-incubator][18], and we’ll help you through the rest of it.

 [1]: https://github.com/StackStorm-Exchange/stackstorm-menandmice
 [2]: https://www.menandmice.com/products/ip-address-management/
 [3]: https://github.com/StackStorm-Exchange/stackstorm-tuleap
 [4]: https://tuleap.org
 [5]: https://github.com/StackStorm-Exchange/stackstorm-nsx_vtep/blob/master/README.md
 [6]: https://github.com/StackStorm-Exchange/stackstorm-acos
 [7]: https://github.com/StackStorm-Exchange/stackstorm-bitbucket
 [8]: https://github.com/StackStorm-Exchange/stackstorm-github
 [9]: https://github.com/StackStorm-Exchange/stackstorm-digitalocean
 [10]: https://github.com/StackStorm-Exchange/stackstorm-email
 [11]: https://github.com/StackStorm-Exchange/stackstorm-hpe_icsp
 [12]: https://github.com/StackStorm-Exchange/stackstorm-netbox
 [13]: https://github.com/StackStorm-Exchange/stackstorm-sensu
 [14]: https://github.com/StackStorm-Exchange/stackstorm-slack
 [15]: https://github.com/StackStorm-Exchange/stackstorm-orion
 [16]: https://github.com/StackStorm-Exchange/stackstorm-splunk
 [17]: https://docs.stackstorm.com/reference/pack_configs.html
 [18]: https://github.com/StackStorm-Exchange/exchange-incubator