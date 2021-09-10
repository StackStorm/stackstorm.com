---
title: 4 Ways To Break Through The Barriers To DevOps Adoption
author: st2admin
type: post
date: 2015-02-19T05:45:56+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/02/19/4-ways-break-barriers-devops-adoption/
dsq_thread_id:
  - 3528616082
categories:
  - Blog
  - Community
  - Home

---
**February 18, 2015**

_by Evan Powell_

_This post originally appeared on <a href="http://venturebeat.com/2015/02/18/4-ways-to-break-through-the-barriers-to-devops-adoption/" target="_blank">VentureBeat</a>._

DevOps is hot. Google Trends <a href="http://www.google.com/trends/explore#q=devops" target="_blank">confirms</a> that awareness of the term has exploded over the last eighteen months, and DevOps gurus like Gene Kim and Patrick Dubois — who is credited with coining the term DevOps — are becoming even more widely read and consulted by a range of companies. Even so-called “legacy” companies, such as Target, Ford, and Johnson and Johnson are embracing and experimenting with DevOps.

And yet, as discussed in my last <a href="http://venturebeat.com/2015/01/22/this-is-whats-keeping-some-enterprises-from-adopting-devops/" target="_blank">article</a>, the barriers to enterprises achieving the kind of productivity boost that DevOps adoption promises are considerable and often non-obvious. These non-obvious barriers have confounded even the companies now acknowledged as the most productive creators and operators of software in history: companies like Facebook, eBay/PayPal, Amazon Web Services, Apple, and others.

How have the most successful operators overcome the barriers to DevOps adoption and achieved the sort of 10-20x, or even 50x boosts in agility, that have allowed them to innovate at a higher level than competitors and even change the world?

<!--more-->

<img loading="lazy" class="alignnone size-full wp-image-2626" src="http://stackstorm.com/wp/wp-content/uploads/2015/02/DevOps-dudes-780x433.jpg" alt="P1010129 copy" width="780" height="433" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/02/DevOps-dudes-780x433.jpg 780w, https://stackstorm.com/wp/wp-content/uploads/2015/02/DevOps-dudes-780x433-300x166.jpg 300w" sizes="(max-width: 780px) 100vw, 780px" /> 

##### _Image Credit: photo credit: P1010129 copy via photopin_

Those types of gains sound pretty unreal and are extremely unusual in my experience. But here are a few data points:

  * Facebook operates with one person for each 25,000 servers. A reasonably good <a href="http://en.wikipedia.org/wiki/Information_Technology_Infrastructure_Library" target="_blank">ITIL operator</a>, by contrast, might be operating at one person for 500 servers.
  * One of StackStorm’s users is seeing their provisioning times for a self service infrastructure pipeline involving few hundred actions drop from several hours on average to as little as a few minutes.
  * And of course Amazon Web Services itself is doing hundreds of deployments per minute, continuously improving an environment of truly mind-stretching scale, so far above average levels of agility any comparison would look silly.

So let’s take a look.

###### 1. Talking about a revolution…

Our experience with the top operators suggests that adoption of the qualities that make DevOps happen — incredible agility, cross-silo automation, and teamwork – does not happen smoothly. In just about every case, we saw a particular group and use case succeed, build awareness and expectations, and then fail to scale across the organization.

Therefore, step 1 for broader enterprise adoption of DevOps is to understand that even the “best” DevOps shops went through crises to achieve industry changing levels of productivity. Set both your own and your organization’s expectations accordingly.

###### 2. Embrace your legacy

As a senior executive at a “too big to fail” bank recently shared with me, “legacy” is what they call technologies that actually run the bank.

Because of the continued value of legacy systems, heterogeneity is a fact of life in the enterprise. So when conducting your trials and planning for the broader automation and collaboration of DevOps, think about how to integrate the management of not just a few systems, but a few dozen systems.

Be sure not to forget the n^2 problem: As the number of systems increases, the integrations among them increase exponentially.

For example, a continuous integration proof of concept that takes code from a repository then builds and tests it might have 3-5 systems that need to be integrated, for a total of 9-25 potential system-to-system integrations. The number of integrations is not too big of a headache to manage.

On the other hand, when you roll that into production and extend it into deployments, you could easily have 10-15 systems or more that need to be tied together, for 100 to 225 (or even more) bi-directional integrations. How will you manage those integrations and the automation logic embedded within them in a way that is DevOps friendly?

###### 3. Celebrate diversity

As discussed in my last article on adoption barriers, it is difficult for any enterprise to recruit and retain the full-stack engineers who can code and have made DevOps a reality at most top operators. This should come as no surprise to any IT leader in an enterprise.

However, the proofs of concept and initial DevOps deployments in many enterprises do not include operators from different silos of technologies and from different skill levels.

I recommend getting the security engineers and the operators involved fairly early, along with their peers in storage, compute, networking and application development.

We are starting to witness successes by enterprises that have formed cross-silo working groups and then slice off, integrate, automate, and collaborate around workflows <em style="font-weight: inherit;">horizontally (</em>as opposed to vertically within a particular group and technology), just after a first lab or test or dev proof of the value of DevOps.

###### 4. Embrace your scale

Most DevOps tooling has been written by DevOps system administrators. The tools they have written tend to work well when used by others like themselves and for focused use cases.

However, when you follow points 1-3 to set expectations correctly, embrace your legacy, and to look horizontally across silos and skill sets, you may find that you’ve raised the bar for DevOps software and collaboration environments.

Take the software you are using to orchestrate your end-to-end pipelines — such as code delivery and deployment, ongoing operations, and scaling processes — and try using it to tie those and other processes together.

If it started life as code written by sys admins for sys admins to run on their workstations, it probably does not have the architecture needed to tie together hundreds of integrations across many silos and skill sets and across different data centers in a DevOps-friendly way.

Don’t be snowed by the jargon. You deserve to know the answer to questions such as: “How will the software you use to deliver end-to-end DevOps remain running when bad things happen — or when really good things happen and the scale grows exponentially thanks to broader adoption and the N^2 problem?”

Once you automate your technology development, deployment, and operation pipelines to achieve a “step function” boost in your company’s competitiveness, losing the wiring that makes that happen is like dropping the transmission on your truck.

The AWSes, Facebooks, eBays, and Apples of the world have invested considerable resources creating the glue that ties together their operations. While a point solution doing one task in one location may not need to scale, the control systems tying all of these together certainly must scale.

Apple’s recent announcement that it is building a $2 billion special-purpose data center in Arizona to focus on its control and management systems is one of many examples of how seriously the large operators take the building and operations of their control planes.

In conclusion, non-obvious barriers to DevOps adoption are befuddling many enterprises. However, those that manage to break through the barriers by understanding and accepting them will achieve company- and industry-transforming results.

Please let me know your thoughts in the comments below, or find me on Twitter at <a href="https://twitter.com/epowell101" target="_blank">@epowell101</a>.