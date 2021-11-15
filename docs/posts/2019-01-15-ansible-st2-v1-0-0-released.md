---
title: Ansible StackStorm role v1.0.0 released
author: Eugen C.
type: post
date: 2019-01-15T09:29:24+00:00
url: /2019/01/15/ansible-st2-v1-0-0-released/
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - News
tags:
  - announcement
  - ansible
  - ansible-st2
  - configuration management
  - release

---
**Jan 15, 2019**  
_By [Eugen C. (@armab)][1]_

We&#8217;re very excited to announce that Ansible roles to deploy StackStorm have been promoted to major version `1.0.0`!

<center>
  <figure class="wp-block-image"><a href="https://galaxy.ansible.com/StackStorm/stackstorm/" target="_blank"><img loading="lazy" width="800" height="478" src="https://stackstorm.com/wp/wp-content/uploads/2019/01/ansible-stackstorm_v1.0.png" alt="" class="wp-image-8659" srcset="https://stackstorm.com/wp/wp-content/uploads/2019/01/ansible-stackstorm_v1.0.png 800w, https://stackstorm.com/wp/wp-content/uploads/2019/01/ansible-stackstorm_v1.0-150x90.png 150w, https://stackstorm.com/wp/wp-content/uploads/2019/01/ansible-stackstorm_v1.0-300x179.png 300w, https://stackstorm.com/wp/wp-content/uploads/2019/01/ansible-stackstorm_v1.0-768x459.png 768w, https://stackstorm.com/wp/wp-content/uploads/2019/01/ansible-stackstorm_v1.0-80x48.png 80w, https://stackstorm.com/wp/wp-content/uploads/2019/01/ansible-stackstorm_v1.0-220x131.png 220w, https://stackstorm.com/wp/wp-content/uploads/2019/01/ansible-stackstorm_v1.0-167x100.png 167w, https://stackstorm.com/wp/wp-content/uploads/2019/01/ansible-stackstorm_v1.0-251x150.png 251w, https://stackstorm.com/wp/wp-content/uploads/2019/01/ansible-stackstorm_v1.0-398x238.png 398w, https://stackstorm.com/wp/wp-content/uploads/2019/01/ansible-stackstorm_v1.0-695x415.png 695w" sizes="(max-width: 800px) 100vw, 800px" /></a></figure>
</center>

<!--more-->

Surprisingly, `1.0.0` is not too much about announcing role stability, &#8211; the repository <a rel="noreferrer noopener" aria-label="stackstorm/ansible-st2 (opens in a new tab)" href="https://github.com/stackstorm/ansible-st2" target="_blank">stackstorm/ansible-st2</a> was actively maintained for more than `3` years and there is no reason to say that Ansible deployment is not stable yet. Because it already had more than `30` releases, this time there were no versions left for a major change and so finally `v1.0.0` was shipped. A great chance to celebrate this big milestone! 🎉

With over `55+` Github stars, `150+` pull requests and `700+` commits from `25` contributors we want to thank our community for their support: reporting bugs, generating ideas as well as submitting pull requests. It wouldn&#8217;t be possible without you, our users! With over `100K` Ansible Galaxy downloads, `ansible-st2` became one of the most popular and discussed production-ready StackStorm deployments.

What&#8217;s changed? In recent releases there was a lot of ongoing maintenance related to StackStorm version to version differences: nodejs `6` -> `8` version update for `st2chatops` role, support for new st2 services like `st2workflowengine` , `st2timersengine`, `st2scheduler`, fixes, improvements and more. 

There are some more user-facing changes in v1.0.0: minimum required Ansible version was bumped to `v2.5` that led to some unavoidable syntax changes, &#8211; as you may know Ansible `v2.4` reached end of its life and officially unsupported. Besides that, the `BWC` sub-role which installs and configures StackStorm Enterprise offering was renamed to `EWC`, &#8211; don&#8217;t forget to update role references in your plays if you&#8217;re using Enterprise. If not, &#8211; it&#8217;s time to <a rel="noreferrer noopener" href="https://stackstorm.com/features/" target="_blank">Try StackStorm Enterprise with a free 90-day trial</a>.

<blockquote class="wp-block-quote">
  <p>
    Not an Ansible user?<br />Check out other methods to deploy StackStorm: <a rel="noreferrer noopener" aria-label="Puppet (opens in a new tab)" href="https://docs.stackstorm.com/install/puppet.html" target="_blank">Puppet</a>, <a href="https://github.com/stackstorm/chef-stackstorm" target="_blank" rel="noreferrer noopener" aria-label="Chef (opens in a new tab)">Chef</a>, <a rel="noreferrer noopener" aria-label="Docker (opens in a new tab)" href="https://docs.stackstorm.com/install/docker.html" target="_blank">Docker</a>, <a rel="noreferrer noopener" aria-label="Kubernetes / HA (opens in a new tab)" href="https://docs.stackstorm.com/install/k8s_ha.html" target="_blank">Kubernetes / HA</a>, <a rel="noreferrer noopener" aria-label="Vagrant / OVA (opens in a new tab)" href="https://docs.stackstorm.com/install/vagrant.html" target="_blank">Vagrant / OVA</a>.
  </p>
</blockquote>

As usual, you can download it all at Ansible Galaxy: <a rel="noreferrer noopener" aria-label="galaxy.ansible.com/StackStorm/stackstorm/ (opens in a new tab)" href="https://galaxy.ansible.com/StackStorm/stackstorm/" target="_blank">galaxy.ansible.com/StackStorm/stackstorm/</a> and find source code as Github repository: <a rel="noreferrer noopener" aria-label="github.com/stackstorm/ansible-st2 (opens in a new tab)" href="https://github.com/stackstorm/ansible-st2" target="_blank">github.com/stackstorm/ansible-st2</a>. We recommend to pin the role to specific version in your infrastructure to avoid sudden surprises. Read more about evolution of `ansible-st2` role in <a rel="noreferrer noopener" href="https://github.com/StackStorm/ansible-st2/releases" target="_blank">Releases Changelog</a>.

That&#8217;s all,  
Happy Automating!

 [1]: https://github.com/armab