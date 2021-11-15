---
title: 'DevOps Today: Man Or Methodology?'
author: Dmitri Zimine
type: post
date: 2014-05-12T05:30:41+00:00
excerpt: '<a href="/2014/05/12/devops-today-man-methodology/">READ MORE</a>'
url: /2014/05/12/devops-today-man-methodology/
dsq_thread_id:
  - 3184963131
categories:
  - Blog

---
**May 12, 2014**

_by Patrick Hoolboom_

I&#8217;ve read a number of articles discussing DevOps from just about every angle.  The topics range from <a href="http://puppetlabs.com/blog/what-is-a-devops-engineer" target="_blank">What Is A DevOps Engineer</a> to <a href="http://continuousdelivery.com/2012/10/theres-no-such-thing-as-a-devops-team/" target="_blank">There Is No Such Thing As A “DevOps Team&#8221;</a>. The latter was written by Jez Humble who is an expert in Continuous Delivery (his book on the subject is amazing; I definitely recommend reading it). I am not going to try and dissect his statements or rebuke his article, as I agree with him. I&#8217;d like to give my spin on what DevOps is today and how it applies to the Development/Operations relationship in organizations of all sizes.

This blog is mostly focused on the benefits of DevOps as seen from the standpoint of the Operations Engineer. (There are a number of higher level, externally facing benefits to adopting DevOps – in the future I will dig deeper into DevOps benefits, and how that impacts the non-technical areas of the business.)

**Man or Methodology?**

Does DevOps refer to a specific role within the organization?

Are engineers trained to be comfortable working at all levels of the stack?

Or, is DevOps an umbrella term to refer to methodologies as they are applied across the organization?

<!--more-->

I say both, either, or none. There are aspects of DevOps that can be applied to a small group of operators within your organization, or used at a higher level across the board. The benefit of moving towards DevOps are vast but I have distilled them down to a few key points that I feel are most important.

  * **Save your unicorns for unicorn work.** 
      * Keep your Brents free (quick shout out to <a href="http://www.amazon.com/The-Phoenix-Project-Helping-Business/dp/0988262592" target="_blank">The Phoenix Project</a> for this reference). You should never have mission critical thought workers be the bottlenecks in your production pipeline. Remove them from the normal process flow, limit their distractions, and allow them to improve the overall process.
  * **Watch the watchers.** 
      * Infrastructure as Code, committed to a revision control system provides accountability.
      * Auditing. Commit messages and tools such as <a href="http://www.reddit.com/r/chatops/" target="_blank">ChatOps</a> give a timestamp history of what everyone did when.
      * Visibility and understanding. ChatOps and peer reviewed code changes allow others a chance to see what the infrastructure changes are going to be, and can comment on them ahead of time. Let&#8217;s keep the 3AM pages to a minimum, ok? 🙂
  * **Enable better full stack understanding.** 
      * By providing well communicated changes and transparency across the organization, it gives **all** engineers (Operations and Development) a chance to better understand the changes that have been made, and why.
    
    You&#8217;ll notice some overlap between these topics. Version controlled Infrastructure as Code and auditing ALSO provide better visibility. This is true but it lacks the direct human interaction you get with peer reviews and ChatOps. This human interaction piece is HUGE. Not only does it provide an instant feedback mechanism on the code or actions of the originating engineer, it does so in a fairly public manner. By opening up these processes and discussions to the group, everyone begins to consume them, digest them, and provide their own spin on them. They can then send this spin back out to the group via ChatOps (or your communication mechanism of choice) and the process keeps going.
    
    You have now open sourced your process (albeit, to a limited audience). It can be modified, refactored, or eliminated based on the needs of the group&#8230; NOT the individual.
    
    <div style="background-color: #fff; display: inline-block; font-family: 'Helvetica Neue',Arial,sans-serif; color: #a7a7a7; font-size: 11px;">
      </p> 
      
      <p style="margin: 0;">
        <div style="padding: 0; margin: -12px 0 4px 10px; text-align: left;">
          <a style="color: #a7a7a7; text-decoration: none; font-weight: normal !important; border: none;" href="http://www.gettyimages.com/detail/480585683" target="_blank">#480585683</a> / <a style="color: #a7a7a7; text-decoration: none; font-weight: normal !important; border: none;" href="http://www.gettyimages.com" target="_blank">gettyimages.com</a>
        </div></div> 
        
        <p>
          Historically, Operations Engineers handled their projects or incidents in a fairly individualized manner. This has improved greatly in later years with tools like Puppet and Chef but there are still large parts of most Operations organizations that are run by one-off scripts – non-standardized scripts, often running in questionable locations. The siloed nature of development and operations leads many engineers on both sides to find ways to work around the system. This is a huge problem when it comes to accountability and visibility. When I get paged a 3AM because a mission critical service is down, I want to know exactly what was changed leading up to the incident. I can&#8217;t do that without some sort of group accessible audit trail.
        </p>
        
        <p>
          This brings me back around to the Man or Methodology question. Most people will read what I wrote and scream, &#8220;Methodology!&#8221; Despite my explanations above I still find this too limiting. I believe that DevOps ***in its current state*** can be either. Organizations can see huge benefit increases from simply adding full stack engineers that can work in both silos – individuals who can develop software, deploy that software, and reliably support/maintain it. Conversely, these same organizations could benefit from beginning to break down the classic silos and blurring the lines between Development and Operations, and providing transparency and accountability between the teams.
        </p>
        
        <p>
          The push towards DevOps adoption is opening up a realm of possibilities for both Development and Operations. Big things are coming and I am excited to be at the forefront of it. The winds of change are blowing.</li> </ul>