---
title: 'New In StackStorm: Ansible Integration'
author: st2admin
type: post
date: 2015-06-05T17:28:33+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/06/05/new-in-stackstorm-ansible-integration/
dsq_thread_id:
  - 3824213376
tcb2_ready:
  - 1
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home
tags:
  - ansible

---
**June 5, 2015**

_Contribution by Integration Developer Eugen C._

We’re always happy when the number of integrations to StackStorm increases, creating bridges between more DevOps tools and extending possible use cases.  Our IFTTT for Ops approach &#8211; or Event Driven Automation &#8211; becomes more valuable the more ways to control and listen to your environment come pre-integrated, “batteries included.”

Recently, an <a href="https://github.com/StackStorm-Exchange/stackstorm-ansible" target="_blank">Ansible integration pack</a> was added to StackStorm Exchange, giving users the possibility to use Ansible as an underlying remote change and configuration management tool in conjunction with StackStorm.

There are approaches <a href="http://stackstorm.com/" target="_blank">StackStorm</a> and <a href="http://ansible.com/" target="_blank">Ansible</a> have in common:

<!--more-->

  * Declarative way of doing things
  * Python, YAML files, Jinja templating engine
  * Easiness, low entry point for non-complex solutions
  * Flexibility when you need more

So if you like Ansible and find yourself in need of overall event driven automation to wire the environment together, you&#8217;ll definitely like StackStorm too!

## **Vagrant Demo**

<img loading="lazy" class="aligncenter size-full wp-image-3493" src="http://stackstorm.com/wp/wp-content/uploads/2015/06/vagrant.png" alt="vagrant" width="975" height="798" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/06/vagrant.png 975w, https://stackstorm.com/wp/wp-content/uploads/2015/06/vagrant-300x246.png 300w" sizes="(max-width: 975px) 100vw, 975px" /> 

For those who are interested in seeing some real commands, here is a Vagrant demo with 3 VMs that shows st2 Ansible pack work on simple examples: <a href="https://github.com/StackStorm/st2-ansible-vagrant" target="_blank">https://github.com/StackStorm/st2-ansible-vagrant</a>

It will get you up and running with master VM with all St2 components, as well as Ansible pack. Additionally, it takes up two clean Ubuntu VMs: **node1**, **node2** and performs Ansible commands against them:

  * <a href="https://github.com/armab/st2-chatops-ansible-vagrant/blob/master/ansible.sh" target="_blank">Run simple ad-hoc commands</a>
  * <a href="https://github.com/armab/st2-chatops-ansible-vagrant/blob/master/ansible-playbook.sh" target="_blank">Install nginx via playbook on 2 nodes</a>
  * <a href="https://github.com/armab/st2-chatops-ansible-vagrant/blob/master/ansible-vault.sh" target="_blank">Encrypt/decrypts files with ansible-vault</a>
  * <a href="https://github.com/armab/st2-chatops-ansible-vagrant/blob/master/ansible-galaxy.sh" target="_blank">Download roles from ansible-galaxy</a>

To get started:

    git clone https://github.com/StackStorm/st2-ansible-vagrant.git
    cd st2-ansible-vagrant
    vagrant up
    

<img loading="lazy" class="aligncenter size-full wp-image-3503" src="http://stackstorm.com/wp/wp-content/uploads/2015/06/687474703a2f2f692e696d6775722e636f6d2f7a63347376674a2e676966.gif" alt="687474703a2f2f692e696d6775722e636f6d2f7a63347376674a2e676966" width="849" height="662" /> 

## 

## **More On StackStorm With Ansible**

In the next week or so, we&#8217;ll show how to play with ChatOps &#8211; how to run Ansible from Slack chat via StackStorm ChatOps so these commands are in the context both of your overall automation and in the context of your users who are living in Slack presumably.  We will also introduce you to more complex real world workflows. Stay updated by subscribing to the <a href="http://feedburner.google.com/fb/a/mailverify?uri=StackstormBlog&loc=en_US" target="_blank">StackStorm blog</a> or <a href="http://stackstorm.com/subscribe-to-newsletter/" target="_blank">newsletter</a>.  You can also follow us on twitter (<a href="https://twitter.com/Stack_Storm" target="_blank">@Stack_Storm</a>) or see us at <a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">#stackstorm on Freenode</a>.

&nbsp;