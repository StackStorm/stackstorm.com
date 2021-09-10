---
title: 'Quick update: v2.1.1 published'
author: st2admin
type: post
date: 2016-12-20T17:40:03+00:00
url: /2016/12/20/quick-update-v2-1-1-published/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5396679797
categories:
  - Blog
  - News
tags:
  - release
  - release announcement

---
**December 20, 2016**  
_by Lindsay Hill_

Just in case you missed it, we published StackStorm v2.1.1 late last week. This is a minor update, on top of the major changes to pack management we [made with 2.1][1].

There&#8217;s a few small bugfixes and enhancements:

  * `core.http` now supports HTTP basic auth and digest authentication.
  * Local action runner supports unicode parameter keys and values.
  * Improved error handling and more user-friendly messages for `packs` commands and APIs.

Full details in the [Changelog][2].

This is a recommended update for all v2.1.0 users. Use `yum` or `apt` to upgrade your system. If you&#8217;re not yet running v2.1.0, make sure you read all the [Upgrade Notes][3]. There were some significant changes in v2.1, and it may break your custom packs. It&#8217;s worth it though, we promise.

 [1]: https://stackstorm.com/2016/12/06/2-1-new-pack-management/
 [2]: https://docs.stackstorm.com/changelog.html#december-16-2016
 [3]: https://docs.stackstorm.com/upgrade_notes.html