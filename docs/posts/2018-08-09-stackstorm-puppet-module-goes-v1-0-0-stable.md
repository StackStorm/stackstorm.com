---
title: StackStorm Puppet Module goes v1.0.0 stable!
author: Eugen C.
type: post
date: 2018-08-09T16:21:54+00:00
url: /2018/08/09/stackstorm-puppet-module-goes-v1-0-0-stable/
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - News
tags:
  - announcement
  - Community
  - configuration management
  - open source
  - oss
  - puppet
  - release
  - ruby

---
**August 9, 2018**  
_by [Nick Maludy][1] &#8211; [Encore Technologies][2]_

Ready to automatically provision and maintain StackStorm nodes in production? Then the `stackstorm-st2` Puppet module is for you! We&#8217;re proud to announce the `v1.0.0` stable release of [github.com/StackStorm/puppet-st2][3], the StackStorm Puppet module.

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/08/image1.png" alt="" width="1021" height="701" class="aligncenter size-full wp-image-8143" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/08/image1.png 1021w, https://stackstorm.com/wp/wp-content/uploads/2018/08/image1-150x103.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/08/image1-300x206.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/08/image1-768x527.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/08/image1-80x55.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/08/image1-220x151.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/08/image1-146x100.png 146w, https://stackstorm.com/wp/wp-content/uploads/2018/08/image1-218x150.png 218w, https://stackstorm.com/wp/wp-content/uploads/2018/08/image1-347x238.png 347w, https://stackstorm.com/wp/wp-content/uploads/2018/08/image1-604x415.png 604w, https://stackstorm.com/wp/wp-content/uploads/2018/08/image1-709x487.png 709w, https://stackstorm.com/wp/wp-content/uploads/2018/08/image1-867x595.png 867w" sizes="(max-width: 1021px) 100vw, 1021px" />][4]

Puppet is an excellent tool that allows the user to declare the desired state of their system in code. Once defined, hand over the reins to Puppet and watch as it transforms your nodes into what you’ve declared. We wanted to bring the power of declarative state to StackStorm deployments, and [puppet-st2][3] is that solution.

> Find StackStorm v1.0.0 on Puppet Forge, &#8211; <https://forge.puppet.com/stackstorm/st2> 

A great deal of work has gone into the `v1.0.0` release to ensure that [st2 Puppet Module][5] is ready to provision and manage StackStorm nodes in production environments. See January, 2018 [Puppet Module to Install StackStorm – Announcing Release Candidate][6]. Over the past year we’ve iterated through several pre-releases, release-candidate versions, fixed a lot of bugs, reworked the entire module structure and can now declare it stable and production ready.

There are still a lot of exciting new announcements in this release. Keep reading to find out what&#8217;s changed!

<!--more-->

### Officially Documented

The StackStorm project puts a lot of effort into being easily accessible to end-users and meeting them where they are. One part of this is providing numerous ways of installing StackStorm from [Vagrant][7], to [Ansible][8], to [Docker][9], and even [one-line bash installs][10]. From today installing StackStorm via Puppet is also included in the [official install documentation][5]! This provides yet another option for users installing and managing StackStorm deployments.

### Integration Tests

Verifying that your code actually does what it&#8217;s supposed to do end-to-end is extremely valuable. We&#8217;re proud to announce that, as of `1.0` the `stackstorm-st2` module now executes full integration tests using [Test-Kitchen][11] and is verified with [InSpec][12] in [TravisCI][13].

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/08/puppet-travis.png" alt="" width="1146" height="648" class="aligncenter size-full wp-image-8169" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/08/puppet-travis.png 1146w, https://stackstorm.com/wp/wp-content/uploads/2018/08/puppet-travis-150x85.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/08/puppet-travis-300x170.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/08/puppet-travis-768x434.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/08/puppet-travis-1024x579.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2018/08/puppet-travis-80x45.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/08/puppet-travis-220x124.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/08/puppet-travis-177x100.png 177w, https://stackstorm.com/wp/wp-content/uploads/2018/08/puppet-travis-265x150.png 265w, https://stackstorm.com/wp/wp-content/uploads/2018/08/puppet-travis-421x238.png 421w, https://stackstorm.com/wp/wp-content/uploads/2018/08/puppet-travis-734x415.png 734w, https://stackstorm.com/wp/wp-content/uploads/2018/08/puppet-travis-861x487.png 861w, https://stackstorm.com/wp/wp-content/uploads/2018/08/puppet-travis-1052x595.png 1052w" sizes="(max-width: 1146px) 100vw, 1146px" />][13]

`Kitchen-CI` works by spinning up a new Docker container, then executes a full install of StackStorm with Puppet and the `stackstorm-st2` module. After the Puppet run completes, `kitchen` invokes `InSpec` and runs a set of tests to ensure that StackStorm is configured properly.

### Puppet 3 Deprecation

Puppet 3 went End of Life on 12/31/2016. We have continued to support Puppet 3 installations since this time. Supporting Puppet 3 has become impractical as most modules now only support Puppet 4+. To ease the burden on the maintainers of `stackstorm-st2` we are deprecating Puppet 3 support in `1.0` and will be dropping support in `1.1`. This will allow the developers to focus on adding new features and take advantage of Puppet 4&#8217;s capabilities.

### Support for Orquesta

StackStorm v`2.8` includes a new workflow engine, [Orquesta][14]. The Puppet module fully supports configuring and maintaining this new service called `st2workflowengine`.

### StackStorm Auth Configuration

StackStorm provides a pluggable architecture for authentication. These plugins &#8211; called backends &#8211; communicate to external authentication services such as LDAP or Keystone. Each backend requires a unique package to be installed and has different configuration options. The `stackstorm-st2` now supports installing and configuring all available auth backends (`flat_file`, `keystone`, `ldap`, `mongodb`, `pam`). For more details see the [Configuring Authentication README][15].

### MongoDB Auth Support for Puppet 4+

New versions of the `puppet-mongodb` module throw errors when enabling auth for MongoDB when utilizing Puppet 4+. In this version of `stackstorm-st2` we work around these bugs and support authentication for managed MongoDB instances.

### Bug Fixes and Small Changes

There were a number of bug fixes and a few small changes that went into the `v1.0.0`. A list of all the fixes and changes can be found on the [stackstorm-st2 1.0 release page][16].

### Participation

The [`StackStorm/puppet-st2`][17] module welcomes any and all contributions, including bug reports! If you or your team currently use Puppet or are curious about how to get started stop by the `#puppet` channel in our [public Slack workspace][18].

If you find a bug, or want to suggest a new feature please submit a new issue on the [GitHub issues list][19].

 [1]: https://github.com/nmaludy
 [2]: http://www.encore.tech
 [3]: https://github.com/StackStorm/puppet-st2
 [4]: https://github.com/stackstorm/puppet-st2
 [5]: https://docs.stackstorm.com/latest/install/puppet.html
 [6]: https://stackstorm.com/2018/01/05/announcing-puppet-module-1-0-0-rc/
 [7]: https://docs.stackstorm.com/latest/install/vagrant.html
 [8]: https://docs.stackstorm.com/latest/install/ansible.html
 [9]: https://docs.stackstorm.com/latest/install/docker.html
 [10]: https://docs.stackstorm.com/latest/install/index.html#ref-one-line-install
 [11]: https://kitchen.ci/
 [12]: https://inspec.io/
 [13]: https://travis-ci.org/StackStorm/puppet-st2
 [14]: https://stackstorm.com/2018/07/10/stackstorm-2-8-ui-changes-new-workflow-engine-and-more/
 [15]: https://github.com/StackStorm/puppet-st2#configuring-authentication-st2auth
 [16]: https://github.com/StackStorm/puppet-st2/releases/tag/v1.0.0
 [17]: https://github.com/stackstorm/puppet-st2/
 [18]: https://stackstorm.com/community-signup
 [19]: https://github.com/StackStorm/puppet-st2/issues