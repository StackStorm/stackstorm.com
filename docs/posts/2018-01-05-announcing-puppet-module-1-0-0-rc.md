---
title: Puppet Module to Install StackStorm – Announcing Release Candidate
author: Eugen C.
type: post
date: 2018-01-05T17:27:00+00:00
url: /2018/01/05/announcing-puppet-module-1-0-0-rc/
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6393526506
categories:
  - Blog
  - Community
  - News
tags:
  - 1.0.0-rc
  - configuration management
  - puppet
  - release

---
**January 4, 2018**  
_By [Nick Maludy][1] of [Encore Technologies][2]_

So far StackStorm has multiple installation methods: deb/rpm packages, [`curl|bash`][3] installer used for simple deployments, [Docker][4], [Ansible][5], [Chef][6].

Now it&#8217;s Puppet time!

Starting in July of 2017 a major effort has been underway to modernize the Puppet module to install/deploy StackStorm. In August of 2017 `v1.0.0-beta` was released with completely re-worked internals to support the new StackStorm `deb/rpm` package installation method and fix a large number of bugs. Since the beta we’ve continued development of new features like supporting all 4 StackStorm OSes, Puppet 4 and 5 compatibility, ChatOps installation and configuration, modernized pack management, full integration testing in Docker containers along with a slew of Puppet best practices improvements.

Today we’re proud to announce the Release Candidate version `v1.0.0-rc` of the [`stackstorm-st2`][7] Puppet module which is available on Forge.  
[  
<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/01/stackstorm_st2_·_Puppet_Forge_-_2018-01-04_18.09.50.png" alt="" width="1312" height="756" class="aligncenter size-full wp-image-7607" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/01/stackstorm_st2_·_Puppet_Forge_-_2018-01-04_18.09.50.png 1312w, https://stackstorm.com/wp/wp-content/uploads/2018/01/stackstorm_st2_·_Puppet_Forge_-_2018-01-04_18.09.50-150x86.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/01/stackstorm_st2_·_Puppet_Forge_-_2018-01-04_18.09.50-300x173.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/01/stackstorm_st2_·_Puppet_Forge_-_2018-01-04_18.09.50-768x443.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/01/stackstorm_st2_·_Puppet_Forge_-_2018-01-04_18.09.50-1024x590.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2018/01/stackstorm_st2_·_Puppet_Forge_-_2018-01-04_18.09.50-80x46.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/01/stackstorm_st2_·_Puppet_Forge_-_2018-01-04_18.09.50-220x127.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/01/stackstorm_st2_·_Puppet_Forge_-_2018-01-04_18.09.50-174x100.png 174w, https://stackstorm.com/wp/wp-content/uploads/2018/01/stackstorm_st2_·_Puppet_Forge_-_2018-01-04_18.09.50-260x150.png 260w, https://stackstorm.com/wp/wp-content/uploads/2018/01/stackstorm_st2_·_Puppet_Forge_-_2018-01-04_18.09.50-413x238.png 413w, https://stackstorm.com/wp/wp-content/uploads/2018/01/stackstorm_st2_·_Puppet_Forge_-_2018-01-04_18.09.50-720x415.png 720w, https://stackstorm.com/wp/wp-content/uploads/2018/01/stackstorm_st2_·_Puppet_Forge_-_2018-01-04_18.09.50-845x487.png 845w, https://stackstorm.com/wp/wp-content/uploads/2018/01/stackstorm_st2_·_Puppet_Forge_-_2018-01-04_18.09.50-1033x595.png 1033w" sizes="(max-width: 1312px) 100vw, 1312px" />  
https://forge.puppet.com/stackstorm/st2  
][8]  
Our plan is to release `v1.0.0` stable in the coming weeks, but in order to do this we need your help. We ask everyone who is interested in Puppet-based deployment to give the module a try and provide your feedback!

Keep reading to find out more details about what’s changed and where the project is heading.

<!--more-->

## Modernization Improvements

  * Support latest versions of StackStorm. Prior to `1.0.0-beta` the module was designed around the legacy deployment system. This has been upgraded to the modern package deployment methodology. These changes were ported over.</p> 
  * Support all StackStorm OSes (Ubuntu 14.04, Ubuntu 16.06, CentOS/RHEL 6, CentOS/RHEL 7). Previously the module was not running properly on several of the distributions. A great deal of work has gone into making the module cross-platform compatible.

  * Puppet linting and best practices. Upgraded the style of a majority of the code to validate against modern `puppet-lint` tests.

  * Integration testing. New in `1.0.0-rc`, we&#8217;ve gone and completely rewritten the build system to run in an several isolated Docker environments. This means that every time a build is triggered, `stackstorm/st2` is used to install StackStorm on every supported OS version.

  * Support for Puppet 4.x and Puppet 5.x. New in `1.0.0-rc`. Tied into the integration testing effort, we&#8217;ve also introduced tests for running the module with modern versions of Puppet.

## What Else Has Changed

Some highlights of changes since `v1.0.0-beta`:

  * Migrated to voxpupuli puppet/rabbitmq module and puppet/mongodb modules.</p> 
  * Upgraded NodeJS to 6.x when installing StackStorm >= 2.4.0.

  * Upgraded MongoDB to 3.4 when installing StackStorm >= 2.4.0.

  * New type and provider for managing st2 packs: `st2_pack`.

  * Added new parameter `index_url` to `::st2` allowing custom st2 Exchange

  * Added a new class `st2::profie::chatops` to manage the chatops package, service and configuration.

  * Added new parameters `mongodb_manage_repo` and `nginx_manage_repo` to `::st2` so that the repository can be managed by an external system and not the `stackstorm-st2` module.

  * Added Slack notifications to https://stackstorm-community.slack.com `#puppet` for Travis build failures.

## Future Ideas

That&#8217;s where we&#8217;ve been, here&#8217;s some ideas of where we&#8217;re going:

  * Support for all auth backends (MongoDB, PAM, LDAP, etc).</p> 
  * Improve unit testing coverage.

  * Integration testing verification using `InSpec` or `Serverspec`.

  * Splitting `::st2::profile::server` into component services.

  * High Availability support.

## How Can You Get Started?

We&#8217;ve focused on making getting started with the `stackstorm-st2` module as simple as possible. Just include the full install class in your manifest for a node and you&#8217;re on your way!

<pre><code class="puppet">include ::st2::profile::fullinstall
</code></pre>

This will install StackStorm and all it dependencies!

If you&#8217;re using [r10k][9] or [librarian-puppet][10] to manage your module dependencies, you can reference our `Puppetfile` for your distribution:

  * [RHEL/CentOS 6][11]
  * [RHEL/CentOS 7][12]
  * [Puppet 4.0][13]
  * [Puppet 5.0][14]
  * [Ubuntu 14.04][15]
  * [Ubuntu 16.06][16]

For more info, checkout the [README][7].

## Participation

The `stackstorm-st2` module welcomes any and all contributions (including bug reports)!

If you&#8217;re curious how you can help, check out our [issues list][17], or drop by the `#puppet` channel questions in our [public Slack workspace][18]. We’re always looking for new and exciting ideas for how we can make StackStorm and its supporting projects like the `stackstorm/st2` Puppet module better, so don’t be shy!

## Thanks

A very big thank you goes out to all those who&#8217;ve contributed code to this release!

  * Nick Maludy [@nmaludy][1]
  * Rurik Ylä-Onnenvuori [@ruriky][19]
  * [@bdandoy][20]
  * Eugen C. [@armab][21]

> P.S.  
> From the StackStorm side, we want to thank our partners from [Encore Technologies][2], particularly [Nick Maludy][1] for taking the lead with the Puppet Module [github.com/StackStorm/puppet-st2][7]. As an advanced user, you know best what&#8217;s needed from StackStorm deployment & configuration and contribute to that.  
> That&#8217;s the power of Open Source!

 [1]: https://github.com/nmaludy
 [2]: http://www.encore.tech
 [3]: https://docs.stackstorm.com/install/index.html#ref-one-line-install
 [4]: https://github.com/stackstorm/st2-docker
 [5]: https://github.com/stackstorm/ansible-st2
 [6]: https://github.com/stackstorm/chef-stackstorm
 [7]: https://github.com/StackStorm/puppet-st2
 [8]: https://forge.puppet.com/stackstorm/st2
 [9]: https://github.com/puppetlabs/r10k
 [10]: http://librarian-puppet.com/
 [11]: https://github.com/StackStorm/puppet-st2/blob/master/build/centos6/Puppetfile
 [12]: https://github.com/StackStorm/puppet-st2/blob/master/build/centos7/Puppetfile
 [13]: https://github.com/StackStorm/puppet-st2/blob/master/build/puppet4/Puppetfile
 [14]: https://github.com/StackStorm/puppet-st2/blob/master/build/puppet5/Puppetfile
 [15]: https://github.com/StackStorm/puppet-st2/blob/master/build/ubuntu14/Puppetfile
 [16]: https://github.com/StackStorm/puppet-st2/blob/master/build/ubuntu16/Puppetfile
 [17]: https://github.com/StackStorm/puppet-st2/issues
 [18]: https://stackstorm.com/community-signup
 [19]: https://github.com/ruriky
 [20]: https://github.com/bdanboy
 [21]: https://github.com/armab