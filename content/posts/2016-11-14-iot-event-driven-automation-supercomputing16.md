---
title: 'Unleash the power of IoT with Event-Driven Automation (ST2 & BWC @ SuperComputing16)'
author: st2admin
type: post
date: 2016-11-14T19:09:21+00:00
url: /2016/11/14/iot-event-driven-automation-supercomputing16/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5307235234
categories:
  - Blog
tags:
  - brocade
  - BWC
  - event-driven automation
  - IoT
  - StackStorm
  - SuperComputing16

---
**By Chip Copper, PhD;** Principal Technology Evangelist, Brocade  
_Nov 14, 2016_

The pattern is the same: &#8220;I can&#8217;t because we don&#8217;t&#8230;&#8221;, &#8220;But we are also&#8230;&#8221;, &#8220;Can I &#8230;&#8221;, and finally &#8220;How do I get it?&#8221;

We&#8217;re demonstrating Brocade Workflow Composer (BWC), powered by [StackStorm][1], at [SuperComputing16][2] in Salt Lake City. When you stop by booth 1131, we will give you a token of our appreciation. It&#8217;s an NodeMCU microcontroller. It&#8217;s pretty cool &#8211; WiFi built in, ARM microcontroller, lots of GPIO pins, and it can easily be programmed using the freely-available Arduino IDE. It gets you into the world of IoT quickly and easily, and it&#8217;s a lot of fun! Bonus!

But there is a catch &#8211; you have to watch a demo to get it.

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-bwc-iot-supercomputing16.jpg" alt="stackstorm-bwc-iot-supercomputing16" width="800" height="600" class="aligncenter wp-image-6295 size-full" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-bwc-iot-supercomputing16.jpg 800w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-bwc-iot-supercomputing16-150x113.jpg 150w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-bwc-iot-supercomputing16-300x225.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-bwc-iot-supercomputing16-768x576.jpg 768w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-bwc-iot-supercomputing16-80x60.jpg 80w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-bwc-iot-supercomputing16-220x165.jpg 220w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-bwc-iot-supercomputing16-133x100.jpg 133w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-bwc-iot-supercomputing16-200x150.jpg 200w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-bwc-iot-supercomputing16-317x238.jpg 317w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-bwc-iot-supercomputing16-553x415.jpg 553w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-bwc-iot-supercomputing16-649x487.jpg 649w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-bwc-iot-supercomputing16-793x595.jpg 793w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-bwc-iot-supercomputing16-400x300.jpg 400w" sizes="(max-width: 800px) 100vw, 800px" /> <!--more-->

The StackStorm/BWC demo shows how to automate the acquisition and analysis of data from a number of sensors running on a test stand. To start the workflow, all you have to do is message the system. Picture yourself on your way into the office to start the day&#8217;s work. To get last night&#8217;s data, you open Slack (or your favorite chat tool) on your phone and send the message &#8220;!build the graph.&#8221; StackStorm/BWC is a member of the chat group, and it responds by telling you that it&#8217;s getting started. A few minutes later while standing in line at your favorite coffee shop, you get another chat message from StackStorm/BWC letting you know that the latest set of data is sitting on your virtual desktop ready for analysis. That&#8217;s the way to gather data!

So what happened in the background to make that happen? When StackStorm/BWC got the message to get the data, it kicked off a workflow. The first step was to provision the network to allow the data to be read from the sensors. For security reasons we don&#8217;t want to leave the sensor data acquisition machine on the data vlan all the time, and so the automation begins by provisioning the network port that is attached to the sensors onto the data vlan.

This where I typically get the first bit of feedback &#8211; &#8220;I can&#8217;t because we don&#8217;t use Brocade switches on our data acquisition network.&#8221; That&#8217;s ok, this is open source software. Even though using [BWC][3] with Brocade VDX or SLX switches and network automation suites would make this a WHOLE LOT SIMPLER, you don’t have to. We&#8217;d really like you to use Brocade [VDX or SLX][4] switches and our network automation suites, you don&#8217;t have to. The odds are that someone else has already written the sensors and actions that work for your network platform. If they haven&#8217;t, you can do it pretty easily and you can contribute it back to the open source community just as many others have done. This means that you are not locked into any platform or API. You can use whatever you have.

The next step is to validate network connectivity to the sensors. The sensor platform takes a few minutes for the network port to come up. BWC waits patiently until it receives confirmation that the sensors are ready. The sensor platform that we&#8217;re running here is based on Linux. Time for the second question:

&#8220;But we are also running experiments on dedicated lab devices with their own APIs. I can just interface with them the same way that I&#8217;m talking to any network device I want. right?&#8221; Right! Suddenly the reality of platform independence comes through. People stop thinking the limitations imposed by brands of equipment and start thinking about workflows that can be built on whatever has been deployed.

BWC then transfers the data file from the sensor platform to the analytics platform using the native scp tools available in Linux, but again, that could be anything available on the platform you are using. Upon completion, the network port for the sensors is once again turned off. Heads shaking. They get it.

&#8220;Can I have the analytics chain be driven by StackStorm/Workflow Composer as well?&#8221; Yup, that&#8217;s the next step in the workflow. The data can be submitted to a work queue, the analytics can be done immediately, or in this case, the data is simply handed off to gnuplot for some quick validation.

The last step is to let you know that everything has been completed and is ready for your examination, and so you get the final chat while you are still in line in the coffee shop. If you like, it can even remind you to put some of that flavor stuff on top of your coffee when it is ready. (I&#8217;m not a coffee drinker so I don&#8217;t know what that stuff is, but I see people doing it all the time so it must be pretty good.)

Finally, the smile. The person watching the demo gets it. Platform independent workflow management with an interface as easy as a chat session. &#8220;How do I get it?&#8221; Glad you asked! Just head over to StackStorm.com and off you go. Install StackStorm, and join the community. You’ll be inspired to hear the innovative use cases our community has for StackStorm/Workflow Composer

&#8220;And here is your NodeMCU. Thanks for stopping by.&#8221; They smile. &#8220;Of course, I can automate this with StackStorm/BWC too.&#8221; &#8220;Of course!&#8221;

 [1]: http://stackstorm.com
 [2]: http://www.brocade.com/en/about-us/events/sc16.html
 [3]: http://www.brocade.com/en/products-services/network-automation/workflow-composer.html#
 [4]: http://www.brocade.com/en/backend-content/pdf-page.html?/content/dam/common/documents/content-types/at-a-glance/brocade-ip-fabrics-fuel-automated-cloud-data-center-scale-and-agility-ag.pdf