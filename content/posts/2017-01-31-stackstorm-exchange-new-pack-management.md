---
title: 'StackStorm Exchange: The New Pack Management'
author: st2admin
type: post
date: 2017-01-31T20:36:28+00:00
url: /2017/01/31/stackstorm-exchange-new-pack-management/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5510533863
categories:
  - Blog
tags:
  - exchange
  - StackStorm

---
**Jan 30, 2017**  
_by Edward Medvedev_

_Warning: this post describes a long set of important changes. It is enormous in size and full of cheesy puns, feelings, and heart emojis. You might prefer to [read the documentation][1] if that is not what you are into. Otherwise, grab a favorite caffeinated drink of your choice and let&#8217;s begin!_

A little while ago we [rolled out StackStorm 2.1][2], a release focused on one primary theme: integration packs.

StackStorm pack management infrastructure is evolving with the demand. As the number of integration packs grows, we want to provide means for faster and easier deployment, make pack development more productive, and encourage collaboration. There are dozens of changes making it happen—both in our internal infrastructure and the StackStorm core—and we are excited and hopeful that through better experience with integration packs, working with StackStorm will become even more efficient, easy, and fun.

As it is the case with all &#8220;thematic&#8221; releases, 2.1 is more than just a set of features and changes. It has a lot of context around it, and more importantly, it has a story—and this is a story we are now going to tell.

<!--more-->

### From st2contrib to StackStorm Exchange

Our contribution repository, [st2contrib][3], served the StackStorm users well for a long time. It was home for about a dozen integration packs when it started, and over a few years it successfully expanded to more than a hundred.

The amount of StackStorm content is growing _fast_, and around the time when the pack count couldn&#8217;t fit into an `int8` anymore, placing all packs into a single repository suddenly stopped looking like such a good idea.

Having more content than we could handle was a good problem to have—and still, it was a problem that needed solving. Every clone of `st2contrib` downloaded thousands of extra actions, it was very hard to version and process packs separately, and it was nearly impossible to give external contributors access to a subset of packs or assign pack maintainers.

So we had to bid farewell. As of the 2.1 release, `st2contrib` has been closed to new contributions, and the packs have moved to a new home. The goodbye was bittersweet, but we knew it had to happen.

Of course, the repository will stay open for backwards compatibility with the old StackStorm versions that might have deployment workflows depending on it. However, if you want to keep up with the bug fixes, updates, and new pack versions, we encourage you to upgrade to StackStorm 2.1 and read our [transition guide][4].

Now, about that new home.

[![StackStorm Exchange][5]][6]

StackStorm Exchange is the hub around which our new pack management system works. We have been planning and preparing the transition for a while, and the new infrastructure has been successfully rolled out with the release of StackStorm 2.1.

There is a huge number of changes, big and small, and most of them can be attributed to one of the four key scenarios that we will talk about: discovery, collaboration, development, and deployment.

Those make up four entirely different stories—varying even in mood and tone—but in the end they combine into one giant Super Robot and awesomeness ensues.

Let&#8217;s begin.

### Discovery

![StackStorm Exchange pack list][7] 

Of all the things introduced in this release, the StackStorm Exchange front-end is probably the shiniest. It has been crafted with sweat, tears, ReactJS, and a little bit of love, and we hope you enjoy using it to find new packs you might like.

<img alt="Discarded UI prototype" style="height: 175px;" src="https://i.imgur.com/1f2hOsJ.png" /> 

_The &#8220;a little bit of love&#8221; part might seem debatable in light of some earlier UI prototypes, but our love for automated tests is just as important as our love for users._

We are determined to keep updating the UI with new amazing features, and we won&#8217;t stop until discovering and installing the packs you need is effortless. We&#8217;ll just have to write a React plugin for mind-reading (I&#8217;ve heard you can do anything in JS just by gluing a few hundred of npm modules together, so it should be pretty simple).

Visit the Exchange at [exchange.stackstorm.org][6], or check out the source code at [StackStorm-Exchange/web at Github][8] if you are curious.

Another new way of discovering packs is the `st2 pack` CLI commands introduced in StackStorm 2.1 (more on that later). You can search for packs or get information about a particular one:

<pre class="EnlighterJSRAW" data-enlighter-language="shell">$ st2 pack search monitoring
+----------+------------------------------+---------+-----------------------+
| name     | description                  | version | author                |
+----------+------------------------------+---------+-----------------------+
| dripstat | Integration with the         | 0.2.0   | James Fryman          |
|          | Dripstat Application         |         |                       |
|          | Performance Monitoring tool  |         |                       |
| sensu    | st2 content pack containing  | 0.3.0   | StackStorm, Inc.      |
|          | sensu integrations           |         |                       |
| nagios   | Nagios integration pack. See | 0.2.0   | StackStorm, Inc.      |
|          | README.md for setup          |         |                       |
|          | instructions.                |         |                       |
| newrelic | st2 content pack containing  | 0.3.0   | StackStorm, Inc.      |
|          | newrelic integrations        |         |                       |
| datadog  | datadog                      | 0.0.2   | Lisa Bekdache         |
| mmonit   | st2 content pack containing  | 0.3.0   | Itxaka Serrano Garcia |
|          | mmonit integrations          |         |                       |
+----------+------------------------------+---------+-----------------------+
</pre>

<pre class="EnlighterJSRAW" data-enlighter-language="shell">$ st2 pack show sensu --yaml
author: StackStorm, Inc.
content:
    actions:
        count: 19
    rules:
        count: 2
    tests:
        count: 1
    triggers:
        count: 1
description: st2 content pack containing sensu integrations
keywords:
- sensu
- monitoring
- alerting
name: sensu
ref: sensu
repo_url: https://github.com/StackStorm-Exchange/stackstorm-sensu
version: 0.3.0
</pre>

The underlying back-end behind both the UI and the CLI commands deserves a special mention. We are all into automation, so our pack directory is now exposed as a consumable JSON file: you can download it at [index.stackstorm.org/v1/index.json][9] or clone the [StackStorm-Exchange/index][10] repository.

The index updates in real time: our CI system rebuilds it right after an update is pushed to the packs. Also, because it is served as a static file, we can build the UI as a front-end-only app and host it on GitHub Pages for free, because <span style="text-decoration: line-through;">we are cheap</span> GitHub is awesome.

Pack indexes in 2.1 are meant to be extensible: while the StackStorm Exchange index is used by default, you are free to introduce your own! You can mirror our main index, expand it, or even host your own catalog of internal packs, similar to source files in OS package management. Read on to the Deployment section or jump straight to [the documentation section on indices][11] for the distilled wisdom free of cheesy puns.

With StackStorm Exchange, we hope to make the discovery of integration packs easier for both new and advanced users, and the custom indexes can come in handy for larger-scale Enterprise deployments. We hope to hear your thoughts in our Slack community channel, and please stay tuned—we have even more exciting things planned!

### Collaboration

Pull requests from our community aren&#8217;t just pieces of code: behind each one there is time and effort that someone has put into making StackStorm better for everyone. To show our appreciation, we strive to save as much of your time as we can by reducing the overhead of submitting new packs and features (we also send heart emojis and pug pictures as a sign of appreciation, but I digress).

StackStorm Exchange continues this tradition: we have made both architectural and organizational changes that are meant to make contributions faster, easier, and more straightforward.

Most importantly, the packs are now split into multiple single-pack repositories inside a dedicated GitHub organization, [StackStorm-Exchange][12]. Smaller repositories are not just easier to work with, but also more manageable—and they make our primary organizational change possible.

**With the transition to StackStorm Exchange, we are introducing the pack maintainer role.**

A pack maintainer is someone who is an active developer (and often creator) of the pack, and an expert on both the target product of the pack and the API or the library that is used. Pack maintainers often help other users with their contributions, respond to issues, and review pull requests. They heavily rely on the packs they maintain in production use.

Some of our most active community members have already taken up this role over time, and now we are happy to recognize them in an official capacity. Those we are inviting to become maintainers are getting full permissions to their pack repositories and will be able to develop and manage their packs more efficiently. We are fascinated by everyone who has agreed to step up, and to give credit where it’s due, we will talk about our maintainers shortly in a dedicated post!

Everyone else submitting a pull request or opening an issue benefits from this equally: in addition to the help from our engineering team, they will also get help from pack maintainers, who are often more knowledgeable about their packs than we are. With this kind of help, we can reduce the average time required for bug fixes, reviews, and new releases, as well as the average response time for issues, which, in turn, benefits our users as well.

As a conclusion to the collaboration part, we would like to thank everyone who has ever contributed to a StackStorm pack. With the new changes, we humbly hope to encourage you to keep working with StackStorm and developing new integrations. Think of StackStorm Exchange as a huge heart emoji that we&#8217;re sending to every one of you.

❤️️

### Development

The core change in the pack development workflow—hosting packs in their separate repositories—has already been mentioned in passing, and now we are going to focus on it a little more. First things first: with this change, we had to make a very hard decision.

_Dramatic build-up music plays._

**The transition to single-pack repositories is breaking**. Pack installation in StackStorm 2.1 does not support repositories with multiple packs in them.

_Sudden violin screech!_

Let&#8217;s rewind and talk history: there were several problem areas with `st2contrib` that made this change unavoidable.

  * **Organization**: inability to fine-tune access—for instance, assign maintainers to individual packs.</p> 
  * **Structure**: overall mess and clutter, like having issues from 100+ packs piled up in one place or being unable to follow the changes only in certain packs.

  * **Architecture**: having to clone the entire repository to install a single pack is, well, suboptimal.

  * **Technical debt**: best illustrated by the opening comment in the pack download action.

<pre class="EnlighterJSRAW" data-enlighter-language="python">#####
# !!!!!!!!!!!!!!
# !!! README !!!
# !!!!!!!!!!!!!!
#
# This NEEDS a rewrite. Too many features and far too many assumption
# to keep this impl straight any longer. If you only want to read code do
# so at your own peril.
#
# If you are here to fix a bug or add a feature answer these questions -
# 1. Am I fixing a broken feature?
# 2. Is this the only module in which to fix the bug?
# 3. Am I sure this is a bug fix and not a feature?
#
# Only if you can emphatically answer 'YES' to allow about questions you should
# touch this file. Else, be warned you might loose a part of you soul or sanity.
#####
</pre>

Consider this: the transition to single-pack repositories _solves all those problems at once_. And then some: we can start utilizing git tools and repository metadata to introduce features like versioning at virtually no cost.

Even though introducing breaking changes always feels like a blood sacrifice—and relying on git for package management [can definitely backfire][13]—no other solution would be nearly as effective at this stage of our growth. And so the blood sacrifice has been made. So it goes.

Regardless of whether you contribute to community packs in the Exchange or create packs for your own internal use, you will notice positive changes from day one. First, let&#8217;s see how the problem areas outlined above turn into improvements:

  * **Organization:** as pack maintainers contribute their time and expertise to help us review issues and pull requests, you can expect better code quality of the Exchange contributions—and faster reviews because of the shared workload!</p> 
  * **Structure:** single-pack repositories are easier to manage and control with git. Logs and metadata are concise, diffs in branches and tags are free of clutter, and whenever there is a new commit upstream, you know it is related to your pack. It is also easier to keep track of issues and pull requests—and easier for the users to follow only the packs they need.

  * **Architecture:** several internal improvements like faster pack deployments, extended support for private repositories, or git+SSH support.

  * **Technical debt:** 84.5% less code paths that lead to insanity—and more time to develop useful features!

Pretty neat, right? But we have only scratched the surface: now we can take this idea of git coupling even further and build up on it to make development—and then deployment—even more convenient.

  * **Live development:** since pack installation essentially becomes a `git clone`, you can work with installed packs just like you would with any other git repository. Switch tags and branches, try out local changes and revert them, or even make commits from your StackStorm server (not a good development workflow, but could be useful for playing around or pushing hotfixes upstream).</p> 
  * **Versioning:** following the previous point, we can easily make our deployment action install specific pack revisions, branches, and tags (only branches were supported before 2.1). Use feature branches for development, pin pack versions to a specific revision in production—you know, do what you would normally do with versioned packages.

And then a few more extra features for pack developers as a small cherry on top:

  * **Pack metadata additions**: there are several new fields in `pack.yaml`, like `contributors` or `stackstorm_version`—read more about them on the [pack documentation page][14]. Additionally, we introduce semver format (`X.Y.Z`) validation for the `version` field to keep the versioning more consistent.</p> 
  * **Extensible CI in Exchange**: if you are developing an Exchange pack that requires special treatment (for instance, extra system-level dependencies for running tests), it is now possible to modify its CI environment or add new checks—unlike `st2contrib` which had uniform CI for all packs.

  * **Version tagging in Exchange**: if your PR to any of the Exchange packs changes version in `pack.yaml`, our caring CI robot will also create a corresponding version tag in git for easier deployment. Speaking of tidy and orderly!

With all the changes, the one important goal we are trying to achieve is creating a development environment that just _gets out of your way_. You have probably noticed that the new features are not focused _on_ development, but create a utility layer _around_ it instead—and while we find this layer very helpful, it is also completely optional.

You do not have to list your packs in StackStorm Exchange, you do not have to host your repositories on GitHub, and you do not even have to use git at all. At the end of the day, StackStorm packs are just directories and files, and you are free to create, store, and deploy them in any way you want.

Instead of imposing a set of tools or a specific workflow, we would rather take the supporting role and reduce overhead and clutter as much as possible, so that you can focus on writing code and getting things done.

Damage boost engaged!

### Deployment

Now, for the final part of the StackStorm Exchange transition: deployment. Pack deployment in 2.1 is one huge bundle of improvements and new features—something that every change in this release has been building up towards, and something that has made all the blood sacrifices worth it.

There is enough good news for everyone.

Good news for those who use our CLI: we have new `st2 pack` subcommands for installing, upgrading, and managing packs.

<pre class="EnlighterJSRAW" data-enlighter-language="shell">usage: st2 pack [-h] {list,get,show,search,install,remove,register,config} ...

A group of related integration resources: actions, rules, and sensors.

positional arguments:
  {list,get,show,search,install,remove,register,config}
                        List of commands for managing packs.
    list                Get the list of packs.
    get                 Get information about an installed pack.
    show                Get information about an available pack from the
                        index.
    search              Search the index for a pack with any attribute
                        matching the query.
    install             Install new packs.
    remove              Remove packs.
    register            Register a pack: sync all file changes with DB.
    config              Configure a pack based on config schema.

optional arguments:
  -h, --help            show this help message and exit
</pre>

Good news for those who work with git: packs can be installed from any git repository—and versioned with tags, branches, or commit SHAs.

<pre class="EnlighterJSRAW" data-enlighter-language="shell">$ st2 pack install https://github.com/emedvedev/chatops_tutorial=49b65a5

    [ succeeded ] download pack
    [ succeeded ] make a prerun
    [ succeeded ] install pack dependencies
    [ succeeded ] register pack

+-------------+---------------------------+
| Property    | Value                     |
+-------------+---------------------------+
| name        | Chatops Tutorial          |
| description | Tutorial pack for ChatOps |
| version     | 0.3.0                     |
| author      | emedvedev                 |
+-------------+---------------------------+
</pre>

Good news for those who like neat interactive prompts: most packs can be configured interactively with `st2 pack config`.

<pre class="EnlighterJSRAW" data-enlighter-language="shell">$ st2 pack config sensu
ssl (boolean) [n]: false
host: localhost
pass (secret): ******
user: admin
port [4567]: 4568
---
Do you want to preview the config in an editor before saving? [y]: n
---
Do you want me to save it? [y]:
+----------+---------------------------+
| Property | Value                     |
+----------+---------------------------+
| pack     | sensu                     |
| values   | {                         |
|          |     "port": "4568",       |
|          |     "ssl": false,         |
|          |     "host": "localhost",  |
|          |     "user": "admin",      |
|          |     "pass": "secret"      |
|          | }                         |
+----------+---------------------------+
</pre>

Good news for those who like ChatOps: we have made a complete overhaul of our pack management aliases.

<img alt="ChatOps aliases" style="height: 511px;" src="https://i.imgur.com/BxcWBtC.png" /> 

Good news for those who control StackStorm through the API: there is an API endpoint for every pack management command in StackStorm 2.1.

<pre class="EnlighterJSRAW" data-enlighter-language="shell">$ curl -k https://192.168.16.20/api/v1/packs/uninstall \
    -H "Content-Type: application/json" \
    -d '{"packs":["jira"]}'

{"execution_id": "588f7bc9c4da5f38ad10a344"}
</pre>

Good news for those who want to keep it classy: you can [maintain your own pack index][11] to make your private packs searchable and resolvable by name. You can even host your own directory page: just fork our [Exchange front-end][8]!

<img alt="Custom index" style="height: 511px;" src="https://i.imgur.com/L140wl4.png" /> 

Good news for those who got sad after learning that we do not support multi-pack repositories anymore: there is a [migration script][15] (courtesy of [@pixelrebel][16]) that helps you split them while preserving the commit history.

<pre class="EnlighterJSRAW" data-enlighter-language="shell">Moving bwc_topology...
Rewrite 459e3a1e7bf72bd114e9380ed7ac88fa36fda721 (11/11) (0 seconds passed, remaining 0 predicted)
Ref 'refs/heads/master' was rewritten

Counting objects: 89, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (55/55), done.
Writing objects: 100% (89/89), 27.38 KiB | 0 bytes/s, done.
Total 89 (delta 45), reused 55 (delta 31)
remote: Resolving deltas: 100% (45/45), done.
To https://github.com/stackstorm/stackstorm-bwc_topology.git
 * [new branch]      master -&gt; master
The bwc_topology pack has been transferred.
</pre>

And what if you would rather not use any of this and prefer a completely different deployment workflow? Oh boy, do we have good news for you, too! As mentioned in the development section, you are completely free to keep doing this in 2.1, and just as before, all you need is to have your packs copied to `/opt/stackstorm/packs` and reload the content:

<pre class="EnlighterJSRAW" data-enlighter-language="shell">$ cp -r stackstorm-aws/ /opt/stackstorm/packs/aws
$ st2 pack register aws
+--------------+-------+
| Property     | Value |
+--------------+-------+
| actions      | 639   |
| aliases      | 0     |
| configs      | 0     |
| policies     | 0     |
| policy_types | 3     |
| rule_types   | 2     |
| rules        | 0     |
| runners      | 13    |
| sensors      | 2     |
| triggers     | 0     |
+--------------+-------+
</pre>

That would be all.

### Conclusion

With one release—for most of our users, essentially overnight—pack management in StackStorm turned from a bunch of actions into a full-featured package control system with versioning, CLI commands, API endpoints, and a dedicated hub. It has not been an easy journey, and some sacrifices have been made, but in the end it was well worth it.

When it comes to acknowledgements, it has been an immense collective effort, and while our entire engineering team has been working in full force to make the release happen, it would not be complete without the support of our amazing community.

We are grateful to everyone who has ever contributed to our growing library of more than a hundred integration packs—for helping StackStorm and the community grow.

To the StackStorm experts who stepped up to become our first pack maintainers—for their sincere desire to give back.

To the curious folks who started testing features before we even announced they are in development—for giving early feedback and showing us the fun of open source.

To the awesome crowd of a spontaneous [StackStorm meetup in London][17]—for sharing their thoughts during my early Exchange presentation.

To everyone who relies on StackStorm—for giving our work meaning.

Thank you. ❤️️

* * *

Lastly, a few useful documentation links:

  * [full 2.1.0 changelog][18];
  * [upgrade notes][19];
  * [`st2contrib`/Exchange transition notes][4];
  * [general pack documentation][20];
  * [pack development documentation][21].

And as always, we are there for you! If you have questions, want to give feedback, or just feel chatty, you can find us in our [StackStorm community Slack][22].

_— Ed_

 [1]: docs.stackstorm.com/packs.html
 [2]: https://stackstorm.com/2016/12/06/2-1-new-pack-management/
 [3]: https://github.com/StackStorm/st2contrib
 [4]: https://docs.stackstorm.com/reference/pack_management_transition.html
 [5]: https://i.imgur.com/PSqGRDb.png
 [6]: https://exchange.stackstorm.org
 [7]: https://i.imgur.com/7jmr8QC.png
 [8]: https://github.com/StackStorm-Exchange/web
 [9]: https://index.stackstorm.org/v1/index.json
 [10]: https://github.com/StackStorm-Exchange/index
 [11]: https://docs.stackstorm.com/packs.html#hosting-your-own-pack-index
 [12]: https://github.com/StackStorm-Exchange/
 [13]: https://github.com/CocoaPods/CocoaPods/issues/4989#issuecomment-193772935
 [14]: https://docs.stackstorm.com/reference/pack_management_transition.html?highlight=contributors#changes-to-take-advantage-of
 [15]: https://github.com/StackStorm-Exchange/exchange-tools/blob/master/split-packs.sh
 [16]: https://github.com/pixelrebel
 [17]: https://www.meetup.com/London-StackStorm-User-Meetup/
 [18]: https://docs.stackstorm.com/changelog.html#december-05-2016
 [19]: https://docs.stackstorm.com/upgrade_notes.html#st2-v2-1
 [20]: https://docs.stackstorm.com/packs.html
 [21]: https://docs.stackstorm.com/reference/packs.html
 [22]: https://stackstorm.com/community-signup