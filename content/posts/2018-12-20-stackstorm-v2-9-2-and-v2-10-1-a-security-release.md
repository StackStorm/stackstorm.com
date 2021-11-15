---
title: 'StackStorm v2.9.2 and v2.10.1: A Security Release (CVE-2018-20345)'
author: Tomaz Muraus
type: post
date: 2018-12-20T19:10:07+00:00
url: /2018/12/20/stackstorm-v2-9-2-and-v2-10-1-a-security-release/
thrive_post_fonts:
  - '[]'
  - '[]'
  - '[]'
categories:
  - Community
  - News
tags:
  - release
  - release announcement

---
**Dec 20, 2018**  
_By Tomaz Muraus_

Today we are announcing the release of StackStorm v2.9.2 and StackStorm v2.10.1.

Those two patch releases fix a security issue which has been reported to us this week by one of our users (Alexandre Juma &#8211; thanks!).

<!--more-->

## Background

The issue lies in the `GET /v1/keys` API endpoint where `?scope=all` and `?user=<username>` query parameter filters are not correctly handled. This allows any authenticated user to potentially retrieve user-scoped datastore items for other users.

The issue affects all the Open Source StackStorm releases from 1.5.0 to v2.10.0 (inclusive). Enterprise editions with RBAC enabled are not affected. When RBAC is enabled, only users with admin role can utilize `?scope=all` and `?user=<username>` query parameter filter and retrieve / view values for any system user.

We would strongly encourage our users who are affected by this issue to upgrade to one of those releases. If you are unable to upgrade to the v2.10.x series yet which has [just been released][1], you should upgrade to v2.9.2 which also includes this fix.

The issue has been assigned CVE identifier **CVE-2018-20345**.

## Better Security Issue Handling

Software security and robustness are the key qualities we strive for in every change we make. But we realized we didn&#8217;t have clear procedures for reporting security issues.

We have created a new Security page in our [documentation][2] and on our [website][3] which documents how issues can be reported to us in a secure and responsible manner.

We will continue to follow the same [responsible disclosure][4] process we followed so far. This means we will ask person who reports an issue to give us some time to prepare and develop a fix before announcing the issue publicly.

We are thankful to the users and security research who help us make our software and ecosystem more secure by reporting any issues they find.

## Upgrading

As always, make sure you have backups first. Then follow the standard [Upgrade Instructions][5].

 [1]: https://stackstorm.com/2018/12/14/pre-change-freeze-stackstorm-2-10/
 [2]: https://docs.stackstorm.com/security.html
 [3]: https://stackstorm.com/security
 [4]: https://en.wikipedia.org/wiki/Responsible_disclosure
 [5]: https://docs.stackstorm.com/latest/install/upgrades.html