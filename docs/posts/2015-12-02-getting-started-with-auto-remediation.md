---
title: 'Auto-Remediation: Getting Started'
author: st2admin
type: post
date: 2015-12-02T20:04:21+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/12/02/getting-started-with-auto-remediation/
dsq_thread_id:
  - 4402122770
tcb2_ready:
  - 1
thrive_post_fonts:
  - '[]'
categories:
  - Blog
tags:
  - Auto-remediation

---
**December 2, 2015**  
_by Patrick Hoolboom_

<p dir="ltr">
  <span style="font-weight: 400;">On the latest </span><a href="https://www.youtube.com/watch?v=_z6uyPU1Voo"><span style="font-weight: 400;">Automation Happy Hour</span></a><span style="font-weight: 400;"> we talked with engineers from Netflix about auto-remediation. A good portion of the discussion was around how to get started. This got me thinking that I should probably take a moment to go over this topic a bit.</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">People tend to overanalyze auto-remediation. It seems there is a mentality that they must automate away all of their problems on day one. This type of thinking frequently leads to analysis paralysis. They deadlock on trying to decide </span><i><span style="font-weight: 400;">what</span></i><span style="font-weight: 400;"> to automate. &nbsp;In this article I am going to outline two of the best ways I have found to get people started in auto-remediation. &nbsp;Facilitated troubleshooting and simple monitoring events.</span>
</p>

<h2 dir="ltr">
  <b>Why Auto-Remediate?</b>
</h2>

<p dir="ltr">
  <span style="font-weight: 400;">Auto-remediation is more than a band-aid for poorly implemented infrastructure or applications. &nbsp;Servers go down, processes hang, outages happen. &nbsp;It provides a significant reduction in time to resolution and allows the team to focus more on root cause analysis to prevent future outages. &nbsp;It helps alleviate pager fatigue and let’s people focus more on the important task of improving the applications or infrastructure. &nbsp;Leveraging an event driven automation platform such as StackStorm also gives better visibility into what is and isn’t working in your process. &nbsp;Let the machines mitigate the event so you can focus on making sure it doesn’t happen again.</span><!--more-->
</p>

<h2 dir="ltr">
  <b>Facilitated Troubleshooting</b>
</h2>

<p dir="ltr">
  <span style="font-weight: 400;">An easy way to get started is to </span><i><span style="font-weight: 400;">NOT</span></i><span style="font-weight: 400;"> remediate right away. Your team may not be sold on fully automated resolutions yet. &nbsp;Facilitated troubleshooting gives you a good way to show value from automation while still allowing a person to perform the final remediation action. &nbsp;&nbsp;Auto-remediation is really broken into two pieces, diagnostic workflows and remediation workflows. &nbsp;Facilitated troubleshooting is running the diagnostic workflow automatically, and the remediation workflow manually. These workflows collect information about the event, to better prepare the person who will respond to the page.</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">When an event fires, collect a </span><i><span style="font-weight: 400;">lot more</span></i><span style="font-weight: 400;"> data about that event. Think about the things you would check if you were woken up by the page. &nbsp;These steps will become the tasks in your diagnostic workflow. &nbsp;These types of workflows are handy as they allow you to execute more expensive or long running checks. This lets you keep your monitoring system lean and mean but still get the necessary information during an event. Take this data and share it with the on call engineers or team as you see fit (chat, ticket, email, etc). &nbsp;Include suggested next steps or additional workflows they may run to help reduce time to resolution even more.</span>
</p>

<h2 dir="ltr">
  <b>KISS</b>
</h2>

<p dir="ltr">
  <span style="font-weight: 400;">When you are ready to auto-remediate, start with the low hanging fruit. Automate the easy things in order to identify the proper patterns for you and your organization. Some examples of easy tasks:</span>
</p>

<li dir="ltr" style="font-weight: 400;">
  <span style="font-weight: 400;">Restarting a dead/hung process</span>
</li>
<li dir="ltr" style="font-weight: 400;">
  <span style="font-weight: 400;">Clearing disk space</span>
</li>
<li dir="ltr" style="font-weight: 400;">
  <span style="font-weight: 400;">Removing unused volumes or VMs</span>
</li>

<p dir="ltr">
  <span style="font-weight: 400;">Nir Alfasi from Netflix spoke of automating the remediation of health checks for service discovery. This is a great example of a simple remediation. </span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">Does service discovery think the node is down?</span>
</p>

<li dir="ltr" style="font-weight: 400;">
  <span style="font-weight: 400;">Check health of the instance</span>
</li>
<li dir="ltr" style="font-weight: 400;">
  <span style="font-weight: 400;">Attempt to reboot if unhealthy</span>
</li>
<li dir="ltr" style="font-weight: 400;">
  <span style="font-weight: 400;">Attempt to clear the health check if node is healthy</span>
</li>
<li dir="ltr" style="font-weight: 400;">
  <span style="font-weight: 400;">If all else fails, escalate!</span>
</li>

<p dir="ltr">
  <span style="font-weight: 400;">Another example would be a simple disk space remediation:</span>
</p>

<p dir="ltr">
  <a href="https://github.com/DoriftoShoes/workflow-patterns/blob/master/packs/linux-ops/actions/workflows/purge_logs.yaml"><span style="font-weight: 400;">Disk Space Cleanup</span></a>
</p>

<h3 dir="ltr">
  <b>Which Events Should I Auto-Remediate?</b>
</h3>

<p dir="ltr">
  <span style="font-weight: 400;">A good way to get started quickly is to look at the alert history from your monitoring system. </span>
</p>

<li dir="ltr" style="font-weight: 400;">
  <span style="font-weight: 400;">What alerts happen frequently?</span>
</li>
<li dir="ltr" style="font-weight: 400;">
  <span style="font-weight: 400;">Of these frequent alerts, which ones are dealt quickly and/or easily?</span>
</li>

<p dir="ltr">
  <span style="font-weight: 400;">Ask yourself those questions as you look over the monitoring events. &nbsp;&nbsp;Most teams have a fair amount of those nagging events. &nbsp;Things that happen fairly regularly and are a simple fix. &nbsp;Pick </span><b>one</b><span style="font-weight: 400;"> and automate it! &nbsp;There is no need to automate </span><b>ALL</b><span style="font-weight: 400;"> of the alerts you find right away. &nbsp;These are the types of events you should auto-remediate.</span>
</p>

<h3 dir="ltr">
  <b>Which Events Are Easy Targets for Facilitated Troubleshooting?</b>
</h3>

<p dir="ltr">
  <span style="font-weight: 400;">Take a look at your monitoring events again. Look for more general alerts that require you to touch many different systems or applications to troubleshoot. These make great candidates for facilitated troubleshooting. StackStorm can contact all these systems to gather this data, saving you (as or with the on call engineer) from having to check everything manually.</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">Things like application latency alerts are perfect for this. You may need to check health of networking equipment, look for long running queries or deadlocks in the database, out of memory errors, etc.</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">Another great example provided by our friends at Netflix was building a rich context around alerts from their monitoring system (Atlas). &nbsp;They leverage the power of StackStorm to make API calls out to other tools (such as their deployment tool, Spinnaker). &nbsp;Making the API queries and building the context is not something that most monitoring systems can do&#8230;at least not easily. &nbsp;Make use of workflows to do this heavier work for you.</span>
</p>

<h2 dir="ltr">
  <b>How Do I Get Others To Love Auto-Remediation?</b>
</h2>

<p dir="ltr">
  <span style="font-weight: 400;">Often, the largest barriers to getting started with auto-remediation (or automation in general) are not technical. &nbsp;Team members may have had bad experiences with automations or there may even be a fear of “automating oneself out of a job”. &nbsp;The best way to overcome these issues is to show people the added value of automating a process. &nbsp;One of the quickest ways to do this is by giving them visibility of what is being automated. &nbsp;</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">Make sure you are adding notifications to all your workflows! The team should see all the awesome things that you are automating. Let them see all the work that your new workflows are doing for them. StackStorm has a great notification system built in that can make this significantly easier:</span>
</p>

<p dir="ltr">
  <a href="https://docs.stackstorm.com/chatops/notifications.html"><span style="font-weight: 400;">StackStorm Notifications</span></a>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">Leverage collaborative tools like ticketing systems or ChatOps to share this information. &nbsp;Make it as seamless as possible for everyone. &nbsp;If most of the event management and communication is done via JIRA or Bugzilla, have the automations update the appropriate issue or ticket in those tools. &nbsp;On the other hand if chat is more prevalent, post the notifications to the appropriate chat channels. &nbsp;By getting early notification of events, and a rich context around that event, you’ll be able to quickly show the value of automation.</span>
</p>

<h2 dir="ltr">
  <b>Next Steps</b>
</h2>

<p dir="ltr">
  <span style="font-weight: 400;">Now that you are auto-remediating your disk space alerts, doing facilitated troubleshooting for your application latency issues, and automating the </span><b>E_NOTENOUGHCAFFEINE</b><span style="font-weight: 400;"> errors at your desk, you may ask &#8220;What&#8217;s Next?&#8221;.</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">Well first and foremost, if you wrote an awesome workflow we’d love to see it! &nbsp;Share your operational patterns with the community. &nbsp;You can either make your own GitHub repo that is publicly accessible, or submit a pull request against ours! &nbsp;Let others take advantage of the remediations you have written, and maybe even help you improve them.</span>
</p>

<p dir="ltr">
  <a href="https://exchange.stackstorm.org"><span style="font-weight: 400;">StackStorm Exchange</span></a>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">There are a number of different ways to proceed from here, but one of the best routes is ChatOps. For more information on ChatOps, check out our docs:</span>
</p>

<p dir="ltr">
  <a href="https://docs.stackstorm.com/chatops/index.html"><span style="font-weight: 400;">StackStorm ChatOps</span></a>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">And of course, there is StackStorm Enterprise. This gives you access to role based access controls, ldap authentication, and the awesome graphical workflow designer, Flow. Flow is a fantastic utility for creating your workflows as well as sharing them.</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">Last but certainly not least&#8230;join our community and our Automation Happy Hours!</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">Sign up for the StackStorm Slack Community here:</span>
</p>

<p dir="ltr">
  <a href="https://stackstorm.com/community-signup"><span style="font-weight: 400;">StackStorm Community Sign Up</span></a>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">And keep an eye out here for our next Automation Happy Hour:</span>
</p>

<p dir="ltr">
  <a href="https://stackstorm.com/register"><span style="font-weight: 400;">Automation Happy Hour Registration</span></a>
</p>