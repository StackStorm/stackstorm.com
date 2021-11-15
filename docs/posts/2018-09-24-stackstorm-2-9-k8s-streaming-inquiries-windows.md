---
title: 'StackStorm 2.9: K8s, Streaming, Inquiries, Windows'
author: st2admin
type: post
date: 2018-09-24T17:00:12+00:00
url: /2018/09/24/stackstorm-2-9-k8s-streaming-inquiries-windows/
thrive_post_fonts:
  - '[]'
categories:
  - Community
  - News
tags:
  - release
  - release announcement

---
**Sep 25, 2018**  
_By Lindsay Hill_

New Streaming & Inquiries Apps in the Web UI, Orquesta second beta, Helm Chart for running StackStorm in HA mode on Kubernetes, new Windows runners, and plenty of fixes and improvements: StackStorm 2.9 is ready to go! Here’s all the details:

<!--more-->

## Web UI &#8211; Streaming Output, Inquiries

In StackStorm 2.5 we added support for [real-time streaming output][1] for long-running actions. But it only worked via CLI or API. We’ve made it a lot easier: you can see it in the Web UI!

Here’s how to use it:

First launch a long-running command that produces output:

`st2 run core.local cmd="i=0;while [[ $i -lt 10 ]]; do echo $(date); i=$[$i+1];sleep 10; done" timeout=220`

Not very exciting, but that will display the date every 10s.

Then go to the History tab in the Web UI, and find your action. Click on that, and look at the right-hand side:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/09/live_output.png" alt="" width="400" height="913" class="aligncenter size-full wp-image-8211" />][2]

See that new “check live output” link? Click on that, and you’ll see this:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/09/example_live_output.png" alt="" width="600" height="484" class="aligncenter size-full wp-image-8212" />][3]

That will keep updating until the action finishes.

Nifty eh?

In 2.5 we also added [Inquiries][4], but again, it was only available via CLI and API. Now check out the new “Inquiries” tab in the Web UI:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/09/empty_inquiries.png" alt="" width="1200" height="436" class="aligncenter size-full wp-image-8214" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/09/empty_inquiries.png 1200w, https://stackstorm.com/wp/wp-content/uploads/2018/09/empty_inquiries-150x55.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/09/empty_inquiries-300x109.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/09/empty_inquiries-768x279.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/09/empty_inquiries-1024x372.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2018/09/empty_inquiries-80x29.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/09/empty_inquiries-220x80.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/09/empty_inquiries-250x91.png 250w, https://stackstorm.com/wp/wp-content/uploads/2018/09/empty_inquiries-280x102.png 280w, https://stackstorm.com/wp/wp-content/uploads/2018/09/empty_inquiries-510x185.png 510w, https://stackstorm.com/wp/wp-content/uploads/2018/09/empty_inquiries-750x273.png 750w, https://stackstorm.com/wp/wp-content/uploads/2018/09/empty_inquiries-975x354.png 975w, https://stackstorm.com/wp/wp-content/uploads/2018/09/empty_inquiries-1190x432.png 1190w" sizes="(max-width: 1200px) 100vw, 1200px" />][5]

No open inquiries at the moment, so let’s kick something off.

We’ll use the [orquesta-ask-basic][6] example from the Examples pack:

    vagrant@st2vagrant:~$ st2 run examples.orquesta-ask-basic
    .
    id: 5ba5a7c1179d9b089903695b
    action.ref: examples.orquesta-ask-basic
    parameters: None
    status: paused
    start_timestamp: Sat, 22 Sep 2018 02:24:01 UTC
    end_timestamp:
    result:
      output: null
    +--------------------------+------------------------+--------------+-----------+------------------+
    | id                       | status                 | task         | action    | start_timestamp  |
    +--------------------------+------------------------+--------------+-----------+------------------+
    | 5ba5a7c2179d9b045e725bdd | succeeded (0s elapsed) | start        | core.echo | Sat, 22 Sep 2018 |
    |                          |                        |              |           | 02:24:02 UTC     |
    | 5ba5a7c2179d9b045e725be0 | pending                | get_approval | core.ask  | Sat, 22 Sep 2018 |
    |                          |                        |              |           | 02:24:02 UTC     |
    +--------------------------+------------------------+--------------+-----------+------------------+
    vagrant@st2vagrant:~$
    

Now go back to our Inquiries UI:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/09/pending_inquiry-1.png" alt="" width="974" height="254" class="aligncenter size-full wp-image-8215" />][7]

We can see a “Pending” Inquiry. Click on “Approved”, and then “Respond”

We can see successful inquiries under “Succeeded”

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/09/succeeded.png" alt="" width="975" height="282" class="aligncenter size-full wp-image-8216" />][8]

This should make it much easier to use Inquiries. We’ve also fixed a few long-standing bugs related to workflows getting stuck in Pausing state.

## <del>Orchestra</del> Orquesta Second Beta

Our new workflow engine took a holiday in Spain, and now wishes to be known as “[Orquesta][9].” All documentation has been updated to reflect the new name. If you have been trying it out, and used `runner_type: orchestra`, this will still work.

This is the second public beta for Orquesta. This release includes bugfixes and features. Some highlights include:

  * Inquiry support
  * Ported YAQL functions & Jinja filters to Orquesta, and added `|` support.
  * API for Workflow inspection
  * Bug fixes &#8211; duplicate task execution, looping tasks pointing to wrong context.

We’re now busy working on more bugfixes and features as we head to our GA release in 3.0, later this year.

## StackStorm Enterprise in HA mode on Kubernetes

Keen to run StackStorm on Kubernetes? So are we! We’ve published beta [docs][10], containers and Helm Chart for running StackStorm Enterprise in HA mode on Kubernetes. Try it out for yourself, and watch out for an upcoming blog post explaining this in much more detail.

This is beta right now, but will go stable later this year. We’ll also be releasing configurations for running the Community version of StackStorm.

## Windows Runners

Our good friend [Nick Maludy][11] has contributed new Windows runners. These are based on [PyWinRM][12], which is better supported than the old `winexe`-based runners.

The new runners are `winrm-cmd`, `winrm-ps` and `winrm-ps-script`. The `winrm-cmd` runner executes Command Prompt commands remotely on Windows hosts using the WinRM protocol. The `winrm-ps-cmd` and `winrm-ps-script` runners execute PowerShell commands and scripts on remote Windows hosts using the WinRM protocol.

There’s also new `core` actions: `core.winrm_cmd` and `core.winrm_ps_cmd`.

The legacy Windows runners are now considered deprecated. They will be removed in StackStorm 3.1.

## Improved Metrics Support

StackStorm v2.8.0 introduced support for metrics which provide operator with a detailed visibility (performance and health) into StackStorm deployment. This release builds on that functionality and adds many more metrics and related improvements.

With all those metrics in place, operators now have a very good and detailed visibility into a StackStorm deployment.

For information on how to configure this feature and list of the available metrics, please refer to [the documentation][13]

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/09/Screenshot-from-2018-09-24-11-19-12.png" alt="" width="900" height="193" class="aligncenter size-medium wp-image-8225" />][14]

<p style="text-align: center;">
  An example Graphite dashboard utilizing metrics functionality for our StackStorm CI/CD (build) deployment.
</p>

## Ability to Easily Inject Triggers Into the System From Workflows

This release includes new `core.inject_trigger` action which allows user to easily inject arbitrary trigger into the system. Most common use case includes injecting trigger into the system inside a workflow.

Before this change, injecting a trigger into the system from a workflow was far from trivial and meant utilizing [core.http action and POSTing a trigger to the webhook or other more complex approach][15].

## Miscellaneous Changes & Fixes

Lots happening here &#8211; this is just a few interesting items:

  * API filtering &#8211; we’ve added more controls around filtering what gets returned with API calls. We’ve also made some speed improvements. We’re working hard to improve the UI and API performance. Watch out for lots more here.
  * Saving pack configs from the Web UI works once again.
  * We fixed a bug with Python 3 actions with certain Python 3 versions & distros.
  * We’ve upgraded `mongoengine` and `pymongo`, which will let us support Mongo 3.6 in future.
  * You can now emit actiontrigger instances at more stages of an action’s lifecycle, not just when it completes. Handy if you want to set up notification rules for specific actions.
  * The [CloudSlang][16] runner is now deprecated. It will be removed from StackStorm 3.1. It will be available separately for users who wish to continue using it, but it will no longer be tested or supported by the StackStorm team.

More details in the [changelog][17].

## Install Time

Packages are available in our apt and yum repos. Follow the standard instructions to [install][18], or upgrade following the [General Upgrade Procedure][19].

You know the drill by now: backup first.

And as always, thanks to everyone who contributed.

 [1]: https://stackstorm.com/2017/11/07/new-stackstorm-2-5-real-time-action-output-streaming/
 [2]: https://stackstorm.com/wp/wp-content/uploads/2018/09/live_output.png
 [3]: https://stackstorm.com/wp/wp-content/uploads/2018/09/example_live_output.png
 [4]: https://stackstorm.com/2017/10/31/new-stackstorm-2-5-inquiries/
 [5]: https://stackstorm.com/wp/wp-content/uploads/2018/09/empty_inquiries.png
 [6]: https://github.com/StackStorm/st2/blob/master/contrib/examples/actions/workflows/orquesta-ask-basic.yaml
 [7]: https://stackstorm.com/wp/wp-content/uploads/2018/09/pending_inquiry-1.png
 [8]: https://stackstorm.com/wp/wp-content/uploads/2018/09/succeeded.png
 [9]: http://www.spanishdict.com/translate/orquesta
 [10]: https://docs.stackstorm.com/latest/install/ewc_ha.html
 [11]: http://www.encore.tech
 [12]: https://github.com/diyan/pywinrm
 [13]: https://docs.stackstorm.com/latest/reference/metrics.html
 [14]: https://stackstorm.com/wp/wp-content/uploads/2018/09/Screenshot-from-2018-09-24-11-19-12.png
 [15]: https://forum.stackstorm.com/t/is-there-a-way-to-trigger-event-in-workflow-like-inquiry-and-consume-it-in-rules/199/2
 [16]: https://docs.stackstorm.com/cloudslang.html
 [17]: https://docs.stackstorm.com/changelog.html
 [18]: https://docs.stackstorm.com/install/index.html
 [19]: https://docs.stackstorm.com/install/upgrades.html#general-upgrade-procedure