---
title: StackStorm Enterprise HA in Kubernetes – βeta
author: Eugen C.
type: post
date: 2018-09-26T15:00:11+00:00
url: /2018/09/26/stackstorm-enterprise-ha-in-kubernetes-beta/
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - News
tags:
  - containers
  - Docker
  - enterprise
  - HA
  - helm
  - high-availability
  - k8s
  - kubernetes

---
**Sep 26, 2018**  
_By [Eugen C.][1] and [Warren Van Winckel][2]_

More groups are progressing from just talking about Event-Driven Automation to actually doing it in practice. StackStorm helps make this easy. When organizations start offloading business-critical tasks and automating for real it becomes essential to ensure that the Automation engine itself is not a single point of failure when it is responsible for recovering a fleet of servers, managing datacenters, and automating remediations.

StackStorm was designed to be cloud-native, API-driven, easily deployed, microservice-oriented, resilient and can be scaled out horizontally to fulfill High Availability and/or High Load demands.

Previously we only documented best practices describing how to distribute StackStorm in HA mode ([docs.stackstorm.com/reference/ha.html][3]), giving a high level overview regarding StackStorm design and how to ensure its redundancy. Based on those recommendations, some companies were spending weeks to months to codify a complex st2 HA infrastructure and iterate over their deployments until finding that &#8220;silver bullet&#8221; stability/production state.

[![StackStorm HA in K8s and Helm][4]][5]

<!--more-->

We&#8217;re glad to announce [`stackstorm-ha`][6] &#8212; a solution to automatically deploy StackStorm Enterprise (Extreme Workflow Composer) cluster based on Kubernetes, a container orchestration platform at planet scale. As Enterprises are becoming cloud-native, 70+ percent of Fortune 100 companies use containers, 50+ percent leveraged Kubernetes, the most impactful OpenSource project in recent times. Kubernetes success relies on ideas refined in production at one of the world&#8217;s largest tech companies and more other tech giants joining its rapid OpenSource development.

With `stackstorm-ha` you can benefit from running reproducible instructions to setup StackStorm cluster in HA configuration along with the dependent components st2 relies on like MongoDB HA ReplicaSet as a database engine, RabbitMQ HA cluster as a communication bus, and etcd as a distributed coordination backend.  
Steps to setup the entire StackStorm fleet with `30+` pods and all the complexity of many moving parts under the hood is simple as:

    $ helm repo add stackstorm https://helm.stackstorm.com/
    $ helm install \
      --set enterprise.enabled=true \
      --set enterprise.license=<EWC_LICENSE_KEY> \
      stackstorm/stackstorm-ha
    

> Don&#8217;t have StackStorm Enterprise license key?  
> It&#8217;s easy to obtain a 90-day free trial at [stackstorm.com/#product][7] 

It makes an incredibly complex deployment easy! With that, you&#8217;ll also benefit from the Kubernetes failover, rescheduling, self-healing capabilities, as well as the rich K8s opensource community, ecosystem, plugins and tools.

[![StackStorm HA with Kubernetes and Helm, demo][8]][9]

For example, adding monitoring or log collection on top of that is easy as running a couple of commands.

Of course, we expect you to be familiar with the basics. You&#8217;ll need to setup [Kubernetes][10] cluster by yourself and have [Helm][11] installed, the K8s package manager.

> Helm Chart and K8s objects source code is available at Github repository [github.com/stackstorm/stackstorm-ha][9], official documentation at [docs.stackstorm.com][6]. 

Even if your organization is not there yet, we encourage you to start experimenting. [Our documentation][5] brings some pointers about how to install and use StackStorm in Kubernetes and we&#8217;re happy to help you start your digital transformation!

With multiple HA improvements came in `v2.9`, future StackStorm plans are to bring Kubernetes deployment to community edition and further harden High Availability, Reliability and Performance capabilities of the platform in next `v3.0` release. As this new deployment method is in beta state and further development is in progress, we ask you to try it and influence future work by providing your valuable feedback via ideas, bug reports, feature or pull requests in [StackStorm/stackstorm-ha][12], ask questions on our [forum.stackstorm.com][13] and welcome discussions in [Slack][14] `#docker` channel or write us an email.

 [1]: https://github.com/armab
 [2]: https://github.com/warrenvw
 [3]: https://docs.stackstorm.com/reference/ha.html
 [4]: https://stackstorm.com/wp/wp-content/uploads/2018/09/stackstorm-enterprise-ha.png
 [5]: https://docs.stackstorm.com/latest/install/k8s_ha.html#enterprise-ewc
 [6]: https://docs.stackstorm.com/latest/install/k8s_ha.html
 [7]: https://stackstorm.com/#product
 [8]: https://stackstorm.com/wp/wp-content/uploads/2018/09/stackstorm-enterprise-ha-demo.gif
 [9]: https://github.com/stackstorm/stackstorm-ha
 [10]: https://kubernetes.io/docs/setup/pick-right-solution/
 [11]: https://docs.helm.sh/using_helm/#install-helm
 [12]: https://github.com/StackStorm/stackstorm-ha
 [13]: https://forum.stackstorm.com/
 [14]: https://stackstorm.com/community-signup