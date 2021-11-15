---
title: 'Announcing StackStorm Vagrant & OVA'
author: Eugen C.
type: post
date: 2018-05-21T05:00:11+00:00
url: /2018/05/20/announcing-stackstorm-vagrant-ova/
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Blog
  - Community
  - News
tags:
  - installation
  - ova
  - vagrant
  - virtual appliance
  - virtual image
  - virtualbox
  - VM

---
**May 21, 2018**  
_By [Warren Van Winckel][1] and [Eugen C.][2]_

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover.png" alt="StackStorm Vagrant Box" class="alignnone wp-image-7779 size-full" width="800" height="478" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover.png 800w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-150x90.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-300x179.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-768x459.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-80x48.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-220x131.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-167x100.png 167w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-251x150.png 251w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-398x238.png 398w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-stackstorm-cover-695x415.png 695w" sizes="(max-width: 800px) 100vw, 800px" />][3]

We&#8217;re glad to announce that StackStorm Vagrant box and Community OVA are available for general use and included as installation method in [StackStorm Docs][3].

<!--more-->

## Why another installation method?

Vagrant / OVA is the quickest and easiest way to get complex StackStorm architecture with 9 microservices, Workflow Engine, message queue like RabbitMQ, databases like PostgreSQL and MongoDB, nginx, ChatOps up and running with no hassle.

The virtual machine image comes pre-installed, configured and tested. This helps to avoid time-consuming installation and configuration steps. Perfect as a starting point to meet with StackStorm, get a quick platform overview, test, demo or even using StackStorm in isolated from the internet air-gapped systems.

We now highly recommend using a Vagrant / OVA to get familiar with the StackStorm platform.  
It&#8217;s a really 2-click experience!

## StackStorm Vagrant

This snippet is worth a thousand words:

<pre><code class="sh">vagrant init stackstorm/st2
vagrant up
vagrant ssh
</code></pre>

Trying StackStorm was never so easy!

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-up.png" alt="Vagrant UP with StackStorm" width="894" height="814" class="alignnone size-full wp-image-7796" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-up.png 894w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-up-150x137.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-up-300x273.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-up-768x699.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-up-80x73.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-up-220x200.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-up-110x100.png 110w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-up-165x150.png 165w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-up-261x238.png 261w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-up-456x415.png 456w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-up-535x487.png 535w, https://stackstorm.com/wp/wp-content/uploads/2018/05/vagrant-up-653x595.png 653w" sizes="(max-width: 894px) 100vw, 894px" />][4]

Many projects have similar pre-packaged Vagrant box that is used for evaluation and simplifies first experience so you don&#8217;t need to wait, install, configure anything and suffer if installation failed somewhere in the middle.

Let&#8217;s leave extensive configuration for [other production installers][5], &#8211; just give me working CLI `st2 action run`, now!

## OVA & Virtual Appliance

An alternative to Vagrant box is Virtual appliance which is available for download as `.OVA` image from the [StackStorm/packer-st2 Github Releases][6] page. It might be especially helpful for running in isolated from the internet air-gapped environments.

Only Virtualbox is available for Community edition, but [StackStorm Enterprise][7] has more, &#8211; just [Contact us][8].

> Warning! If by any chance you&#8217;re using OVA in production environment, don&#8217;t forget to change the default StackStorm login credentials and revise SSH authorized keys and password for `vagrant` linux user. 

## st2-integration-tests

We&#8217;ve put in the image a new goodie, &#8211; `st2-integration-tests`.

It&#8217;s a script that can perform StackStorm infrastructure/integration tests and report back with more detailed info about what and why things don&#8217;t work as expected. Tests are run at the infra/linux/configuration level. As an example, you&#8217;ll quickly be able to tell that MongoDB didn&#8217;t start, RabbitMQ is not listening on its port, or that there&#8217;s some misconfigured StackStorm or Linux user settings.

This can save time to avoid extensive troubleshooting steps, while you&#8217;re playing with StackStorm:

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/05/st2-integration-tests1.png" alt="StackStorm Vagrant integration tests" width="831" height="745" class="alignnone size-full wp-image-7794" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/05/st2-integration-tests1.png 831w, https://stackstorm.com/wp/wp-content/uploads/2018/05/st2-integration-tests1-150x134.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/05/st2-integration-tests1-300x269.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/05/st2-integration-tests1-768x689.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/05/st2-integration-tests1-80x72.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/05/st2-integration-tests1-220x197.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/05/st2-integration-tests1-112x100.png 112w, https://stackstorm.com/wp/wp-content/uploads/2018/05/st2-integration-tests1-167x150.png 167w, https://stackstorm.com/wp/wp-content/uploads/2018/05/st2-integration-tests1-265x238.png 265w, https://stackstorm.com/wp/wp-content/uploads/2018/05/st2-integration-tests1-463x415.png 463w, https://stackstorm.com/wp/wp-content/uploads/2018/05/st2-integration-tests1-543x487.png 543w, https://stackstorm.com/wp/wp-content/uploads/2018/05/st2-integration-tests1-664x595.png 664w" sizes="(max-width: 831px) 100vw, 831px" /> 

If something went wrong, &#8211; just run `st2-integration-tests`!  
Broke it completely? Just destroy the VM and try a new box again! (`vagrant destroy; vagrant up`)

## Bugs, Issues, Contributions

We are constantly striving to ensure that you have best experience.  
However, if you find something that doesn&#8217;t work, please let us know and we&#8217;ll be glad to take a look.  
We also love Pull Requests from the community at [StackStorm/packer-st2][4].

 [1]: https://github.com/warrenvw
 [2]: https://github.com/armab
 [3]: https://docs.stackstorm.com/install/vagrant.html
 [4]: https://github.com/StackStorm/packer-st2
 [5]: https://docs.stackstorm.com/install/index.html
 [6]: https://github.com/StackStorm/packer-st2/releases
 [7]: https://stackstorm.com/#product
 [8]: mailto:support@stackstorm.com