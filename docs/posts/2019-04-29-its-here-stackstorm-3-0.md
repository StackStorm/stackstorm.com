---
title: 'It’s Here: StackStorm 3.0'
author: st2admin
type: post
date: 2019-04-29T17:15:44+00:00
url: /2019/04/29/its-here-stackstorm-3-0/
thrive_post_fonts:
  - '[]'
  - '[]'
categories:
  - Community
  - News
tags:
  - release
  - release announcement

---
**April 29, 2019**

_By Lindsay Hill_

It’s here at last: StackStorm 3.0. This is a big release for us: Orquesta is GA, and Workflow Designer has a great new look & feel, massively improving usability. We’ve added Microsoft Teams support, Inquiries also goes GA, and more. Here’s all the details: <!--more-->

## Orquesta GA

We are proud to announce that our new workflow engine, [Orquesta][1], is out of beta. It has been thoroughly tested internally and externally over the last year, going through several betas. It is ready for full production use.

This is a new workflow engine, written by our team. It is more tightly integrated into StackStorm than Mistral, using the same configuration files, logging, commands and APIs, and database. No more separate PostgreSQL DB required.

It gives us all the capabilities of Mistral, but is easier to deploy, operate and troubleshoot.

Mistral is still included in the StackStorm packages, but we recommend all users begin migrating their workflows now.

We’ll do a deeper dive into Orquesta in an upcoming blog post.

## All-New Workflow Designer

[Extreme Workflow Composer][2] has had a huge overhaul. Check it out:

<img loading="lazy" src="https://ewc-docs.extremenetworks.com/_images/pkg_promote_workflow.png" width="1380" height="770" class="aligncenter size-full" scale="0" /> 

This is a huge usability improvement. New look & feel, new workflow layout, and much more control from within the UI. Now you can configure transitions, task parameters, published variables, etc. all from within the UI.

You can even choose the color of transition arrows &#8211; it doesn’t have to be a simple success == green, failure == red color scheme. Pick whatever makes sense for you.

We’re very excited about Workflow Designer. We want to make it the faster, easiest way to develop, test and debug workflows. Sign up for a [trial here][3].

Watch out for more blog posts about Workflow Designer soon.

## Microsoft Teams

ChatOps now supports [Microsoft Teams][4]. Slack is still near & dear to our hearts, but Microsoft Teams is seeing huge growth, and we know many organizations are starting to use it.

You can now configure StackStorm to work with Teams. It does work a little differently to other chat bots, due to some architectural differences. Pay close attention to the [documentation][4].

This is the first release of this support, and we consider it \`beta\` right now, but we expect it to be GA in the next StackStorm release.

## Bits & Pieces

It’s not just the big things. There’s plenty of other small changes here too.

  * Firstly, this is the last StackStorm release that will support Ubuntu 14.04. It is now [End of Support][5] by Ubuntu, and so we bid it farewell too. You will need to upgrade to Ubuntu 16.04. We have Ubuntu 18.04 packages in our [“unstable” repository][6]. You can try those out now, or wait until version 3.1, when we promote them to “stable.”
  * [Inquiries][7] is now a first-class citizen. The API has moved from \`/exp\` to \`/v1\`. You must update any external integrations.
  * Cloudslang and winexe runners have been removed.
  * \`pack.yaml\` now has a \`python_versions\` attribute to show which major Python versions the pack supports. You’re all writing your code to work with Python 3 now, right? Right?

## Upgrade!!! (But Backup First)

As always, make sure you have backups first. Then read the [Upgrade Notes][8] and follow the [Upgrade Instructions][9]. Run into a problem? Post on our [Forum][10]. Or think you’ve found a bug? Create an [issue][11] with full details.

 [1]: https://docs.stackstorm.com/orquesta/index.html
 [2]: https://www.extremenetworks.com/product/workflow-composer/
 [3]: https://stackstorm.com/features/#ewc
 [4]: https://docs.stackstorm.com/chatops/msteams.html
 [5]: https://wiki.ubuntu.com/Releases
 [6]: https://packagecloud.io/StackStorm/unstable
 [7]: https://docs.stackstorm.com/inquiries.html
 [8]: https://docs.stackstorm.com/upgrade_notes.html#st2-v3-0
 [9]: https://docs.stackstorm.com/latest/install/upgrades.html
 [10]: https://forum.stackstorm.com
 [11]: https://github.com/StackStorm/st2/issues