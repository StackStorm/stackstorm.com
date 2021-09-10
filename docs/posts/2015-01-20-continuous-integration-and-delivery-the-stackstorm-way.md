---
title: Continuous Integration And Delivery, The StackStorm Way
author: st2admin
type: post
date: 2015-01-20T18:33:28+00:00
excerpt: '<a href="http://stackstorm.com/2015/01/20/continuous-integration-and-delivery-the-stackstorm-way/">READ MORE</a>'
url: /2015/01/20/continuous-integration-and-delivery-the-stackstorm-way/
dsq_thread_id:
  - 3438939496
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home

---
**January 20, 2015**

_by James Fryman_

There have been so many times when I have been on both the receiving end and giving end of this conversation, and it goes something like this:

> Me: Man, this awesome toolchain at Company _X_ really makes it easy to ship software!
> 
> Friend: How can I get my hands on that hotness!?
> 
> Me: Well&#8230;. um&#8230; 

And the conversation shifts&#8230; and the involved engineers begin discussing and sharing the good and bad about the toolchain, things that they want to do, how it&#8217;s helped&#8230; you get the idea. Unfortunately, the best that the receiver is going to get are the abstract ideas about these tools. Wonderful after-work discussion, but really horrible in actually helping share craft to make all of our jobs easier and more efficient.

Let&#8217;s face it. If it&#8217;s difficult to share small code snippets with each other, forget about it when talking about trying to share entire process toolchains. Oftentimes, they are hyper-specialized to a specific company, tightly coupled with systems. There has to be a better way to share operational patterns while allowing for the tweaks and knobs that are unique to each company.

This is a problem begging to be solved, and we&#8217;re taking a pass at it. And what better way to do that then to show off what can be done with StackStorm with a Continuous Delivery/Continuous Integration Pipeline.

<!--more-->

###### What Is It?

This CI/CD Workflow is designed as a generic packaging and deployment pipeline. The aim here is to create a pipeline flexible enough to be able to push code of any type through, and prepare it for rapid deployment and management via StackStorm.

This pipeline uses the Canary pattern. In the canary pattern, code is deployed to a small subset of users before being ultimately rolled out to production. This allows for users to do testing on a smaller surface area and discover problems at small scale before they become large scale.

This workflow subscribes to the &#8216;Convention over Configuration&#8217; approach to the world. Any project should be able to be used by this pipeline, assuming it follows these conventions:

  * CI Portion
  * A project exists on GitHub, and has its outgoing webhook configured to send to StackStorm
  * The project has two scripts designed to ensure the project is setup for CI
  * \`script/cisetup\` &#8211; Prepares the build directory to run CI. Executed prior to CI begin
  * \`script/cibuild\` &#8211; Commands to test the execute the CI build process
  * Project has been configured on Jenkins Server
  * Project has a post-install script (\`script/post-inst\`) to do any items post-package installation
  * (NOTE: Any of the scripts can simply \`exit 0\`, but they need to exist)
  * Consul has been configured to advertise servers with the following tags:
  * &#8216;appname::approle&#8217;
  * &#8216;appname::approle_canary&#8217;
  * By default, appname is the project name, and approle is \`app\`

All of this code is open-source, and available for you to explore and use as best as you can. The code for this operational pattern can be found in our StackStorm Showcase at <https://github.com/stackstorm-showcase/cicd-canary>.

###### Design Decisions

This workflow was designed initially to cover the most generic use-case possible, and attempts to make few assumptions about the operating environment that this could be used in. Specifically:

  * The application language used should not be relevant to the pipeline
  * The deploy mechanism must be native to the operating system
  * Deploys should make best-effort at synchronous deployment, and also be eventually consistent

###### Architecture

Below is a list of components that make up the underlying infrastructure in aggregate, and shows how StackStorm fits into the overall picture of asset management. Many of the tools here were chosen to allow use in an isolated, local environment.

<img loading="lazy" class="alignnone size-full wp-image-2231" src="http://stackstorm.com/wp/wp-content/uploads/2015/01/7f690d3e-94e7-11e4-950d-e5c8cb98adf5.jpg" alt="7f690d3e-94e7-11e4-950d-e5c8cb98adf5" width="562" height="653" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/01/7f690d3e-94e7-11e4-950d-e5c8cb98adf5.jpg 562w, https://stackstorm.com/wp/wp-content/uploads/2015/01/7f690d3e-94e7-11e4-950d-e5c8cb98adf5-258x300.jpg 258w" sizes="(max-width: 562px) 100vw, 562px" /> 

  * Load Balancing: HAProxy
  * Continuous Delivery
  * Asset: OS Packages
  * Strategy: Canary
  * Continuous Integration Server: Jenkins
  * Service Discovery: Consul
  * Orchestration Layer: StackStorm
  * Configuration Management: Puppet / Consul-Template
  * Provisioning: Vagrant / EC2 / DigitalOcean

###### Process Flow

Who doesn&#8217;t love process flows? Oftentimes, a picture says much more than words can. But, in the event that you also like words&#8230; the workflow in complete is listed below. As you&#8217;ll see below, all of the items are very small in nature, and different tools are combined to create a robust toolchain.

<img loading="lazy" class="alignnone size-full wp-image-2230" src="http://stackstorm.com/wp/wp-content/uploads/2015/01/james_2.png" alt="james_2" width="814" height="798" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/01/james_2.png 814w, https://stackstorm.com/wp/wp-content/uploads/2015/01/james_2-300x294.png 300w" sizes="(max-width: 814px) 100vw, 814px" /> 

  1. User pushes new commit to GitHub</p> 
  2. [GitHub] Fires a webhook to StackStorm</p> 
  3. [StackStorm :: Web Hook] StackStorm receives the webhook, and matches it to an incoming rule to begin a CI Job</p> 
  4. [Jenkins] Clones application from GitHub</p> 
  5. [Jenkins] On build completion, sends a webhook back to StackStorm with Success/Failure</p> 
  6. [Jenkins :: Success] StackStorm kicks off packaging workflow to build an OS package from the application.</p> 
  7. [Package] StackStorm queries Consul for an available host to build a package</p> 
  8. [Package] StackStorm downloads the application from GitHub</p> 
  9. [Package] StackStorm queries the downloaded repository for metadata to build the package</p> 
 10. [Package] StackStorm packages up the repository using FPM</p> 
 11. [Package] StackStorm takes the package and inserts it into Freight (APT Repository), marking it eligible for download</p> 
 12. [Package] StackStorm cleans up all tempfiles and hands off to Deploy Workflow</p> 
 13. [Deploy :: Canary] StackStorm updates the currently advertised version of the application to deploy.</p> 
 14. [Deploy :: Canary] StackStorm queries all hosts that have been tagged as &#8216;canary&#8217;</p> 
 15. [Deploy :: Canary] StackStorm tells all canary hosts a package has been updated, and updates the servers.</p> 
 16. User waits for any external alarms to fire (New Relic, Nagios, etc).

 17. If no failures, user deploys new package to production.

 18. [Deploy :: Production] StackStorm updates the currently advertised version to the currently deployed canary version</p> 
 19. [Deploy :: Production] StackStorm tells all production hosts a package has been updated, and updates the servers.</p> 

### Decisions, Decisions

The architecture decisions in this pipeline are pretty arbitrary. Every infrastructure is slightly different, which is part of what makes the problem of sharing infrastructure patterns all that much more difficult. But, what we hope is illustrated here is just how easy it is to swap out different components of the stack.

Having problems with Jenkins? Get rid of it. Want to try out containers? Add it to the workflow/pipeline. Composing complex pipelines is now getting easier. This workflow may not fit your needs completely, but it should get you quite a bit further. On top of that, all of the code adheres to the &#8216;Infrastructure as Code&#8217; ethos, and Pull Requests are gladly accepted.

###### Why this way as opposed to&#8230;

###### &#8230;with \`bash\` scripts?

`bash` scripts are a great way to get started with automation, and to quickly prototype things you need to get done. No doubt about it, we are huge fans of all things shell over here at StackStorm! The downside though is that over time, these scripts become a bit kludgy and difficult to manage. With StackStorm, we integrate with many of these soon-to-be or already written scripts, but we take responsibility for things like auditing, logging, user interfaces with help, an API and reliability and for tying them into a broader pipeline via a rules engine and workflow. We make it so that the shell scripts can focus on doing what they are great at doing&#8230; the quick and dirty stuff.

###### &#8230; Jenkins.

It&#8217;s true. Jenkins has a lot of the workflow management inside of it, and has proven to be robust in creating great delivery stories. We certainly tip our hat to the efforts there. StackStorm provides additional benefits in a few key areas:

  1. Not tied to a single technology. With Jenkins, you must use their UI, and write their XML. With StackStorm, the driving technology can be any language and any tool. Use our API to interact however you want, and write files in easy to understand YAML.</p> 
  2. Respond to additional events. StackStorm goes above and beyond Jenkins&#8230; adding the ability to take in additional information about events happening in your datacenter, and to use that to make additional decisions.

###### Get Crazy!

One of the more interesting benefits of a system like this is the ability to protect yourself… from yourself. How many times have you made the wrong move on a computer, and the subsequent day/week/month was not too pleasant? For me, far too many to care to say. In this pipeline, I built out logic that prevents a production deploy from happening straight to code. When the user issues a production deploy command, the only possible choice they have is to promote the currently running canary version.



This enforces good practice amongst the deployment pipeline. Combined with the fact that this policy is already documented as code, the ability to adapt and change policy is enforced, auditable, and easily adaptable.

###### Overall

I&#8217;m really excited about this. This is really only the tip of the iceberg in terms of what StackStorm can do for you, and where we are going! I am most interested in learning about how many of you take the code for this solution and start to adapt it for your organization. What things of this pattern did you use? Which ones did you toss? Most importantly &#8211; how much effort was it to build upon this pattern? Our goal is to make it such that we can get you around ~80% of the way with our platform and solutions like this, and the last mile is all yours to run with. So, if you do play with this, please let us know! We love feedback (the good kind and the best kind… but also the constructive kind if you have it).

There has been a ton of photos in here, and they often speak volumes more than words do. We’re continuing to refine our ChatOps story, and you’ll see some of that in this solution.

[<img loading="lazy" class="alignnone size-full wp-image-2233" src="http://stackstorm.com/wp/wp-content/uploads/2015/01/700.jpg" alt="700" width="700" height="438" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/01/700.jpg 700w, https://stackstorm.com/wp/wp-content/uploads/2015/01/700-300x187.jpg 300w, https://stackstorm.com/wp/wp-content/uploads/2015/01/700-400x250.jpg 400w" sizes="(max-width: 700px) 100vw, 700px" />][1]

And if you are interested in seeing a demo of this in action, we have a video! Check it out <a href="http://youtu.be/532upeN9x1w" target="_blank">here</a>:



###### More things to come&#8230;

We&#8217;re continuing to work on new features to add to the core StackStorm platform. Over the next several months, we&#8217;ll be adding features like:

  * Web Based GUI
  * Role Based Access Control
  * Additional ChatOps Interfaces
  * &#8230; and so much other cool stuff I can hardly wait!

If you haven’t already, we invite you to check out our product by [installing StackStorm][2] and following the [quick start][3] instructions — it will take less than 30 minutes to give you a taste of our automation. Share your thoughts and ideas via <a href="https://groups.google.com/forum/#!forum/stackstorm" target="_blank">stackstorm@googlegroups.com</a>, [#stackstorm on irc.freenode.net][4] or on Twitter [@Stack_Storm][5].

Until Next Time!  
&nbsp;

 [1]: http://stackstorm.com/wp/wp-content/uploads/2015/01/700.jpg
 [2]: http://docs.stackstorm.com/install/index.html
 [3]: http://docs.stackstorm.com/start.html
 [4]: http://webchat.freenode.net/?channels=stackstorm
 [5]: https://twitter.com/Stack_Storm