---
title: The DevOps Journey Has Just Begun
author: st2admin
type: post
date: 2014-11-18T03:20:57+00:00
excerpt: '<a href="http://stackstorm.com/2014/11/18/the-devops-journey-has-just-begun/">READ MORE</a>'
url: /2014/11/18/the-devops-journey-has-just-begun/
dsq_thread_id:
  - 3246459131
categories:
  - Blog
  - Community
  - Home

---
_by James Fryman_

_This post originally appeared November 16, 2014 on <a href="http://venturebeat.com/2014/11/16/the-devops-journey-has-just-begun/" target="_blank">VentureBeat</a>._

<p style="color: #231f20;">
  Recently, I had the honor of <a href="http://youtu.be/iXL3iqxRFdg" target="_blank">speaking at DevOpsDays Berlin</a> and attending DevOpsDays Ghent 2014. Both conferences included plenty of discussion surrounding the fifth anniversary of the speaking series, with as many enthusiastic ‘State of the (DevOps) Union’ conversations to match.
</p>

<p style="color: #231f20;">
  Attendees expressed varied interpretations of the meaning of DevOps, how companies are approaching implementation of the ideas discussed in DevOps, and the latest technology musings which mostly consisted of inquiries regarding if (and how) Docker was used within respective companies. These topics were examined during my recent talk in Berlin, DevOps Day 2: People and Process.
</p>

<p style="color: #231f20;">
  I’d like to present my perspective about my own experiences in tackling many of the challenges in the DevOps methodology, and many of the subjects I have discussed with others along that journey.
</p>

<p style="color: #231f20;">
  <!--more-->
</p>

<p style="color: #231f20;">
  <img loading="lazy" class="alignnone size-full wp-image-1899" src="http://stackstorm.com/wp/wp-content/uploads/2014/11/devops-guys.jpg" alt="P1010129" width="780" height="488" srcset="https://stackstorm.com/wp/wp-content/uploads/2014/11/devops-guys.jpg 780w, https://stackstorm.com/wp/wp-content/uploads/2014/11/devops-guys-300x187.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2014/11/devops-guys-400x250.jpg 400w" sizes="(max-width: 780px) 100vw, 780px" />
</p>

**Increased engagement in the DevOps community**

<p style="color: #231f20;">
  DevOps appears to be gaining a significant amount of traction as of late. While the initial DevOpsDays conference had 50-60 attendees, the count in Berlin is now up to around 250, and topped 450 in Ghent — with nearly 70 percent being first time DevOpsDays Conference attendees in Ghent. A wide variety of companies were represented, including large multi-national companies (1,000+ people) and small-medium businesses.
</p>

<p style="color: #231f20;">
  One of the more exciting aspects stemming from the adoption of DevOps practices is that many companies are traditionally more cautious with their IT process and are evaluating (and in many cases sharing) their experience with adopting methodologies accelerating the IT delivery pipeline.
</p>

<p style="color: #231f20;">
  The DevOps Enterprise Summit, held in late October this year, was a perfect example of this. Large banks, giant retailers, and enterprise product companies are all sharing their journey in evaluating and adopting these new methodologies into their day-to-day practices and long-term strategies. The term “journey” has been a common one of late, with many companies embracing the continuous improvement nature of implementing tools and processes aimed to change how companies work. This feedback loop and the subsequent successes are enticing more companies to adopt these new processes and mindsets.
</p>

<p style="color: #231f20;">
  Several years ago, the conversation around DevOps often gravitated toward implementing tools and processes to make system administrators’ lives better.
</p>

<p style="color: #231f20;">
  Organizations used to have a ratio of admins to number of servers being managed in the 1:25+ range. At this level, companies under rapid growth trajectories were often held back by IT departments, as it simply was not feasible to grow the workforce at the same rate as the company. This resulted in many hours of angst between developers charged to ship new features and operations personnel balancing stability and availability.
</p>

<p style="color: #231f20;">
  During my times consulting clients in speeding up delivery, a bottleneck analysis often always pointed at the ability for operations to scale the technology systems and staff safely and securely. With today’s DevOps methodologies it is not uncommon to see ratios of admins to number of servers being managed exceeding 1:500 as a new normal.
</p>

**From #monitoringsucks to #monitoringlove**

<p style="color: #231f20;">
  Now the conversation is pivoting to realign the tactics in applying DevOps process and technology. Since the beginning of the DevOps movement, one of the core tenets has been to break down the ‘wall’ between development and operations.
</p>

<p style="color: #231f20;">
  I was interested to see how many projects attempted to solve this problem with frameworks. If only developers and operations personnel spoke the same technology language, things would be better. This is certainly part of the puzzle, but by no means a complete one. The underlying premise was right — the same language needs to be spoken, but the solution is more often a people concern. This has manifested itself with many core ideas now present in the DevOps vernacular as discussed at DevOpsDays Ghent.
</p>

<p style="color: #231f20;">
  Engagements like the #monitoringsucks movement allowed operations personnel to have frank conversations about what was not working in the existing operational model.
</p>

<p style="color: #231f20;">
  This in turn changed the tone to #monitoringlove, which is now directed at how to be more effective and mindful about utilizing monitoring in the stack.
</p>

<p style="color: #231f20;">
  Likewise, #empathy has become a very common theme, with team members on both sides of the proverbial wall being able to experience and understand the others’ priorities in the delivery pipeline.
</p>

<p style="color: #231f20;">
  Developers being on-call is just as exciting to me as operations personnel contributing to the very codebases running on their systems. The lines are continually blurring each day, which is not only improving the workforce, but requiring frank reviews of existing processes and the ability to cut out large parts as a ‘non value-add unnecessary’ step.
</p>

**The shift toward computer automation and collaboration**

<p style="color: #231f20;">
  With this blending of skills, I see the conversation inevitably moving toward workflow and finding opportunities for many parts of delivery to be handed in-part or in-full to the computers. This was recently shown to me at GitHub in a very novel concept that is often referred to as ChatOps (see <a style="font-weight: inherit; font-style: inherit; color: #4479bd;" href="https://www.youtube.com/watch?v=NST3u-GjjFw" target="_blank">Jesse Newland’s talk</a>). ChatOps exposes commonly performed operations tasks and makes them available in a chat client.
</p>

<p style="color: #231f20;">
  The true power of ChatOps lies in the ability to unify the actions taken on the system with the context of the conversation that often happens in company chat room. Suddenly, while having a conversation about a new feature into production, developers and operations personnel can often test a new feature with continuous integration, deploy a new feature, check on the status of the application and system monitoring, and pull up performance graphs related to the operations — all relatively in real-time and common to all parties.
</p>

<p style="color: #231f20;">
  Additionally, it makes tools commonly used by operations accessible to developers. Graphing, monitoring, logging: These are all things that developers want to consume, but often are prohibitive for one reason or another. Yet, when easily digestible, they are rapidly consumed to create new interfaces and patterns that never cease to surprise.
</p>

<p style="color: #231f20;">
  Through ChatOps, it is not uncommon to see this extend beyond the operations/developer relationship. With ChatOps, business personnel who often rely on operations to do various tasks throughout the day/week/month/year are suddenly empowered to take control of the system and get things done.
</p>

<p style="color: #231f20;">
  I heard story after story at DevOpsDays where a non-technical member of the business was able to do things such as spinning up staging environments to test features, locking financial systems during end-of-month/quarter/year book management, answering and retrieving data about customer systems, and more.
</p>

<p style="color: #231f20;">
  The true power of DevOps in an organization comes when operations personnel give power to the people who need it to make their job easier.
</p>

**Creating a unified story and pipeline**

<p style="color: #231f20;">
  The next step in this evolution is unifying all of the primitives being created in the various tools to match the processes on the backend that drive business value.
</p>

<p style="color: #231f20;">
  We’ll see new technologies come out that aim to solve the problem of modeling business processes and unifying the various technologies that have been powering companies. The day when a variety of tools can provide a unified story and pipeline is coming, and will bring in the next chapter of change.
</p>

<p style="color: #231f20;">
  There is still much work to be done. I continue to receive calls from recruiters asking for DevOps engineers — only meaning that a company expects a specific knowledge of part of the ‘DevOps Toolchain’. I still receive calls from interested clients looking to ‘buy’ DevOps and wondering how much it will cost and how long it takes to plug in. I still have conversations with people in the field who struggle to understand how DevOps impacts their most important customers, such as developers and others in the company using technology to make their jobs easier.
</p>

<p style="color: #231f20;">
  But this is normal. This is all part of normal culture change, which takes time and energy. Many companies showing success with implementing DevOps continue to encourage other companies to take a critical look at how IT is delivered and operated within their organizations.
</p>

<p style="color: #231f20;">
  The good news is that the conversations are happening, and the debates continue to shape how we leverage all this computing power at our disposal for real change.
</p>

<p style="color: #231f20;">
  Several years ago, I was considering leaving the IT field altogether as it seemed companies would forever march to the beat of a never-changing tempo, and make IT growth happen by force of sheer will. Today, I look at what I do and the trajectory of the industry and I could not be more excited to do my part in moving real and meaningful change forward.
</p>

<p style="color: #231f20;">
  Those of us involved in DevOps are able to help companies realize their true potential by being an enabler, not the roadblock. And we are just getting started.
</p>