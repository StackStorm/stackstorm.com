---
title: 'StackStorm Success Stories: Anonymous Service Provider'
author: st2admin
type: post
date: -001-11-30T00:00:00+00:00
draft: true
url: /?p=2775
categories:
  - Uncategorized

---
**TBD, 2015**

_by Evan Powell_

Insert intro language here&#8230;

**Wireless Service Provider**

This particular user’s legal department would extract some of my various essential parts if I were to mention them by name. Nonetheless, their story is worth sharing as it echoes what many of our users are telling us.

We are working with this service provider’s service assurance team. This team is the nervous system for their services, providing real time and historic information on performance to their customers, partners, and of course to the operations team within the service provider.

They use StackStorm in two ways: to automate the running of their internal systems, and to provide better intelligence to their internal and external customers.

<span style="text-decoration: underline;">Internal System Management</span>

This service assurance group has more than 100 systems that it must tie together in order to deliver services. The integration of these systems for automations intended to build, rebuild, troubleshoot and scale these systems was becoming a “100 factorial problem” that only promised to get worse as more systems were added.

With StackStorm, they are now able to interface with all of these systems programmatically from one location – and to tie them together into easy to author workflows. The user authored the following diagram that shows where StackStorm fits. Although in practice, Jira, Consult and Wily all interact directly with StackStorm; as do a couple of portal like tools used by the level 1 and level 2 NOCs:  
<img loading="lazy" class="alignnone wp-image-2762" src="http://stackstorm.com/wp/wp-content/uploads/2015/02/2.25.15-blog-entry-diagram-300x213.png" alt="2.25.15 blog entry diagram" width="500" height="356" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/02/2.25.15-blog-entry-diagram-300x213.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/02/2.25.15-blog-entry-diagram-400x284.png 400w, https://stackstorm.com/wp/wp-content/uploads/2015/02/2.25.15-blog-entry-diagram.png 857w" sizes="(max-width: 500px) 100vw, 500px" /> 

<span style="text-decoration: underline;">External System Management</span>

Having used StackStorm to tie together their systems and automate the building, updating and troubleshooting of these systems, this operator set out to develop workflows that enabled them to deliver better services to their customers.

As an example, before StackStorm, Jira integration was handled with a handful of scripts and often with manual effort. Someone would drop from their “command console” into Jira to update tickets as information was gathered from systems as disparate as Wily and other monitoring systems. With the addition of StackStorm, this data flows smoothly from alerting systems – increasingly including some micro services themselves – via StackStorm into Jira.

If you’ll notice, StackStorm is also starting to be used to support Hubot. “Wait a minute!” you may say, “I thought ChatOps via Hubot was all about ‘ticketless IT’.” Actually belts and suspenders is a very common pattern where ticketing remains thanks to all the existing tooling and, crucially, to SLAs that are measured based on tickets.

If you put these few integrations together, you can see what kind of workflows are being used by this service provider. The tier 1 NOC largely continues to use ticketing and its in-house developed Command Console – and those tickets are more frequently updated with useful information because of StackStorm. On the other hand, ChatOps is now used by the tier 2 team. This team uses the interactive exchanges made possible by StackStorm to run additional interrogations, conducting what we call facilitated troubleshooting directly from their chat interfaces.

<span style="text-decoration: underline;">Why StackStorm?</span>

This wireless service provider had a few takeaways when we asked them “why StackStorm”:

  1. “The N factorial problem was killing us. We were spending more time maintaining our service assurance services then we were in building new services to help assure the services of our customers.” Yes, that’s a meta mouthful, but all too often the world in which we all live.
  2. “We will always have legacy systems. StackStorm lets us abstract away from these systems and gradually remove them as we find better solutions. StackStorm helps eliminate operational lock-in.”
  3. “We felt out of control before. Now we have much more control even as we go to higher and higher degrees of automation. Plus the support has been stellar.”

**Conclusion**

Large-scale users are finding tangible benefits when using StackStorm. We at StackStorm are also publishing detailed and technically useful case studies. You can read one on <a href="http://stackstorm.com/wp/wp-content/uploads/2014/10/StackStorm-Case-Study-Lg-SaaS-Operator.pdf" target="_blank">how a large first generation SaaS provider used StackStorm</a> – plus some masterful operational architecture – to boost their agility as measured by deploys per developer per day by over 50x here.

Incidentally, we welcome guest blogs and posts. We need everyone’s input to continue to stitch together today’s heterogeneous environments into highly automated pipelines that remain trustworthy, auditable, and controllable via ChatOps and other systems as well.

So please continue to share your experiences, requests and, yes, bug reports and fixes. You can learn how to do all of that – and how to use StackStorm itself &#8211; at our <a href="http://stackstorm.com/community/" target="_blank">StackStorm Community site</a>.

If you haven’t already, we invite you to check out our product by <a href="http://docs.stackstorm.com/install/index.html" target="_blank">installing StackStorm</a> and following the <a href="http://docs.stackstorm.com/start.html" target="_blank">quick start</a> instructions — it will take less than 30 minutes to give you a taste of our automation. Share your thoughts and ideas via [stackstorm@googlegroups.com][1], <a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">#stackstorm on irc.freenode.net</a> or on Twitter <a href="https://twitter.com/Stack_Storm" target="_blank">@Stack_Storm</a>. You can also reach me directly on Twitter at <a href="https://twitter.com/epowell101" target="_blank">@epowell101</a>.

 [1]: https://groups.google.com/forum/#!forum/stackstorm