---
title: How StackStorm “Stacks” Against The Competiton
author: st2admin
type: post
date: 2014-11-03T04:51:45+00:00
excerpt: '<a href="/2014/10/31/stackstorm-vs-other-software/">READ MORE</a>'
url: /2014/11/03/stackstorm-vs-other-software/
dsq_thread_id:
  - 3185638587
categories:
  - Blog
  - Community
  - Home

---
**November 3, 2014**

_by Evan Powell_

StackStorm connects events to actions you might want to take; and it does so through simple abstractions that allow you to reuse your approaches to managing events and to taking actions, including filtering events and applying rules and workflows. We call this sharing your _operational patterns_.

The approach of connecting events to actions is extremely extensible as events ranging from Nagios alerts to direct human interactions and actions from closing a ticket to interacting via our flavor of Hubot (“Stackbot”) can be tied together transparently, so they are easy to share, to manage and to control. Because of this flexibility, StackStorm solves many different problems for users, from helping with CI/CD through troubleshooting and remediation. And so StackStorm capabilities overlap to some extent with existing solutions. While we compare StackStorm to a number of such tools, StackStorm embraces the tool chain approach of DevOps operators.

<!--more-->StackStorm plays nice with others.

In the consumer space, there is a service that ties actions together with events called “If this Then That” or IFTTT.  While IFTTT is focused on different users with different needs and of course different technologies &#8211; and it GUI, GUI, GUI and it is SaaS as opposed to open source software &#8211; it is pretty analogous.

**StackStorm vs. Home Grown Goodness**

StackStorm helps solve a problem that exists eventually in every organization adopting DevOps at any scale &#8211; the growth and management of operations automation so that this automation does not begin to hamper the very agility it is intended to unlock.

Most organizations start by manually managing infrastructure through simple scripts or web-based interfaces. As the infrastructure grows, any manual approach to management becomes both error-prone and tedious, and many organizations home-roll tooling to help automate the repetitive processes involved.

Over time silos of automation appear.  Frequently, a solution like Jenkins is used to automate builds and test as a first piece of automation.

Jenkins then gets extended more and more, with the help of home built scripts, into other use cases.  Meanwhile Nagios checks are being extended perhaps along with a broader event pipeline comprised of solutions like Sensu and Celiometer and Nagios based scripts start to take their own actions.

Meanwhile some other actions are being taken by PagerDuty.  And sometimes we just want Jira to do a little bit of this and that as we close a ticket or open an issue.

These tools &#8211; and many others &#8211; and the relationships between each of them &#8211; require time and resources to configure, integrate and manage.  You get N tools connected to those N tools, potentially in both directions, so you have (N*2)N connections.

Because the tooling must be updated in lockstep with any new features or infrastructure, it becomes the limiting factor for how quickly the infrastructure can evolve. The top operators have all hit the islands of automation wall &#8211; and they have undertaken multi million dollar software projects to write operations automation frameworks that address these challenges.

StackStorm addresses these challenges for the rest of us &#8211; for those that have better things to do than rewire the wiring of our ever evolving software infrastructure.  StackStorm provides in a modular way certain capabilities that scripts growing into operations wiring often lack: event filtering, a rules engine, extensible workflow, audit, access controls, collaboration integration, and the ability to scale and manage all of this as “Automation as a Service.”  Removing the burden of building these tools allows operators to focus on their infrastructure and not the tooling.

Furthermore, StackStorm is open source and certain of this open source code is a part of the independently governed OpenStack community. This open source nature and affiliation with OpenStack ensures StackStorm software will be around for the long term.

**StackStorm vs. Chef, Puppet, Etc.**

StackStorm software interacts with leading configuration management solutions to enable these tools to take actions within the context that StackStorm provides of other automations that may be responses to events such as a common remediation workflow or perhaps a rolling upgrade.  Other use cases might include CI/CD, autoscaling and more.

Once your StackStorm instance is integrated with one of these configuration tools via an integration pack, you can use that tool as needed without changing the configuration management system.

An operational pattern that has emerged amongst StackStorm users is that StackStorm takes on event processing and multi-stage action execution and is also responsible for updating the underlying configuration management system so that, if desired, the configuration management retains a role as a system of record.  Existing scripts written to extend configuration management solutions into event processing and multi stage executions can be ingested by StackStorm software; with the addition of some basic meta data they are ready for use.

The architecture that allows StackStorm to ingest events, evaluate them and take actions upon them while running as a service is quite a bit different than the architecture which existing configuration management systems utilize to address their use cases.

We have learned a lot from the Chefs, Puppets and others.  Like them we embrace infrastructure as code and are kindred spirits in many ways.  The ubiquity of their integrations with underlying software and hardware is one reason that a solution like StackStorm to deliver overall operations automation is possible today.

**StackStorm vs. Docker**

Docker is a better version of container technology, that promises to &#8220;help developers build and ship higher quality apps faster&#8221; and sysadmins &#8220;to deploy and run any app on any infrastructure, quickly and reliably&#8221; thanks to integrated packaging, a nifty use of a copy on write file-system with caching, and hefty value added by a community authoring and reviewing Docker files and more.  Learn more:<http://www.docker.com/whatisdocker/>

Docker containers are helping spread DevOps approaches to application development and management.

StackStorm works with Docker so that Docker related actions, such as deployments and the creation of Docker files, can be triggered as a part of a StackStorm managed series of events &#8211; and so that Docker and related activities can also be a source of events; for example, Docker throwing a status update can trigger StackStorm to take actions on your behalf and those actions may in turn include spinning up another Docker container.  In this way Docker, while a real step forward in many regards, logically fits into automation of operations from StackStorm just as do other underlying environments, including AWS, OpenStack, and others.

Of course, StackStorm and StackStorm content such as integrations (sensors) and actions, can be deployed via Docker containers too.

**StackStorm vs. Monitoring**

StackStorm leverages and extends monitoring in a variety of ways.  While StackStorm’s capabilities overlap with aspects of monitoring tools, StackStorm does not replace the need for monitoring.

StackStorm integrates with monitoring solutions in a couple of ways.  First, StackStorm takes events from monitoring and acts upon them; StackStorm sensors can be active &#8211; reaching out to monitoring, or passive, receiving SNMP traps for example.  Secondly, almost every monitoring solution enables some level of scripting so that simple actions are taken when certain events are identified.  These simple automations &#8211; many of which can be ingested as a script into StackStorm &#8211; may be better managed via StackStorm where they can enjoy the benefits of the rules engine, workflow, other integrations and more that are provided by StackStorm and where they can take their role as a part of the overall operations automation environment.

Additionally, StackStorm sensors are plugable, meaning that additional points of integration to monitoring can be added.  This means that a common operational pattern &#8211; that of the use of multiple pieces of monitoring to deliver an event pipeline &#8211; can be easily tied together and, again, managed via StackStorm.   There are some environments where the volume of events calls for a special purpose message bus at the core of your event pipeline; in many other environments, the volume of events can easily be handled by the highly scalable StackStorm sensors.

A final way that StackStorm integrates with and leverages monitoring solutions is by providing an additional level of event correlation and validation.  For example, much of the OpenStack troubleshooting guide has already been automated by StackStorm users; as is common to most troubleshooting, the process at getting to root cause is beyond the purview of any one monitoring solution and instead often requires both correlations amongst underlying monitoring solutions and actions taken sometimes via a process of elimination &#8211; such as logging into a suspect network device &#8211; to identify the underlying root cause.  This entire process, consisting of inbound notifications, outbound validations, and remedial actions can be tied together with conditional logic and integration into your existing collaboration and incident response systems by StackStorm.

**StackStorm vs. RunDeck**

RunDeck is a tool for run book automation.

StackStorm often fulfills a similar role, storing and managing automations.  Both solutions are pluggable, both enable operators to trigger actions from a GUI or an API (StackStorm has a CLI as well), both are used to capture and share aspects of operational patterns.

Unlike RunDeck, StackStorm also incorporates sensors, which are pluggable pieces of code that can ingest and process events.  This enables the complete operational pattern, from event &#8211; whether human or system generated &#8211; to action &#8211; whether remote actions executed via StackStorm or via a configuration management system &#8211; to be saved, shared, and managed.

The underlying architecture required for StackStorm to absorb and process and act upon these events is quite a bit different than RunDeck’s.

&nbsp;