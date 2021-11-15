---
title: Welcome linux packages, goodbye AIO installer
author: Dmitri Zimine
type: post
date: 2016-04-22T02:03:43+00:00
url: /2016/04/21/goodbye-aio/
dsq_thread_id:
  - 4766664319
categories:
  - Blog
  - Community

---
**April 21**  
_by Dmitri Zimine_

StackStorm now installs with native linux packages. AIO will continue work for 1.3, but is no longer supported from v1.4 on. How is this good? Read on.

### Welcome new packages

[StackStorm 1.4 is out][1]. It comes [packed with exciting features, bug fixes and improvements][2], but the highlight of this release is the standard linux package based installation. From 1.4 this is the way to deploy StackStorm. And it is quite good.

<!--more-->

  * **It is standard.** With RPM/DEB on a proper package repository, you got updates, uninstall, tooling support &#8211; all the goodies of proper linux packages. Docker support is made easy &#8211; take a sneak-peak on our [docker work-in-progress][3], and by the way someone from the community is building an &#8220;evaluation&#8221; docker image, get ready!
  * **It is reliable.** Now that the packages include all the dependencies, installation is no longer at mercy of network and availability of services like pypi, npm, or docker-hub, and StackStorm can be installed behind proxy, firewall, or in fully gated environment. All st2* processes are isolated into a dedicated python virtual environment so that they don’t pollute the system or conflict with what is already installed.
  * **It is transparent.** We start by presenting a &#8220;map&#8221; that explains the reference deployment: what are all the components, what do they do, how they are wired, so that you can reason about the deployment, adjust to your desired deployment, or troubleshoot when something goes wrong. A step-by-step guides walk you through the installation by the &#8220;reference deployment&#8221;. And these instructions are codified in bootstrap scripts that can be used to accelerate your installation. 
  * **It is fast.** With bootstrap script, StackStorm is installed **in 3 minutes (!)**, and following a guide manually takes about 20 min.
  * **It&#8217;s not &#8220;the installer&#8221;.** Yes, we provide simple bootstrap scripts that codify our documentation, and yes, you are welcome to use them &#8220;as is&#8221;, or modify to your liking. However, these scripts scripts are merely helpers, kept deliberately simple for your understanding. They are not an attempt to replace or match &#8220;AIO installer&#8221;, thus not guaranteed to work on every environment or handle corner cases. We believe that users and the StackStorm community in general will reap greater benefits by understanding how things work and are therefore shifting our focus to clearer docs, simpler scripts, leaving more power to you the user.

But what about &#8220;the installer&#8221;? This brings us to the next topic:

### What about All-In-One installer?

StackStorm is a relatively complex set of micro-services, thus it was important to provide a smooth, simple way to evaluate it. All-In-One installer was aimed to assisting users with the initial setup and configuration for evaluation or even one-node production. It turned a dedicated box into StackStorm appliance, building it on a fly based on user choices, and delivered simple user experience via sleek graphical interface.

It worked well, when it worked. But we hit major problems:

  * **It breaks too often.** While tested and worked like charm on specific images or AWS instances, it turned a victim of endless permutations on the user&#8217;s systems. OS flavors, network configurations, proxies, firewalls, rights and permissions, conflicting components and packages &#8211; it all leads to too many corner case failures that cause the whole installation to fail.  
    Network hiccups, shortest outages on pypi, npm, puppet forge, docker hub, linux package repos cause the whole installation to fail. Worse yet, we were not shielded from the upstream changes in dependencies, and when they broke (and they do break!) &#8211; AIO stayed broken.
  * **When it breaks, it&#8217;s hard to repair.** To provide the simplicity of user experience, it turned out to be complex under the hood. Based on puppet, for those of us who aren&#8217;t Puppet-masters it is obscure and difficult to or troubleshoot. Users felt helpless and called support.
  * **It costs us an arm and a leg.** Supporting and maintaining AIO installer was killing us. Between handholding failing installations on support channel and fixing endless corner cases in the code, we found 80% of our team worked on installer, with no light at the end of the tunnel. This is the time is taken away from fixing bugs and moving the needle on StackStorm core functionality and features.

So we made a decision to sun-set the AIO installer as soon as we provide a solid, reliable alternative way to install. Now that linux based package is out in 1.4, AOI installer is no longer supported.

We still believe that a turn-key appliance form factor is needed. We hope to return to AIO and redo it, as originally envisioned: based on proper deb packages, docker images, with a nice UI delivering a turn-key appliance with great user experience, and &#8220;works every time&#8221;. We hope to get to it in a future.

### What about existing AIO based deployments?

You will need to migrate to package based deployment.  
Install 1.4 on a different box (no, you can&#8217;t do it on top of existing AIO installer). Move the content from your AIO-installed 1.3 to the new 1.4 deployment. Sorry, there is no better answer: these methods of installations are so different that there is no simple upgrade.

With Linux packages, standard updates and upgrades will be supported, so hopefully this is the last time we upset you with between minor versions.

* * *

This is a big change for StackStorm deployments, and it will serve the community well. Looking forward, we will be able to simplify the upgrade process for our users, improve the maintainability of the deployment, and minimize the time to resolution when you do need to reach out for support. Making the deployment easier for you makes it easier for us to troubleshoot. So please embrace the change, and happy StackStorming!

 [1]: https://stackstorm.com/2016/04/20/stackstorm-v1-4/
 [2]: https://docs.stackstorm.com/changelog.html#april-18-2016
 [3]: https://github.com/StackStorm/st2-dockerfiles