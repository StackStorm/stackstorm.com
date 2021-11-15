---
title: 'Monitorama 2017: Data Science, Discussions, and Deep Dives'
author: st2admin
type: post
date: 2017-06-07T15:29:20+00:00
url: /2017/06/07/monitorama-2017-data-science-discussions-deep-dives/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5888648652
categories:
  - Blog
  - Community

---
<p dir="ltr">
  <strong>June 7, 2017</strong><br /> <em>by Matt Oswalt</em>
</p>

<p dir="ltr">
  The team here at StackStorm was psyched to sponsor Monitorama 2017. This was the first Monitorama we attended, and it was an interesting new take on the world of monitoring. A proper monitoring infrastructure is key crucial for event-driven automation, in order to better understand what an “event” is.
</p>

<!--more-->

<p dir="ltr">
  Monitorama is a fairly small conference, opting for a single speaker track instead of several talks in parallel. I found this to be a very comfortable and engaging format; the organizers did a great job of structuring the schedule so that the topics flowed organically, and even flowed into the hallway conversations. Also, because it was in Portland, a local coffee shop came and made pour-overs for everyone, so that was a nice alternative to traditional conference coffee 🙂
</p>

<p dir="ltr">
  Naturally, the conference focused on monitoring, but I noticed two strong common themes:
</p>

<li dir="ltr">
  Many talks promoted a very “non-traditional” approach to monitoring. In lieu of looking at Nagios dashboards, many speakers tackled the topic from almost a data science perspective. Lots of deep-dives into mathematics and performance analysis techniques.
</li>
<li dir="ltr">
  There was a heavy focus on the human side of operations and being on call. This reminded me a lot of <a href="https://stackstorm.com/2017/03/23/stackstorm-srecon-2017/">SREcon 2017</a>. There were a lot of war stories, and perspectives into making ops lives easier through better processes.
</li>

<h2 dir="ltr">
  Non-Traditional Monitoring
</h2>

<p dir="ltr">
  I come from a networking background, and when it comes to monitoring, most products in this space have historically focused on up/down monitoring &#8211; i.e. is it up or down? These days, simple metrics like that are not sufficient, and more granular, programmatically accessible telemetry is needed. This is a situation that is slowly improving, but there’s still a lot of work to do.
</p>

<p dir="ltr">
  We’ve all seen recently, all IT disciplines have &#8211; out of necessity &#8211; had to operate closer and closer to the applications. As a result, the line where “traditional monitoring” has operated is getting blurred with things like application performance monitoring. No longer can the network engineer or sysadmin focus solely on whether their switch or server is on &#8211; they have to be able to understand how applications interact with their infrastructure, and be able to show detailed performance metrics and other telemetry on how this is taking place.
</p>

<p dir="ltr">
  <a href="https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.02.43-AM.png"><img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.02.43-AM.png" alt="" width="542" height="307" class="wp-image-6862 aligncenter" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.02.43-AM.png 1652w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.02.43-AM-150x85.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.02.43-AM-300x170.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.02.43-AM-768x435.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.02.43-AM-1024x580.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.02.43-AM-80x45.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.02.43-AM-220x125.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.02.43-AM-176x100.png 176w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.02.43-AM-265x150.png 265w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.02.43-AM-420x238.png 420w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.02.43-AM-732x415.png 732w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.02.43-AM-860x487.png 860w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.02.43-AM-1050x595.png 1050w" sizes="(max-width: 542px) 100vw, 542px" /></a>
</p>

<p dir="ltr">
  John Rauser started the conference with a message from the future &#8211; okay, not really, his goal was simply to bring the world of data science into the monitoring toolchains in use today, in his talk  “<a href="https://www.youtube.com/watch?v=P8dc-rLnLr0&feature=youtu.be&t=1h1m25s">Finding Inspiration in the Data Science Toolchain</a>”. In it, he illustrated several ways that ideas from the world of data science were having a big impact on monitoring techniques, and vice versa. For instance, some data scientists are finding usefulness in the idea of infrastructure-as-code &#8211; describing visualizations and calculations in code as opposed to a click-through GUI. In general, the idea of bringing the specialized skills of a few, and making it consumable for the masses, resonated with me greatly, and is definitely a big driver for what we do at StackStorm.
</p>

<p dir="ltr">
  Ian Bennett (Twitter) gave a talk near the end of the last day on “<a href="https://youtu.be/o_8EsyFWal0?t=5h29m30s">Debugging Distributed Systems</a>” that I found interesting. In it, he highlights the need for traditional sysadmin skills and more developer-oriented skills to coexist to fully troubleshoot a problem. One minute he’s talking about an optimal logging infrastructure, and the next minute he’s diving into troubleshooting application performance by looking at how the garbage collector in JVM is handling certain string concatenations.
</p>

<p dir="ltr">
  In general, I enjoyed this fresh take on monitoring. There are a lot of interesting ideas and tools that are just starting to take shape in this space, and I came away from these talks inspired with new ideas for <a href="https://docs.stackstorm.com/sensors.html">StackStorm sensors</a> to write in order to connect this advanced logic with some sweet auto-remediation workflows.
</p>

<h2 dir="ltr">
  The Changing Culture of Operations
</h2>

<p dir="ltr">
  <a href="https://youtu.be/P8dc-rLnLr0?t=1h28m40s">Alice Goldfuss gave a lively talk</a> about the need for change in the culture of operations and being on-call. This was a very useful look into the way operations are traditionally run, and their impact on human beings. She did a good job of mixing real talk about what’s wrong, what’s right, and some funny stories along the way. There were some good ideas presented here &#8211; one that impacted me greatly was the need to stop viewing pages as a metric of success. I had many discussions later this week about this topic, especially as it pertains to StackStorm, since the whole idea of auto-remediation is to never have to solve the same problem twice. When encountering an outage, troubleshoot it, fix it, then write a workflow that incorporates all that logic into “code” &#8211; a workflow that performs these same steps on your behalf next time. Bottom line: don’t take pride in the fact that you get paged &#8211; work to reduce the number of times a human needs to be engaged to solve a problem.
</p>

<p dir="ltr">
  <a href="https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.08.26-AM.png"><img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.08.26-AM.png" alt="" width="514" height="281" class="wp-image-6863 aligncenter" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.08.26-AM.png 1268w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.08.26-AM-150x82.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.08.26-AM-300x164.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.08.26-AM-768x419.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.08.26-AM-1024x559.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.08.26-AM-80x44.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.08.26-AM-220x120.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.08.26-AM-183x100.png 183w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.08.26-AM-275x150.png 275w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.08.26-AM-436x238.png 436w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.08.26-AM-750x409.png 750w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.08.26-AM-892x487.png 892w, https://stackstorm.com/wp/wp-content/uploads/2017/06/Screen-Shot-2017-06-07-at-7.08.26-AM-1090x595.png 1090w" sizes="(max-width: 514px) 100vw, 514px" /></a>
</p>

<p dir="ltr">
  These ideas and more &#8211; such as the need for developers and operations to work more closely &#8211; really hit home for me, and I would recommend this talk for anyone, whether or not you consider operations your primarily role.
</p>

<h2 dir="ltr">
  Auto Remediation Meetup
</h2>

<p dir="ltr">
  I was pleased to participate in a panel at <a href="https://www.meetup.com/Auto-Remediation-and-Event-Driven-Automation/events/239668383/">the first meeting of the Portland chapter of the Auto-remediation meetup</a>. This not only served as a great (and audience-interactive) discussion of automation and monitoring, but also a good recap of Monitorama 2017 (this took place the last day of the conference at a local brewpub). I highly recommend you watch the video, there were a lot of great audience questions (that we hopefully answered):
</p>

<div style="text-align: center;">
</div>

<h2 dir="ltr">
  Conclusion
</h2>

<p dir="ltr">
  It was clear that Monitorama&#8217;s audience leaned heavily towards the &#8220;ops&#8221; side. This kind of mix is no stranger to me, as I’ve been going to these kind of conferences for a few years. However, unlike traditional IT conferences, where applications or developer types are despised (for the most part), Monitorama definitely took a more positive approach &#8211; opting instead to work <b>better</b> with developers; even borrowing tools and ideas from the world of software in order to work more efficiently. This was greatly comforting to me, since I’ve been advocating for this approach in the world of networking for a few years.
</p>

<p dir="ltr">
  I am excited for next year’s Monitorama, and am hoping we’ll be back as a sponsor next year. There’s a LOT to talk about at the intersection point between monitoring and automation, and I feel strongly that StackStorm can provide a lot of value as monitoring makes this transition into the world of data science.
</p>