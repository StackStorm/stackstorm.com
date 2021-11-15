---
title: StackStorm v1.5 is alive!
author: st2admin
type: post
date: 2016-06-27T22:55:51+00:00
url: /2016/06/27/stackstorm-v1-5-alive/
dsq_thread_id:
  - 4943657773
tcb2_ready:
  - 1
thrive_post_fonts:
  - '[]'
categories:
  - Blog
tags:
  - release

---
**June 27, 2016**  
_by Lindsay Hill_

**StackStorm v1.5.0** has been released! More features, more improvements, and more bugfixes (sorry about those). Read on to hear about the changes, or fire up `apt`/`yum` and upgrade!

## CLI Completion!

Spend a lot of your time using the `st2` CLI? You&#8217;ll love this change: We&#8217;ve added CLI auto-completion to the `st2` command. Type `st2` then hit tab twice. You&#8217;ll get a list of all available arguments. This works multiple levels deep. Very handy when you can&#8217;t quite remember the right syntax:

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2016/06/cli_completion.gif" alt="cli_completion" width="870" height="304" class="aligncenter size-full wp-image-5784" /> 

Simple, but cool.

## Datastore Secrets and User-Scoping

The StackStorm datastore service allows you to store common parameters and their values for reuse within sensors, actions and rules. Prior to v1.5, these were available to all users. Now you can scope variables to a specific user, and you can control who can read or write into those variables. By default, variables are stored in the `system` scope, but you can scope it to a specific user by adding `--scope=user`, e.g.:

`st2 key set date_cmd "date -u" --scope=user`

<!--more-->

You can also store ‘secrets’ &#8211; values encrypted using a symmetric key. This needs to be enabled by the StackStorm administrator. Once it’s setup, users can store keys with the `--encrypt` flag. Only the administrator and the user who set the value will be able to decrypt it, if it was user-scoped.

The combination of user-scoping and encryption is particularly useful for users that need to store API secrets and credentials in the datastore.

We’ve got some more details in the [Datastore documentation][1], and we’ll also be covering it in future blog posts.

## Pack Configuration v2

Pack config files which are located inside the pack directory (`config.yaml`) have been deprecated in favor of the new pack configuration v2. The new config files are outside the pack directory, in the `/opt/stackstorm/configs/` directory. The format is similar to the existing pack configs, but in addition to the static values they can also contain dynamic values. A dynamic value contains a Jinja expression which is resolved to the datastore item during run-time. This can include the new datastore secrets.

This approach offers more flexibility, and makes updating packs easier, since users don’t need to directly manipulate pack content anymore. This helps if you’re following the “infrastructure as code” approach (and you should!).

> This change is backwards-compatible. Your existing configurations will continue to work, but we encourage you to plan to migrate to take advantage of the new features.

For more information, check the updated [Pack Configuration][2] docs. Keep an eye on this blog, where we&#8217;ll publish more details about the new configuration style, and how to migrate.

## Register-triggers

We added the `--register-triggers` flag to the `st2-register-content` script and `st2ctl`. When this flag is provided, all triggers contained within a pack triggers directory are registered, consistent with the behavior of sensors, actions, etc. This feature allows users to register trigger types outside the scope of the sensors.

## Other Improvements & New Features

The [Changelog][3] contains the full list, but here’s a selection of other improvements and new features in v1.5:

  * The underscore prefix has been removed from the `sensor_service` and `config` variables available with the `Sensor` and `PollingSensor` classes. Those variables are now `self.sensor_service` and `self.config`.
  * SSL support for mongodb connections.
  * Add `-y` / `--yaml` flag to the CLI `list` and `get` commands. If this flag is provided, the response will be formatted as YAML. Related: We removed support for JSON format for resource metadata files. JSON has been deprecated since StackStorm v0.6, so we gave you fair warning. Now the only supported metadata file format is YAML.
  * The deprecated Fabric-based remote runner has been removed
  * Allow user to provide a path to the private SSH key file for the remote runner `private_key` parameter. Previously only raw key material was supported.
  * Add RBAC support for runner types API endpoints.
  * Change the way SFTP connections work, so the remote runner should now also work on Cygwin on Windows
  * API and CLI now allow rules to be filtered by their ‘enabled’ state.
  * Improved error message if an SSH private key is passphrase protected but the user fails to supply passphrase.
  * Add new API endpoint and corresponding CLI commands (`st2 runner disable <name>`, `st2 runner enable <name>`) which allows administrator to disable (and re-enable) a runner.
  * Store action execution state transitions (event log) in the log attribute on the ActionExecution object.</name></name>

## Notable Bugfixes

Yes, there were bugs. We’re sorry. Now there’s fewer bugs. Some of the interesting fixes include:

  * Alias names are now correctly scoped to a pack, so the same name for an alias can be used across different packs
  * SSH Bastion host support now works properly
  * Fix support for password protected private key files in the remote runner. (bug-fix)
  * Add missing `pytz` dependency to `st2client` requirements file. (bug-fix)
  * Fix datastore access on Python runner actions (set `ST2_AUTH_TOKEN` and `ST2_API_URL` env variables in Python runner actions to match sensors).
  * Added a work-around for trigger creation which would cause rule creation for CronTrigger to fail under some circumstances.
  * Make sure `st2-submit-debug-info` cleans up after itself and deletes a temporary directory it creates.

## New Community contributions since v1.4

Our community continues to contribute useful integrations. Here’s some new packs added since v1.4 was released:

  * [CloudFlare][4]
  * [HPE Insight Control Server Provisioning][5]
  * [Networking Utilities][6] &#8211; handy generic utilities for checking things like if an IP is valid
  * [OpsGenie][7]

## But wait, there’s more!

Read the full [Changelog][8] to see all the details. We’ve also been tidying up the [documentation][9] as we go. I’ve been on a typo hunt, but I’m sure there’s more out there. It’s a race between creating and fixing typos. Some days I feel like the developers are winning, other days I get on top of it.

Thanks to all those Community members who contributed code to this release, including: Kale Blankenship, Peter Idah, Andrew Jones, Jon Middleton, Paul Mulvihill, Adam Mielke, Cody A. Ray, and Anthony Shaw.

## OK, OK, How do I Upgrade?

With v1.4 we [deprecated the AIO installer][10]. This means everyone should now be using packages. Debian/Ubuntu users should use `apt-get upgrade st2` to upgrade, while RHEL/CentOS users should use `yum upgrade st2`.

Of course, make sure you have a backup before upgrading. You should also read the [Upgrade Notes][11].

Questions? Problems? Feedback? Get in touch via the [StackStorm slack community][12] or [@Stack_Storm][13].

 [1]: http://docs.stackstorm.com/datastore.html#scoping-items-stored-in-datastore
 [2]: https://docs.stackstorm.com/pack_configs.html
 [3]: https://github.com/StackStorm/st2/blob/master/CHANGELOG.rst#150---june-22-2016
 [4]: https://github.com/StackStorm-Exchange/stackstorm-cloudflare
 [5]: https://github.com/StackStorm-Exchange/stackstorm-hpe_icsp
 [6]: https://github.com/StackStorm-Exchange/stackstorm-networking_utils
 [7]: https://github.com/StackStorm-Exchange/stackstorm-opsgenie
 [8]: https://github.com/StackStorm/st2/blob/master/CHANGELOG.rst#150---june-24-2016
 [9]: http://docs.stackstorm.com/
 [10]: https://stackstorm.com/2016/04/21/goodbye-aio/
 [11]: https://docs.stackstorm.com/upgrade_notes.html#st2-v1-5
 [12]: https://stackstorm.com/community-signup/
 [13]: https://twitter.com/Stack_Storm