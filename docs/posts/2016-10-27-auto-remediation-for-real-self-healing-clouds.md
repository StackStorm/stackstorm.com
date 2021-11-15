---
title: 'Auto-Remediation for Real: Self-Healing Clouds and Auto-Remediation as a Service'
author: st2admin
type: post
date: 2016-10-27T18:58:59+00:00
url: /2016/10/27/auto-remediation-for-real-self-healing-clouds/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5258446323
categories:
  - Blog
tags:
  - Auto-remediation
  - event-driven automation
  - Mirantis
  - nagios
  - Netflix
  - openstack
  - pager duty
  - prometheus
  - self-healing
  - symantec
  - volta
  - zabbix

---
**Oct 27, 2016**  
_by Dana Christensen_

What do companies like eBay, VMware, Facebook, Netflix, Mirantis, Verizon, Infosys, Cisco, Dell, LinkedIn, and Apple have in common?

They all attended the <a href="http://www.meetup.com/Auto-Remediation-and-Event-Driven-Automation/" target="_blank">Auto-Remediation and Event-Driven Automation MeetUp</a> on Oct. 20th hosted by the StackStorm team at Brocade in San Jose.

The topic for the evening was “Remediation For Real” and both Mirantis and Netflix provided excellent overviews and demonstrations of how auto-remediation is helping to address business issues and increase their engineers’ productivity (and sleeptime!).

<!--more-->

## The Power of Community

The power of Community and MeetUps is to inspire and help each other up our game &#8211; and the presentations and conversation before and after the presentations delivered.  We saw real-life examples of auto-remediation use cases (and code), shared best practices and key learnings. The presenters all offered excellent suggestions for how to define and implement auto-remediation solutions, including how they decided on the underlying technology for their solutions. [StackStorm][1] is the underlying engine for both the Mirantis and Netflix solutions,  and it was helpful to hear why they chose StackStorm rather than attempting to build their own solution.

## Mirantis and Self-Healing Clouds

Mirantis kicked off the evening with a preview of their OpenStack Summit presentation, <a href="https://www.mirantis.com/blog/auto-remediation-making-an-openstack-cloud-self-healing/" target="_blank">“Auto-Remediation: Making OpenStack Clouds Self Healing”.</a> Their presentation focused on how auto-remediation is being used to streamline operations of the Mirantis managed Symantec cloud&#8211;an OpenStack + AWS hybrid environment. The OpenStack environment consists of four regions, 100’s of racks, with thousands of compute nodes. The AWS environment is rapidly growing, with tens of thousands of cores. The monitoring, metering, and alerting ecosystem includes multiple solutions &#8211; most notably Zabbix, Nagios, Prometheus, PagerDuty and Volta. There are three Mirantis engineers assigned to run this relatively large cloud. The team realized that the time they spend working on outages was hindering their productivity in other areas &#8211; so they decided to investigate using auto-remediation as a way to streamline and automate their day to day operations.

Watch the presentation to get an excellent overview of the Symantec cloud environment, how the team set about looking at operational patterns that they should automate in their day to day operations; examples of basic and advanced use cases for automating their OpenStack cloud, and key learnings from their deployment:

<p style="text-align: center;">
</p>

## Auto-Remediation at Netflix

Netflix was next up to share key learnings about their auto-remediation platform <a href="http://techblog.netflix.com/2016/08/introducing-winston-event-driven.html" target="_blank"><span>Winston</span></a><span>. As a bit of background, Netflix engineers operate under a full ownership model. Engineers are responsible for architecting and coding the customer experience AND they own deployment and all operational aspects of their service. From a business perspective&#8211;engineers have to deal with the conflict between new feature development work that needs to be done to move a service forward vs. the work that needs to be done to keep an existing service healthy. Enabling scale to match the growth of the Netflix business, and focus on SLAs are also key business goals.</span>

Netflix is investing in the development of tools and services for their engineers to increase job satisfaction (eliminating the need to do a lot of mundane, repetitive tasks) and productivity. The presentation provided a great overview of the one-stop portal that they developed for Winston; how they incorporated best practices for things like compliance/auditing, reporting, and security (authority and authentication); and the UI that Netflix developed to provide auto-remediation as a service for their engineers.

The Netflix team shared use cases and helpful observations about rolling out an auto-remediation service. One of the interesting points is that the main barrier to rolling out this solution is not technical&#8211;it is cultural. Watch the video to hear suggestions for overcoming cultural barriers you might encounter when rolling out an auto-remediation project:

<p style="text-align: center;">
</p>

## Benefits of Auto-Remediation

Key benefits that both Mirantis and Netflix touched on include:

<li dir="ltr">
  Freeing engineers/developers from tier 1 support activities so they can focus on business issues
</li>
<li dir="ltr">
  Enabling scale
</li>
<li dir="ltr">
  Delivering on SLAs
</li>
<li dir="ltr">
  Reduced MTTR
</li>
<li dir="ltr">
  Reduced risk of human errors
</li>
<li dir="ltr">
  Reduced pager fatigue
</li>

It was great to see familiar faces and to make new friends at the MeetUp. As the popularity of StackStorm continues to expand worldwide, we are seeing MeetUps happening in Japan, Australia, London, Los Angeles, and Amsterdam.  We will be sharing key learnings from these MeetUps in the StackStorm community.  To date DevOps has focused on deployment&#8211;but with the StackStorm community and the Auto-Remediation Meetup we are taking the conversation beyond deployment&#8211;to event-driven automation.

We look forward to continuing the conversation.  See you at the next <a href="http://www.meetup.com/Auto-Remediation-and-Event-Driven-Automation/" target="_blank"><span>Auto-Remediation and Event-Driven Automation Meetup! </span></a>

 [1]: https://stackstorm.com/