---
title: ST2 2.8.1 plus Exchange Pack Updates
author: st2admin
type: post
date: 2018-07-17T18:40:55+00:00
url: /2018/07/17/st2-exchange-pack-updates/
thrive_post_fonts:
  - '[]'
  - '[]'
  - '[]'
  - '[]'
  - '[]'
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6455183675
categories:
  - Community
  - News
tags:
  - Community
  - exchange

---
_July 17, 2018_  
_by Lindsay Hill_

Using packs from the [StackStorm Exchange][1]? Here&#8217;s a roundup of recent updates, including new packs for Algosec, Cisco ACI and AWS Boto3, along with fixes and updates for Slack, MySQL, Zabbix, RabbitMQ and more. We&#8217;ve also released StackStorm 2.8.1, with a few small fixes since 2.8. Details below:

<!--more-->

## StackStorm 2.8.1

We&#8217;ve fixed a few small issue in StackStorm since last week&#8217;s [2.8 release][2].

  * The `password:` parameter for the http_runner is now marked `secret: true`, so it will properly mask passwords in the logs. 
      * We&#8217;ve fixed an issue with `secret: true` not being properly applied to entire object/array parameters. 
          * Installing `st2client` using `pip`? It will now properly add all requirements, and this will stay in synch. 
              * Improved the `st2` for better auto-detection of terminal width, and a better default if auto-detection fails. </ul> 
                ## New Packs
                
                Three new packs this time around:
                
                  * [AWS Boto3][3]: Stripped-down AWS pack for running boto3 actions. 
                      * [Algosec][4]: Lets you work with [AlgoSec][5] products including Firewall Analyzer and FireFlow. 
                          * [Cisco ACI][6]: Actions for working with [Cisco&#8217;s Application Centric Infrastructure][7]. 
                              * [StackStorm-Backups][8]: Inception-style actions for backing up the StackStorm databases. </ul> 
                                ## Updates and Fixes
                                
                                Lots of smaller updates &#8211; new actions, bugfixes, etc.
                                
                                  * [Consul][9]: Fixes for the &#8220;agent\_service\_register&#8221; action. 
                                      * [Terraform][10]: The &#8220;apply&#8221; action now automatically approves changes. 
                                          * [MySQL][11]: New UPDATE action, and Unicode fixes. 
                                              * [Slack][12]: The &#8220;files.upload&#8221; action now uses POST. 
                                                  * [Cloudflare][13]: We&#8217;ve finally switched to the python-cloudflare library, and added actions. 
                                                      * [Twitter][14]: Want to upload a picture with that automated Tweet? Now you can. 
                                                          * [Zabbix][15]: New actions for handling hosts with multiple IDs. 
                                                              * [EXOS][16]: You can now send multiple commands at once. 
                                                                  * [RabbitMQ][17]: We&#8217;ve updated the underlying pika library. 
                                                                      * [Email][18]: Small fixes for better Unicode handling. </ul> 
                                                                        If you&#8217;re using any of the above packs, we recommend updating.
                                                                        
                                                                        Thanks to all those who contributed.

 [1]: https://exchange.stackstorm.org
 [2]: https://stackstorm.com/2018/07/10/stackstorm-2-8-ui-changes-new-workflow-engine-and-more/
 [3]: https://github.com/StackStorm-Exchange/stackstorm-aws_boto3
 [4]: https://github.com/StackStorm-Exchange/stackstorm-algosec
 [5]: https://www.algosec.com/
 [6]: https://github.com/StackStorm-Exchange/stackstorm-cisco_aci
 [7]: https://www.cisco.com/c/en/us/solutions/data-center-virtualization/application-centric-infrastructure/index.html
 [8]: https://github.com/StackStorm-Exchange/stackstorm-backups
 [9]: https://github.com/StackStorm-Exchange/stackstorm-consul
 [10]: https://github.com/StackStorm-Exchange/stackstorm-terraform
 [11]: https://github.com/StackStorm-Exchange/stackstorm-mysql
 [12]: https://github.com/StackStorm-Exchange/stackstorm-slack
 [13]: https://github.com/StackStorm-Exchange/stackstorm-cloudflare
 [14]: https://github.com/StackStorm-Exchange/stackstorm-twitter
 [15]: https://github.com/StackStorm-Exchange/stackstorm-zabbix
 [16]: https://github.com/StackStorm-Exchange/stackstorm-exos
 [17]: https://github.com/StackStorm-Exchange/stackstorm-rabbitmq
 [18]: https://github.com/StackStorm-Exchange/stackstorm-email