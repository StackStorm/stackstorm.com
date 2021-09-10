---
title: StackStorm v1.5.1 released
author: Tomaz Muraus
type: post
date: 2016-07-12T18:36:40+00:00
url: /2016/07/12/stackstorm-v1-5-1-released/
dsq_thread_id:
  - 4980480410
categories:
  - Blog
  - News
tags:
  - release announcement

---
**July 13, 2016**  
By Tomaz Muraus

Today we are happy to announce the release of StackStorm v1.5.1.

This is primarily a bug-fix release which includes bug fixes and improvements for some of the features which have been introduced in StackStorm v1.5.0.

## Release Highlights

  * Fix trigger registration when using st2-register-content script with &#8211;register-triggers flag.
  * Fix an issue with CronTimer sometimes not firing due to TriggerInstance creation failure.
  * Add support for default values when a new pack configuration is used. Now if a default value is specified for a required config item in the config schema and a value for that item is not provided in the config, default value from config schema is used.
  * Support for posixGroup in the enterprise LDAP authentication backend

We would like to thank [Cody A. Ray][1] for reporting the first two issues and also helping us debug and troubleshoot the second one. In addition to that, we would also like to thank [lbogardi][2] and [Steven Bakker][3] for reporting the LDAP backend limitation and also [proposing a solution for it][4].

If you are running StackStorm v1.5.0 we would like to encourage you to upgrade to the latest release and if you are not running StackStorm v1.5 yet, we would also encourage you to upgrade so you can utilize cool new features such as [Improved Pack Configuration, Datastore Secrets][5] and [more][6].

 [1]: https://github.com/codyaray
 [2]: https://github.com/lbogardi
 [3]: https://github.com/sbakker
 [4]: https://github.com/StackStorm/st2/issues/2721
 [5]: https://stackstorm.com/2016/06/30/improved-pack-configuration-user-scoped-datastore-items-secure-secrets-store/
 [6]: https://stackstorm.com/2016/06/27/stackstorm-v1-5-alive/