---
title: StackStorm Enterprise is Back!
author: st2admin
type: post
date: 2016-09-01T19:15:29+00:00
url: /2016/09/01/stackstorm-enterprise-back/
dsq_thread_id:
  - 5112316095
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Blog
  - News
tags:
  - release
  - release announcement

---
**September 1, 2016**  
_by Lindsay Hill_

StackStorm Enterprise is back, and it’s now **Brocade Workflow Composer**. We’ve just shipped version 2.0. The platform has had a look & feel update, the usual round of bugfixes and enhancements, and we’re introducing “Network Automation Suites” for our networking friends. More on those in a minute.

<div style="width: 510px" class="wp-caption aligncenter">
  <img loading="lazy" src="http://68.media.tumblr.com/68eac6bac2bdf867be35c5c47a1838ac/tumblr_mzz6cfLpLU1rzik3go1_500.gif" width="500" height="247" alt="Did you miss me?" class="size-full" />
  
  <p class="wp-caption-text">
    Did you miss me?
  </p>
</div>

We know that you’ve been asking about the future of StackStorm, where the project is going, when you can buy StackStorm Enterprise again, etc. Well, today we should be able to answer all of those questions.  
<!--more-->

Our [community][1] members will have noticed we’ve been a bit quiet recently. That’s because we’ve been working super-hard on getting this release out the door. There’s a lot of work going on under the hood to make it possible, so we’re pretty happy to see it shipped.

## New Colors, New Names and and the Return of Enterprise

<del>StackStorm Enterprise</del> is now Brocade Workflow Composer (BWC). What was known as StackStorm Community Edition is now just StackStorm. That will remain Open Source. The key differences are that BWC includes <del>Flow</del>Workflow Designer, Professional Support, and now Network Automation Suites.

We’ve updated the colors for StackStorm, and we’ve “Brocade-ised” the colors for the BWC web interface. Here’s a sample of the new look &#8211; what do you think?

<p style="text-align: center;">
  <img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2016/09/WebUI-ST2.png" alt="WebUI-ST2" width="1168" height="549" class="aligncenter size-full wp-image-6026" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/09/WebUI-ST2.png 1168w, https://stackstorm.com/wp/wp-content/uploads/2016/09/WebUI-ST2-300x141.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/09/WebUI-ST2-768x361.png 768w, https://stackstorm.com/wp/wp-content/uploads/2016/09/WebUI-ST2-1024x481.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2016/09/WebUI-ST2-1080x508.png 1080w" sizes="(max-width: 1168px) 100vw, 1168px" />StackStorm Web Interface
</p>

<p style="text-align: center;">
  <img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2016/09/WebUI-BWC.png" alt="BWC Web Interface" width="1168" height="556" class="aligncenter size-full wp-image-6027" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/09/WebUI-BWC.png 1168w, https://stackstorm.com/wp/wp-content/uploads/2016/09/WebUI-BWC-300x143.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/09/WebUI-BWC-768x366.png 768w, https://stackstorm.com/wp/wp-content/uploads/2016/09/WebUI-BWC-1024x487.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2016/09/WebUI-BWC-1080x514.png 1080w" sizes="(max-width: 1168px) 100vw, 1168px" /> BWC Web Interface
</p>

“Flow” has a new name, and a new look &#8211; it’s now “Workflow Designer”:

<p style="text-align: center;">
  <img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2016/09/workflow-designer.png" alt="workflow-designer" width="1352" height="818" class="aligncenter size-full wp-image-6025" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/09/workflow-designer.png 1352w, https://stackstorm.com/wp/wp-content/uploads/2016/09/workflow-designer-300x182.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/09/workflow-designer-768x465.png 768w, https://stackstorm.com/wp/wp-content/uploads/2016/09/workflow-designer-1024x620.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2016/09/workflow-designer-1080x653.png 1080w" sizes="(max-width: 1352px) 100vw, 1352px" /> Workflow Designer
</p>

The BWC docs have a different home to the StackStorm docs. The StackStorm documentation remains at [docs.stackstorm.com][2]. The BWC docs include BWC-specific information, including details about the Network Automation Suites. They&#8217;re at [bwc-docs.brocade.com][3], and yes, they too have a new look and feel:  
<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2016/09/BWC-Docs.png" alt="BWC Docs" width="800" height="374" class="wp-image-6002 size-full" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/09/BWC-Docs.png 800w, https://stackstorm.com/wp/wp-content/uploads/2016/09/BWC-Docs-300x140.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/09/BWC-Docs-768x359.png 768w" sizes="(max-width: 800px) 100vw, 800px" /> 

BWC is an add-on set of packages on top of StackStorm. To install it, you’ll need a license key. You can quickly get an evaluation key at [stackstorm.com/#ewc][4], or if you prefer, at [Brocade BWC page][5]. Then you just need to follow the [BWC installation instructions][6]. BWC is available for purchase through Brocade and its partners. Thanks to those of you who have put up with us rolling over trial licenses over the last few months.

## Network Automation Suites

We’re introducing the concept of “Automation Suites” with this release. These are additional packages installed on top of the BWC platform, that address a specific network automation use-case. The first Automation Suite we’re releasing now is the “IP Fabric Automation Suite.” This targets Brocade IP Fabrics, providing integration packs and additional services needed to provision and manage IP Fabrics. It’s more than just a traditional StackStorm integration pack &#8211; it provides things like an inventory service, and additional set of CLI commands.

We think this is a really good concept &#8211; by separating the platform from the specific vertical use-case, the platform remains “pure” and can be used by anyone, but we have a way of deploying the integrations and services needed for a specific use-case. You can use BWC without needing to install the networking components.

Expect to see additions to this suite, and new suites, over the coming months. We also think this approach could be used by other people who want to use BWC as an automation platform for other environments. We learnt a lot in making these changes, so get in touch if you want to hear more about it.

## It’s not just Re-Branding

We didn’t just change the colors and logos. We’re continuing to make StackStorm better, and we won’t be stopping any time soon. Here’s some of the stuff we’ve done since v1.6:

### Platform Improvements

  * Upgrade pip and virtualenv libraries used by StackStorm pack virtual environments to the latest versions (8.1.2 and 15.0.3)
  * Jinja filter changes, including new custom functions `to_json_string`, `to_yaml_string` and `to_human_time_from_seconds`
  * ChatOps response includes execution time by default
  * Allow users to cancel multiple executions with a single `st2 execution cancel` command
  * `st2ctl reload` now runs &#8211;register-rules
  * `packs.load` default timeout is now 100s
  * `packs.uninstall` will now warn you if there any rules referencing the pack being uninstalled
  * Python runner actions and sensors will still load even if the module name clashes with another module in PYTHONPATH

### Bugfixes

  * Fix validation of action parameter type attribute. Previously we allowed registration of any string value, and it would fail when executed. Now it will fail at registration.
  * Fixed bug when Jinja templates with filters in parameters weren’t rendered correctly.
  * Fixed disabling and enabling of sensor through API and CLI
  * Fixed HTTP runner so it works with newer versions of requests library (>= 2.11.0)

Thanks to everyone who contributed with bug reports and code.

Full details are, as always, in the [Changelog][7]

## Getting v2.0

New packages are now in the `stable` repositories. If you’re already running StackStorm > v1.4, you can upgrade using `yum` or `apt`.

> As always, we strongly recommend that you treat your automation code as true code &#8211; use source control systems, use configuration management systems. You break it, you get to keep the pieces. 

## The Future

Getting our first “Brocade” release out the door was a major milestone. We had to figure out a few things to get Brocade and StackStorm systems aligned. Now we’ve done that, it’s full steam ahead. More/better/faster releases coming!

 [1]: http://stackstorm.com/community-signup
 [2]: https://docs.stackstorm.com/
 [3]: https://bwc-docs.brocade.com/
 [4]: https://stackstorm.com/#ewc
 [5]: https://brocade.com/bwc
 [6]: https://docs.stackstorm.com/install/bwc.html
 [7]: https://docs.stackstorm.com/changelog.html