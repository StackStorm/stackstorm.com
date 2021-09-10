---
title: 'Innovation at Dimension Data: Taking DevOps Beyond Deployment'
author: Dmitri Zimine
type: post
date: 2016-12-15T18:44:25+00:00
url: /2016/12/15/dimension-data-devops-beyond-deployment/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5383308898
categories:
  - Blog
  - Community
tags:
  - devops

---
**December 6, 2016**  
_By Dana Christensen_

At the DevOps Enterprise Summit in San Francisco last month, DevOps leaders like Target, American Airlines, Disney, and Quicken Loans spoke of the importance collaboration, eliminating silos, managing/optimizing operations and addressing technical debt, the importance of open source and contributing to community, and continuous learning. I was especially struck by Jason Cox of Disney, who stressed the importance of “creating a culture of courage” where teams are encouraged to be curious, to experiment, explore and embrace change&#8211;including process, roles, and technology.

<div id="attachment_6428" style="width: 650px" class="wp-caption aligncenter">
  <a href="https://stackstorm.com/wp/wp-content/uploads/2016/12/di_data_meetup.jpg"><img aria-describedby="caption-attachment-6428" src="https://stackstorm.com/wp/wp-content/uploads/2016/12/di_data_meetup-1024x768.jpg" alt="" width="640" class="size-large wp-image-6428" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/12/di_data_meetup-1024x768.jpg 1024w, https://stackstorm.com/wp/wp-content/uploads/2016/12/di_data_meetup-150x113.jpg 150w, https://stackstorm.com/wp/wp-content/uploads/2016/12/di_data_meetup-300x225.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2016/12/di_data_meetup-768x576.jpg 768w, https://stackstorm.com/wp/wp-content/uploads/2016/12/di_data_meetup-80x60.jpg 80w, https://stackstorm.com/wp/wp-content/uploads/2016/12/di_data_meetup-220x165.jpg 220w, https://stackstorm.com/wp/wp-content/uploads/2016/12/di_data_meetup-133x100.jpg 133w, https://stackstorm.com/wp/wp-content/uploads/2016/12/di_data_meetup-200x150.jpg 200w, https://stackstorm.com/wp/wp-content/uploads/2016/12/di_data_meetup-317x238.jpg 317w, https://stackstorm.com/wp/wp-content/uploads/2016/12/di_data_meetup-553x415.jpg 553w, https://stackstorm.com/wp/wp-content/uploads/2016/12/di_data_meetup-649x487.jpg 649w, https://stackstorm.com/wp/wp-content/uploads/2016/12/di_data_meetup-793x595.jpg 793w" sizes="(max-width: 1024px) 100vw, 1024px" /></a>
  
  <p id="caption-attachment-6428" class="wp-caption-text">
    Anthony Shaw at Auto-Remediation meetup
  </p>
</div>

It turns out that these themes are being talked about not only by the large DevOps leaders. These themes are being repeated in conversations around the globe with IT leaders who are looking to leverage DevOps practices to successfully drive Digital Transformation.

Anthony Shaw, Director of Innovation and Technical Talent at [Dimension Data][1] has seen this first hand. Anthony not only leads innovation efforts within Dimension Data-but he also travels the world speaking with customers about their business priorities, their Digital Transformation goals, and how the innovative use of technology, organizational structure, and day to day operational practices can accelerate their Digital Transformation journey.

<!--more-->

Last week we were fortunate to have Anthony travel from his home in Australia all the way to the US to present at the Gartner Data Center Conference in Las Vegas, and then join us to speak at the [Auto Remediation and Event Driven Automation Meetup][2] here in San Jose, where he shared his thoughts on key DevOps Trends & Challenges&#8211;and some creative ways to address these challenges leveraging the power of the StackStorm platform.

<div id="attachment_6429" style="width: 810px" class="wp-caption aligncenter">
  <a href="https://stackstorm.com/wp/wp-content/uploads/2016/12/Trends.png"><img aria-describedby="caption-attachment-6429" loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2016/12/Trends.png" alt="" width="800" height="450" class="aligncenter size-full wp-image-6437" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/12/Trends.png 800w, https://stackstorm.com/wp/wp-content/uploads/2016/12/Trends-150x84.png 150w, https://stackstorm.com/wp/wp-content/uploads/2016/12/Trends-300x169.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/12/Trends-768x432.png 768w, https://stackstorm.com/wp/wp-content/uploads/2016/12/Trends-80x45.png 80w, https://stackstorm.com/wp/wp-content/uploads/2016/12/Trends-220x124.png 220w, https://stackstorm.com/wp/wp-content/uploads/2016/12/Trends-178x100.png 178w, https://stackstorm.com/wp/wp-content/uploads/2016/12/Trends-267x150.png 267w, https://stackstorm.com/wp/wp-content/uploads/2016/12/Trends-423x238.png 423w, https://stackstorm.com/wp/wp-content/uploads/2016/12/Trends-738x415.png 738w" sizes="(max-width: 800px) 100vw, 800px" /></a>
  
  <p id="caption-attachment-6429" class="wp-caption-text">
    Anthony’s Observations on DevOps Trends & Challenges in 2016
  </p>
</div>

### DevOps Spaghetti: Emergence of Multiple Point Solutions

The Challenge:

With all of his clients, Anthony has found that point solutions have been multiplying exponentially. Enterprises are finding themselves challenged to manage and maintain the 10’s to 100’s of point solutions they’ve implemented to fix problems that have come up over the years. They&#8217;ve looked at a problem like monitoring, for example. They&#8217;ve picked one tool for monitoring the storage, another tool for monitoring their virtualization layer, and before they know it they&#8217;ve got 20 different tools all monitoring something.

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2016/12/spagetti.jpg" alt="" width="800" height="450" class="aligncenter size-full wp-image-6438" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/12/spagetti.jpg 800w, https://stackstorm.com/wp/wp-content/uploads/2016/12/spagetti-150x84.jpg 150w, https://stackstorm.com/wp/wp-content/uploads/2016/12/spagetti-300x169.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2016/12/spagetti-768x432.jpg 768w, https://stackstorm.com/wp/wp-content/uploads/2016/12/spagetti-80x45.jpg 80w, https://stackstorm.com/wp/wp-content/uploads/2016/12/spagetti-220x124.jpg 220w, https://stackstorm.com/wp/wp-content/uploads/2016/12/spagetti-178x100.jpg 178w, https://stackstorm.com/wp/wp-content/uploads/2016/12/spagetti-267x150.jpg 267w, https://stackstorm.com/wp/wp-content/uploads/2016/12/spagetti-423x238.jpg 423w, https://stackstorm.com/wp/wp-content/uploads/2016/12/spagetti-738x415.jpg 738w" sizes="(max-width: 800px) 100vw, 800px" />][3]

### What many companies think of as DevOps Barely Scratches the surface

The Challenge:

Anthony has observed that when many customers speak of DevOps, they tend to limit their focus on application deployment. Most DevOps tools on the market today are focused on being able to get the application deployed as quickly as possible, or being able to update the application in production and staging environments 10x, 100x per day. These practices typically apply to shiny new in house developed applications and services. However, for most of these clients, application deployment is maybe 5% of the overall problem. The major challenges are around operational support, availability, and scaling.

### Organizational Structures: Centralize or Decentralize?

The Challenge:

Organizationally, when looking at DevOps, many companies are tempted to centralize to avoid a proliferation of tools . They&#8217;ll pick one team and say &#8220;This is the DevOps team,&#8221; and they&#8217;ll write a process and a procedure for that team. The problem immediately becomes that that team becomes a bottleneck.

The other option that companies look at is de-centralizing. They will provide DevOps training for the teams, but each team makes its decisions around which tools they use. The issue quickly becomes lack of standardization. This results in a lot of disparity between teams about what gets used with minimal to no collaboration or communication between the teams. Teams tend to pick different tools, and different approaches. Documentation, sharing of knowledge and problem solving between teams is typically quite scarce. These emerging silos and lack of collaboration quickly becomes a barrier to moving forward in the client’s Digital Transformation journey.

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2016/12/structure.jpg" alt="" width="800" height="450" class="aligncenter size-full wp-image-6439" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/12/structure.jpg 800w, https://stackstorm.com/wp/wp-content/uploads/2016/12/structure-150x84.jpg 150w, https://stackstorm.com/wp/wp-content/uploads/2016/12/structure-300x169.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2016/12/structure-768x432.jpg 768w, https://stackstorm.com/wp/wp-content/uploads/2016/12/structure-80x45.jpg 80w, https://stackstorm.com/wp/wp-content/uploads/2016/12/structure-220x124.jpg 220w, https://stackstorm.com/wp/wp-content/uploads/2016/12/structure-178x100.jpg 178w, https://stackstorm.com/wp/wp-content/uploads/2016/12/structure-267x150.jpg 267w, https://stackstorm.com/wp/wp-content/uploads/2016/12/structure-423x238.jpg 423w, https://stackstorm.com/wp/wp-content/uploads/2016/12/structure-738x415.jpg 738w" sizes="(max-width: 800px) 100vw, 800px" />][4]

### Summary:

As companies look to implement or expand their DevOps practices, Anthony recommends they look to break down silos, collaborate, manage technical debt, and optimize operations with event driven automation.

During his presentations at Gartner and at the Auto Remediation and Event Driven Automation Meetup, Anthony shared how Di Data has been addressing these challenges, and what he best practices recommendations he makes to customers. Anthony spoke of how they are leveraging the power of the StackStorm platform to overcome these challenges and optimize the data center. You can view the [recording of Anthony’s presentation here][5].

 [1]: http://www.dimensiondata.com
 [2]: https://www.meetup.com/Auto-Remediation-and-Event-Driven-Automation/
 [3]: https://stackstorm.com/wp/wp-content/uploads/2016/12/spagetti.jpg
 [4]: https://stackstorm.com/wp/wp-content/uploads/2016/12/structure.jpg
 [5]: https://www.youtube.com/watch?v=t8F2SBGOQx4