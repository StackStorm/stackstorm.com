---
title: PagerDuty Pack Update – API v2
author: st2admin
type: post
date: 2017-05-30T19:59:32+00:00
url: /2017/05/30/pagerduty-pack-update-api-v2/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5864565693
categories:
  - News
tags:
  - integration packs

---
<p dir="ltr">
  <strong>May 30, 2017</strong><br /> <em>by Warren Van Winckel</em>
</p>

We have updated the PagerDuty pack to use the &#8220;pypd&#8221; library, maintained by PagerDuty. Previously we were using the &#8220;pygerduty&#8221; library, maintained by DropBox. Key point to note is that &#8220;pygerduty&#8221; uses version 1 of the PagerDuty API, and &#8220;pypd&#8221; uses version 2.

We needed to update to v2 because PagerDuty [will not be supporting version 1 of their API][1] after July 6, 2017. As a consequence of the migration to the latest API, any existing Stackstorm and PagerDuty users should update their packs and configurations now. You will need to change the way some actions are called because the API has changed and some new parameters are required:

<span style="font-family: andale mono,monospace">st2 run pagerduty.acknowledge_incident email=’&#8217; ids=<incident-ids></span>

<span style="font-family: andale mono,monospace">st2 run pagerduty.resolve_incident email=’’ ids=<incident-ids></span>

<!--more-->

&#8220;<incident ids>&#8221; is a comma separated list of incident ids. Additionally, ensure the <span style="font-family: andale mono,monospace">/opt/stackstorm/configs/pagerduty.yaml</span> file looks similar to this:

<span style="font-family: andale mono,monospace">api_key: T7-yQxyFzxSiy2p2vQr5<br /> debug: false<br /> service_key: c409912215b34511aa1814d8fa9b9d00</span>

In the next few weeks, we will be adding additional functionality to the pack so that you can take advantage of even more features of PagerDuty.

 [1]: https://v2.developer.pagerduty.com/docs/api-v2-frequently-asked-questions