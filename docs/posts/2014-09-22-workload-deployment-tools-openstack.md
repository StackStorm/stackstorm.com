---
title: Workload Deployment Tools For OpenStack
author: Dmitri Zimine
type: post
date: 2014-09-22T21:21:23+00:00
excerpt: '<a href="/2014/09/22/workload-deployment-tools-openstack/">READ MORE</a>'
url: /2014/09/22/workload-deployment-tools-openstack/
dsq_thread_id:
  - 3184683101
thrive_post_fonts:
  - '[]'
categories:
  - Blog

---
**September 22, 2014**

_by Dmitri Zimine_

_This post originally appeared September 19, 2014 on <a href="https://opensource.com/business/14/9/open-source-tools-openstack-workload-deployment" target="_blank">OpenSource.com</a>._

<p style="color: #000000;">
  This is the second part in a series of three articles surveying automation projects within <a href="https://opensource.com/resources/what-is-openstack" target="_blank">OpenStack</a>, explaining what they do, how they do it, and where they stand in development readiness and field usage. Previously, in <a href="https://opensource.com/business/14/9/openstack-deployment-tools" target="_blank">part one</a>, I covered cloud deployment tools that enable you to install/update OpenStack cloud on bare metal. Next week, in the final article, I will cover automating &#8220;day 2 management&#8221;—tools to keep the cloud and workloads up and running.
</p>

<p style="color: #000000;">
  The second class of automation products deals with deploying the workloads—virtual instances, virtual environments, applications, and services. The OpenStack projects in this category are Heat, Solum, and Murano.
</p>

<p style="color: #000000;">
  <!--more-->
</p>

**Heat**

<p style="color: #000000;">
  <a href="https://wiki.openstack.org/wiki/Heat" target="_blank">Heat</a> is an &#8220;orchestration service to launch multiple composite cloud applications using <a href="https://github.com/openstack/heat-templates" target="_blank">templates</a>.&#8221;
</p>

<p style="color: #000000;">
  The user of Heat defines virtual infrastructure ‘stacks&#8217; as a template, a simple <a href="http://en.wikipedia.org/wiki/YAML" target="_blank">YAML</a>file describing resources and their relations—servers, volumes, floating IPs, networks, security groups, users, etc. Using this template, Heat &#8220;orchestrates&#8221; the full lifecycle of a complete stack. Heat provisions the infrastructure, making all the calls to create the underlying parts and to wire them together. To make changes, the user modifies the template and updates the existing stack, and Heat makes the right changes. When the stack is decommissioned, Heat deletes all the allocated resources.
</p>

<p style="color: #000000;">
  Heat supports auto-scaling, so a user can define a scaling group and a scaling policy. A monitoring event (e.g. Ceilometer alert) triggers the scaling policy, and Heat provisions extra instances into the auto-scaling group.
</p>

<p style="color: #000000;">
  Since Icehouse, Heat also supports the provisioning and managing of software; to utilize this capability, a user defines what software should be installed on the instance, and Heat weaves deploying and configuring it into the instance lifecycle. It is also possible to integrate Heat with configuration management tools like Puppet and Chef so that Heat is called by these tools.
</p>

<p style="color: #000000;">
  Heat is similar to AWS Cloud Formation. In fact, Heat started as an implementation AWS Cloud Formation templates on OpenStack and Cloud Formation compatibility is part of the Heat mission. Heat also serves as a platform component for other OpenStack services and is used as a deployment orchestration service by TripleO and Solum.
</p>

<p style="color: #000000;">
  Heat is officially integrated into the OpenStack project. It is a hot project in OpenStack automation with a large, strong community. According to an OpenStack survey, Heat has about ten percent of deployment in the field.
</p>

**Murano**

<p style="color: #000000;">
  <a href="https://wiki.openstack.org/wiki/Murano" target="_blank">Murano</a> is an OpenStack self-service application catalog which targets cloud end-users (including less technically-inclined ones). Murano provides a way for developers to compose and publish high-level applications—anything from a simple single virtual machine to a complex multi-tier app with auto-scaling and self-healing. Murano uses a YAML based language to define an application, and the API and UI (user interface) to publish it to the service catalog. End users browse a categorized catalog of applications through the self-service portal, and get their apps provisioned and ready-to use with a &#8220;push-of-a-button.&#8221; Murano is similar to traditional enterprise service catalog apps, like VMware vCAC or IBM Tivoli Service Request Manager.
</p>

<p style="color: #000000;">
  Murano is an &#8220;OpenStack-related&#8221; project, likely to apply to &#8220;Incubating&#8221; in the Juno release cycle, and is primarily developed by Mirantis. Murano has been already used in the field, typically introduced and customized by Mirantis professional services. It seems to especially fit customers with Windows-based environments.
</p>

**Solum**

<p style="color: #000000;">
  <a href="http://solum.io/" target="_blank">Solum</a> is designed to make cloud services easier to consume and integrate into your application development process. It is just like Heroku or CloudFoundry (in fact it supports Heroku and CloudFoundry artifacts!) but is natively designed for OpenStack, within OpenStack.
</p>

<p style="color: #000000;">
  Solum deploys an application from a public git repository to an OpenStack cloud, to a variety of language run-times via pluggable &#8216;language packs.&#8217; App topology and runtime is described in a YAML &#8220;plan&#8221; file. A service add-on framework will provide services, like MongoDB, MemCache, NewRelic, etc. for the app to use.
</p>

<p style="color: #000000;">
  Solum pushes an application through Continuous Integration pipeline from the source code up to the final deployment to production via a Heat template.
</p>

<p style="color: #000000;">
  In the future, Solum plans to guide and support developers through the dev/test/release cycle. It will support rollbacks to previous versions, as well as, monitoring, manual and auto-scaling and other goodies being developed.
</p>

<p style="color: #000000;">
  Solum&#8217;s implementation leverages many OpenStack projects including Heat, Nova, Glance, Keystone, Neutron, and Mistral.
</p>

<p style="color: #000000;">
  Solum is still in its infancy and most of the noted features are on the roadmap for 2015. However, it is a well-run community project with a strong team and solid support from Rackspace, Red Hat, and a few significant others.
</p>

<p style="color: #000000;">
  Solum as a native PaaS looks promising if it is able to establish and differentiate itself sufficiently from existing PaaS frameworks.
</p>

**Summary**

<p style="color: #000000;">
  When it comes to virtual infrastructure deployment, the OpenStack community has converged on Heat. Notably, Heat is a preferred way for Docker integration with OpenStack. Field adoption, while growing, still remains at about twenty percent, leaving the rest to general tools and custom solutions.
</p>

<p style="color: #000000;">
  The common field patterns for application deployment are either using CloudFoundry, or custom orchestration solutions on top of masterless Puppet or Chef solo. A large number of vendors&#8217; products for cross-cloud and hybrid deployment may be at play here, too.
</p>