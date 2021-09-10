---
title: OpenStack Day Two Operations Tools
author: Dmitri Zimine
type: post
date: 2014-09-26T15:51:34+00:00
excerpt: '<a href="/2014/09/26/openstack-day-two-operations-tools/">READ MORE</a>'
url: /2014/09/26/openstack-day-two-operations-tools/
dsq_thread_id:
  - 3181235931
thrive_post_fonts:
  - '[]'
categories:
  - Blog

---
**September 26, 2014**

_by Dmitri Zimine_

_This post originally appeared September 26, 2014 on <a href="http://opensource.com/business/14/9/openstack-day-two-operations-tools" target="_blank">OpenSource.com</a>._

This is the third part in a series of three articles surveying automation projects within <a href="https://opensource.com/resources/what-is-openstack" target="_blank">OpenStack</a>, explaining what they do, how they do it, and where they stand in development readiness and field usage. Previously, in <a href="https://opensource.com/business/14/9/openstack-deployment-tools" target="_blank">part one</a>, I covered cloud deployment tools that enable you to install/update OpenStack cloud on bare metal. In <a href="https://opensource.com/business/14/9/open-source-tools-openstack-workload-deployment" target="_blank">part two</a>, I covered workload deployment tools. Today, we&#8217;ll look at tools for day two operations.

Day two operations automation is all about maintaining and managing the cloud infrastructure and workload to keep it running.

<!--more-->

The day two use cases include responding to hardware failures and app performance degradations, troubleshooting, reactive and proactive maintenance, and other tasks, often boring and mundane—stuff we really want to automate so that we can spend time on more creative work. This is a wide area, but the projects here are only emerging now. And, unlike cloud or workload deployment automation, there is no established pattern or dominant approach to automating day two operations.

Some projects, like Rubick, Blazar, or Satori, are solving a specific, narrow use case. Others, like Mistral and Congress, are set to become generic, general-purpose cross-domain automation tools.

**Blazar**

<a href="https://wiki.openstack.org/wiki/Blazar" target="_blank">Blazar</a> (ex. Climate) is an “OpenStack reservation as a service project”. Blazar manages the “lease” of cloud resources (virtual or physical), scheduling resource use in the future, negotiating lease terms between the user and the system, automating the process of allocating and releasing the resources, and providing visibility to resource consumption.

Blazar introduces Nova filters and API extensions to Nova (blazar-nova) to make it aware of lease concept (see blazar-nova).

It currently implements reservation of virtual instances and physical hosts. With its pluggable architecture, the support for volumes and other resources is coming.

Blazar is a new “related” project and was first announced at the OpenStack Hong Kong Summit 2013, and now has base functionality implemented, but it&#8217;s not ready for use beyond POC.

**Rubick**

<a href="https://wiki.openstack.org/wiki/Rubick" target="_blank">Rubick</a> is a diagnostic tool that inspects and validates OpenStack cloud configurations for correctness and consistency, and reports any errors or misconfigurations.

Rubick auto-discovers an OpenStack cluster, extracts actual configurations of OpenStack components (Keystone, Cinder, Nova, etc.), and checks them against a rule set to validate consistency and correctness. Some rules are simple syntax checks of configuration parameters. Other rules are more complex and inspect the entire model to find semantic inconsistencies across multiple OpenStack components. A simple web UI walks the user through the process of discovery and validation, and reports configuration errors and warnings.

Status: OpenStack related product. It is functional and complete but the out of box rule set is limited. For broad adoption, Rubick needs other OpenStack projects to jump on contributing the rules. As of now, this has not happened.

**Satori**

<a href="https://wiki.openstack.org/wiki/Satori" target="_blank">Satori</a> provides configuration discovery for existing infrastructure. Given a URL and some credentials, it will discover the role and resource behind this URL, figure out how this resource is related to the OpenStack cloud (e.g., it’s a Nova instance, or Cinder control node), and lists the services that are running on this server.

Satori is conceptually similar to discovery tools like <a href="https://github.com/opscode/ohai" target="_blank">Ohai</a> and <a href="https://github.com/puppetlabs/facter" target="_blank">Facter</a>, and may leverage these tools, adding OpenStack specifics to it.

With pluggable implementation on the roadmap, Satori plans to discover non-OpenStack infrastructure—API for other clouds, nodes in a Chef server, operating system and application topologies, run time processes and relations between the systems.

Satori is a very young project—it started in 2014 and just had a first proof of concept in March 2014.

**Congress**

<a href="https://wiki.openstack.org/wiki/Congress" target="_blank">Congress</a> is a generic cross-domain policy management framework for the cloud. It monitors the set of cloud services for policy compliance, and applies corrective actions when violations are identified. In the future, Congress will even prevent violations from happening in the first place when possible.

Congress policies apply to applications, hardware, networking, security and business rules. By being a cross-domain framework, it is capable of handling cross-domain policies, like “every network attached to a VM must be a private network owned by someone in the same group as the VM owner”—touching Neutron, Nova, and Keystone.

The policies are declared in the <a href="http://en.wikipedia.org/wiki/Datalog" target="_blank">DataLog</a> language. Data providers are used to connect with cloud services, fetch the relevant data, keep them up-to-date, and execute corrective actions.

To be successful, Congress will need a buy in from OpenStack projects, so that they provide their own hooks and plugins for policy monitoring and enforcement.

Congress is a “related” OpenStack project. It has an early implementation showing basic architecture, policy language support and basic data source plugins for Nova and Neutron.

**Mistral**

<a href="https://wiki.openstack.org/wiki/Mistral" target="_blank">Mistral</a> is a workflow service for OpenStack cloud automation.

A workflow—a sequence of tasks with transitions and conditional logic—is expressed as YAML based definition. A workflow can be triggered on demand, on schedule, or on a monitoring event. Mistral runs workflows at scale, with high availability and resilience. It executes task actions, keeps the workflow state, and carries data between the tasks. The new improved [Version 2 of DSL and API][1]introduced a variety of new features.

Mistral offers an extensible set of actions, with SSH, REST HTTP, email, and OpenStack pack included. A basic UI is available as a Horizon dashboard; a visual representation of workflow plan and execution is on the roadmap.

Mistral’s target users are cloud administrators for workflow-based automation of operational procedures, integration across cloud components, other infrastructure services and business processes. Application developers can leverage Mistral as workflow service, similar to AWS Simple Workflow.

Mistral is also a platform component for other OpenStack services that need a concept of a workflow service. Solum, Fuel, Barbican, Murano, Keystone, Trove, Congress, and a few more are beginning to integrate with Mistral.

Mistral is a related project, and has a functional pilot version. It is planning to apply for incubation in Juno cycle.

**Summary**

Day two operations are still dominated by manual and custom individual scripts that operators have built themselves. Automation is inevitably coming to the enterprise but the operational patterns are still being established.

General cross-domain tools can help form these patterns—Congress policies and Mistral workflows can become a currency to capture and share them across the community.

As the patterns are established, we can expect more projects and solutions to emerge, getting OpenStack closer to a fully automated, autonomic, self-driving cloud.

<img loading="lazy" class="alignnone size-full wp-image-817" src="http://stackstorm.com/wp/wp-content/uploads/2014/09/business_clouds.png" alt="business_clouds" width="520" height="292" />

 [1]: https://wiki.openstack.org/wiki/Mistral/DSLv2