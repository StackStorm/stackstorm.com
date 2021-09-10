---
title: Cisco Spark integration for StackStorm
author: st2admin
type: post
date: 2016-03-23T04:01:31+00:00
url: /2016/03/22/cisco-spark-integration-stackstorm/
dsq_thread_id:
  - 4685437730
tcb2_ready:
  - 1
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - News
  - Tutorials
tags:
  - chatops
  - cisco
  - hubot
  - spark

---
**March 22, 2016**  
_by <a href="https://twitter.com/anthonypjshaw" target="_blank">Anthony Shaw</a> of Dimension Data_

I&#8217;m &#8220;pretty excited&#8221; to share some news, we&#8217;ve just finished integrating Cisco Spark into StackStorm, via our automation-bot, Hubot.  
This means you can get all of the power of StackStorm chatops from within Cisco Spark rooms and collaboration experiences.

## What is Cisco Spark?

Cisco Spark delivers cloud-based business communications that enables customers to message, meet and call anyone, whether it be on their mobile device, desktop or meeting room end-points.

## What is StackStorm?

StackStorm is an event-driven automation platform that ties together every component of your environment. It&#8217;s commonly used for auto-remediation—including response to security events—and other cases such as complex deployments.

## Configuring Cisco Spark

If you don&#8217;t already have a Cisco Spark account, you can sign up at [www.ciscospark.com][1].

Once you have signed up, go to [developer.ciscospark.com][2] and sign in, then you should be able to generate a key

![][3]  <!--more-->

Now, copy the key to the clipboard and save it for later.

![Copy the key][4] 

You want to create a room, or get the ID of an existing room also, so in the developer console go to the rooms page and test out the create room function.

![Creating a key][5] 

Copy the `id` property of the created room from the response in the right-hand pane, you will need this later.

Back in the Cisco Spark UI, you can then join that room by searching for it.

![][6] 

## Configuring StackStorm

To configure the StackStorm chatops bot to set the following environment variables:

  * `HUBOT_SPARK_API_URI` &#8211; The URI, defaults to the public service if not provided
  * `HUBOT_SPARK_ACCESS_TOKEN` &#8211; The access token we just created
  * `HUBOT_SPARK_ROOMS` &#8211; A list of room Ids (comma seperated) you want your bot to listen in

You need to alter the following properties of `"/opt/puppet/hieradata/answers.yaml"` then run `update-system`

<pre><code class="yaml">...
hubot::adapter: "spark"
hubot::env_export:
HUBOT_LOG_LEVEL: "debug"
HUBOT_SPARK_API_URI=https://api.ciscospark.com/v1
HUBOT_SPARK_ACCESS_TOKEN="your token"
HUBOT_SPARK_ROOMS="your room ID"
...
</code></pre>

If you already have the docker hubot image running, stop it and download the new version

<pre><code class="bash">service docker-hubot stop
docker rmi stackstorm/hubot
docker pull stackstorm/hubot
service docker-hubot start
</code></pre>

Now you can tail `docker logs hubot` to see what is going on, check into your room and start issuing those ChatOps commands!

## Testing the integration

Then you will be able to post messages and wait for the arrival of your bot.

![][7] 

Then to test that out, head into StackStorm and run the `chatops.post_message` action with a hello message:

![Hello world][8] 

And then back in Cisco Spark you should see your message!

![In Spark][9] 

## What now?

Now you can install more packs that support ChatOps commands into your StackStorm environment, try out some of these out-of-the-box integrations.

  * **Duo Security** ChatOps integration &#8211; <https://github.com/StackStorm-Exchange/stackstorm-duo>
  * **Tesla** ChatOps integration &#8211; <https://github.com/StackStorm-Exchange/stackstorm-tesla>
  * **ServiceNow** ChatOps integration &#8211; <https://github.com/StackStorm-Exchange/stackstorm-servicenow>
  * **SaltStack** ChatOps integration &#8211; <https://github.com/StackStorm-Exchange/stackstorm-salt>

## About Dimension Data

Dimension Data is a ICT services and solutions provider that uses its technology expertise, global service delivery capability, and entrepreneurial spirit to accelerate the business ambitions of its clients. For an idea of what we do, check out this [YouTube video of the Tour de France- powered by Dimension Data][10]

### Dimension Data and Cisco Spark

Dimension Data is one of Cisco’s largest global partners with a relationship that extends over 20 years and a Cisco Gold Partner in every region in which we operate. Dimension Data’s Cisco qualifications cover virtually all the certifications and specializations that Cisco uses to classify its partners.

[Dimension Data announced Cisco Spark hybrid services after celebrating their 25 year partnership with Cisco][11]

Cisco Spark Hybrid Services is the next generation of the Spark Service that that connects clients’ existing on-premises collaboration capabilities to Cisco Spark in the Dimension Data Collaboration Cloud services bringing together the best of both worlds.

### Dimension Data and StackStorm

Dimension Data are a StackStorm Enterprise customer and have been using StackStorm to automate research projects, integrate and automate their public cloud and automate the deployment of [Cloud Services][12]

## About Anthony

Anthony runs Innovation and Research projects for Dimension Data&#8217;s IT-as-a-Service global division out of Sydney, Australia.

Anthony is a long-time StackStorm user, after starting to use StackStorm to automate the Dimension Data Cloud, Anthony ended up developing packs for [tesla][13], [OctopusDeploy (https://github.com/StackStorm-Exchange/stackstorm-octopusdeploy), [SignalR][14], and others..

Anthony&#8217;s goal for next month (once the hardware arrives) is to upgrade the sprinkler system in his house to use StackStorm IFTTT triggers to control the water flow based on the weather conditions.. More to come on that one.

You can follow Anthony on [Twitter][15] to see what he&#8217;s currently up to.

## Acknowledgement

I&#8217;d like to acknowledge:

  * **Edward Medvedev** for his continued collaboration with me, on late night discussions about Tesla, the correct way to setup the horn honking and support on my bizarre and poorly thought through ideas for StackStorm. Keep it real Ed-  
![Keep it real][16] 
  * The &#8216;Stormers **Manas**, **Lakshmi**, **Tomaz**, **Winston**, **Kirill** and **Patrick** for providing consistent 24&#215;7 above-and-beyond support for us on our wild automation adventure.

[_Image: Cartoon Network_]

 [1]: https://www.ciscospark.com/
 [2]: https://developer.ciscospark.com/
 [3]: http://s8.postimg.org/dnq0660g5/developer_key.png
 [4]: http://s28.postimg.org/hzphh1kkd/key_copy.png
 [5]: http://s8.postimg.org/6upn9w9mt/create_a_room.png
 [6]: http://s30.postimg.org/xevybou35/join_room.png
 [7]: http://s11.postimg.org/suvx19wyr/stackstorm_testing.png
 [8]: http://s16.postimg.org/729365mkl/chatops_test.png
 [9]: http://s30.postimg.org/bva1w9in5/stackstorm_hello_world.png
 [10]: https://www.youtube.com/watch?v=X194y3oAtbM
 [11]: http://www.dimensiondata.com/Global/Downloadable%20Documents/Dimension%20Data%20Launches%20Global%20Cisco%20Spark%20Hybrid%20Services.pdf
 [12]: http://www.dimensiondata.com/en-AU/Solutions/Cloud/
 [13]: https://github.com/StackStorm-Exchange/stackstorm-tesla
 [14]: https://github.com/StackStorm-Exchange/stackstorm-signalr
 [15]: https://twitter.com/anthonypjshaw
 [16]: http://stackstorm.com/wp/wp-content/uploads/2016/03/1681874-inline-inline-6-how-adventure-time-keeps-it-real.jpg