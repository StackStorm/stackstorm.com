---
title: 'User story:  StackStorm, Workflows, and ChatOps'
author: st2admin
type: post
date: 2015-08-15T00:12:30+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/08/14/user-story-stackstorm-workflows-and-chatops/
dsq_thread_id:
  - 4033879202
tcb2_ready:
  - 1
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home

---
**August 14, 2015**  
_by Joe Topjian_

<h2 dir="ltr">
  Introduction
</h2>

<p dir="ltr">
  For the past nine months or so, some of us at Cybera have been using a system called StackStorm. StackStorm is a very powerful tool that provides a hub for building automated workflows. That&#8217;s a pretty vague description, but StackStorm&#8217;s power comes from its amorphous character.
</p>

<h2 dir="ltr">
  <a name="initalsteps"></a>Initial Steps
</h2>

<p dir="ltr">
  A core feature of StackStorm is the ability to store a library of &#8220;commands&#8221;. These commands can be anything: creating a ticket in Jira, executing an action on a remote server, doing a Google search — anything. We already had our own <a href="https://github.com/cybera/novac/tree/icehouse" target="_blank">library</a> of everyday commands, so our first task was to port this library into StackStorm. This process felt awkward. It quickly became obvious that most of our commands were focused on single-phase information reconnaissance. StackStorm seemed to work best with multi-phase workflows. The StackStorm team was very receptive to this feedback and worked with us on some simple changes that made our library a bit less awkward to use.
</p>

<p dir="ltr">
  <!--more-->
</p>

<p dir="ltr">
  Once we had our original library stored inside StackStorm, we then began exploring how we could change our library to take advantage of StackStorm&#8217;s other features. It was around this time that I came across their original <a href="https://github.com/StackStorm/st2/blob/master/instructables/chatops.md" target="_blank">ChatOps</a> instructions.
</p>

<h2 dir="ltr">
  <a name="chatops"></a>ChatOps
</h2>

<p dir="ltr">
  A quick Google search shows that ChatOps is a <a href="https://www.pagerduty.com/blog/what-is-chatops/" target="_blank">term that came out of GitHub</a>. It&#8217;s a methodology that enables collaborative development and troubleshooting through a &#8220;chat&#8221; medium such as IRC or Slack.
</p>

<p dir="ltr">
  This sounded like an interesting feature to explore. Instead of having each team member running the same command in one window, getting the same output, and then discussing the interpretation of the results in another window, we could just do everything in one window. It sounded like such an obvious thing to do.
</p>

<p dir="ltr">
  The above-mentioned instructions describe how to integrate StackStorm with Slack. Fortunately, Slack is what we use at Cybera, so the process of integration was quite easy.
</p>

<p dir="ltr">
  Once it was set up, the benefits were immediately obvious. On the same day that integration was in place, we held our weekly team meeting for the <a href="http://www.cybera.ca/projects/cloud-resources/rapid-access-cloud/" target="_blank">Rapid Access Cloud.</a> Our meetings usually involve everyone sitting around a table with their laptops. Whenever the topic of a certain project came up (how many virtual machines the project was using, if a new project had begun using the Rapid Access Cloud, etc), someone would run a command in Slack that would print the report for all of us to see.
</p>

<p dir="ltr">
  Instead of:
</p>

<p dir="ltr">
  &#8220;Can someone lookup how many instances that project is using?&#8221;
</p>

<p dir="ltr">
  pause
</p>

<p dir="ltr">
  &#8220;It looks like they&#8217;re using three.&#8221;
</p>

<p dir="ltr">
  &#8220;How big are the instances?&#8221;
</p>

<p dir="ltr">
  pause
</p>

<p dir="ltr">
  wash, rinse, repeat.
</p>

<p dir="ltr">
  There was now:
</p>

<p dir="ltr">
  &#8220;So as everyone can see in Slack, that project is using three instances.&#8221;
</p>

<p dir="ltr">
  <img loading="lazy" class="left" title="" src="http://www.cybera.ca/assets/Uploads/_resampled/resizedimage714889-Screen-Shot-2015-07-07-at-3.02.24-PM.png" alt="Screen Shot 2015 07 07 at 3.02.24 PM" width="714" height="889" />
</p>

<h2 dir="ltr">
  <a name="chatopscatalyst"></a>ChatOps as a Catalyst
</h2>

<p dir="ltr">
  ChatOps integration was the key to our library modifications. It allowed us to see how our original monolithic reports could be broken down into smaller atomic pieces. These pieces are then mixed and matched like LEGOs, building multi-phase workflows that either help us collaborate in Slack or do some behind-the-scenes automations.
</p>

<p dir="ltr">
  LEGO-building may be the best way to describe how we&#8217;re currently using StackStorm. StackStorm provides a repository of community-contributed <a href="https://exchange.stackstorm.org" target="_blank">packs</a>. By using these packs in conjunction with our own in-house Cybera-specific pack, we can build different workflows and actions for our different projects.
</p>

<h2 dir="ltr">
  <a name="workflows"></a>Workflows
</h2>

<p dir="ltr">
  &#8220;Workflows&#8221; has been mentioned several times already and it deserves more explanation. A great, in-depth article on workflows can be found <a href="http://stackstorm.com/2015/04/10/the-return-of-workflows/" target="_blank">here</a>. Basically, a workflow can be thought of as a multi-step process. We&#8217;ve only scratched the surface of using workflows, but can already see their power.
</p>

<p dir="ltr">
  As an example, we have a command that will generate a report of a project&#8217;s usage in the Rapid Access Cloud. This command accepts a project in its unique ID form.
</p>

<p dir="ltr">
  Projects are internally referenced by a unique ID such as &#8220;9aa5f9f66b4b417d84d778a23acdf45b&#8221;, as well as a common name like &#8220;jtopjian&#8221;. When referring to projects in conversation, it&#8217;s easier to use the latter form. However, for automated processes, the unique ID is used. This is because a project can sometimes have special characters in the common name, or even the same common name as another project. The unique ID will always have alpha-numeric characters and be guaranteed to be unique.
</p>

<p dir="ltr">
  So if I want to run a report of the &#8220;jtopjian&#8221; project, I first need to look up the unique ID and use that to run the report command. Why not just combine the two steps into a workflow?
</p>

<p dir="ltr">
  Step 1: Take a project&#8217;s common name as an input and output the unique ID.
</p>

<p dir="ltr">
  Step 2: Take the unique ID from step 1 as input, run the reporting command, and print the result as output.
</p>

<p dir="ltr">
  Even more beneficial is that Step 1 is written in Ruby, our common language for internal tools. The reporting tool is written in Golang (as an exercise to further explore this language). So pieces that make up workflows can be completely unrelated.
</p>

<h2 dir="ltr">
  <a name="conclusion"></a>Conclusion
</h2>

<p dir="ltr">
  StackStorm has been a very exciting tool for us. It&#8217;s enabled us to discover new ways of collaborating as well as building automated workflows for our environments. As we continue to use it every day, we look forward to the new discoveries we&#8217;ll make.
</p>

<h2 dir="ltr">
  <a name="refernces"></a>References
</h2>

<p dir="ltr">
  <a href="http://stackstorm.com/2015/04/10/the-return-of-workflows/" target="_blank">The Return Of Workflows<br /> </a><a href="https://www.pagerduty.com/blog/what-is-chatops/" target="_blank">So, What is ChatOps? And How do I Get Started?<br /> </a><a href="https://speakerdeck.com/jnewland/chatops-at-github" target="_blank">ChatOps at GitHub<br /> </a><a href="http://stackstorm.com/2015/04/23/stackstorm-and-chatops-for-dummies/" target="_blank">StackStorm And “ChatOps For Dummies”<br /> </a><a href="http://stackstorm.com/2015/06/08/enhanced-chatops-from-stackstorm/" target="_blank">Enhanced ChatOps From StackStorm<br /> </a><a href="http://stackstorm.com/2015/06/12/integrating-chatops-with-stackstorm/" target="_blank">Integrating ChatOps With StackStorm<br /> </a><a href="http://stackstorm.com/2015/06/24/ansible-chatops-get-started-%F0%9F%9A%80/" target="_blank">Ansible and ChatOps. Get started</a>
</p><nav class="blog-navigation"></nav>