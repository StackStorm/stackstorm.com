---
title: StackStorm 0.9 Features Support For Microsoft Windows And Azure
author: st2admin
type: post
date: 2015-04-30T17:18:58+00:00
excerpt: '<a href="http://stackstorm.com/2015/04/30/stackstorm-0-9-azure/">READ MORE</a>'
url: /2015/04/30/stackstorm-0-9-azure/
dsq_thread_id:
  - 3725969718
categories:
  - Blog
  - Community
  - Home

---
**April 30, 2015**

_by Evan Powell_

The pace here never seems to let up, and in fact it just keeps accelerating, as Thursday we introduced the general release of <a href="http://docs.stackstorm.com/install/index.html" target="_blank">version 0.9</a> of StackStorm. The new release supports an important partnership with Microsoft and adds some new visual authoring tools in our new WebUI to simplify use of StackStorm.

Additionally, as always, we are listening to you on IRC (<a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">#stackstorm on Freenode</a>) and to our supported customers as well and constantly improving and fixing the platform itself.  Please take a look at the [release notes][1] to see all the details.

###### Microsoft Integrations

With 0.9 we will be supporting Microsoft products and services including Azure and Microsoft Windows.

We will talk much more about this relationship in the next week or two along with our friends at Microsoft. As an aside, I’m absolutely flummoxed – in a good way – by the enthusiasm and professionalism and, yes, friendliness of the team we work with at Microsoft. I’ve dealt with pre anti-trust Microsoft and still carry scars from all those years ago. As many have pointed out, today’s Microsoft is a lot, lot different than in those days.

As you’ll note, we are not charging for StackStorm on Azure. We’re hopeful this will be another way for users to try out StackStorm without much friction. Note that Rackspace integration for StackStorm is of course strong as well and we have users running us on Digital Ocean and AWS of course as well.

<!--more-->

So with 0.9, you can run on Azure, you can control Azure, and you can listen to Azure as a source of events. All in all, Azure becomes a first class citizen in StackStorm’s event driven automation.

Windows also becomes a first class citizen. You can control and listen to Windows and can now more easily incorporate any existing powershell scripts into StackStorm as actions.

Again, we will talk much more about our Microsoft relationship shortly. Stay tuned.

###### WebUI Improvements

Last month, we introduced our graphical user interface (GUI) in our release of <a href="http://stackstorm.com/2015/03/03/stackstorm-0-8-introducing-new-web-ui/" target="_blank">version 0.8 of StackStorm</a>, and with version 0.9, we’ve enhanced with several improvements, including visual authoring of rules such as create, edit, and delete.

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/04/rule_creation.gif" alt="rule_creation" width="1245" height="608" class="alignnone size-full wp-image-3167" /> 

With these changes to our GUI we are simplifying the use of StackStorm to more fully automate your environment.

Keep in mind that StackStorm often runs as an event driven orchestrator running behind the scenes listening to events and taking actions, including workflows, as needed.  As Rackspace has demonstrated, complex imperative flows can even be boiled down into a simple declarative set of statements that anyone can invoke via chat.  Yes – Slack can control your software pipeline, your remediation, anything you need done that people routinely do – with the help of StackStorm powered ChatOps.

We are starting to talk more about ChatOps and blogged last week for instance about the very good _<a href="https://victorops.com/chatops-for-dummies/" target="_blank">ChatOps for Dummies</a>_ book our own James Fryman contributed to. Read more <a href="http://stackstorm.com/2015/04/23/stackstorm-and-chatops-for-dummies/" target="_blank">here</a>.

Our GUI also plays an important part in simplifying the management of the immense power of StackStorm event driven automation. Whereas end users like developers may never know more about StackStorm than that it is the wiring making the magic deploys via Slack happen, the SREs and others responsible for designing, building and running the operational environment do some of their work in StackStorm itself.

One more comment about the GUI. Everything in StackStorm – all the automations and integrations &#8211; are stored as files and can and should be source code controlled. Please don’t think that our ongoing enhancements to our GUI mean we are going to become yet another closed, click-fest automation product that requires people do interact via checkboxes and GUIs to get anything done. StackStorm itself is 100% automatable and, again, the GUI is intended to further help in administration.

###### Mistral Enhancements

First off, congratulations to Mistral for becoming an official OpenStack project effective the new Kilo release. We are benefiting hugely by having Mistral, which we drive, upstream in OpenStack and are looking forward to working with our fellow contributors at the upcoming <a href="https://www.openstack.org/summit/vancouver-2015/" target="_blank">Vancouver summit</a>.

We have a led a huge amount of work on Mistral including streamlined workflow authoring and management. Mistral is also now better at catching syntax errors and typos in the DSL and YAQL that may appear at runtime, thus streamlining workflow creation.

###### More To Come

Speaking of workflow and Mistral, as <a href="http://stackstorm.com/2015/04/10/the-return-of-workflows/" target="_blank">Dmitri recently pointed out</a>, there seems to be a return to awareness of the importance of workflow as glue in reasonably complex operational environments.

Our friends at LinkedIn have agreed to host an upcoming meetup on the subject on May 14 as the first in a new meetup series: “<a href="http://www.meetup.com/Auto-Remediation-and-Event-Driven-Automation/events/222051597/" target="_blank">Auto-remediation and event driven automation</a>.” Please join and follow along to our conversations if you can.

Also – if you’d like to help us as we iterate on forthcoming SaaS and analytics capabilities, please ping us. You can reach us on IRC at <a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">#stackstorm on freenode</a> and can sign up for a preview of our future SaaS offering <a href="http://stackstorm.com/early-saas-signup/" target="_blank">here</a>.

Stay tuned, and make sure to sign up for <a href="http://stackstorm.com/subscribe-to-newsletter/" target="_blank">our newsletter</a>.  
&nbsp;

 [1]: https://github.com/StackStorm/st2/releases/tag/v0.9.0