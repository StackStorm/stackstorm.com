---
title: StackStorm v3.5.0 Released
author: Amanda McGuinness
type: post
date: 2021-06-30T06:59:55+00:00
url: /2021/06/29/stackstorm-v3-5-0-released/
thrive_post_fonts:
  - '[]'
  - '[]'
categories:
  - Blog
  - Community
  - News
tags:
  - release
  - release announcement

---
**June 29, 2021**

_by [Amanda McGuinness][1] of [Ammeon Solutions][2]_ _and_ _[Marcel Weinberg][3]_

<span>It has been nearly 4 months since our</span><span> </span>previous[<span> </span><span>v3.4.0 release</span>][4]<span> </span>and we’re super excited about this one!

With Ubuntu 16.04 reaching end-of-life, we are pleased to announce support for Ubuntu 20.04 (Focal Fossa). We have also included lots of performance improvements in v3.5.0.  
  
See below, for further information on what&#8217;s included in the release.

<!--more-->

_ _

## Ubuntu Support

Ubuntu 16.04 (Xenial Xerus) reached end-of-life at the end of April 2021, and therefore support for it has been removed from StackStorm v3.5.0 onwards. 

We are pleased to announce that StackStorm v3.5.0 has added support for Ubuntu 20.04 (Focal Fossa), which will be supported with MongoDB v4.4 and Python 3.8.

We continue to support Ubuntu 18.04 (Bionic Beaver) and RedHat Enterprise Linux/CentOS 7 and 8, with MongoDB v4.0 and Python 3.6.

## Performance Improvements

Even faster&#8230;

There have been a lot of performance improvements added to the v3.5.0 release, mainly in the database abstraction layer. Look out for a future blog post, that describes in detail the performance improvements and the benchmark results. These changes will substantially speed up action executions and workflow runs for most users, especially when large amounts of JSON are passed between actions.

On top of improving the database abstraction layer, contributors also improved the API/CLI/Web UI and service start-up times, so restarting StackStorm microservices should take less time than before.

## Redis Coordination Backend

As Orquesta workflows become more complex, a coordination backend is required. Previously, this was an optional StackStorm component, but now the one-line bash installer installs Redis as a co-ordination backend by default. Other coordination backends are also supported so please check out the [coordination documentation page][5] for more information.

## Upgrades

Please follow the [Upgrade Instructions][6] and [Notes for 3.5.0][7] release from the documentation to understand the extra steps required for upgrading from v3.4.1 to v3.5.0.

## Other Changes

Additional changes include:

  * `Node.js` was upgraded to v14 for `st2chatops`
  * `Nginx` configuration has been updated to support TLS v1.2 and v1.3
  * A number of improvements have been made to the `Web UI`, including support for task retry and delay in the Workflow Designer, restriction on username and password length, and inactivity timers and automatic logout
  * The <code class="EnlighterJSRAW" data-enlighter-language="generic">st2</code> client now supports getting multiple resources in a single `st2 get` command
  * Rules on loading and configuring packs were tightened up a bit, so from now on, duplicate action parameters (or action parameters that are also defined in the action runner) will prevent packs from loading from v3.5.0 onwards

For the full list of changes, please check out the release [changelog][8].

## Future Work

Given the feedback we received from the [ChatOps 2020 User Survey][9] we are still working on rewriting st2chatops in Python and improving its integration with the rest of StackStorm. This will not be an easy task, so please pitch in and help out if you can! Find [StackStorm v3.6.0 Roadmap][10] project and [ChatOps Discussion][11] on Github.

## Special Thanks

Special thanks to [Tomaz][12] [Muraus][12] for all the performance investigation and improvement tasks, as well as his help on the Ubuntu 20.04 support.

Ubuntu 20.04 support was planned and organised by [Carlos][13]. He performed a lot of the tasks involved, with assistance from others in the community.  
  
Thanks to [Orchestral][14] for their enhancements on security hardening and Web UI.

[Marcel Weinberg][3] was a great assistant release manager, helping me to keep an eye on the release plan, assisting on the Ubuntu 20.04 work, and helping with the pre-release and release testing. Thanks to [Eugen][15] and [blag][16] for their guidance and help throughout the release, and assisting me with the release process.

We&#8217;d like to thank everyone who has contributed towards the release: providing PR fixes, raising issues, commenting on discussions, etc. This release would not have been possible without the support, testing, and contributions from the community!

## P.S.

If StackStorm was helpful to you, please make a [Donation][17] to the project CommunityBridge profile. The funds will be used to support the StackStorm infrastructure behind the releases, packages, CI/CD.

 [1]: https://github.com/amanda11
 [2]: https://www.ammeonsolutions.com/
 [3]: https://github.com/winem
 [4]: https://stackstorm.com/2021/03/04/v3-4-0-released/
 [5]: https://docs.stackstorm.com/coordination.html
 [6]: https://docs.stackstorm.com/install/upgrades.html#v3-5
 [7]: https://docs.stackstorm.com/upgrade_notes.html#st2-v3-5
 [8]: https://docs.stackstorm.com/changelog.html#june-23-2021
 [9]: https://stackstorm.com/2020/08/03/2020-chatops-user-survey/
 [10]: https://github.com/orgs/StackStorm/projects/22
 [11]: https://github.com/StackStorm/discussions/issues/8
 [12]: https://github.com/Kami
 [13]: https://github.com/nzlosh
 [14]: https://orchestral.ai/
 [15]: https://github.com/armab
 [16]: https://github.com/blag
 [17]: https://stackstorm.com/donate/