---
title: 0.13 released! Time to upgrade!
author: st2admin
type: post
date: 2015-08-26T20:10:37+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/08/26/0-13-released-time-to-upgrade/
dsq_thread_id:
  - 4420594167
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home

---
**August 26, 2015**  
_by Lakshmi Kannan_

We are excited to announce another release of StackStorm. 0.13 comes with some great features, user contributions and many bug fixes. It&#8217;s definitely worth upgrading and the upgrade should be non-eventful. If you are trying us out for the first time, use the shiny [GUI installer][1]!

You can bring your own box or use [AWS AMI][2] or a <a href="https://solutionexchange.vmware.com/store/products/stackstorm#.Vd4oZ7xViko" target="_blank">VMware VMDK</a> or vagrant as the base box and kick off the (beta) installer after provisioning.

Please ask for support if you face issues!

Speaking of which, if you need help, a great place to get it is our [slack community][3]. If you haven&#8217;t registered yet, sign up [here][4].

If you are entering into production with StackStorm, we do have support and professional service options that most of our known production users are leveraging.  Sorry for the sales pitch, read more here: <http://stackstorm.com/services/>

<!--more-->

![configure_chatops][5] 

## User contributions

[Itxaka][6] added support for openstack authentication backend to StackStorm auth. Now you can use openstack authentication if you already have it installed with StackStorm. This gives you one more opportunity to try out StackStorm&#8217;s [openstack pack][7]. Thanks Itxaka!

## Highlights

0.13 brings you support for tracing. You can now add a trace tag to every execution request for manual executions or add a trace tag to a trigger dispatched from sensor. You can use the trace tag to then see what rules were fired and what executions were executed. This is a wonderful debugging tool and also improves the visibility of what&#8217;s happening inside StackStorm. This was a popular request from some of our advanced customers who want the ability to correlate external events to StackStorm events. Please try it out and let us know how you like it! [Docs][8] should get you started. We are open to feedback or comments.

We are moving away from fabric based SSH runner to a home grown SSH runner on top of Paramiko. Thanks to [libcloud][9] project and our own [Tomaz Muraus][10] for the initial implementation. This should address a lot of issues we were seeing with parallel execution of actions on multiple hosts. New SSH runner also would allow you to run SSH actions as a different user + credentials combo than the system user. The new runner is enabled by default and it should be exactly compatible with the previous generation SSH runner. Try it out and let us know how it works for you! You can also revert to the old runner by setting `use_paramiko_ssh_runner` to false in config.

Support for clustered rabbit mq is now available! This is also a popular request from our advanced customers who have a clustered rabbit mq setup already and want to use that with StackStorm. As a StackStorm user, you won&#8217;t have to make any changes in configuration.

We now have `X-Request-ID` tagging of API requests as a HTTP header. This will help debug API errors and track it in the logs using the ID (`grep {ID} /var/log/st2/st2api.log`). Look for that header in API responses.

We also added support to re-spawn sensors on failures or exceptions. Sensors could be hitting APIs of external services, process the results and inject triggers into StackStorm. Any sensor interacting with an external service or system could crash due to a multitude of reasons. If that happens, sensor process might die. Now those sensor processed will be re-spawned on crash or failure by sensor container a maximum of two times.

## Bug fixes

A lot of bug fixes went into the 0.13 release. Some critical bugs were fixed with API responses, sandboxed python environment path etc. Also, a potential security issue w.r.t injection of arbitrary code when supplying positional parameters for scripts was fixed. An upgrade is highly recommended.

We also have several additional features and plans coming up as we gear up for our 1.0 release later this year, including Role Based Access Control. Be sure to take a look at our [Roadmap][11] and stay subscribed to our [newsletter][12].

 [1]: http://docs.stackstorm.com/install/all_in_one.html
 [2]: https://aws.amazon.com/marketplace/pp/B014G0NHRM/?ref=_pntr_twitter
 [3]: https://stackstorm-community.slack.com/
 [4]: https://stackstorm.com/community-signup
 [5]: http://docs.stackstorm.com/_images/st2installer_step_3.png
 [6]: https://twitter.com/itxaka
 [7]: https://github.com/StackStorm/openstack
 [8]: http://docs.stackstorm.com/traces.html
 [9]: https://libcloud.apache.org/
 [10]: https://twitter.com/KamiSLO
 [11]: http://docs.stackstorm.com/roadmap.html
 [12]: http://stackstorm.com/subscribe-to-newsletter/