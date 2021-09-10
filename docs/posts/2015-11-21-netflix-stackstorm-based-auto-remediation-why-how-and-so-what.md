---
title: 'Netflix: StackStorm-based Auto-Remediation – Why, How, and So What'
author: st2admin
type: post
date: 2015-11-21T21:18:41+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/11/21/netflix-stackstorm-based-auto-remediation-why-how-and-so-what/
dsq_thread_id:
  - 4339561571
categories:
  - Blog
  - Community
  - Home

---
#### _Lessons from this week&#8217;s Event Driven Automation Meet-up_

**November 21, 2015**  
_by Evan Powell_

<span style="font-weight: 400;">This week two excellent engineers at Netflix spoke at the </span><a href="http://meetup.com/Auto-Remediation-and-Event-Driven-Automation/" target="_blank"><span style="font-weight: 400;">Event Driven Automation meet-up</span></a> <span style="font-weight: 400;">which Netflix hosted.  It was great to see old friends and thought leaders from Cisco, Facebook, LinkedIn and elsewhere. </span><span style="font-weight: 400;">This blog summarizes Netflix’s presentation. </span>

**My quick summary is that it was the best presentation I’ve seen that combines both solid reasoning about** **_why_** **to move towards auto-remediation as well as information about** **_how_** **to do so.**

<span style="font-weight: 400;">Before we get to all that substance, however, I should admit that my favorite moment of the evening was probably when they explained why Netflix calls auto-remediation based on StackStorm &#8220;Winston.&#8221; Remember Mr Wolf?</span>

<img loading="lazy" class="aligncenter size-full wp-image-4850" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/hk-pulp-fiction.gif" alt="hk-pulp-fiction" width="500" height="210" /> 

<!--more-->

<span style="font-weight: 400;">The entire video (of the meet-up that is, not Pulp Fiction) will be posted on the Event Driven Automation meet-up soon.  I highly recommend it and I’ll try to remember to cross link here when it is posted.  [note here it is: <a href="https://www.youtube.com/watch?v=ln8MhCJGC-g&feature=youtu.be" target="_blank">https://www.youtube.com/watch?v=ln8MhCJGC-g&feature=youtu.be</a> ]  As mentioned below, an upcoming Automation Happy Hour will dig into Netflix’s Winston as well.  </span>

<span style="font-weight: 400;">After introductions of our speakers Sayli and JS we got down to business</span>

<span style="font-weight: 400;">JS kicked off the discussion by talking about the great AWS reboot of last year; you may remember that Amazon discovered a Xen vulnerability and over a particular weekend they rebooted basically the entire fleet.  </span>

<span style="font-weight: 400;">While this caused considerable stress at Netflix it did not cause downtime to their Cassandra fleet thanks in large part to the existing remediation plus of course the resiliency of Cassandra.  </span>

<span style="font-weight: 400;">However, JS explained that their experience &#8211; and the massive scaling they are undertaking at Netflix &#8211; helped motivate the teams at Netflix to pay attention to what worked and what was not working so well with the existing remediation.</span>

<span style="font-weight: 400;">In short, the pre-existing remediation still far too often left the engineer on call and dealing with 2am pages.  </span>

<img loading="lazy" class="aligncenter wp-image-4851 " src="http://stackstorm.com/wp/wp-content/uploads/2015/11/Before-1024x768.jpg" alt="Before" width="544" height="408" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/Before-1024x768.jpg 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Before-300x225.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Before-1080x810.jpg 1080w" sizes="(max-width: 544px) 100vw, 544px" /> 

<span style="font-weight: 400;">Incidentally &#8211; we’ve seen this pattern before.  While Jenkins has some workflow capabilities one is really stretching its capabilities to use it in this way.</span>

<span style="font-weight: 400;">As they explained, the result is team burn-out and more:</span>

<img loading="lazy" class="aligncenter wp-image-4852" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/Pain-points-.jpg" alt="Pain points" width="707" height="530" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/Pain-points-.jpg 3264w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Pain-points--300x225.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Pain-points--1024x768.jpg 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Pain-points--1080x810.jpg 1080w" sizes="(max-width: 707px) 100vw, 707px" /> 

<span style="font-weight: 400;">Looking at the human workflow &#8211; how alerts are handled absent an effective auto-remediation flow &#8211; makes it clear why this is.</span>

<img loading="lazy" class="aligncenter wp-image-4853" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/Manual-flow.jpg" alt="Manual flow" width="687" height="515" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/Manual-flow.jpg 3264w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Manual-flow-300x225.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Manual-flow-1024x768.jpg 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Manual-flow-1080x810.jpg 1080w" sizes="(max-width: 687px) 100vw, 687px" /> 

<span style="font-weight: 400;">As you can see &#8211; it takes at least 30 minutes to solve the problem and during that time a number of sometimes intricate manual tasks are performed under duress, at 2am.  </span>

<span style="font-weight: 400;">Netflix dwelled on a photo of a physical runbook at the event.  It was a binder maybe 7-10 inches thick.  Imagine trying to search through that at 2am.  And yet that’s &#8211; or the digital equivalent &#8211; is often what occurs without automated remediation.</span>

<span style="font-weight: 400;">Their experience led them towards a handful of seemingly simple requirements:</span>

<img loading="lazy" class="aligncenter wp-image-4854" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/Requirements-1.jpg" alt="Requirements (1)" width="673" height="505" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/Requirements-1.jpg 3264w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Requirements-1-300x225.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Requirements-1-1024x768.jpg 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Requirements-1-1080x810.jpg 1080w" sizes="(max-width: 673px) 100vw, 673px" /> 

<span style="font-weight: 400;">When I first say this slide, my gut sort of clenched as I thought: “oh noos, we have become PaaS!”  It turns out that they meant more that they wanted to emulate the approach taken by Facebook and Linkedin and elsewhere &#8211; the remediation itself should be extensible and run as a service, so that other groups could consume it.  </span>

<span style="font-weight: 400;">The automation using building blocks is itself worthy of a blog.  Actually, if you scan our blog you’ll see that theme woven into a number of blogs already.  </span>

<span style="font-weight: 400;">I’m leaving out a number of slides of course just to give a summary.  </span>

<span style="font-weight: 400;">At this point the talk turned to a brief view of the technologies and then to outcomes.  </span>

<span style="font-weight: 400;">Once they started using StackStorm, they were able to change the process.  Note that they call their remediation solution Winston, which is excellent both because as mentioned a) </span>  
<img loading="lazy" class="aligncenter size-full wp-image-4850" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/hk-pulp-fiction.gif" alt="hk-pulp-fiction" width="500" height="210" /> <span style="font-weight: 400;">and b) because by naming their StackStorm based remediation something other than StackStorm they recognize the work they and other users do to adapt StackStorm to their environment.  Suffice it to say we perceive and appreciate the real engineering Netflix has done to help StackStorm mature and deliver value.  </span>

<span style="font-weight: 400;">These days, instead of waiting for pages, they use their Winston to solve an ever increasing percentage of issues before they distract and disrupt the humans.  They used the following illustration to show the event flow these days (note that the doggie has a pager by its head &#8211; so paging is still possible :)).  </span>

<img loading="lazy" class="aligncenter size-full wp-image-4856" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/Winston-after.jpg" alt="Winston after" width="3264" height="2448" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/Winston-after.jpg 3264w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Winston-after-300x225.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Winston-after-1024x768.jpg 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Winston-after-1080x810.jpg 1080w" sizes="(max-width: 3264px) 100vw, 3264px" /> 

<span style="font-weight: 400;">Sayli emphasized that when pages do happen they happen with “assisted diagnosis” already performed.  So when you get paged you already have what we tend to call facilitated troubleshooting performed.  Hence the stuff you do every time a condition of type X is reported is already done and you hopefully can use your pattern matching skills to take those results and quickly identify and then fix (maybe again with Winston / StackStorm’s help) the issue.   </span>

<span style="font-weight: 400;">Being engineers they didn’t stop at that level, of course.  They went into the underlying architecture a bit.  As you can see they leverage StackStorm to pull events out of the SQS based queue via which their monitoring, called Atlas, announces events. StackStorm then matches on those events, determines what course of action to take, and then executes on that course of action. And all components scale horizontally and vertically.</span>

<img loading="lazy" class="aligncenter wp-image-4857" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/Conceptual-arch-w-StackStorm-.jpg" alt="Conceptual arch w StackStorm" width="695" height="521" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/Conceptual-arch-w-StackStorm-.jpg 3264w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Conceptual-arch-w-StackStorm--300x225.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Conceptual-arch-w-StackStorm--1024x768.jpg 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/Conceptual-arch-w-StackStorm--1080x810.jpg 1080w" sizes="(max-width: 695px) 100vw, 695px" /> 

<span style="font-weight: 400;">This point caused some real excitement in the audience.  There were a number of questions about “who watches the watcher” and “why remediate when you can just do it right the first time.”  </span>

<span style="font-weight: 400;">Regarding the first question, JS claimed that so far they’ve been unable to overrun StackStorm with events.  Even so, they err on the side of flagging StackStorm events as high priority (such as StackStorm starting to peg a CPU) since conceivably that event could be the sign that the dam is leaking water.  They have thought about using StackStorm itself to remediate StackStorm &#8211; a pattern we’ve seen elsewhere &#8211; however have not yet implemented it.</span>

<span style="font-weight: 400;">Regarding the question about “why not do it right the first time” they said yes, sure.  Of course, as Vinay Shah, an engineering leader said at the Meet-up:</span>** **

<p style="text-align: center;">
  <b>&#8220;if remediation was not needed then neither would be monitoring.&#8221;</b><span style="font-weight: 400;">  </span>
</p>

<span style="font-weight: 400;">And as I’ve pointed out before, we have 158 and counting monitoring projects.  Shit happens people, deal with it!</span>

<span style="font-weight: 400;">Having said that, one benefit of auto remediation is you can start to enable developers to themselves think not just about how to <em>test</em> their systems (aka test driven development) but how to <em>remediate</em> them.  Why would they take on this perspective &#8211; well, at Netflix and many other places these days the developers have pagers.  This dynamic is a huge motivation for developers to embrace StackStorm and remediation platforms more generally.  </span>

<span style="font-weight: 400;">This summary is just the skeleton of what was to me the best overall presentation I’ve seen of the why, how and so what of auto-remediation.  As is always the case in these meet-ups, the conversations in the aisle over burritos and beers was fascinating and invaluable.  It was great to catch up with folks like Shane Gibson and to meet face to face some of the team at Pleexi for example. </span>

<span style="font-weight: 400;">Hopefully this has whetted your appetite.  Good news, in addition to the upcoming posting of the video you can also join StackStorm’s Happy Hour on December 1st.  Sayli and JS will join StackStorm’s Patrick Hoolboom and James Fryman to dig in deeper into Winston and StackStorm.  Please come armed with questions.  </span>

<span style="font-weight: 400;"><strong>Register here for that Happy Hour:</strong>   </span>[<span style="font-weight: 400;">www.stackstorm.com/register/</span>][1]

<span style="font-weight: 400;">Last but not least, if you want to take a look at StackStorm, head to </span>[<span style="font-weight: 400;">StackStorm.com </span>][2]<span style="font-weight: 400;">and grab either the Community Edition or the Enterprise Edition.  Both editions are based on the same code &#8211; Enterprise Edition has some capabilities, including Flow, that help especially enterprises get value out of StackStorm.  You can also see an example of Cassandra auto-remediation in a tutorial blog format &#8211; complete with a snazzy Flow gif &#8211; </span>[<span style="font-weight: 400;">here</span>][3]<span style="font-weight: 400;">.  </span>

[<img loading="lazy" class="aligncenter size-full wp-image-4800" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/remediation-cassandra.gif" alt="remediation-cassandra" width="837" height="518" />][4]

<span style="font-weight: 400;">Finally &#8211; many thanks to </span>[<span style="font-weight: 400;">JS</span>][5] <span style="font-weight: 400;">and </span>[<span style="font-weight: 400;">Sayli </span>][6]<span style="font-weight: 400;">and Vinay and </span>[<span style="font-weight: 400;">Nir</span>][7] <span style="font-weight: 400;">and of course </span>[<span style="font-weight: 400;">Christos</span>][8] <span style="font-weight: 400;">and the rest of the team at Netflix.  Giving back to the overall community by hosting the </span>[<span style="font-weight: 400;">meet-up</span>][9] <span style="font-weight: 400;">was truly good of you :).</span>

 [1]: http://www.stackstorm.com/register/
 [2]: http://www.stackstorm.com
 [3]: https://stackstorm.com/2015/09/22/auto-remediating-bad-hosts-in-cassandra-cluster-with-stackstorm/
 [4]: http://stackstorm.com/wp/wp-content/uploads/2015/11/remediation-cassandra.gif
 [5]: https://twitter.com/jsjeannotte
 [6]: https://twitter.com/HikerTechy
 [7]: https://twitter.com/niralfasi
 [8]: https://twitter.com/chriskalan
 [9]: http://www.meetup.com/Auto-Remediation-and-Event-Driven-Automation/