---
title: Road to native StackStorm packages
author: st2admin
type: post
date: 2016-05-03T09:00:56+00:00
url: /2016/05/03/road-to-packages/
dsq_thread_id:
  - 4797365681
categories:
  - Blog
  - Community

---
**May 3**  
_by Lakshmi Kannan_

Software is not done unless it is shipped to users and they can play around with something Tangible. For a feature or bug fix to be meaningful, the interested party has to get their hands on it, and decide if the new piece of code improves their life or reduces their pain. In this blog, I am going to tell you a fascinating story of us trying to ship a set of micro services to our customers, how we learnt from our initial mistakes and then describe our new approach to make you and us happier.

The reason I am writing this particular blog post is twofold. I want:

  1. fellow nerds to learn from our experience and replicate our success, bypassing our initial mistakes, and 
  2. to self reflect on where we went wrong and how we course corrected.

<!--more-->

Some of you already know that the StackStorm product is a collection of individual services all designed to interact with each other through well defined remote procedure calls (both REST and non-REST). To sum up the product, we have a core [StackStorm system][1] that consists of API servers (HTTP), sensor containers (process manager that manages sensor processes), rules engine (processes that work on incoming events and invoke appropriate actions or workflows) and action runners (processes that invoke some code that interacts with physical infrastructure or applications). We have end user interaction pieces such as the StackStorm CLI and [UI][2]. We also have [ChatOps pieces][3] that let end users interact with StackStorm in fun and interesting ways via a chat client. Not to prolong this list, but we also have our enterprise features such as LDAP integration plugin and the workflow authoring web tool that we call Flow. Here is a some cool chatops demo to refresh your mind!

Chatops demo!  
<img loading="lazy" class="alignnone size-full wp-image-3541" src="http://stackstorm.com/wp/wp-content/uploads/2015/06/chatops_step_2.gif" alt="chatops_step_1" width="1299" height="710" /> 

As much as we would like to write all these pieces using the same tech stack, reality dictates that we pick the tool of choice for each piece. Some of these choices (Coffee) are also restricted by our reliability on third party components &#8211; Hubot for example. To give you an idea of technology involved in StackStorm product, we have Python, Javascript, Coffee and minimal Bash. You can infer the runtime requirements for these (Python 2.7, Node etc). As much as we would like StackStorm to be a self-sustaining piece of software, we need a database for storing things and a queue for inter-process communication (RabbitMQ). And not to forget Mistral, our workflow orchestrator. It is a multi-process system with APIs, runners, datastore (PostgreSQL) and a queue (luckily, RabbitMQ).

In a purely SaaS model, it would have been easier to ship (relatively speaking) but challenging  
to scale for thousands of users. We would have had to build a multi-tenant system from day one, which adds a significant design overhead. In a ship to on premises (on-prem) model, we don&#8217;t incur the cost of a multi-tenant system but we pay the cost of building something that continually ships the product to customers in a reliable and straightforward manner. To expand on this a bit, a SaaS model would have let us have more control on the environment itself (type of fabric &#8211; VM or container, type of OS, deployment strategy &#8211; placing the processes on the fabric). We&#8217;d still need a deployment tool to continually ship but there are plethora of tools available to facilitate this. In the on-prem model, we lose control over the environment while at the same time we also need a tool that helps users consume the product in a sane way. This applies to both the first time and for updates. Maybe this would have been easier if we shipped a monolithic binary (like Chrome for example) but we have micro services (for good reasons). And on-prem is critical for us because of the type of our customers (small, medium and large scale enterprises). Of late, folks have realized the problems in shipping product to enterprise customers and have started companies around this (for example, [gravitational][4]). Ideally we’d have liked to use them as our platform for deployments but they seem to be not yet ready for prime time. We’ll re-evaluate our strategy as they mature and we learn more about our customers.

Six months ago, when we sat down together to decide on our strategy to ship the &#8220;generally available&#8221; (GA) product (which itself took a year to build), we quickly settled on three things:

  1. End user experience should be great for first time evaluation of the product.
  2. HA deployment would be supported via an opinionated model using common config management tools (we have in-house Puppet expertise). 
  3. Custom deployment models based on customer request would be done via enterprise support. 

It is easy to see that our stress would have been on (1) as we were expecting a majority our customers to fall into evaluation category (product being just GA). Before GA, we were still getting early feedback from customers (I think we&#8217;ve been doing it since the second month from inception of the product development). Our ship story till then was a bunch of Bash scripts that just installed the core components using OS package management tools, install its dependencies using language specific dependencies manager (pip and npm) and configures the product for evaluation. These scripts didn&#8217;t ship all of the components (for example, web UI had to be installed by hand). The scripts also had to deal with different kinds of operating systems (Ubuntu, Debian, CentOS and RHEL). These scripts worked great but it was inflexible. Maintaining Bash scripts wasn&#8217;t easy. But the installation was more or less straight forward. If something went wrong, customers were able to look at the script and rationalize what went wrong. The Bash scripts were fundamentally aimed at giving user a simple StackStorm product to play with, without the bells and whistles of the more feature rich components such as the UI and ChatOps. The scripts intentionally skipped SSL termination, apache/nginx webservers (instead using Python&#8217;s simple http servers) and offloaded authentication setup to end users.

When it came to GA, most of those shortcuts were too limiting and would not have let users experience the complete product. Our primary focus was to let users get a feel for the entire product. So it had to have authentication, SSL termination and all the important features such as UI, Flow, LDAP module etc. Let&#8217;s look at a demo of our Flow product, shall we?

Flow demo!  
<img loading="lazy" class="alignnone size-full wp-image-3541" src="https://cloud.githubusercontent.com/assets/1839421/10035629/512ee8a8-6151-11e5-9a23-4de167d58200.gif" alt="chatops_step_1" width="1299" height="710" /> 

Our DevOps engineers have a strong Puppet background and have worked in both SaaS and large enterprises before. Our developers share such diverse backgrounds as well. We all have shipped software before but we had diverse ideas as to how to do that. We knew deep down that working with an arbitrary environment is a daunting task by itself.

By now, you&#8217;d have come to the conclusion that shipping an appliance would be the best option here. People can then run the appliance (Virtualbox or Vagrant images) and then profit. We also knew that would be the most ideal state for evaluation, but we didn&#8217;t believe that the end deployment model would involve customers using stock appliance images. So instead of making our lives easier, we decided to make it intentionally harder so we can learn more about the day two installation story. Some customers specifically told us that appliances are only good for evaluation, but serious deployments would require us to run on bare metal boxes because of anticipated traffic loads.

A day two installation would look like “people can install native packages on their boxes and use a config management tool of their choice to configure StackStorm the way they wanted for HA purposes.” We strongly believe in providing opinionated solutions where possible but we do not claim to have a thorough understanding of customer requirements when it comes to their infrastructure. So we were targeting a blue-print installation that customers can simply follow and implement the installation procedure using tools such as Chef, Puppet or Ansible.

Our initial blueprint installation involved a spaghetti of Puppet modules that dealt with different  
operating systems, installing specific versions of Python, Node etc and then installation of StackStorm product itself. We also had puppet modules to configure nginx, SSL, authentication etc. We realized that we had too many Puppet modules. On top of that, to make sure people can get up and running without understanding Puppet, we wrote Bash scripts which then installed Puppet and its dependencies, fetched the StackStorm specific Puppet modules and then installed the product itself. For the initial iteration, we did not have what we call bundled packages. By bundled packages, I mean a binary that ships with related dependencies that can be dynamically linked. For Python processes, this would be mean a virtualenv containing required pip dependencies and our code itself. For Node, this would mean we ship Node modules with the package. I am intentionally glossing over dependencies with native C bindings which need to be pre-compiled for target OSes and then shipped. For the first pass, we intentionally skipped this. Instead we relied on installing our bits and then using the language specific dependencies manager (pip, npm etc) to install dependencies (system wide). We also had Puppet modules that installed these dependency managers. We also shipped a GUI configuration wizard to let users customize the installation. In the span of couple of months, we had an installer that let people evaluate stackstorm on their systems. We started hearing from customers.

We unfortunately did not hear good things. I can hear you say &#8220;Well, what did you expect?&#8221;. Before digging into what went wrong, let me highlight the good things:

  1. We had a blueprint for installation.
  2. We had good traction because of the web configuration wizard.
  3. We were able to showcase more features like ChatOps and give users a feel for what it is like to work with authenticated and encrypted StackStorm. 
  4. We created a [Slack support channel][5] to provide fast, informative and interactive support to our customers. 

Our Slack community support is a blog post by itself. It is one of the highlights of the product itself. We learnt immensely about what worked and what did not work from our customers in a rapid and sometimes critical manner.

To be perfectly honest, we were expecting some of that feedback but we did get some unexpected feedback too. Even though our product was primarily evaluated by DevOps engineers, we also had some sysadmins who liked the simplicity of the installation (`curl https://install.stackstorm.com | sudo sh -s`), and decided to evaluate StackStorm. When the installation worked, everyone was really happy and was excited about the product itself. When the installation went wrong, things were a mess. To be direct, a failed installation simply sucked because some steps of the installation were not idempotent. It sucked even more when people couldn’t figure out where the failure happened and why it happened. We&#8217;d point people to Puppet logs, but, it is super hard to figure out what failed. This was the first friction for our customers. Even smart ones found it hard to narrow down the problem because of poor visibility and too many Puppet modules to scan. Even open sourcing the [Puppet modules][6] and the [installer][7] itself wasn&#8217;t winning us much. We were trying to hand hold too many failed installations which led people to frustration because depending on where the installation failed, it could either be fixed by hand, or the installation has to be repeated on a completely new box. Even when we found actual bugs, tracking it to Puppet code and making a fix is hard. Developers found it super hard because puppet is super opinionated and super finicky at the same time. You can&#8217;t even test individual modules sometimes and the whole turnaround time to testing the new changes on all operating systems was hampering our ability to roll out fixes. Most of the failures people saw were related to upstream failures such as downloading pip modules or node modules. We&#8217;ve also seen failures due to a bad dependency package pushed to pypi and npm. Also, the installation simply did not work in enterprises where boxes are behind firewalls. Though we knew about this, we under estimated the number of people who were unwilling to try out the evaluation version in non-firewalled or cloud environments. Some customers also had HTTP proxying setup and it was  
hard to handle proxying in all kinds of dependency installation using a multitude of tools. We could have pulled this off but it would have required weeks of effort.

To solve these installation failures and the fundamental issues of installing on firewalled environments, we went back to our idea of a native package with self contained dependencies with pre-compiled native extensions. In the case of Python, we generate a requirements.txt that has pinned versions of pip dependencies. We then build wheels out of these dependencies with native extensions pre-compiled on target OSes. We use [dh-virtualenv][8] to generate native packages for Python products. For Node modules, we do something similar. Most of the packaging work is [Open Source][9]. You might be interested in how we used dh-virtualenv to also ship native rpm packages. We heavily rely on Docker to contruct the [package building environment][10] and also Circle CI for the actual package building process on commit to source repos. By taking this approach, we essentially reduced our surface area for failures. We host the signed packages in [packagecloud][11].

You can now install st2 components using native packages. We currently support Ubuntu trusty, RHEL 6, RHEL 7, CentOS 6 and CentOS 7 flavors. By switching to bundled packages, we also cut down the installation time from 40 minutes to less than 10 minutes. Our latest installation documentation is simple, straightforward to follow and easy to debug failed installations. We are actively collecting feedback and fixing things. We&#8217;d love your input. We also have simplified installation scripts that use these native packages to get you a minimal install for [Ubuntu trusty][12], [RHEL 7][13], [RHEL 6][14]. Try it out!

Now that we have native packages, we open ourselves to providing multiple form factors such as appliances, Docker containers, etc. We are actively working on building Docker containers for different components using these packages on top of an opinionated base image (debian). We are going to take a multi-step approach in providing a Docker-compose based single host evaluation environment for st2 and then we will ship an opinionated way of connecting Docker containers for distributed deployment. We are learning the ropes here and would welcome community participation. It is also easy now for the community to generate appliances based on the packages based installer.

We still believe a config management tool like Chef or Puppet would add a lot of value in configuring the distributed StackStorm deployment. We will build Puppet modules for these ourselves. Those would be opinionated ones, of course. Customers who want a custom deployment model could use these Puppet modules and build their own equivalents. We saw this pattern even with our old installer which had quite complex Puppet-foo. I am sure the new ones will be easy to mimic.

To summarize our learnings:

  1. Respect customers&#8217; time. A decent first user experience combined with a high speed installation is super critical.
  2. Native packages with bundled dependencies enables shipping reliable software via different form factors.
  3. By keeping the number of things you do with config management tools small and testable, you reduce friction in customers trying out the product and also making fixes.

All this work was made possible by our ex-stormer [James Fryman&#8217;s][15] vision combined with extra ordinary work done by stormers [Denis Barishev][16] and [Eugen][17]. Pretty much everyone on the team has touched on some aspect of the packaging work. For us, it is another proud moment of collaborative engineering to bring our customers the best.

Once again, please try out our new installer using packages for [Ubuntu trusty][12], [RHEL 7][13],  
[RHEL 6][14] and feel free to open an issue or make a fix. We also welcome you to participate in [StackStorm community][18] and scream for help there if needed!

Special thanks to our new product manager [Lindsay Hill][19] for proof reading and adding a special touch to the blog. With more help from fellow Brocadians, we hope to bring more cool stuff to you soon!

 [1]: https://github.com/StackStorm/st2
 [2]: https://github.com/StackStorm/st2web
 [3]: https://stackstorm.com/2015/06/08/enhanced-chatops-from-stackstorm/
 [4]: http://gravitational.com/
 [5]: https://stackstorm.com/community-signup
 [6]: https://github.com/StackStorm/puppet-st2
 [7]: https://github.com/StackStorm/st2workroom
 [8]: https://github.com/spotify/dh-virtualenv
 [9]: https://github.com/StackStorm/st2-packages
 [10]: https://github.com/StackStorm/st2-dockerfiles
 [11]: https://packagecloud.io
 [12]: https://docs.stackstorm.com/install/deb.html
 [13]: https://docs.stackstorm.com/install/rhel7.html
 [14]: https://docs.stackstorm.com/install/rhel6.html
 [15]: https://github.com/jfryman
 [16]: https://github.com/dennybaa
 [17]: https://github.com/armab
 [18]: stackstorm.com/community-signup
 [19]: https://lkhill.com/about/