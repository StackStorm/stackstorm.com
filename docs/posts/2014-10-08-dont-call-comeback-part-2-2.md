---
title: '“Don’t Call It A Comeback!” [Part 2]'
author: Dmitri Zimine
type: post
date: 2014-10-08T15:54:54+00:00
excerpt: '<a href="/2014/10/08/dont-call-comeback-part-2-2/">READ MORE</a>'
url: /2014/10/08/dont-call-comeback-part-2-2/
dsq_thread_id:
  - 3184647653
thrive_post_fonts:
  - '[]'
categories:
  - Blog

---
**October 8, 2014**

_by Evan Powell_

In <a href="http://stackstorm.com/2014/10/07/dont-call-comeback-part-1/" target="_blank">part one</a> of this blog series we discussed the first and second waves of operations automation and how they’ve paved the way for the emerging third wave. In part two, we’ll discuss the importance and impact of the third wave.

**Why do we need another wave, and why is it like the first? ** 

Across many domains in IT you see waves such as those we are witnessing in the automation space today. A few important changes that are forcing change on many pieces of IT include:

**1. Abstraction is powerful, but “too much” is bad**

We hear this all the time from our DevOps users. They want to be able to achieve the benefits of automation – and to improve the lives of their operators, developers and especially their end users.

<!--more-->

And yet, if they do not see the underpinnings of the automation they often lose trust in it. Developers want to see the code itself – they can think in code – and if you hide somewhere in proprietary code information about the state of “their” datacenter or “their” application, they become upset (and not just because they thought they were building a stateless architecture J). The design requirement we took from this is to actually externalize the automation completely, as code. The phrase that is often used to describe this, is “Infrastructure as Code.”

**2. Developers, developers, developers**

Almost eight years after Steve Ballmer’s famous sweat stained chant<sup>1</sup>, the world of IT is more dominated by developers than ever. And their domain has gone right into infrastructure itself, via the DevOps movement.

Because developers now build and help run some the most massively productive IT environments in history – like Facebook, Google, and AWS – automation must conform with requirements like treating infrastructure as code.

Moreover, it is because developers are in charge that every single API must be a first class citizen. They determine whether your API is inadequate very quickly. If you treat your APIs badly by deprecating them suddenly and without warning, you are essentially slapping developers that use your APIs in the face. The rise of APIs and the rise of developers as not just consumers of IT but as its operators go completely hand in hand.

**3. Scale and scalable humans**

The unicorn companies that have broken open new frontiers use advanced automation to do the basic tasks, allowing humans to focus on actually thinking, building, troubleshooting and evolving their systems. The 10-100x productivity advantages that companies like Facebook, Google and others achieve are amazing.

However, it turns out they are also fighting each other tooth and nail over the scarce humans that are able to build and then help operate these massively scalable environments (when they are not colluding over salaries at least).<sup>2</sup>

In addition to collusion, what have these major players done to address the incredible scarcity of top talent? In part, they have started down the path of artificial intelligence.

Facebook has written publicly a couple of times about their use of artificial intelligence in complex environments. A few years ago they talked about a type of remediation as a service they called <a href="https://www.facebook.com/note.php?note_id=10150275248698920https://www.facebook.com/note.php?note_id=10150275248698920" target="_blank">FBAR</a>.

More recently they claimed a 27 percent savings in power used on compute cycles thanks to the use of a highly intelligent system they call, somewhat less imaginatively, <a href="https://code.facebook.com/posts/816473015039157/making-facebook-s-software-infrastructure-more-energy-efficient-with-autoscale/" target="_blank">AutoScaling</a>.

In both cases you can see the role that machine intelligence plus control theory is having at Facebook. At StackStorm, we are aware of similar approaches in other large operators including Microsoft – who wrote about their <a href="http://research.microsoft.com/pubs/64604/osr2007.pdf" target="_blank">AutoPilot project</a> back in 2007.

**Conclusion**

In summary, the third wave is seeing Infrastructure as Code, humans organizing themselves via DevOps, and machine intelligence being used with control theory to close the loop and provide intelligent – and still transparent – automations that learn.

This third wave builds upon the prior waves to deliver the promise of broadly adopted automation without the downsides of either the difficult to manage first wave of systems or the inflexibility and eventual lack of trust of VMware’s black boxes, which are so reminiscent of the mainframe era.

What projects do we see as fitting into this third wave? Well, in the basic order of their usage as an organization that moves from agile development into agile operations (aka DevOps) we see:

  1. Docker automating tracking of all dependencies for an environment while providing efficient and very fast to deploy containers;
  2. Jenkins automating QA testing;
  3. OpenStack and Docker orienting orchestration solutions, possibly leveraging libswarm APIs like Kubernetes and Fig;
  4. A reinvented monitoring space, including Sensu, and of course the application performance vendors like New Relic and even measure _everything_ AppFirst, who seems to be doing well with very large enterprises;
  5. StackStorm and others are focusing on automation as a service; and this layer is based on the incredible explosion of control knobs that have been introduced into the data center via APIs and via control software like Chef, Puppet, mCollective, SaltStack and even Fabric.  We also see Docker itself starting to be used in certain use cases. As a side note and a possible subject of a future post, there is a fissure that is expanding between shops betting on “immutable” approaches powered by Docker typically, and those shops that are willing to recast and fix servers with the help of Chef and Puppet.

We have seen a number of Automation as a Service (AaaS) libraries with management for this control layer built by the larger operators; however, have yet to see a project or company really lay claim to delivering true automation as a service. This is where StackStorm intends to play, working especially with existing projects in configuration management and remote execution, as well as interfacing with monitoring providers to extend the reach of both by closing the loop between monitoring and other triggering events and actions taken.

These closed loops will lend themselves to the use of advanced control theory in concert with machine intelligence as the examples of Facebook and Microsoft suggest.

We at StackStorm believe an era of truly self-driving data centers is around the corner for the broader market. Thanks to both a forthcoming emergence of automation as a service and the subsequent layering of self-driving controls we expect to see a broader adoption of DevOps and hence dramatic improvements in our ability to build and operate software. In short, working with the ferment of innovation occurring in and around cloud and DevOps, we believe we can help make the world a fundamentally smarter place through automation, machine learning, and control theory.

We’re interested in your comments – feel free to share them below or via <a href="http://www.twitter.com/Stack_Storm" target="_blank">@Stack_Storm</a> or <a href="http://www.twitter.com/epowell101" target="_blank">@epowell101</a>. Are we indeed at the beginning of the third wave of operations automation? What else could we and should we have learned from the prior waves? And why are these waves occurring?

_<sup>1</sup> <a href="https://www.youtube.com/watch?v=8To-6VIJZRE" target="_blank">https://www.youtube.com/watch?v=8To-6VIJZRE</a>_  
 _<sup>2</sup> Nothing has been proven, but you can see smoking gun emails thanks to PandoDaily <a href="http://pando.com/2014/03/22/revealed-apple-and-googles-wage-fixing-cartel-involved-dozens-more-companies-over-one-million-employees/" target="_blank">here</a>._