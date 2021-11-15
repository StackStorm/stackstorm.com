---
title: OpenStack Automation With Cloud Deployment Tools
author: Dmitri Zimine
type: post
date: 2014-09-13T06:54:17+00:00
excerpt: '<a href="/2014/09/13/openstack-automation-cloud-deployment-tools/">READ MORE</a>'
url: /2014/09/13/openstack-automation-cloud-deployment-tools/
dsq_thread_id:
  - 3184698258
thrive_post_fonts:
  - '[]'
categories:
  - Blog

---
**September 13, 2014**

_by Dmitri Zimine_

This post originally appeared September 12, 2014 on <a href="http://opensource.com/business/14/9/openstack-deployment-tools" target="_blank">OpenSource.com</a>.

<p style="color: #000000;">
  In the cloud world, the mantra is &#8220;automate everything.&#8221; It&#8217;s no surprise that as OpenStack expands its scope, automation projects are emerging within it. But, the variety and the sheer number of these projects is still surprising: there are over twenty!
</p>

<p style="color: #000000;">
  This is the first part in a series of three articles surveying automation projects within OpenStack, explaining what they do, how they do it, and where they stand in development readiness and field usage. Some of these projects, like Mistral for workflow as a service (full disclosure: I help drive this project as CTO of StackStorm) and Compass for provisioning (from Huawei), are intended to help with non-OpenStack environments as well.
</p>

My goal in this series is to give a high level map, trigger your curiosity, and to give you pointers to dig for more details.

<!--more-->

First, let&#8217;s clarify what it means to be &#8220;within OpenStack.&#8221; A project typically moves from &#8220;related&#8221; to &#8220;incubated&#8221; to &#8220;integrated.&#8221; In all cases, irrespective of which stage of acceptance they have achieved, OpenStack projects are managed in a similar way. For example, in every case for the projects I&#8217;m going to review in this survey: the code is in Python, hosted on StackForge, and the code itself follows OpenStack structure and conventions. In addition, the commit review processes all have in common Gerrit/Jenkins/Zulu, and all of these projects include Tempest integration and DevStack integration. Moreover, project management is done on Launchpad, the docs are on a wiki, and open communication is achieved via the openstack-dev mailing list and more. The bottom line is that you know an OpenStack project when you see it.

Here are the automation projects that I consider OpenStack automation projects. I split the projects in three categories and review them in turn. Today, in part one, I cover cloud deployment tools that enable you to install/update OpenStack cloud on bare metal. In future articles, I will examine the automation of workload deployment—provisioning virtual machines, groups of VMs, and/or applications, and automating &#8220;day 2 management&#8221;—tools to keep the cloud and workloads up and running.

**Cloud deployment tools**

With no further adieu, let&#8217;s look at cloud deployment tools. Cloud deployment tools deal with provisioning the components of OpenStack—building an OpenStack cloud. Not surprisingly, these tools tend to be relatively mature and broadly used since the first thing that needs to be automated is often the deployment of OpenStack itself.

**Fuel**

&#8220;The control plane for installing and managing OpenStack.&#8221;

Originally Mirantis&#8217; proprietary solution, <a href="https://wiki.openstack.org/wiki/Fuel" target="_blank">Fuel</a> is now open source and contributed to OpenStack. An orchestration layer on top of Puppet, MCollective, and Cobbler, Fuel codifies Mirantis&#8217; best practices of OpenStack deployment. Like other tools in this category, it does hardware discovery, network verification, OS provisioning and deploying of OpenStack components. Fuel&#8217;s distinct feature is a polished and easy to use Web UI that makes OpenStack installation seem simple.

First released in 2013, it is now OpenStack &#8220;related&#8221; project. We have seen Fuel in the field a lot. OpenStack newbies often choose Fuel in their proof of concepts, attracted by the ease of use to get their cloud up and running. Also, Mirantis&#8217; consultants brought Fuel into some large production deployments. And now it is a part of Mirantis&#8217; OpenStack distribution which is one of the leading several such distros available. However because Fuel is only &#8220;related,&#8221; it is not fully upstream as would be an integrated project. Therefore you will likely not find Fuel in non-Mirantis distros or in the OpenStack source itself.

**Compass**

&#8220;<a href="https://wiki.openstack.org/wiki/Compass" target="_blank">Compass</a> is an open source project designed to provide &#8220;deployment as a service&#8221; to a set of bare metal machines.&#8221;

Yet another OpenStack deployment tool, Compass was developed by Huawei for their specific needs and made to be open source as an OpenStack-related project in Jan 2014. Compass developers position it as a simple, extensible data-driven platform for deployment, and as not limited to OpenStack. Through the plugin layer, it leverages other tools for hardware discovery, OS and hypervisor deployment, and configuration management.

Compass is a &#8220;related&#8221; project. While it is apparently mature enough for internal Huawei use, we have not seen it running outside of Huawei even though it is positioned as being useful beyond just OpenStack.

**TripleO**

<a href="https://wiki.openstack.org/wiki/TripleO" target="_blank">TripleO</a> installs, upgrades, and operates OpenStack cloud using OpenStack own cloud facilities. Yes, &#8220;it takes OpenStack to deploy OpenStack.&#8221;

In essence, TripleO is a dedicated OpenStack installation, called &#8220;the under-cloud,&#8221; that is used to deploy other OpenStack clouds—&#8221;overclouds&#8221; on bare metal.

The desired over-cloud configuration is described in a Heat template, and the deployment orchestrated by Heat. The nodes are provisioned on bare metal using Nova bare metal (Ironic): it PXE-boots the machine and installs images with OpenStack components. The images are dynamically generated with disk-image builder from image elements.

Operators enjoy using familiar OpenStack tools: Keystone authentication, Horizon dashboard, and Nova CLI, deploying and operating OpenStack cloud on hardware just like they deploy and operate a virtual environment.

TripleO targets ultra-large scale deployments (they say small deployments are solved by other tools) to do continuous integration and deployment of multiple evolving OpenStack clouds.

TripleO is an officially &#8220;integrated&#8221; project. With the most traction in OpenStack community and support of HP, Red Hat, and substantial others, it has established itself as a way-to-go long-term. The readiness status of TripleO is puzzling: on the one hand, it is used by HP Helion. On the other, the wiki and documentation states that it is &#8220;functional, but still evolving.&#8221; I haven&#8217;t seen it deployed in production yet, this will likely change in Kilo cycle (Spring 2015).

**Other tools**

  * <a href="http://devstack.org/" target="_blank">DevStack</a> is the best known for the ease of bringing up a complete OpenStack cloud for developing or playing around. It is not for production!
  * Other smaller deployment-related tools under OpenStack: 
      * <a href="https://wiki.openstack.org/wiki/Packstack" target="_blank">PackStack</a>: a utility that uses Puppet modules to deploy various parts of OpenStack on multiple pre-installed servers over SSH automatically. Surprisingly it is widely used: according to the <a href="http://www.slideshare.net/ryan-lane/openstack-atlanta-user-survey" target="_blank">OpenStack usage survey</a>, it&#8217;s #4 after Puppet, Chef, and DevStack.
      * <a href="https://wiki.openstack.org/wiki/Warm" target="_blank">Warm</a>: provides the ability to deploy OpenStack resources from YAML templates.
      * <a href="https://wiki.openstack.org/wiki/Inception" target="_blank">Inception</a>: OpenStack in OpenStack for testing and playing.
      * <a href="http://anvil.readthedocs.org/en/latest/topics/gettingstarted.html" target="_blank">Anvil</a>: DevStack version, written in Python, and supported by Yahoo.

**Summary**

Automating OpenStack bare metal provisioning is a fairly well solved problem. In addition to OpenStack tools described above, there are many outside of our defined &#8220;OpenStack umbrella&#8221;, notably [Crowbar][1], the first OpenStack specific deployment tool. The only challenge now is to select a tool of your liking from a bunch of apparently good ones. An excellent in depth comparison of the tools is available<a href="https://www.openstack.org/summit/openstack-summit-hong-kong-2013/session-videos/presentation/an-evaluation-of-openstack-deployment-frameworks" target="_blank">here</a>.

If you go down the path of purchasing support for a distribution from a OpenStack distribution reseller—and there are many of them—they will very likely include such a solution in the distribution and will of course use that tool to deliver the deployment quickly and efficiently.

I don&#8217;t want to play favorites, but the scope and rapid progress of TripleO is particularly impressive.

It is still evolving, but the OpenStack community is converging around it with sometimes competitors like Red Hat and HP collaborating effectively. TripleO solves an important set of problems for operators that are serious about larger scale deployment. We expect to see it broadly used amongst our users, which tend to be larger private and public cloud operators, whether they are SaaS, enterprise or service providers.

_Coming next: In part two, I&#8217;ll cover OpenStack projects for automating workload deployment. I welcome and really appreciate your feedback and comments below or on our Twitter account, <a href="https://twitter.com/stack_storm" target="_blank">@Stack_Storm</a>. We are also hosting a meetup in the StackStorm offices to discuss OpenStack automation on October 14. Join us and register [here][2]._

 [1]: http://crowbar.github.io/home.html
 [2]: http://www.meetup.com/San-Francisco-Silicon-Valley-OpenStack-Meetup/events/206106642/