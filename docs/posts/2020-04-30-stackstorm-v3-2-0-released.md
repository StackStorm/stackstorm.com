---
title: StackStorm v3.2.0 released
author: Eugen C.
type: post
date: 2020-04-30T17:43:02+00:00
url: /2020/04/30/stackstorm-v3-2-0-released/
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - News
tags:
  - release

---
<p class="ifp">
  <strong>May 1, 2020</strong><br data-rich-text-line-break="true" /><em>By <a href="https://github.com/armab">Eugen Cusmaunsa (@armab)</a> and <a href="https://github.com/punkrokk">@punkrokk</a></em>
</p>

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2020/04/stackstorm-v3.2.0-release-2.png" alt="" class="aligncenter size-full wp-image-9003" width="952" height="360" srcset="https://stackstorm.com/wp/wp-content/uploads/2020/04/stackstorm-v3.2.0-release-2.png 952w, https://stackstorm.com/wp/wp-content/uploads/2020/04/stackstorm-v3.2.0-release-2-150x57.png 150w, https://stackstorm.com/wp/wp-content/uploads/2020/04/stackstorm-v3.2.0-release-2-300x113.png 300w, https://stackstorm.com/wp/wp-content/uploads/2020/04/stackstorm-v3.2.0-release-2-768x290.png 768w, https://stackstorm.com/wp/wp-content/uploads/2020/04/stackstorm-v3.2.0-release-2-80x30.png 80w, https://stackstorm.com/wp/wp-content/uploads/2020/04/stackstorm-v3.2.0-release-2-220x83.png 220w, https://stackstorm.com/wp/wp-content/uploads/2020/04/stackstorm-v3.2.0-release-2-250x95.png 250w, https://stackstorm.com/wp/wp-content/uploads/2020/04/stackstorm-v3.2.0-release-2-280x106.png 280w, https://stackstorm.com/wp/wp-content/uploads/2020/04/stackstorm-v3.2.0-release-2-510x193.png 510w, https://stackstorm.com/wp/wp-content/uploads/2020/04/stackstorm-v3.2.0-release-2-750x284.png 750w" sizes="(max-width: 952px) 100vw, 952px" /> 

It happened! 🎉 After a long wait, we&#8217;re more than excited to announce the StackStorm `v3.2.0` release.

The StackStorm project has had some turbulent times since the previous release almost one year ago. The new v3.2.0 version is the first release since the project [joined the Linux Foundation][1], formed new [Governance][2], and gathered a new team of [Maintainers][3]. Considering the amount of changes happened, it looks like a big restart for the project.

It&#8217;s awesome for StackStorm to be under new governance. But that also means everything is on the Community&#8217;s shoulders now. And while it&#8217;s harder to rely only on the community&#8217;s efforts compared to the previously dedicated team of full-time employees, these days we&#8217;re observing increased number of contributors and interest from the larger organizations to adopt StackStorm Event Driven Automation and Automated Remediation. We hope this trend continues and we are striving for a better project future and further growth, together.

So what&#8217;s new in StackStorm 3.2.0?  
This version aggregated almost one hundred changes including bugfixes, new [Pack Dependencies][4], [RHEL 8 / CentOS 8 Support][5], Orquesta [retry][6] and [re-run][7] features, [ChatOps updates][8], [Immutable parameters in Action Aliases][9], performance improvements, and more.

<!--more-->

## <a id="more-transparency"></a>More Transparency

This is the first time we have invited our community to participate in the release process. They gave us a hand in the [StackStorm v3.2dev pre-release testing][10], trying out new features and finding any regressions. Thanks to our users, lots of bugs were discovered last-minute and fixed before they landed in the production version!

We opened most of our processes, best practices, [release mechanisms][11], and plans. See the resources below:

  * [Discussions][12]
  * [Wiki][13]
  * [TSC Meetings][14]
  * [Proposals][15]
  * [Project Governance][16]
  * [Contributors & Maintainers][3]
  * [How to start Contributing & become a Maintainer?][17]

With that, anyone can easily create a proposal, participate in existing discussions and give feedback.

## <a id="pack-dependencies"></a>Pack Dependencies

You can now list dependencies on other packs and StackStorm will install them automatically during `st2 pack install`. Here is an example `pack.yaml` definition:

<pre><code class="hljs haml">dependencies:
  -&lt;span class="ruby"> excel
&lt;/span>  -&lt;span class="ruby"> powerpoint=&lt;span class="hljs-number">0&lt;/span>.&lt;span class="hljs-number">2.2&lt;/span>
&lt;/span>  -&lt;span class="ruby"> &lt;span class="hljs-symbol">https:&lt;/span>/&lt;span class="hljs-regexp">/github.com/&lt;/span>&lt;span class="hljs-constant">StackStorm&lt;/span>/stackstorm-ms.git
&lt;/span></code></pre>

See <https://docs.stackstorm.com/latest/packs.html#pack-dependencies> for more info. We&#8217;re expecting new cool patterns and use cases here. How about meta-packages?

## <a id="rhel-8-centos-8-support"></a>RHEL 8 / CentOS 8 Support

This is the second modern OS that we added after Ubuntu Bionic 18.04 LTS which comes with `Python 3.6` and `MongoDB 4.0`. There is no Mistral for new platforms, Orquesta replaced it as a main workflow engine. It&#8217;s time to start planning to upgrade to newer OSes. <span>Keep in mind that RHEL 8 / CentOS 8 is new &#8211; please report any bugs if you spot them.</span>

See <https://docs.stackstorm.com/install/rhel8.html> for more info. Great to have this highly requested feature!

## <a id="orquesta"></a>Orquesta

### `<code>`</code><a id="orquesta-retry"></a>`retry` in workflow definition

Orquesta task retry in workflow definition is a new awesome addition:

<pre><code class="hljs stylus">  action: core&lt;span class="hljs-class">.http&lt;/span> url=https:&lt;span class="hljs-comment">//stackstorm.com/&lt;/span>
  retry:
    count: &lt;span class="hljs-number">3&lt;/span>
    delay: &lt;span class="hljs-number">1&lt;/span>
</code></pre>

This should greatly improve operations where specific tasks can be flaky and non-idempotent by nature. So tasks related to networking, installations, and downloads ([Github&#8217;s 503 unicorn][18] is looking at you) can be placed under the retry.

<https://docs.stackstorm.com/latest/orquesta/languages/orquesta.html#task-retry-model> covers more examples.

### `<code>`</code><a id="orquesta-re-run"></a>`re-run` workflow from a specific step

Do you have a task that failed in the middle of workflow? The new Orquesta feature allows a workflow execution to be re-run from a specific task instead of starting from the beginning of the workflow:

<pre><code class="hljs applescript">st2 execution re-&lt;span class="hljs-command">run&lt;/span> &lt;execution-&lt;span class="hljs-property">id&lt;/span>&gt; &lt;span class="hljs-comment">--tasks &lt;task_name&gt;&lt;/span>
</code></pre>

Check out <https://docs.stackstorm.com/latest/orquesta/operations.html#re-running-workflow-execution-from-task-s> for more examples and explanation.

## <a id="chatops"></a>ChatOps

### <a id="chatops-refactoring"></a>Refactoring

ChatOps got a good overhaul and refactoring with the fixes and updates for chat adapters like Microsoft Teams, Mattermost, Cisco Spark (Webex).

### <a id="chatops-immutable-parameters"></a>Immutable Parameters

There is also a new goodie. Immutable parameters in action aliases, &#8211; one of the [most requested][19] improvements to chatops aliases. It allows you to predefine in alias custom values to be passed to an action. Previously another middle-action was needed to achieve this. Now this shortcut could be done just by using alias definition:

<pre><code class="hljs handlebars">&lt;span class="xml">---
name: pack1.restart-nginx
description: Just restart nginx on host001
action_ref: linux.service

formats:
  - "restart nginx"
immutable_parameters:
  service: nginx
  act: restart
  hosts: host001
  private_key: "&lt;/span>&lt;span class="hljs-expression">{{ &lt;span class="hljs-variable">st&lt;/span>2&lt;span class="hljs-variable">kv&lt;/span>('&lt;span class="hljs-variable">system.host&lt;/span>001_&lt;span class="hljs-variable">private&lt;/span>_&lt;span class="hljs-variable">key&lt;/span>', &lt;span class="hljs-variable">decrypt&lt;/span>=&lt;span class="hljs-variable">true&lt;/span>) }}&lt;/span>&lt;span class="xml">"
&lt;/span></code></pre>

Check out documentation: <https://docs.stackstorm.com/chatops/aliases.html#with-immutable-parameters>. Thanks [@nicholasamorim][20] for contributing this!

## <a id="platform-bugfixes"></a>Platform Bugfixes

StackStorm and its components accumulated almost 100 changes including bugfixes for better stability and performance. Check out full [CHANGELOG][21].

## <a id="deprecation-notice"></a>Deprecation Notice

This is the last release that will support [Mistral][22]. StackStorm has been headed in this direction for years and now [Orquesta][23], StackStorm&#8217;s home-grown workflow engine matured enough to outperform Mistral in its functionality, architecture, and performance. StackStorm&#8217;s next `v3.3` release will remove Mistral as a Workflow Engine completely and also allow us to get rid of infrastructure dependency like PostgreSQL. We&#8217;re super excited about this change and happy to simplify the platform architecture and deployment!

Mistral is not the only thing that will be removed. StackStorm `v3.2` is the last release that will support `RHEL 6` / `CentOS 6`, which reached its EOL. Supporting it for years was a pain and our team can&#8217;t wait to get rid of the EL6 hacks across the codebase.

## <a id="help-needed"></a>Help Needed!

StackStorm includes a lot of components that makes it a great  and complete project: [st2][24] core platform, st2 plugins and modules, [documentation][25], [StackStorm Exchange][26] with the `150`+ integration packs, [Web UI][27], the [Orquesta workflow engine][28], [deb/rpm packages][29], [CI][30]/[CD][31], [ChatOps][32], internal infrastructure and a number of deployment methods like [Puppet][33], [Chef][34], [Ansible][35], [Docker][36], [Kubernetes][37], [Vagrant][38] as well as our [Forum][39] and [Slack Communities][40]. This is maintained by just a few folks during their free time.

The elephant in the room is our Web UI and ChatOps which are Javascript-based. <span>Going forward as bugs accumulate, npm dependencies come out of date, we no longer have a paid resource on maintaining those repositories and at this moment nobody from the <a href="https://github.com/StackStorm/st2/blob/master/OWNERS.md">Project Maintainers</a> has professional experience with ReactJS (<code>st2web</code>) and node.js (<code>st2chatops</code>).</span>

> **Community Call to Action!**
> 
> We invite our Javascript-savvy community to step in and help us maintain patching and start working on other backlog items. `st2web` and `st2chatops` needs a maintainer:
> 
>   * [StackStorm/st2web/issues][41]
>   * [StackStorm/st2chatops/issues][42][][42]
>   * [StackStorm/hubot-stackstorm/issues][43]

If you&#8217;re using StackStorm in your org, &#8211; it&#8217;s the best time to get involved and help the project you trust in your production environment!

* * *

Enjoy new StackStorm `v3.2.0` and don&#8217;t forget to follow the [Upgrade Notes][44].

Soon we&#8217;ll have very exciting big news everyone would love to hear which by its magnitude may be a candidate for a major `4.0` version, so check back soon! Join our [Slack Community][40] for that announcement and follow us on Twitter [@Stack_Storm][45].

 [1]: https://stackstorm.com/2019/10/07/stackstorm-joins-the-linux-foundation/
 [2]: https://stackstorm.com/2020/02/20/stackstorm-governance-and-maintainers/
 [3]: https://github.com/StackStorm/st2/blob/master/OWNERS.md
 [4]: #pack-dependencies
 [5]: #rhel-8-centos-8-support
 [6]: #orquesta-retry
 [7]: #orquesta-re-run
 [8]: #chatops-refactoring
 [9]: #chatops-immutable-parameters
 [10]: https://github.com/StackStorm/discussions/issues/6
 [11]: https://github.com/StackStorm/discussions/wiki/Release-Process
 [12]: https://github.com/stackstorm/discussions
 [13]: https://github.com/stackstorm/discussions/wiki
 [14]: https://github.com/StackStorm/discussions/issues?q=is%3Aissue+is%3Aopen+label%3ATSC%3Ameeting
 [15]: https://github.com/stackstorm/discussions/issues?q=is%3Aissue+is%3Aopen+label%3Aproposal
 [16]: https://github.com/StackStorm/st2/blob/master/GOVERNANCE.md
 [17]: https://github.com/StackStorm/st2/blob/master/GOVERNANCE.md#how-to-start-contributing
 [18]: https://github.com/503.html
 [19]: //github.com/StackStorm/st2/issues/1704)
 [20]: https://github.com/nicholasamorim
 [21]: https://github.com/StackStorm/st2/blob/master/CHANGELOG.rst#320---april-27-2020
 [22]: https://docs.stackstorm.com/mistral.html
 [23]: https://docs.stackstorm.com/orquesta/index.html
 [24]: https://github.com/stackstorm/st2
 [25]: https://docs.stackstorm.com/
 [26]: https://exchange.stackstorm.org/
 [27]: https://github.com/stackstorm/st2docs
 [28]: https://github.com/stackstorm/orquesta
 [29]: https://github.com/stackstorm/st2-packages
 [30]: https://github.com/stackstorm/st2ci
 [31]: https://github.com/stackstorm/st2cd
 [32]: https://github.com/stackstorm/st2chatops
 [33]: https://github.com/stackstorm/puppet-st2
 [34]: https://github.com/stackstorm/chef-stackstorm
 [35]: https://github.com/stackstorm/ansible-st2
 [36]: https://docs.stackstorm.com/install/docker.html
 [37]: https://github.com/stackstorm/stackstorm-ha
 [38]: https://docs.stackstorm.com/install/vagrant.html
 [39]: https://forum.stackstorm.com/
 [40]: https://stackstorm.com/community-signup
 [41]: https://github.com/stackstorm/st2web/issues
 [42]: https://github.com/StackStorm/st2chatops/issues
 [43]: https://github.com/StackStorm/hubot-stackstorm/issues
 [44]: https://docs.stackstorm.com/latest/upgrade_notes.html#st2-v3-2
 [45]: https://twitter.com/Stack_Storm