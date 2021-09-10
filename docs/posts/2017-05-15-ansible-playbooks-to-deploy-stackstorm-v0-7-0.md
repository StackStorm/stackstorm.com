---
title: 'Ansible playbooks to deploy StackStorm: BWC, ChatOps and more'
author: Eugen C.
type: post
date: 2017-05-15T19:19:14+00:00
url: /2017/05/15/ansible-playbooks-to-deploy-stackstorm-v0-7-0/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5820345321
tcb2_ready:
  - 1
categories:
  - Blog
  - Community
  - News
tags:
  - ansible
  - ansible-st2
  - configuration management
  - deployment
  - playbooks
  - release announcement

---
**May 15, 2017** _by Eugen C. (<a href="https://github.com/armab/" target="_blank" rel="noopener noreferrer">@armab</a>)_

<a href="https://github.com/StackStorm/ansible-st2" target="_blank" rel="noopener noreferrer"><img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/05/ansible-st2-v0.7-release_1.png" alt="Ansible Playbooks v0.7.0 to deploy StackStorm: bwc, st2chatops and more" width="800" height="478" class="alignnone size-full wp-image-6792" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/05/ansible-st2-v0.7-release_1.png 800w, https://stackstorm.com/wp/wp-content/uploads/2017/05/ansible-st2-v0.7-release_1-150x90.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/05/ansible-st2-v0.7-release_1-300x179.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/05/ansible-st2-v0.7-release_1-768x459.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/05/ansible-st2-v0.7-release_1-80x48.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/05/ansible-st2-v0.7-release_1-220x131.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/05/ansible-st2-v0.7-release_1-167x100.png 167w, https://stackstorm.com/wp/wp-content/uploads/2017/05/ansible-st2-v0.7-release_1-251x150.png 251w, https://stackstorm.com/wp/wp-content/uploads/2017/05/ansible-st2-v0.7-release_1-398x238.png 398w, https://stackstorm.com/wp/wp-content/uploads/2017/05/ansible-st2-v0.7-release_1-695x415.png 695w" sizes="(max-width: 800px) 100vw, 800px" /></a>

As you may know, previously we [announced][1] availability of Ansible production-friendly playbooks to install & configure StackStorm for cases when our demo `bash` installer wasn&#8217;t sufficient.

With the new release [github.com/StackStorm/ansible-st2][2] `v0.7.0` you can do even more!

This version includes new `bwc` and `st2chatops` roles, features like passing settings to `st2.conf`, enhancements to use custom SSL certificate for `st2web`, more documentation use-cases, some breaking changes and of course, bug fixes.

<!--more-->

### ChatOps {#chatops}

StackStorm ChatOps is rocking, but it wasn&#8217;t available as a playbook. Now you can configure ChatOps via Ansible with the new `st2chatops` role. Thanks to stormer [Anirudh Rekhi][3], you can do this:

<pre class="EnlighterJSRAW" data-enlighter-language="yaml">- name: Install st2chatops with "slack" hubot adapter
    role: st2chatops
    vars:
      st2chatops_version: latest
      st2chatops_hubot_adapter: slack
      st2chatops_config:
        HUBOT_SLACK_TOKEN: xoxb-CHANGE-ME-PLEASE
</pre>

^^ So slick!

### StackStorm Enterprise (BWC) {#stackstormenterprisebwc}

Our own [Lakshmi Kannan][4] has a serious case of [FOMO][5], and didn&#8217;t want to miss the fun others were having with Ansible. So he created a new `bwc` role.

Here is an example to customize [Brocade Workflow Composer][6] (BWC) with [LDAP][7] auth backend and [RBAC][8] configuration to allow/restrict/limit different StackStorm functionality to specific users.

That&#8217;s the power of StackStorm Enterprise:

<pre class="EnlighterJSRAW" data-enlighter-language="yaml">- name: Install StackStorm Enterprise
  hosts: all
  roles:
    - name: Install and configure StackStorm Enterprise (BWC)
      role: bwc
      vars:
        bwc_repo: enterprise
        bwc_license: CHANGE-ME-PLEASE
        bwc_version: latest
        # Configure LDAP backend
        # See: https://bwc-docs.brocade.com/authentication.html#ldap
        bwc_ldap:
          backend_kwargs:
            bind_dn: "cn=Administrator,cn=users,dc=change-you-org,dc=net"
            bind_password: "foobar123"
            base_ou: "dc=example,dc=net"
            group_dns:
              - "CN=stormers,OU=groups,DC=example,DC=net"
            host: identity.example.net
            port: 389
            id_attr: "samAccountName"
        # Configure RBAC
        # See: https://bwc-docs.brocade.com/rbac.html
        bwc_rbac:
          # Define BWC roles and permissions
          # https://bwc-docs.brocade.com/rbac.html#defining-roles-and-permission-grants
          roles:
            - name: core_local_only
              description: "This role has access only to action core.local in pack 'core'"
              enabled: true
              permission_grants:
                - resource_uid: "action:core:local"
                  permission_types:
                    - action_execute
                    - action_view
                - permission_types:
                  - runner_type_list
          # Assign roles to specific users
          # https://bwc-docs.brocade.com/rbac.html#defining-user-role-assignments
          assignments:
            - name: test_user
              roles:
                - core_local_only
            - name: stanley
              roles:
                - admin
            - name: chuck_norris
              roles:
                - system_admin
</pre>

Massive thing for our enterprise customers. Community users, you can request a trial license [here][9] and try it now!

### Configure `st2.conf` & `mistral.conf` settings {#configurest2confampmistralconfsettings}

With the new `st2_config` var it&#8217;s possible to adjust _any_ `st2.conf` configuration setting by passing a dict of values to the `st2` role, like this:

<pre class="EnlighterJSRAW" data-enlighter-language="yaml">- name: Install st2, configure with external MongoDB and RabbitMQ
    role: st2
    vars:
      # https://github.com/StackStorm/st2/blob/master/conf/st2.conf.sample
      st2_config:
        auth:
          enable: True
        database:
          host: st2-remote-mongo-node
          port: 27017
          db_name: st2
          username: st2
          password: random-password123
        messaging:
          url: amqp://st2:st2@st2-remote-rabbitmq-node:5672/
</pre>

The Mistral role var `st2mistral_config` works in the same way.

Super helpful long-waited feature!

This will be especially beneficial for those wanting to configure StackStorm with external services like `RabbitMQ`, `MongoDB`. We&#8217;ll focus on HA-friendly deployments more in next releases, see for example: [ansible-st2/issues/17][10].

### Custom certificate for st2web {#customcertificateforst2web}

By default we generate a self-signed certificate for `nginx` in `st2web` role. That&#8217;s good just to try it out, but doesn&#8217;t work well in real-world production deployments.

If you have a custom, signed SSL certificate, you can pass it now:

<pre class="EnlighterJSRAW" data-enlighter-language="yaml">- name: Configure st2web with custom certificate
    role: st2web
    vars:
      st2web_ssl_certificate: "{{ lookup('file', 'local/path/to/domain-name.crt') }}"
      st2web_ssl_certificate_key: "{{ lookup('file', 'local/path/to/domain-name.key') }}"
</pre>

One more step forward to production-friendly configurations.

### Installing behind a proxy {#installingbehindaproxy}

If you are installing from behind a proxy, you can use the environment variables `http_proxy`, `https_proxy`, and `no_proxy` in the playbook. They will be passed through during the execution.

Thanks [John Hogenmiller][11] for sharing his discoveries and providing the documentation example:

<pre class="EnlighterJSRAW" data-enlighter-language="yaml">---
- name: Install st2 behind a proxy
  hosts: all
  environment:
    http_proxy: http://proxy.example.net:8080
    https_proxy: https://proxy.example.net:8080
    no_proxy: 127.0.0.1,localhost
  roles:
    - st2
</pre>

### Community {#community}

I would like to additionally thank our power user [Hiroyasu OHYAMA][12] who contributed really nice feature requests and fixes for this release. Shout out to everyone in our growing [Slack community][13] for asking questions, helping others, committing Pull Requests.

If you are aware of using Ansible with StackStorm, here is the full [ansible-st2 v0.7.0 CHANGELOG][14].

 [1]: https://stackstorm.com/2017/02/02/introducing-ansible-playbooks-deploy-stackstorm/
 [2]: https://github.com/StackStorm/ansible-st2
 [3]: https://github.com/humblearner
 [4]: https://github.com/lakshmi-kannan/
 [5]: https://en.wikipedia.org/wiki/Fear_of_missing_out
 [6]: https://bwc-docs.brocade.com/
 [7]: https://bwc-docs.brocade.com/authentication.html#ldap
 [8]: https://bwc-docs.brocade.com/rbac.html
 [9]: https://stackstorm.com/#ewc
 [10]: https://github.com/StackStorm/ansible-st2/issues/17
 [11]: https://github.com/ytjohn
 [12]: https://github.com/userlocalhost
 [13]: https://stackstorm.com/community-signup
 [14]: https://github.com/StackStorm/ansible-st2/releases/tag/v0.7.0