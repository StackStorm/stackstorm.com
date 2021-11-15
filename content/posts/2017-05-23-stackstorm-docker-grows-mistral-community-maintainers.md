---
title: 'StackStorm on Docker Grows Up: Mistral, Community Maintainers and more…'
author: st2admin
type: post
date: 2017-05-23T20:48:05+00:00
url: /2017/05/23/stackstorm-docker-grows-mistral-community-maintainers/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5844377083
tcb2_ready:
  - 1
categories:
  - Community
  - News
tags:
  - Docker

---
<p dir="ltr">
  <strong>May 23, 2017</strong><br /> <em>by Warren Van Winckel</em>
</p>

### Mistral Now Included

A month ago, we launched the <span style="font-family: andale mono,monospace">stackstorm</span> image. We continued working on this and now it’s, hmm… ready! Well, software is never ready so how do we mean it? The image now contains Mistral, fixed bugs, new features. You can now perform everything with StackStorm using this image. The <span style="font-family: andale mono,monospace">stackstorm</span> image now contains st2, st2web and st2mistral!

<!--more-->

If you’re using <span style="font-family: andale mono,monospace">docker-compose</span>, the dependent services (Redis, RabbitMQ, PostgreSQL and MongoDB) are pulled from docker hub and run in their own containers. You can also use environment variables to point StackStorm at your own instances of any dependent service..

### Community Maintainer

The st2-docker repository is rapidly maturing. It is no longer in daycare! We’re proud to announce today that it has even outgrown the StackStorm team, and is now maintained by the broader community.

We have an awesome community, and [@shu][1] will take on the mantle of ‘community maintainer’. He will maintain the roadmap, review PRs, and all that good stuff.

Some ideas the community has brought to the table are support for Kubernetes and high availability. However, first, we will reduce the number of assumptions we make about the runtime environment. See the [roadmap][2] for more details.

To that end, if you’d like to request a new feature, or report a bug, as always, please submit an [issue][3].. or better yet, submit a PR with the change and we’ll make sure it gets merged ASAP!

We look forward to what st2-docker will be able to do as it gets older&#8230;

 [1]: https://github.com/shusugmt
 [2]: https://github.com/StackStorm/st2-docker/issues/22
 [3]: https://github.com/StackStorm/st2-docker/issues/new