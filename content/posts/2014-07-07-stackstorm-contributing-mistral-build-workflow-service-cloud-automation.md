---
title: 'What Is Mistral And Why StackStorm Cares: Workflow Service For Cloud Automation'
author: Dmitri Zimine
type: post
date: 2014-07-07T10:30:58+00:00
excerpt: '<a href="/2014/07/07/stackstorm-contributing-mistral-build-workflow-service-cloud-automation/">READ MORE</a>'
url: /2014/07/07/stackstorm-contributing-mistral-build-workflow-service-cloud-automation/
dsq_thread_id:
  - 3184928404
thrive_post_fonts:
  - '[]'
categories:
  - Blog

---
**July 7, 2014**  
_by Dmitri Zimine_

At StackStorm, we believe that workflow is a key ingredient for cloud automation. That’s why we became drivers and core contributors to <a href="https://launchpad.net/mistral" target="_blank">Mistral</a>, a new workflow service for OpenStack.

Why the need for a new workflow service? Haven’t we already experienced Workflow Management? Aren’t a number of established, mature workflow products<sup>[<a href="#footnotes">1</a>]</sup> out there already? Yes, and yes, but…

With a decade of experience building system orchestration and automation products<sup>[<a href="#footnotes">2</a>]</sup> and seeing them used in the field, I realized that using a traditional BPM (business process management) oriented workflow is not a good match with today’s pace of change and scale of operations. The rich variety of <a href="http://www.workflowpatterns.com/" target="_blank">workflow patterns</a> that are bragged about by traditional BPM systems are never used in practice. The graphical representation of workflow, so exciting for non-technical BPM users, becomes a handcuff for techy admins. And complex XML-based syntax made working with workflow definition files a nightmare.

<!--more-->

My experience tells me that a workflow service for system automation needs to do only three things, but do them well. These things are: 1) string atomic tasks into workflows 2) manage the state 3) carry the data between systems. This is the essence. Plus other goodies: tracking execution details, history and audit trail, at scale, with high availability and fault resiliency. Plus cater to the DevOps approach to operating environments – for example, support infrastructure as code, and be scriptable, extensible and open.

That’s Mistral: a simple yet scalable workflow service for cloud automation. It features:

  * Simple intuitive YAML based workflow definition language
  * REST API to operate the workflows
  * Extensible set of actions, with REST HTTP calls, SSH, email, and OpenStack operations available out of the box

Mistral target users are mainly OpenStack administrators who are automating their operations and maintenance procedures, and integrating private clouds with their broader infrastructure. One use case might be <a href="https://github.com/dzimine/mistral-workflows/tree/master/openstack-troubleshooting" target="_blank">automating a page from the OpenStack troubleshooting guide</a>, while keeping a full track in JIRA and sending updates to PagerDuty.

The other group of users is cloud application developers who use Mistral for Workflow Service, just like AWS Simple Workflow.

Mistral is also a platform component for other OpenStack services that need a concept of a workflow service. Heat, Fuel, Barbican, Murano, Keystone, Trove, and a few more are looking at integrating with Mistral.

To get a taste of Mistral, check out the <a href="https://www.youtube.com/watch?v=x-zqz1CRVkI" target="_blank">demo screencast</a> from Mistal PTL, Renat Akhmerov. Or play with it – now that Mistral is a part of <a href="http://devstack.org/" target="_blank">DevStack</a> it is easy to get running.

Last week an <a href="https://pypi.python.org/pypi?%3Aaction=search&term=mistral" target="_blank">updated version</a> of Mistral was released with improvements, important bug fixes, and a nice Horizon dashboard. Mistral is still forming and continues to revisit, refine and redesign based on its pilot implementation. With a strong team of contributors from Mirantis, Intel, Rackspace, and StackStorm, Mistral is growing fast and is on track for OpenStack incubation.

One final comment – Mistral will have applicability beyond OpenStack. Please keep that in mind when you are playing with it or learning more.

I’m working on an article about all the ways to automate OpenStack that I’ll link to from here when it is finalized. Our company has also been asked to hold an [online meetup][1] called &#8220;Automating OpenStack with StackStorm&#8221; on Thursday, July 17. Hope you can join us!

<a name="footnotes"></a>

* * *

**Citations and Links:**

[1] Established workflow systems:  
[Drools][2]  
[jBPM][3]  
<a href="http://activiti.org/" target="_blank">Activiti</a>  
[WWF Windows Workflow Foundation][4]

[2] Workflow based system orchestration and automation products:  
<a href="http://technet.microsoft.com/en-us/library/hh237242.aspx" target="_blank">Microsoft System Center Orchestrator (formely Opalis)</a>  
<a href="http://www8.hp.com/us/en/software-solutions/operations-orchestration-it-process-automation/" target="_blank">HP Operations Orchestration (formerly iConclude)</a>  
<a href="http://www.vmware.com/products/vcenter-orchestrator/" target="_blank">VMware vCenter Orchestrator (formerly Dunes)</a>  
<a href="http://www.bmc.com/it-solutions/product-listing/orchestrator.html" target="_blank">BMC Atrium Orchestrator (formerly Realops)</a>  
<a href="http://en.wikipedia.org/wiki/CA_IT_Process_Automation_Manager" target="_blank">CA ITPAM</a>  
<a href="https://www.netiq.com/products/aegis/" target="_blank">NetIQ Aegis</a>  
<a href="http://www.citrix.com/downloads/workflow-studio/components/workflow-studio.html" target="_blank">Citrix Workflow Studio</a>

 [1]: http://www.meetup.com/OpenStack-Online-Meetup/events/193478232/
 [2]: http://www.jboss.org/drools
 [3]: http://www.jboss.org/jbpm/
 [4]: http://msdn.microsoft.com/en-us/library/vstudio/ms734631(v=vs.90).aspx