---
title: 'New in StackStorm 2.5: Real-time action output streaming'
author: Tomaz Muraus
type: post
date: 2017-11-07T16:58:38+00:00
url: /2017/11/07/new-stackstorm-2-5-real-time-action-output-streaming/
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6268702500
categories:
  - Tutorials
tags:
  - new feature

---
**November 07, 2017**  
_by Tomaz Muraus_

<p dir="ltr">
  <span style="font-weight: 400;">StackStorm v2.5.0 has been </span><a href="https://stackstorm.com/2017/10/26/stackstorm-2-5-hit-streets/"><span style="font-weight: 400;">released recently</span></a><span style="font-weight: 400;">. In addition to </span><a href="https://stackstorm.com/2017/10/31/new-stackstorm-2-5-inquiries/"><span style="font-weight: 400;">Inquiries</span></a><span style="font-weight: 400;">, it includes another </span><a href="https://github.com/StackStorm/st2/issues/2175"><span style="font-weight: 400;">widely requested</span></a><span style="font-weight: 400;"> feature &#8211; real-time output of actions.</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">Real-time action output streaming allows users to see any output produced by an action in real-time. </span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">This makes troubleshooting and debugging actions much easier and faster. It is especially handy in environments where StackStorm is used as a CI / CD tool and for long running actions (do you have a long running action which builds and installs a software package and you want to see the progress in real-time? Now that and a lot more is possible).</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">Prior to this release, it was only possible to see the output once the action has finished (well, there were some workarounds which involved using “tail” command, but those workarounds had many limitations and issues).</span>
</p>

<p dir="ltr" style="text-align: center;">
</p>

<!--more-->

<h1 dir="ltr">
  <span style="font-weight: 400;">Real-time action output streaming</span>
</h1>

<p dir="ltr">
  <span style="font-weight: 400;">We have done a lot of testing of this feature, but it is still considered experimental in this release and as such, it’s behind a feature flag. To enable it, set </span><b>actionrunner.stream_output = True </b><span style="font-weight: 400;">property in st2.conf and restart all services (</span><b>sudo st2ctl restart</b><span style="font-weight: 400;">).</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">Pending no major issues or blockers, the streaming feature will be enabled by default in the next major release.</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">Right now the feature is supported for all the most commonly used runners (local, remote, python runner).</span>
</p>

<h1 dir="ltr">
  <span style="font-weight: 400;">Consuming action output in real-time</span>
</h1>

<p dir="ltr">
  <span style="font-weight: 400;">Immediately after the action execution has been scheduled you can start consuming the output either by using the CLI or API:</span>
</p>

<h2 dir="ltr">
  <span style="font-weight: 400;">CLI</span>
</h2>

<p dir="ltr">
  <span style="font-weight: 400;">We have added a new “st2 execution tail” command. This command consumes events from the event-stream API and prints any output as soon as it’s available.</span>
</p>

<p dir="ltr">
  <span>st2 execution tail <execution id> [&#8211;include-metadata] [&#8211;type=stdout/stderr]</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">The command also supports simple workflows which are not nested &#8211; it will automatically follow any new action which which is kicked off by the workflow and tail and print the output of it.</span>
</p>

<p dir="ltr" style="text-align: center;">
</p>

<p dir="ltr">
  <span style="font-weight: 400;">The video above shows an example of this command in action. In this example we ran the “packs.install” action and then tailed the output of it. As you can see, we did not provide an “execution id” argument to the command. By default, if no execution id argument is provided, it will default to “last” and tail the last execution in the system.</span>
</p>

<h2 dir="ltr">
  <span style="font-weight: 400;">StackStorm API</span>
</h2>

<p dir="ltr">
  <span style="font-weight: 400;">In addition to the CLI, you can consume the output using the new </span><b>GET /v1/executions/<execution id>/output[?type=stdout/stderr/other]</b><span style="font-weight: 400;"> API endpoint.</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">This is useful in situations when you might not have access to the CLI and when you want to consume the output quickly and easily. The API endpoint keeps a long running connection open until the execution completes (or until the user closes the connection) which means you can simply curl the URL and any output will be shown as soon as it’s available.</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;"></span>
</p>

<h2 dir="ltr">
  <span style="font-weight: 400;">StackStorm Stream API</span>
</h2>

<p dir="ltr">
  <span style="font-weight: 400;">If you want to access the output programmatically, the best way to do that is using the event-stream API endpoint. Event-stream API endpoint follows the server-sent event specification and any change which is made to a StackStorm resource is reflected in the event-stream (e.g. an event is dispatched when an execution has been scheduled, when it starts running, when it completes, etc.).</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">The name of the event for the action output events is </span><b>st2.execution.output__create</b><span style="font-weight: 400;">.</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;"></span>
</p>

<h2 dir="ltr">
  <span style="font-weight: 400;">WebUI</span>
</h2>

<p dir="ltr">
  <span style="font-weight: 400;">Right now real-time output is only available via CLI and the API. We plan to add support for it to the WebUI in future, once the feature comes out of the experimental phase.</span>
</p>

<h1 dir="ltr">
  <span style="font-weight: 400;">Conclusion</span>
</h1>

<p dir="ltr">
  <span style="font-weight: 400;">We are excited and happy to finally be able to bring you this widely requested feature. We encourage you to try it out and as always, if you have any questions / comments / feedback, please </span><a href="https://stackstorm.com/#community"><span style="font-weight: 400;">get in touch</span></a><span style="font-weight: 400;">.</span>
</p>

<span style="font-weight: 400;">This post served as a brief introduction. For more information and more in-depth examples, please refer to the documentation &#8211; </span>[<span style="font-weight: 400;">Real-time Action Output Streaming</span>][1]<span style="font-weight: 400;">. If you are interested in the implementation details and want to dig deeper, the following PRs should serve as a good starting point &#8211; </span>[<span style="font-weight: 400;">3657</span>][2]<span style="font-weight: 400;">, </span>[<span style="font-weight: 400;">3729</span>][3]<span style="font-weight: 400;">.</span>

 [1]: https://docs.stackstorm.com/latest/reference/action_output_streaming.html
 [2]: https://github.com/StackStorm/st2/pull/3657
 [3]: https://github.com/StackStorm/st2/pull/3729