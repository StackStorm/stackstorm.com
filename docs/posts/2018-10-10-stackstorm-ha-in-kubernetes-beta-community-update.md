---
title: StackStorm HA in Kubernetes βeta – Community update
author: st2admin
type: post
date: 2018-10-10T13:06:04+00:00
url: /2018/10/10/stackstorm-ha-in-kubernetes-beta-community-update/
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - News
tags:
  - Community
  - community-edition
  - containers
  - Docker
  - FOSS
  - HA
  - helm
  - high-availability
  - k8s
  - kubernetes

---
**Oct 10, 2018**  
_By [Warren Van Winckel][1] and [Eugen C.][2]_

A couple weeks ago, [we released][3] the Helm chart and docker images so you could install StackStorm Enterprise HA cluster in Kubernetes.

Today, we’re glad to announce that the Community free and open source edition of StackStorm HA is now available, too! With this update we are excited to bring Kubernetes powers to the broader community and strive for greater adoption in production with better safety for all important operations you delegate to StackStorm automation engine.

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/10/cover.png" alt="Combined logo" width="800" height="600" class="aligncenter size-full wp-image-8340" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/10/cover.png 800w, https://stackstorm.com/wp/wp-content/uploads/2018/10/cover-150x113.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/10/cover-300x225.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/10/cover-768x576.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/10/cover-80x60.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/10/cover-220x165.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/10/cover-133x100.png 133w, https://stackstorm.com/wp/wp-content/uploads/2018/10/cover-200x150.png 200w, https://stackstorm.com/wp/wp-content/uploads/2018/10/cover-317x238.png 317w, https://stackstorm.com/wp/wp-content/uploads/2018/10/cover-553x415.png 553w, https://stackstorm.com/wp/wp-content/uploads/2018/10/cover-649x487.png 649w, https://stackstorm.com/wp/wp-content/uploads/2018/10/cover-793x595.png 793w" sizes="(max-width: 800px) 100vw, 800px" />][4]

<!--more-->

To install StackStorm cluster:

<pre class="EnlighterJSRAW" data-enlighter-language="shell">helm repo add stackstorm https://helm.stackstorm.com
helm install stackstorm/stackstorm-ha</pre>

This will setup a fleet of more than 30 pods and ensure that every StackStorm component and their dependencies like database, message bus or distributed coordination backend have enough redundancy to guarantee higher availability.

For those with an enterprise license, just enable it in Helm values. `helm upgrade` will upgrade your cluster from Community to Enterprise edition with no loss of data or uptime, [see instructions][5].

> If you want to dig deeper configuring StackStorm HA in K8s with Helm &#8211; we recommend to check out documentation and latest development at [github.com/stackstorm/stackstorm-ha][4]. 

We also updated the StackStorm Installation documentation at <https://docs.stackstorm.com/install/k8s_ha.html>

### New Community Dockerfiles

The community docker images used by the `stackstorm-ha` helm charts are found at [github.com/stackstorm/st2-dockerfiles][6]. Today, we deprecate [runtime/kubernetes-1ppc][7] in `st2-docker` repository. It will be removed early next year in time for the StackStorm v3.1 release. The new Dockerfiles are based on `Ubuntu Xenial` and define granular resources like ports, volumes, users per container. This ensures better security and makes it very clear what each container can access. We aim to follow [12 factor app][8], [docker dev][9] and [dockerfile best practices][10]. For example, containers are ephemeral and immutable, they&#8217;re smaller in size, everything is logged to stdout/stderr and we use one service per container to strive the production-level expectations.

### Future Plans

We will remove the beta label, and announce General Availability in the next few months. We want to get some real-world user feedback first. Let us know if you hit any problems! Near term, we plan to work on K8s Ingress Controller ([#6][11]), Prometheus Metrics ([#23][12]), Liveness/Readiness probes for st2 services to ensure correct K8s failover, st2sensorcontainer partitioning/load distribution, as well as various security enhancements, features and production requirements. A list of all documented issues is found at [StackStorm/stackstorm-ha/issues][13] and [StackStorm/st2-dockerfiles/issues][14].

As this new deployment method is in beta state and further development is in progress, we ask you to try it and influence future work by providing your valuable feedback. You can do this via ideas, bug reports, feature or pull requests in [StackStorm/stackstorm-ha][15] and/or [StackStorm/st2-dockerfiles][16]. Also by asking questions at [forum.stackstorm.com][17] or in our [Slack][18] `#docker` channel. As always, you can write us an email.

 [1]: https://github.com/warrenvw
 [2]: https://github.com/armab
 [3]: https://stackstorm.com/2018/09/26/stackstorm-enterprise-ha-in-kubernetes-beta/
 [4]: https://github.com/stackstorm/stackstorm-ha
 [5]: https://docs.stackstorm.com/latest/install/k8s_ha.html#enterprise-ewc
 [6]: https://github.com/stackstorm/st2-dockerfiles
 [7]: https://github.com/StackStorm/st2-docker/tree/master/runtime/kubernetes-1ppc
 [8]: https://12factor.net
 [9]: https://docs.docker.com/develop/dev-best-practices/
 [10]: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
 [11]: https://github.com/stackstorm/stackstorm-ha/issues/6
 [12]: https://github.com/stackstorm/stackstorm-ha/issues/23
 [13]: https://github.com/StackStorm/stackstorm-ha/issues
 [14]: https://github.com/StackStorm/st2-dockerfiles/issues
 [15]: https://github.com/StackStorm/stackstorm-ha
 [16]: https://github.com/StackStorm/st2-dockerfiles
 [17]: https://forum.stackstorm.com
 [18]: https://stackstorm.com/community-signup