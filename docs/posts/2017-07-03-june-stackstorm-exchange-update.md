---
title: June StackStorm Exchange Update
author: st2admin
type: post
date: 2017-07-03T17:00:48+00:00
url: /2017/07/03/june-stackstorm-exchange-update/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5961248232
categories:
  - Community
tags:
  - automation

---
_July 3, 2017_  
_by Lindsay Hill_

Hey folks, just a quick roundup of happenings on the StackStorm Exchange for the month of June. New packs, updates to existing packs, and a reminder about changes to pack configuration.

<!--more-->

## First, the New Packs:

  * [Netbox][1] &#8211; DigitalOcean IPAM
  * [ActiveDirectory][2] &#8211; pretty much any action you’d like to run against Active Directory
  * [Microsoft Exchange][3] &#8211; send email, trigger events when email received, get calendar items

## Updates to Existing Packs

  * [Ansible][4] &#8211; JSON support in `extra_vars`.
  * [AWS][5] &#8211; ChatOps aliases, updates to the action generator scripts to handle new actions, and simplifications to the README. 
  * [CSV][6] & [XML][7] &#8211; new `parse_file` actions to simplify loading data from file.
  * [Email][8] pack &#8211; TLS is now optional. Of course you should use TLS, if you can. But if you insist, now you don’t have to use it.
  * [Jira][9] &#8211; in a similar vein to the above, you can now disable Jira SSL certificate validation, if you are so inclined.
  * [Kafka][10] &#8211; GCP Stackdriver support.
  * [Kubernetes][11] &#8211; fixes include payload validation, support for Kubernetes 1.5.

## Other Changes:

  * Many packs have updated to use action runner `python-script`, rather than `run-python`. No change in functionality, but it removes a deprecated runner alias, and standardises things. Consistency is good.
  * Don’t forget about the move to `config.schema.yaml`. If you have older pack versions using `config.yaml` files, you must migrate to the [new configuration style][12]. The old style will not work with the upcoming StackStorm 2.4.

Thinking about submitting a new pack? We’d love to see it! Just open a PR against [github.com/StackStorm-Exchange/exchange-incubator][13], and we’ll help you through the rest of it.

 [1]: https://github.com/StackStorm-Exchange/stackstorm-netbox
 [2]: https://github.com/StackStorm-Exchange/stackstorm-activedirectory
 [3]: https://github.com/StackStorm-Exchange/stackstorm-msexchange
 [4]: https://github.com/StackStorm-Exchange/stackstorm-ansible
 [5]: https://github.com/StackStorm-Exchange/stackstorm-aws
 [6]: https://github.com/StackStorm-Exchange/stackstorm-csv
 [7]: https://github.com/StackStorm-Exchange/stackstorm-xml
 [8]: https://github.com/StackStorm-Exchange/stackstorm-email
 [9]: https://github.com/StackStorm-Exchange/stackstorm-jira
 [10]: https://github.com/StackStorm-Exchange/stackstorm-kafka
 [11]: https://github.com/StackStorm-Exchange/stackstorm-kubernetes
 [12]: https://docs.stackstorm.com/reference/pack_configs.html
 [13]: https://github.com/StackStorm-Exchange/exchange-incubator