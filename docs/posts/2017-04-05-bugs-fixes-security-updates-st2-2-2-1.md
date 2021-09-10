---
title: 'Bugs, fixes, security updates: It’s ST2 2.2.1'
author: st2admin
type: post
date: 2017-04-05T20:17:30+00:00
url: /2017/04/05/bugs-fixes-security-updates-st2-2-2-1/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5699213739
categories:
  - Blog
  - News
tags:
  - release
  - StackStorm

---
**April 5, 2017**  
_by Lindsay Hill_

StackStorm 2.2.1 has been released, incorporating the usual array of improvements, bug fixes, and this time a BWC-specific security update. Read on for details.  
<!--more-->

### Pack Management Fixes

  * If the config schema specified default values, but you didn&#8217;t create a config in \`/opt/stackstorm/configs/\`, Python actions & sensors never got those default values. Whoops. Resolved. Workaround: Create a pack config file.
  * The pack configs API endpoint was not working when RBAC was enabled. Fixed now.
  * Config schema validation might not be performed upon registration, which could result in bad or empty config schemas. It is now working as expected.

### BWC LDAP Security Fix

While working on some LDAP improvements, we found a potential security exposure in the BWC LDAP Authentication backend. If the requirements were that a user was a member of all three groups _x_, _y_, _z_, then BWC may have allowed access if a user was a member of only a subset of those groups &#8211; e.g. if the user was only a member of groups _x_ and _z_. This has been resolved, and tests added to check for this condition in future. We encourage users to upgrade. This only affects BWC (StackStorm Enterprise) users who use LDAP, and have authentication policies that require users to be a member of multiple groups.

### Miscellaneous Fixes & Improvements

  * Updated \`tooz\` library (v1.15.0) means you can now use backends such as Consul and etcd for coordination.
  * The \`st2ctl reload\` command now preserves the exit code from \`st2-register-content\`. So if your content registration fails, your scripts will properly detect it.
  * Nginx has been updated to remove support for medium-strength ciphers in the default configuration. You can always add them back in, if you&#8217;re some sort of monster who only uses the StackStorm Web UI from IE 7 on Windows XP. The rest of us will happily use stronger encryption without noticing any difference.
  * The \`st2-run-pack-tests\` tool now works directly out of box on servers where StackStorm was installed using packages. In addition to that, the tool no longer installs all the global pack dependencies when they&#8217;re already available.

As always, full details are in our [Changelog][1].

### Upcoming Releases

This will probably be the last 2.2.x version that gets shipped. We are working on 2.3 right now, which is going to include a [new API][2] (with docs!!), and LDAP group -> RBAC role synchronization. More upcoming features include the new [packs view in st2web][3], and [oauth2 support][4]. Thanks [Peter!][5] Not sure if those last two will make it into 2.3 or the next version after, but they won&#8217;t be far away.

 [1]: https://docs.stackstorm.com/changelog.html#april-3-2017
 [2]: https://github.com/StackStorm/st2/pull/2727
 [3]: https://github.com/StackStorm/st2web/tree/feature/packs-view
 [4]: https://github.com/pidah/st2-auth-backend-oauth2
 [5]: https://github.com/pidah