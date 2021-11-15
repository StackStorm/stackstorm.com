---
title: New and Improved StackStorm Docker Images!
author: st2admin
type: post
date: 2017-08-30T17:36:56+00:00
url: /2017/08/30/new-improved-stackstorm-docker-images/
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6107731013
categories:
  - Blog
  - Community
tags:
  - Docker

---
<p dir="ltr">
  <strong>August 30, 2017</strong><br /> <em>by Warren Van Winckel</em>
</p>

## Tagged Images

For a little while now, the <span style="font-family: courier new,courier,monospace">stackstorm/stackstorm</span> docker image has been tagged with the version of StackStorm that comes pre-installed in the image. Now, you can pin your installation to a specific release of StackStorm! Images tagged with “latest” contain the most recent StackStorm release at the time it was tagged.

The <span style="font-family: courier new,courier,monospace">stackstorm/stackstorm:2.4.0</span> image will always contain the 2.4.0 release of stackstorm. The previous release, 2.3.2, is available at <span style="font-family: courier new,courier,monospace">stackstorm/stackstorm:2.3.2</span>. We never again update <span style="font-family: courier new,courier,monospace">stackstorm/stackstorm:2.3.2</span> after 2.4.0 is released. Any feature changes to st2-docker will only ever apply to the most recent stackstorm image.

<!--more-->

## New Images

I’m proud to announce that two community members have each contributed a new image to the st2-docker repository:

  * [stackstorm-all][1]
  * [stackstorm-1ppc][2]

Thanks to [@mab27][3], we have a Docker image called <span style="font-family: courier new,courier,monospace">stackstorm-all</span> that contains StackStorm and all dependent services. This may be required when you are only able to run one container, for example, in a CI test environment.

In addition, [@shusugmt][4] has contributed the <span style="font-family: courier new,courier,monospace">stackstorm-1ppc</span> (stands for “one process per container) Docker image, which allows you to run one service per container &#8211; a [Docker best practice][5], following [12FA principles][6]. Please note that in the next day or two, this image will be merged with the base <span style="font-family: courier new,courier,monospace">stackstorm/stackstorm</span> image. If you want to take it for a spin in the meantime, an example docker-compose.yml is in <span style="font-family: courier new,courier,monospace">runtime/stackstorm-1ppc</span> which uses this 1ppc image.

We have done some early testing of these images on Kubernetes, and have seen good results thus far. You’ll find example manifests under the <span style="font-family: courier new,courier,monospace">runtime/kubernetes-1ppc</span> directory. Using a kubernetes &#8220;Deployment&#8221;, each st2 service can be easily HA enabled by configuring number of replicas to >= 2. For example, you can increase number of Pods which run <span style="font-family: courier new,courier,monospace">st2actionrunner</span> by either just using <span style="font-family: courier new,courier,monospace">kubectl scale</span> command against st2actionrunner or adjusting the number of replicas in manifest yaml file and use <span style="font-family: courier new,courier,monospace">kubectl apply</span>; then all actions are load-balanced among those Pods. (Note: Some components like st2rulesengine or st2sensorcontainer need special care in HA setup, but we don’t describe further details here. See [HA section][7] of official doc.)

Currently, this is just a proof of concept but we believe Kubernetes provides an attractive option for those who require StackStorm to run in an HA environment. We greatly appreciate and encourage any PR’s with improvements.

## Roadmap

In the next few months, we aim to:

  * Solidify the docs and provide at least one good example of how to deploy using docker-compose, including best practices on how to pull in packs, configs and SSL certs, and how to perform upgrades.
  * Make a list of what is required to move from &#8220;eval, light production&#8221; to &#8220;full production, scale out&#8221; for transparency and so others can help out.

## Conclusion

We’re really looking forward to hearing stories about what you’re all doing with StackStorm &#8211; in particular, with these two new images. As always, find us on our #docker channel on Slack, and please submit issues or PR’s.

 [1]: https://github.com/stackstorm/st2-docker/pull/40
 [2]: https://github.com/stackstorm/st2-docker/pull/38
 [3]: https://github.com/mab27
 [4]: https://github.com/shusugmt
 [5]: https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/
 [6]: https://12factor.net
 [7]: https://docs.stackstorm.com/reference/ha.html