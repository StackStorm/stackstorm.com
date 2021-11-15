---
title: StackStorm at SREcon 2017
author: st2admin
type: post
date: 2017-03-23T17:35:11+00:00
url: /2017/03/23/stackstorm-srecon-2017/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5658967650
categories:
  - Blog
  - Community

---
**March 23, 2017**  
_by Matt Oswalt_

StackStorm was proud to once again exhibit at SREcon this year in San Francisco. If you haven’t attended SREcon before, there’s really no better place to get in touch with so many SRE professionals that are pushing the envelope and redefining what it means to run a modern operations team.

This year, we brought a quite nifty, flashy demonstration that one of our core developers Matt Stone put together, involving Raspberry Pis, LEDs, and – of course – StackStorm! (He’s [@BigMStone][1] on twitter – tweet at him and tell him to write his own blog post on his creation – it’s really cool!)

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-22-at-11.54.30-PM.png" alt="" width="404" height="422" class=" wp-image-6702 aligncenter" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-22-at-11.54.30-PM.png 596w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-22-at-11.54.30-PM-143x150.png 143w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-22-at-11.54.30-PM-287x300.png 287w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-22-at-11.54.30-PM-77x80.png 77w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-22-at-11.54.30-PM-210x220.png 210w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-22-at-11.54.30-PM-96x100.png 96w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-22-at-11.54.30-PM-228x238.png 228w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-22-at-11.54.30-PM-397x415.png 397w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-22-at-11.54.30-PM-466x487.png 466w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-22-at-11.54.30-PM-569x595.png 569w" sizes="(max-width: 404px) 100vw, 404px" />][2]

<!--more-->

## SREcon 2017 Takeaways

This was my first SREcon, and hopefully not my last. I was very pleased at not only the high concentration of talented operations professionals, but also the quality of discussion held throughout the two day conference.

One of the things I noticed right away was the sheer number of attendees who just “got it”. I’ve spent a fair amount of my career advocating for more automated, modern approaches to operations, specifically within network infrastructure. Whenever dealing with new technologies or processes, it’s understandable that not everyone is on the same page, so it’s often useful to spend some time level-setting about the problem space.

However, at SREcon, this was very rarely necessary. Nearly everyone we spoke to was already convinced that concepts like “infrastructure as code”, and “event-driven automation” were useful, and was already looking to practice them. They were clearly dealing with challenges that required these new ways of running operations, and were beyond thinking about the problem &#8211; they wanted solutions.

&nbsp;

## The StackStorm “Sweet Spot”

One very common conversation with the audience at SREcon was the subject of where StackStorm fits in the rapidly changing world of operations. We think there are plenty of great tools in the monitoring space, and StackStorm integrates with them &#8211; we don’t try to act like a monitoring tool. Similarly, there are some really great configuration management tools out there, and we integrate with those as well. What we like to do is fit right in the middle.

Perhaps the best way of looking at this is to think about your own built-in procedures. I worked in operations, I know there are a multitude of things that an operations team must deal with each day &#8211; some planned, some not. For each of these things, there’s almost always a predetermined way of dealing with it. Log in to monitoring system. Analyze logs. View dashboards. Correlate information. Update configs. Restart services. This is a day in the life of an operations professional.

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-23-at-12.41.50-AM.png" alt="" width="789" height="278" class="wp-image-6703 aligncenter" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-23-at-12.41.50-AM.png 1036w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-23-at-12.41.50-AM-150x53.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-23-at-12.41.50-AM-300x106.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-23-at-12.41.50-AM-768x271.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-23-at-12.41.50-AM-1024x361.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-23-at-12.41.50-AM-80x28.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-23-at-12.41.50-AM-220x78.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-23-at-12.41.50-AM-250x88.png 250w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-23-at-12.41.50-AM-280x99.png 280w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-23-at-12.41.50-AM-510x180.png 510w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-23-at-12.41.50-AM-750x264.png 750w, https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-23-at-12.41.50-AM-975x344.png 975w" sizes="(max-width: 789px) 100vw, 789px" />][3]

The StackStorm answer, then, is a simple one &#8211; commit those workflows to code. Whether it’s writing an [Action metadata file][4] so you can get started using your own scripts in StackStorm, or writing [full-blown Mistral workflows][5] to automate an entire remediation process, there really is no magic involved here &#8211; it is a matter of committing into “code” the same analysis, decision-making, and remediation you’d normally perform yourself, and letting StackStorm perform these tasks on your behalf.

This area of discussion resonated greatly with the audience at SREcon, and it’s clear that if you haven’t explored event-driven automation yet, the time has never been better to get started.

&nbsp;

## Event-Driven Automation Meetup

Fortunately for those in the Bay Area, StackStorm and LinkedIn are putting on the next [Event-Driven Automation Meetup][6] in Sunnyvale next week. These meetups are great because they focus on the same kind of things I like to focus on, which is the general ideas and concepts behind event-driven automation, with less of a focus on specific implementations. While there’s always a time and a place for getting into the technical weeds, it’s often useful to take a step back and talk about trends, and collaborate on what’s around the corner.

I will be flying in from sunny Portland to sit on the panel &#8211; but don’t let that discourage you&#8230;I hope to see you there anyways!

Matt Oswalt

[@Mierdin][7]

<h2 dir="ltr">
  <span style="font-weight: 400;"></span>
</h2>

 [1]: https://twitter.com/bigmstone
 [2]: https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-22-at-11.54.30-PM.png
 [3]: https://stackstorm.com/wp/wp-content/uploads/2017/03/Screen-Shot-2017-03-23-at-12.41.50-AM.png
 [4]: https://docs.stackstorm.com/actions.html#converting-existing-scripts-into-actions
 [5]: https://docs.stackstorm.com/mistral.html
 [6]: https://www.meetup.com/Auto-Remediation-and-Event-Driven-Automation/
 [7]: https://twitter.com/mierdin