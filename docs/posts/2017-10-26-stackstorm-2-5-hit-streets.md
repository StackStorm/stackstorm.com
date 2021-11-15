---
title: StackStorm 2.5 Has Hit the Streets!
author: st2admin
type: post
date: 2017-10-26T22:38:33+00:00
url: /2017/10/26/stackstorm-2-5-hit-streets/
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6244078915
categories:
  - News
tags:
  - release
  - StackStorm

---
We are very pleased to announce that StackStorm v2.5 has shipped, including two big new features &#8211; Streaming Output, and the Inquiry Runner, aka `st2.ask`. Read on for more details about the new features:

<!--more-->

## Real-time Action Output Streaming

It&#8217;s here at last! You can now see action output as it is received, rather than having to wait for them to complete, or time out. Super-useful for long-running actions, and debugging new workflows.

After kicking off an action, run `st2 execution tail {ID}` &#8211; or just `st2 execution tail last`, to see real-time output from the most recent execution.

    $ st2 run mypack.my_long_running_action
    $ st2 execution tail last
    stderr -> Line: 7
    stdout -> Line: 8
    stderr -> Line: 9
    stdout -> Line: 10
    Execution 59a7f8260640fd686303e628 has completed.
    

Right now this is available via CLI and API. In future we&#8217;ll expose this via the Web UI. Check out the [docs][1].

This feature is still experimental, and is disabled by default. To enable, set `stream_output = True` in the `[actionrunner]` section of `st2.conf`, and restart all ST2 services. In future it will be enabled by default.

## Inquiries, aka st2.ask

Have you ever wanted to pause a workflow and get approval before proceeding? Or maybe stop and ask for a second authentication factor? The new `core.ask` action is for you. This is part of what we call [Inquiries][2].

To use it, define a `core.ask` step in your workflow, e.g.:

    chain:
    
      - name: task1
        ref: core.ask
        params:
          route: developers
          schema:
            type: object
            properties:
              secondfactor:
                type: string
                description: Please enter second factor for authenticating to "foo" service
                required: True
        on-success: "task2"
    
      - name: task2
        ref: core.local
        params:
          cmd: echo "We can now authenticate to "foo" service with {{ task1.result.response.secondfactor }}"
    

When the workflow runs, it will pause after the `core.ask` step. You can then use [Rules][3] to define how you want to notify users.

You can see inquiries awaiting a response with `st2 inquiries list`, and then answer an inquiry:

    ~$ st2 inquiry respond 59d1ecb732ed353ec4aa9a5a
    secondfactor: bar
    Please enter second factor for authenticating to "foo" service
    
     Response accepted. Successful response data to follow...
    +----------+---------------------------+
    | Property | Value                     |
    +----------+---------------------------+
    | id       | 59d1ecb732ed353ec4aa9a5a  |
    | response | {                         |
    |          |     "secondfactor": "bar" |
    |          | }                         |
    +----------+---------------------------+
    

This is a new feature, and we’re still seeking feedback on it. We expect it to be fully ‘productized’ in version 2.6. If you are using inquiries, we recommend checking the [garbage collection][4] settings.

## Installation Improvements

Our installation scripts have been enhanced to deal with a wider variety of situations. This should make &#8220;one-line&#8221; installs more reliable, and usable by more people. Less need to switch to manual install.

  * Proxy servers now work with the installation scripts.
  * `~stanley` no longer has to be `/home/stanley`, for those crazy kids that like to set DHOME to something like `/var/export/home`.
  * Installation script output is now logged to file under `/var/log/st2`, in addition to on-screen display.
  * Installer scripts handle re-runs better. Not fully idempotent yet. But it can pick up from earlier failures better.
  * BWC + Automation Suites installer scripts better handle it when StackStorm is already installed.

## And More!

We have of course included several smaller fixes and enhancements in this release. Some of these were contributed by the community, and we remain deeply grateful for that. One that we want to highlight is that ChatOps now supports [Rocket.Chat][5] support. If you want to host your own Chat server internally, but don&#8217;t want something that looks like it came from the 90s, Rocket Chat might be for you. Thanks to [Andrew Jones][6].

Full details in [the changelog][7].

Packages are now available in `apt` and `yum` repos. Make sure you backup first, and check the [upgrade notes][8], especially if you&#8217;re upgrading from pre-2.2. If you are using the Brocade DC Fabric Automation Suite, make sure you upgrade that at the same time &#8211; we&#8217;ve made some under the hood packaging changes.

As always, if you run into any problems, get in touch via [Slack][9] or [GitHub][10].

 [1]: https://docs.stackstorm.com/reference/action_output_streaming.html
 [2]: https://docs.stackstorm.com/inquiries.html
 [3]: https://docs.stackstorm.com/inquiries.html#notifying-users-of-inquiries-using-rules
 [4]: https://docs.stackstorm.com/inquiries.html#garbage-collection-for-inquiries
 [5]: https://rocket.chat/
 [6]: https://github.com/cheremushki
 [7]: https://docs.stackstorm.com/changelog.html
 [8]: https://docs.stackstorm.com/upgrade_notes.html
 [9]: https://stackstorm.com/community-signup
 [10]: https://github.com/StackStorm/st2/issues