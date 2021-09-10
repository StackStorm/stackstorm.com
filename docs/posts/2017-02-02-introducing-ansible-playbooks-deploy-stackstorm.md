---
title: Introducing Ansible playbooks to deploy StackStorm
author: Eugen C.
type: post
date: 2017-02-02T19:16:27+00:00
excerpt: |
  <strong>Februrary 3, 2017</strong>
  <em>by Eugen C. (<a href="https://github.com/armab/" target="_blank">@armab</a>)</em>
  
  <a href="https://stackstorm.com/2017/02/02/introducing-ansible-playbooks-deploy-stackstorm/"><img src="https://stackstorm.com/wp/wp-content/uploads/2017/02/ansible-st2-v0.6.0-release.png" alt="Ansible playbooks to deploy stackstorm v0.6.0" width="800" height="478" class="alignnone size-full wp-image-6562" /></a>
  
  Did you know we have Ansible playbooks to deploy StackStorm?
  It's something that was in a shadow for a while.
  
  <a href="https://github.com/StackStorm/ansible-st2">github.com/StackStorm/ansible-st2</a>
  
  Here, now you know!
url: /2017/02/02/introducing-ansible-playbooks-deploy-stackstorm/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5516284843
categories:
  - Blog
  - Community
  - News
tags:
  - ansible
  - configuration management
  - playbooks
  - release

---
**Feb 2, 2017** _by Eugen C. (<a href="https://github.com/armab/" target="_blank">@armab</a>)_  
[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/02/ansible-stackstorm1.png" alt="Ansible playbooks to deploy StackStorm" width="975" height="205" class="alignnone size-full wp-image-6573" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/02/ansible-stackstorm1.png 975w, https://stackstorm.com/wp/wp-content/uploads/2017/02/ansible-stackstorm1-150x32.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/02/ansible-stackstorm1-300x63.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/02/ansible-stackstorm1-768x161.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/02/ansible-stackstorm1-80x17.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/02/ansible-stackstorm1-220x46.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/02/ansible-stackstorm1-250x53.png 250w, https://stackstorm.com/wp/wp-content/uploads/2017/02/ansible-stackstorm1-280x59.png 280w, https://stackstorm.com/wp/wp-content/uploads/2017/02/ansible-stackstorm1-510x107.png 510w, https://stackstorm.com/wp/wp-content/uploads/2017/02/ansible-stackstorm1-750x158.png 750w" sizes="(max-width: 975px) 100vw, 975px" />][1]

Did you know we have Ansible playbooks to deploy StackStorm?  
It&#8217;s something we&#8217;ve been working on quietly for a while:

[github.com/StackStorm/ansible-st2][2]

Well, now you know!

<!--more-->

In spite of this &#8220;secrecy&#8221;, some people used it and even actively contributed. For example our friends from [Arteria Project][3].

### ansible-st2 v0.6.0 released

But there is more good news! Recently we released a big update to `ansible-st2`. In addition to the existing Ubuntu `Trusty` and `Xenial` support, we&#8217;ve added new platforms: `RHEL6/CentOS6`, `RHEL7/CentOS7`. Lots more too: new features, bugfixes, CI improvements like running a play in Docker with Test-Kitchen and Travis across all 4 platforms, idempotence, a lot of end-to-end testing and polishing.

So you can deploy StackStorm with Ansible, even on a real `RHEL` now!

[![Ansible Playbooks to deploy StackStorm v0.6.0 released][4]][2]

Looks like a lot of activity for a single version release in Ansible playbooks repo, isn&#8217;t it?  
Thanks to our own [Anirudh Rekhi][5] and [Matt Oswalt][6] for making it possible!

Being confident about the quality now, we reference Ansible Playbooks as an additional installation method in our docs, check out: [docs.stackstorm.com/install/ansible.html][7]

If you are aware of using Ansible with StackStorm, here is the full [v0.6.0 CHANGELOG][8].

### Quick Install

So if you&#8217;re tired of our [`curl | bash`][9] installer (which is for demonstration purposes) and missing real idempotence and production-friendly deployment and configuration, here are basic instructions to get started:

<pre><code class="sh">git clone https://github.com/StackStorm/ansible-st2.git

ansible-playbook stackstorm.yml
</code></pre>

Behind the scenes the `stackstorm.yml` play is composed of the following roles for a complete installation:  
&#8211; `epel` &#8211; Repository with extra packages for `RHEL/CentOS`.  
&#8211; `mongodb` &#8211; Main DB storage engine for StackStorm.  
&#8211; `rabbitmq` &#8211; Message broker for StackStorm.  
&#8211; `postgresql` &#8211; Main DB storage engine for StackStorm Mistral.  
&#8211; `st2repos` &#8211; Adds StackStorm PackageCloud repositories.  
&#8211; `st2` &#8211; Install and configure StackStorm itself.  
&#8211; `st2mistral` &#8211; Install and configure StackStorm Mistral workflow engine.  
&#8211; `nginx` &#8211; Dependency for `st2web`.  
&#8211; `st2web` &#8211; Nice & shiny WebUI for StackStorm.  
&#8211; `st2smoketests` &#8211; Simple checks to know if StackStorm really works.

For more detailed configuration, please refer to [GitHub repository][10] with a full list of `vars`.

### Community

If you need more, &#8211; please feel free to submit your Pull Requests and remember that our users and contributors are those who make biggest impact on StackStorm, so your involvement or opinion is very important!

Keep an eye on [StackStorm/ansible-st2][2] for more improvements. In future updates you&#8217;ll see `st2chatops`, more options and vars for Custom Installations, Integration tests and eventually we&#8217;ll publish everything on Ansible Galaxy.

 [1]: https://stackstorm.com/2017/02/02/introducing-ansible-playbooks-deploy-stackstorm/
 [2]: https://github.com/StackStorm/ansible-st2
 [3]: http://arteria-project.github.io/
 [4]: https://stackstorm.com/wp/wp-content/uploads/2017/02/ansible-st2-v0.6.0-release.png
 [5]: https://github.com/humblearner
 [6]: https://github.com/mierdin/
 [7]: https://docs.stackstorm.com/install/ansible.html
 [8]: https://github.com/StackStorm/ansible-st2/releases/tag/v0.6.0
 [9]: https://docs.stackstorm.com/install/index.html
 [10]: https://github.com/stackstorm/ansible-st2#variables