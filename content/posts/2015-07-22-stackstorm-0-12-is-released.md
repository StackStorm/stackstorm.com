---
title: StackStorm 0.12 Is Released
author: st2admin
type: post
date: 2015-07-22T19:02:45+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/07/22/stackstorm-0-12-is-released/
dsq_thread_id:
  - 3960489042
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home

---
**July 23, 2015**  
_by Lakshmi Kannan_

It&#8217;s almost end of summer in California and the sun is baking us all pretty nicely. We also had a richter 4.0 earthquake last night but nothing stops us from giving you another shiny release. <a href="https://github.com/StackStorm/st2/releases/tag/v0.12.0" target="_blank">0.12.0</a> was released today with some new features and a bunch of bug fixes.

Take a moment to engage with us and the broader devops community by signing up with our <a href="https://stackstorm.com/community-signup" target="_blank">slack community</a>. We are also available on IRC on <a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">Freenode</a>.

## [][1]{#user-content-whats-new.anchor}What&#8217;s new?

We have some interesting contributions from our users. <a href="https://github.com/jamiees2" target="_blank">James Sigurðarson</a> added args support for our windows script runner, making our windows remote execution support more useful by specifying arguments to pass to these scripts.

<a href="https://github.com/skarmark" target="_blank">Sayli Karmarkar </a>(Netflix) added the ability to filter action executions by trigger instance to get better visibility.

<!--more-->

<a href="https://github.com/orius123" target="_blank">Eliya Sadan</a>, <a href="https://github.com/meirwah" target="_blank">Meir Wahnon</a>, <a href="https://github.com/SamMarkowitz" target="_blank">Sam Markowitz </a>(from the HP workflow project cloudslang.io) added a new cloudslang runner. Now you can run cloudslang orchestrations and workflows from within stackstorm which also proves our workflow really is pluggable. Thanks to all the above people for their awesome contributions.

With 0.12, we introduce secret parameters. When a parameter is defined as a secret in action metadata, it will be masked completely. The clear version is never printed in logs or sent out in API responses. Only admin users (added to st2 configuration file) can unmask the secret parameters in API responses by explicitly sending out a query param`show_secrets=True`.

Also in 0.12, actions can get access to ST2\_ACTION\_API\_URL and ST2\_ACTION\_AUTH\_TOKEN environment variables. So actions can hit StackStorm APIs to call other actions or consume any other StackStorm API.

On the chatops front, our APIs have matured to a point we no longer think they can remain in experimental. Action alias and alias execution APIs have now been promoted to v1. Using these APIs will let you define an alias for an action in StackStorm to be used in chatops. Alias execution API is the API that our bot hits to kick off a chatops command. As a refresher, read [James Fryman&#8217;s blog][2] on chatops with StackStorm.

Pack management APIs are also showing up in StackStorm. We now have an API to list installed packs. We&#8217;ll be adding more APIs in the near future to make it easy to install, uninstall or manage packs.

## [][3]{#user-content-bug-fixes.anchor}Bug fixes

Some interesting bugs were fixed. We had a nasty time zone bug that would show incorrect timestamps for executions. Timestamps are now UTC everywhere and ISO8601 in user visible parts of the system.

Apart from that, several minor bugs have been fixed. See <a href="https://github.com/StackStorm/st2/blob/master/CHANGELOG.rst" target="_blank">Changelog</a> for details.

## [][4]{#user-content-coming-up.anchor}Coming up

We are working on RBAC controls and it should land in time for the next release. Mistral pause and resume is in the works. Chatops enhancements are being worked on. We are also working on horizontal scaling of sensor deployments and reliability improvements.

Plus, an analytics prototype on StackStorm data is getting ready for our alpha users as is our wizzy graphical composition and management of workflows UI.

We are also reworking the installer to leverage docker and provide faster and better path to getting StackStorm up and automating. An AMI instance with 0.12 release packaged up and ready to trial is coming up very shortly.

Please reach us out for any questions or comments via <a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">IRC</a> or <a href="https://stackstorm.com/community-signup" target="_blank">Slack</a>. You can always try twitter too @stack_storm.

 [1]: https://github.com/StackStorm/blogs/blob/epowell101-patch-2/2015/07/2015_07_21_0.12_release.md#whats-new
 [2]: http://stackstorm.com/2015/06/12/integrating-chatops-with-stackstorm/
 [3]: https://github.com/StackStorm/blogs/blob/epowell101-patch-2/2015/07/2015_07_21_0.12_release.md#bug-fixes
 [4]: https://github.com/StackStorm/blogs/blob/epowell101-patch-2/2015/07/2015_07_21_0.12_release.md#coming-up