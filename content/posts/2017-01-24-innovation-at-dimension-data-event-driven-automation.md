---
title: 'Innovation at Dimension Data: Accelerating Innovation and Digital Transformation with StackStorm Event Driven Automation'
author: st2admin
type: post
date: 2017-01-24T16:36:44+00:00
url: /2017/01/24/innovation-at-dimension-data-event-driven-automation/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5489906528
categories:
  - Blog
tags:
  - devops
  - DimensionData
  - event-driven automation
  - StackStorm

---
**Jan 24, 2017**  
_by Dana Christensen_

## Part 1 of 3

At DevOps Enterprise Summit 2016, DevOps leaders like Target, American Airlines, Disney, and Quicken Loans spoke of the importance of managing/optimizing operations, addressing technical debt, eliminating silos, collaboration, and the importance of open source and community to drive innovation. I was especially struck by <a href="https://www.linkedin.com/in/jasoncox3" target="_blank">Jason Cox of Disney</a>, who stressed the importance of “creating a culture of courage” where teams are encouraged to be curious, to experiment, explore and embrace change across process, roles, and technology-all for the purpose of enabling meaningful work.

It turns out that these themes are being talked about not only by these large Enterprise DevOps leaders. These themes are being repeated in conversations around the globe with IT leaders who are looking to leverage DevOps practices to successfully drive innovation and digital transformation.

Anthony Shaw, Group Director of Innovation and Technical Talent at <a href="http://www.dimensiondata.com/" target="_blank">Dimension Data</a> has seen this first hand. Anthony not only leads innovation efforts within Dimension Data-but he also travels the world speaking with customers about their business priorities, their Digital Transformation goals, and how the innovative use of technology, organizational structure, community, and transforming day to day operational practices can accelerate their Digital Transformation journey.<!--more-->

We were fortunate to have Anthony travel from his home in Australia all the way to the US to present about StackStorm at the Gartner Data Center Conference in Las Vegas. He then joined us to speak at the <a href="https://www.meetup.com/Auto-Remediation-and-Event-Driven-Automation/" target="_blank">Auto Remediation and Event Driven Automation Meetup</a> here in San Jose, where he shared his thoughts on key DevOps trends & challenges&#8211;and some creative ways to address these challenges leveraging the power of the StackStorm platform. You can listen to Anthony’s presentation at the MeetUp <a href="https://youtu.be/t8F2SBGOQx4" target="_blank">here</a>.

When looking at how DevOps can accelerate digital transformation, Anthony stresses the importance of : 1) recognizing that DevOps is not just about deployment&#8211;it’s about automating and optimizing ongoing operations; 2) the importance of breaking down silos and streamlining/optimizing DevOps Tool Chains; 3) and the importance of collaboration and open source communities to drive innovation and accelerate digital transformation.

In this series of blogs we will share how Anthony leverages StackStorm to address each of these topics and how he is helping to accelerate innovation with StackStorm within Dimension Data and with their clients.

### StackStorm Takes DevOps Beyond Deployment to Optimize Ongoing Operations

<p style="text-align: center;">
</p>

Anthony has observed that when many customers speak of DevOps, they tend to limit their focus on application deployment- Continuous Integration and Continuous Deployment. Most DevOps tools on the market today are focused on being able to get the application deployed as quickly as possible, or being able to update the application in production and staging environments 10x, 100x per day. These practices typically apply to new in house developed applications and services. However, for most of Anthony’s clients, application deployment is maybe 5% of the overall problem. The major challenges and greatest costs are around ongoing operational support, availability, and scaling.

According to Anthony, the questions enterprises really should ask are: How do you ensure that your teams are working together to provide seamless, uninterrupted delivery of applications and services to your customers? How do you deal with your technical debt? All those other pieces of software or applications that you’ve purchased, that were built a while ago, or acquired as a result of a merger? How do you integrate with the old system that only has a command line interface, doesn’t have a nice REST API to plug into, doesn’t already have a python library? What if something goes down, what do you do next?

The real power of DevOps is in being able to give the operations teams tools to diagnose and remediate issues, think about the day to day events, and that&#8217;s where Anthony suggests customers take a look at StackStorm to leverage the power of event driven automation and auto remediation.

When developing DevOps processes and defining approaches to automation, it&#8217;s important to look at the operational lifecycle of an application instead of just thinking about deployment. Take a meta view of the entire value stream, and identify workflows that involve a lot of repetitive, manual work. Ask questions like what does this application look like in operation? How do we diagnose issues in runtime? How do we look at tuning performance? How do we link those events into the application and the automation process?

[StackStorm][1] is an event driven automation platform that is designed to help you answer these questions in code. You can define rules, workflows, and integration points to your entire application lifecycle. And StackStorm can be leveraged to optimize workflows in all areas across the data center&#8211;including Security, Networking, Big Data Workflows, and IoT.

One example is the way Dimension Data leverages StackStorm to optimize an existing workflow to respond to security incidents.

The diagram below illustrates the StackStorm automation script Dimension Data created to trigger a security audit whenever a new server is deployed on the AWS cloud ( this could work just as well on other clouds such as Microsoft Azure).

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/01/DiDataSlideSecurityWorkflow.jpg" alt="StackStorm DimensionData security" width="960" height="540" class="aligncenter size-full wp-image-6514" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/01/DiDataSlideSecurityWorkflow.jpg 960w, https://stackstorm.com/wp/wp-content/uploads/2017/01/DiDataSlideSecurityWorkflow-150x84.jpg 150w, https://stackstorm.com/wp/wp-content/uploads/2017/01/DiDataSlideSecurityWorkflow-300x169.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2017/01/DiDataSlideSecurityWorkflow-768x432.jpg 768w, https://stackstorm.com/wp/wp-content/uploads/2017/01/DiDataSlideSecurityWorkflow-80x45.jpg 80w, https://stackstorm.com/wp/wp-content/uploads/2017/01/DiDataSlideSecurityWorkflow-220x124.jpg 220w, https://stackstorm.com/wp/wp-content/uploads/2017/01/DiDataSlideSecurityWorkflow-178x100.jpg 178w, https://stackstorm.com/wp/wp-content/uploads/2017/01/DiDataSlideSecurityWorkflow-267x150.jpg 267w, https://stackstorm.com/wp/wp-content/uploads/2017/01/DiDataSlideSecurityWorkflow-423x238.jpg 423w, https://stackstorm.com/wp/wp-content/uploads/2017/01/DiDataSlideSecurityWorkflow-738x415.jpg 738w, https://stackstorm.com/wp/wp-content/uploads/2017/01/DiDataSlideSecurityWorkflow-866x487.jpg 866w" sizes="(max-width: 960px) 100vw, 960px" /> 

The workflow notifies the teams whenever an action is taken. This allows the Di Data security teams to be a lot more agile and responsive. Instead of running a scan once a day or once a week, they can respond immediately to any changes in the infrastructure.

This is just one example of efficiencies gained at Di Data by using StackStorm.  
In the next blog in this series, we will review how Anthony leverages StackStorm at Dimension Data to integrate and Optimize the DevOps Tool Chain.

### Learn More About StackStorm Event Driven Automation & Auto-Remediation

To learn more about StackStorm, please visit the [StackStorm website][1], listen to this excellent <a href="https://www.youtube.com/watch?v=8nq_0QZ-UX0&t=330s" target="_blank">overview of StackStorm</a> given by our expert Stormer Matt Stone at OpenStack Summit Barcelona, or check out this to <a href="https://twitter.com/Stack_Storm/status/823594813555519488" target="_blank">short video</a> on StackStorm

To learn more about how companies like Netflix, Facebook and others are leveraging Event-Driven Automation and Auto-Remediation, please join the <a href="https://www.meetup.com/Auto-Remediation-and-Event-Driven-Automation/" target="_blank">Auto-Remediation and Event Driven Automation Meetup</a>.

 [1]: /