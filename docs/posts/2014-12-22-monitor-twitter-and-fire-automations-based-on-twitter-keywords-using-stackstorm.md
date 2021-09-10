---
title: Monitor Twitter And Fire Automations Based On Twitter Keywords Using StackStorm
author: st2admin
type: post
date: 2014-12-22T22:10:32+00:00
excerpt: '<a href="http://stackstorm.com/2014/12/22/monitor-twitter-and-fire-automations-based-on-twitter-keywords-using-stackstorm/">READ MORE</a>'
url: /2014/12/22/monitor-twitter-and-fire-automations-based-on-twitter-keywords-using-stackstorm/
dsq_thread_id:
  - 3350468937
tcb2_ready:
  - 1
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home
  - Tutorials
tags:
  - tutorial

---
**December 22, 2014**

_by Tomaz Muraus_

<p class="normal">
  The StackStorm automation platform is very powerful and flexible. Our users <a href="http://stackstorm.com/product/#use" target="_blank">most commonly use it</a> to perform tasks such as Continuous Integration & Continuous Deployment, Facilitated Troubleshooting and Remediation as a Service.
</p>

<p class="normal">
  <img loading="lazy" class="alignnone wp-image-2124" src="http://stackstorm.com/wp/wp-content/uploads/2014/12/1.png" alt="1" width="257" height="257" srcset="https://stackstorm.com/wp/wp-content/uploads/2014/12/1.png 280w, https://stackstorm.com/wp/wp-content/uploads/2014/12/1-150x150.png 150w" sizes="(max-width: 257px) 100vw, 257px" /><img loading="lazy" class="alignnone wp-image-2125" src="http://stackstorm.com/wp/wp-content/uploads/2014/12/2.png" alt="2" width="257" height="257" srcset="https://stackstorm.com/wp/wp-content/uploads/2014/12/2.png 272w, https://stackstorm.com/wp/wp-content/uploads/2014/12/2-150x150.png 150w" sizes="(max-width: 257px) 100vw, 257px" /><img loading="lazy" class="alignnone wp-image-2126 size-full" src="http://stackstorm.com/wp/wp-content/uploads/2014/12/3.png" alt="3" width="257" height="257" srcset="https://stackstorm.com/wp/wp-content/uploads/2014/12/3.png 257w, https://stackstorm.com/wp/wp-content/uploads/2014/12/3-150x150.png 150w" sizes="(max-width: 257px) 100vw, 257px" />
</p>

<p style="text-align: center;">
  <em>Continuous Integration & Continuous Deployment, Facilitated Troubleshooting and Remediation as a Service, three mostly common use-cases.</em>
</p>

<p class="normal">
  Because StackStorm is an extensible automation platform, you are not limited to these three use cases. You can use it to perform almost any kind of automation you can think of.
</p>

<p class="normal">
  Today, let’s look at a slightly different use case. I’ll demonstrate how to monitor Twitter in near real-time for matching keywords and relay tweets matching those keywords to a Slack channel.
</p>

<p class="normal">
  <!--more-->
</p>

<p class="normal">
  There are many scenarios where doing something like this comes in handy. A popular scenario is monitoring social media for messages which mention your company or a product name. This allows you to provide a better user experience and support because you are able to react to those messages faster, and potentially also in an automated manner.
</p>

<p class="normal">
  Examples of things you can do when a matching tweet is detected include forwarding that message to the customer department, providing an automated answer for simple questions, kicking off basic troubleshooting or at least event investigation, or relaying the tweet to some other medium that is constantly monitored by your company employees.
</p>

<p class="normal">
  In this blog post we will have a look how do the last scenario I mentioned &#8212; relaying matching tweets to a Slack channel.
</p>

###### Using sensor from Twitter pack to monitor Twitter for matching keywords

We have recently added a <a href="https://github.com/StackStorm-Exchange/stackstorm-twitter" target="_blank">Twitter pack</a> to our <a href="https://exchange.stackstorm.org" target="_blank">StackStorm Exchange</a>. This pack includes a sensor that allows you to monitor Twitter for tweets matching a particular query. Once a matching tweet is detected, a trigger that contains all the information about that tweet is dispatched.

In the background, the sensor works by periodically polling the <a href="https://dev.twitter.com/rest/public/search" target="_blank">Twitter search API</a>.

###### Getting and configuring the pack

To get and configure the pack, simply follow the instructions below.

**Step 1: Download the pack**

<pre>st2 pack install twitter</pre>

**Step 3: Edit the configuration file**

Copy _/opt/stackstorm/packs/twitter/twitter.yaml.example_ to _/opt/stackstorm/configs/twitter.yaml_ and edit the configuration to match your needs.

All the options are explained below and in the <a href="https://github.com/StackStorm-Exchange/stackstorm-twitter/blob/masterREADME.md" target="_blank">README</a>.

  * consumer_key &#8211; Twitter API consumer key
  * consumer_secret &#8211; Twitter API consumer secret
  * access_token &#8211; Twitter API access token
  * access\_token\_secret &#8211; Twitter API access token secret
  * query &#8211; A query to search the twitter timeline for. You can use all the query operators described at <a href="https://dev.twitter.com/rest/public/search" target="_blank">https://dev.twitter.com/rest/public/search</a>
  * count &#8211; Number of latest tweets matching the criteria to retrieve. Defaults to 30, maximum is 100.
  * language &#8211; If specified, only return tweets in the provided language (e.g. en, de, etc.).

To obtain API credentials, you need to first register your application on the <a href="https://apps.twitter.com/" target="_blank">Twitter Application Management</a> page.

<img loading="lazy" class="alignnone size-full wp-image-2127" src="http://stackstorm.com/wp/wp-content/uploads/2014/12/4.png" alt="4" width="868" height="591" srcset="https://stackstorm.com/wp/wp-content/uploads/2014/12/4.png 868w, https://stackstorm.com/wp/wp-content/uploads/2014/12/4-300x204.png 300w" sizes="(max-width: 868px) 100vw, 868px" /> 

<p style="text-align: center;">
  <em>Step A &#8211; Application registration</em>
</p>

<p class="normal">
  After you have done that, go to the &#8220;Keys and Access Tokens&#8221; tab where you can find your consumer key and secret. On the same page you can also generate a read-only access token.
</p>

<p class="normal">
  <img loading="lazy" class="alignnone size-full wp-image-2128" src="http://stackstorm.com/wp/wp-content/uploads/2014/12/5.png" alt="5" width="975" height="550" srcset="https://stackstorm.com/wp/wp-content/uploads/2014/12/5.png 975w, https://stackstorm.com/wp/wp-content/uploads/2014/12/5-300x169.png 300w" sizes="(max-width: 975px) 100vw, 975px" />
</p>

<p class="normal" style="text-align: center;" align="center">
  <em>Step B &#8211; Obtaining consumer key and consumer secret</em>
</p>

<p class="normal" style="text-align: left;" align="center">
  <img loading="lazy" class="alignnone size-full wp-image-2130" src="http://stackstorm.com/wp/wp-content/uploads/2014/12/6.png" alt="6" width="975" height="488" srcset="https://stackstorm.com/wp/wp-content/uploads/2014/12/6.png 975w, https://stackstorm.com/wp/wp-content/uploads/2014/12/6-300x150.png 300w" sizes="(max-width: 975px) 100vw, 975px" />
</p>

<p class="normal" style="text-align: center;" align="center">
  <em>Step C &#8211; Generating and obtaining access token and secret</em>
</p>

<p class="normal">
  As noted above, in the <b>query</b> field you can use all of the query operators supported by Twitter. This gives you a lot of flexibility and makes the solution powerful.
</p>

<p class="normal">
  <b>Step 4: Register the sensor, restart sensor_container service</b>
</p>

<p class="normal">
  For the StackStorm to pick up the new sensor, you need to first register it and then restart the sensor_container service.
</p>

<p class="normal">
  You can do that using the commands listed below.
</p>

<pre>sudo st2ctl reload</pre>

<pre>sudo st2ctl restart</pre>

###### Creating a rule

<p class="normal">
  Now that we have a sensor in-place, we just need to create a <a href="http://docs.stackstorm.com/rules.html" target="_blank">rule</a> which will relay matched tweets to our Slack channel.
</p>

<p class="normal">
  <strong>Example 1: Using slack.post_message action</strong>
</p>

<p class="normal">
  Using slack.post_message action
</p>

<p class="normal">
  In this rule we are going to use a “post_message” action from the slack pack. This action willpost a message which is defined in the parameters to a Slack channel.
</p>

<p class="normal">
  To download and configure the slack pack, followed the steps 1-4 described above (just replace Twitter with Slack). You can find the description of all the available settings in the <a href="https://github.com/StackStorm-Exchange/stackstorm-slack/blob/master/README.md" target="_blank">README</a>.
</p>

<p class="normal">
  <a href="https://gist.github.com/Kami/c13b5b47e974c572e218" target="_blank">https://gist.github.com/Kami/c13b5b47e974c572e218</a>
</p>

As you can see, the rule is pretty simple and straightforward. We don’t define any additional criteria and simply relay every matched tweet to our Slack channel. If you want to perform additional filtering, you can to that using the criteria field.  

For information on how to use this field and which operators are supported, see the <a href="http://docs.stackstorm.com/rules.html" target="_blank">Rules section</a> in the documentation.  

To create this rule, run the following commands:

<pre>curl https://gist.githubusercontent.com/Kami/c13b5b47e974c572e218/raw/52c703a2f98ded48853bc5cba1ffeae1fea85727/gistfile1.yml -o rule1.yaml
st2 rule create rule1.yaml</pre>

**Example 2: Using core.http action**

To show how flexible and powerful StackStorm really is, we are also going to have a look at how to perform exactly the same task using a built-in core.http action.  

core.http action allows you to perform an arbitrary http request and you can control everything from headers, to body and cookies.  

<a href="https://gist.github.com/Kami/7675287d81365cc8dac4" target="_blank">https://gist.github.com/Kami/7675287d81365cc8dac4</a>

<p class="normal">
  As you can see, the rule is the same as the upper one, but instead of using <i>slack.post_message</i> action, we are using <i>core.http</i> action.
</p>

<p class="normal">
  Using this action means we need to define some more parameters inside the rule &#8211; we need to define the webhook url, specify correct headers and pass data in an expected format.
</p>

<p class="normal">
  To create the rule, you run the same commands as above:
</p>

<pre>curl https://gist.githubusercontent.com/Kami/7675287d81365cc8dac4/raw/8f3ca0e5ab8b842be9e693b67aef2b09cb7f6645/gistfile1.yml -o rule2.yaml
st2 rule create rule2.yaml</pre>

###### Putting it all together

<p class="normal">
  Now that we have a sensor and rule in place, all we need to do is wait for a matching tweet to be posted and the tweet will be relayed to our channel.
</p>

<p class="normal">
  <img loading="lazy" class="alignnone size-full wp-image-2136" src="http://stackstorm.com/wp/wp-content/uploads/2014/12/7.png" alt="7" width="975" height="486" srcset="https://stackstorm.com/wp/wp-content/uploads/2014/12/7.png 975w, https://stackstorm.com/wp/wp-content/uploads/2014/12/7-300x149.png 300w" sizes="(max-width: 975px) 100vw, 975px" />
</p>

<p class="normal" style="text-align: center;" align="center">
  <em>Our little solution in action. </em>
</p>

<p class="normal">
  Keep in mind that this blog post just briefly touches the surface of what is possible to do with StackStorm. For example, you can modify this solution to relay the tweet to an IRC channel or email instead of Slack, or you can use a <a href="http://docs.stackstorm.com/workflows.html" target="_blank">Workflow</a> to perform more advanced automation consisting of multiple steps &#8211; the possibilities are almost endless!
</p>

###### Conclusion

<p class="normal">
  I hope this blog post gave you a better idea of how powerful StackStorm really is and showed you that because StackStorm is an extensible automation platform, it’s not just limited to three most commonly used use-cases described above &#8212; it can be used  to perform almost any kind of automation you can think of.
</p>

<p class="normal">
  Additionally, I hope it inspired you to think outside of the box and build something unusual, but cool and useful with StackStorm yourself.
</p>

<p class="normal">
  And if you have already done that, please <a href="http://stackstorm.com/contact/" target="_blank">get in touch</a> &#8211; we are more than happy to feature your use case and / our solution on our blog.
</p>