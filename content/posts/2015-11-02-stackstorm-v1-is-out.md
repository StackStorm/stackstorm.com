---
title: StackStorm v1 is out!
author: Dmitri Zimine
type: post
date: 2015-11-03T01:55:30+00:00
url: /2015/11/02/stackstorm-v1-is-out/
dsq_thread_id:
  - 4401171508
thrive_post_fonts:
  - '[]'
categories:
  - Blog

---
**November 02, 2015**  
_by Dmitri Zimnie_

<img loading="lazy" width="1318" height="457" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-v1-rules.png" alt="stackstorm-v1-rules"class="alignnone wp-image-4701" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-v1-rules.png 1318w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-v1-rules-300x104.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-v1-rules-1024x355.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-v1-rules-1080x374.png 1080w" sizes="(max-width: 1318px) 100vw, 1318px" /> 

A new release of StackStorm is out&#8230;. and (&#8230;drums&#8230;) it is version 1.1!

Yes, this is a major release. The product has really come together, so we decided to name it &#8220;version 1&#8221;. In his recent [Hello World blog][1] Evan Powell shared the learnings over two years that become foundation of StackStorm and made it a distinct product. Here I will go over specific feature highlights of version 1, touch on migration path from earlier versions, and point out to StackStorm’s future directions.

<!--more-->

## Highlights

Version 1 comes in two editions &#8211; Community and Enterprise. They share a common codebase; &#8220;Community&#8221; is full-featured, production-ready, Apache 2.0, and free forever. &#8220;Enterprise&#8221; brings commercial support and additional tools to improve productivity at scale.

StackStorm v1 introduces a few new exciting features as well as accumulated improvements based on your feedback and extensive field usage. For the complete list, see [Changelog][2].

  * Installation and deployment: The new [All-in-One installer][3] brings a secure, reliable, best-practice reference deployment on a single box. Interactive graphical setup (or answer file for unattended installation) to configure users, SSL certificates, wire up a chat system for ChatOps and so on. If an Enterprise license is supplied, the installer deploys Enterprise additions, too. 
    Behind the All-In-One installer, there are [puppet modules][4] to use directly for your custom deployments, and [st2workroom][5] to build StackStorm into a variety of form-factors. In addition to Ubuntu 14, we introduce support to RHEL 6 and 7.

  * Flow v1 &#8211; an innovative visual workflow designer. Flow is unique: unlike every other workflow designer, Flow doesn&#8217;t hide the code: it highlights it as part of our support for infrastructure as code. It helps you navigate, understand, and learn the workflow definition YAML with appealing visual representation, and makes you more productive building workflow structure with drag-and-drop WYSWIG functionality. It is worth giving a try on your side; it is also worth a dedicated blog on us (coming up).

  * Security: RBAC and StackStorm-supported LDAP integration are essential enterprise features. There is more: pluggable auth backends with solid PAM, Keystone and other auth providers; &#8216;Secrets&#8217; in metadata, which prevent flashing parameters in logs and API; and API keys, especially handy for webhooks.

  * ChatOps: with StackStorm, ChatOps is turn-key, much improved and maturing based on massive feedback from the community. Even those still cautious about closed loop automation and auto-remediation find it very appealing to be able to take their existing scripts, plus StackStorm community actions including Ansible, Salt, Chef or Puppet integrations, turn them at will into bot-friendly ChatOps commands with few lines of meta data. These ChatOps users then get the workflows, APIs, execution history and everything else of StackStorm as a bonus &#8211; we see them growing over time into more powerful users.

## Migrating to v1

The recommended way to migrate to v1 is to provision a new StackStorm instance with All-In-One installer, and to roll over the content. Copy your content from `/opt/stackstorm/packs` to the new v1 server. If you&#8217;re doing it right, your content should already be under source control. Adjust content according to [upgrade notes][6]. Test, make sure everything works. To keep your previous history for audit purpose, save the `/var/log/st2/*.audit.*` files.

The old [scripted installer][7] aka st2_deploy.sh is still supported, and it will likely get you upgraded. However we seriously encourage you to switch to the all-in-one installer. Or for serious production, [puppet][8], [chef][9], or [ansible][10] yourself a custom deployment of v1.

## What&#8217;s next:

StackStorm continues to rapidly evolve. Our next focus is around productizing techniques to runat scale, refining content management, debuggability of sensors and triggers, completing the mission of making StackStorm easy to deploy. We are thinking of introducing StackStorm Forge to get together even more of the hundreds of integration packs spread all over github. We want to help the community share and exchange operational patterns as code blueprints. The detailed [roadmap is here][11], and your input is welcome.

Get v1, install, use, enjoy. Take the Flow for a ride. Give us feedback. And stay engaged on [stackstorm-community.slack.com][12] (if you&#8217;re not there yet, [join][13]), or IRC **#stackstorm** on freenode.org.

 [1]: https://stackstorm.com/2015/10/28/hello-world-stackstorm-is-ga-1-1-shipping/
 [2]: http://docs.stackstorm.com/changelog.html
 [3]: http://docs.stackstorm.com/install/all_in_one.html
 [4]: https://github.com/StackStorm/puppet-st2
 [5]: https://github.com/StackStorm/st2workroom
 [6]: http://docs.stackstorm.com/upgrade_notes.html
 [7]: http://docs.stackstorm.com/install/st2_deploy.html
 [8]: http://docs.stackstorm.com/install/puppet.html
 [9]: https://supermarket.chef.io/cookbooks/stackstorm/versions/0.1.0
 [10]: http://docs.stackstorm.com/install/ansible.html
 [11]: http://docs.stackstorm.com/roadmap.html
 [12]: https://stackstorm-community.slack.com
 [13]: https://stackstorm.com/community-signup