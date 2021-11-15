---
title: 'StackStorm 2.3: Something for Everyone!'
author: st2admin
type: post
date: 2017-06-19T21:30:06+00:00
url: /2017/06/19/stackstorm-2-3-something-everyone/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5924981404
tcb2_ready:
  - 1
categories:
  - Blog
  - News
tags:
  - release
  - StackStorm

---
**June 19, 2017**  
_By Lindsay Hill_

StackStorm 2.3 is out, and there’s something in it for everyone. Big API improvements for developers, Web UI fixes for users, and RBAC & LDAP enhancements for Enterprise customers. Plus plenty of pack changes for everyone. Here’s the full details:

<!--more-->

## Changes For Everyone!

### API Overhaul

We know, we know, we’ve been promising API documentation _forever_. Well, here it is: [api.stackstorm.com][1].

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/06/st2_api_docs.png" alt="" width="2428" height="1312" class="alignnone size-full wp-image-6913" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/06/st2_api_docs.png 2428w, https://stackstorm.com/wp/wp-content/uploads/2017/06/st2_api_docs-150x81.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/06/st2_api_docs-300x162.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/06/st2_api_docs-768x415.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/06/st2_api_docs-1024x553.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2017/06/st2_api_docs-80x43.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/06/st2_api_docs-220x119.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/06/st2_api_docs-185x100.png 185w, https://stackstorm.com/wp/wp-content/uploads/2017/06/st2_api_docs-278x150.png 278w, https://stackstorm.com/wp/wp-content/uploads/2017/06/st2_api_docs-440x238.png 440w, https://stackstorm.com/wp/wp-content/uploads/2017/06/st2_api_docs-750x405.png 750w, https://stackstorm.com/wp/wp-content/uploads/2017/06/st2_api_docs-901x487.png 901w, https://stackstorm.com/wp/wp-content/uploads/2017/06/st2_api_docs-1101x595.png 1101w" sizes="(max-width: 2428px) 100vw, 2428px" />][2]

But there’s a lot more going on here than just API documentation. With one of our largest ever [Pull Requests][3], touching 108 files (!), [Kirill][4] has completely overhauled the way our APIs are defined and maintained. We are now using the [OpenAPI specification][5] (formerly known as Swagger). This is good for everyone in the long run: Less maintenance for us, auto-generated clients & documentation for users, and simpler, more reliable code that uses a common standard.

### Web UI Improvements

The web UI has had some love. First, thanks to [Sahil Lele][6] for [PR 351][7]. This makes it **much** easier to review execution output in the Web UI. It adds buttons for wrapping long lines, and hiding/displaying newline characters.

Here’s what a typical execution output looked like before:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/06/execution_output_before.png" alt="" width="2436" height="860" class="alignnone size-full wp-image-6909" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/06/execution_output_before.png 2436w, https://stackstorm.com/wp/wp-content/uploads/2017/06/execution_output_before-150x53.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/06/execution_output_before-300x106.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/06/execution_output_before-768x271.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/06/execution_output_before-1024x362.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2017/06/execution_output_before-80x28.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/06/execution_output_before-220x78.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/06/execution_output_before-250x88.png 250w, https://stackstorm.com/wp/wp-content/uploads/2017/06/execution_output_before-280x99.png 280w, https://stackstorm.com/wp/wp-content/uploads/2017/06/execution_output_before-510x180.png 510w, https://stackstorm.com/wp/wp-content/uploads/2017/06/execution_output_before-750x265.png 750w, https://stackstorm.com/wp/wp-content/uploads/2017/06/execution_output_before-975x344.png 975w, https://stackstorm.com/wp/wp-content/uploads/2017/06/execution_output_before-1190x420.png 1190w" sizes="(max-width: 2436px) 100vw, 2436px" />][8]

See the `stderr` output in the middle, that scrolls off to the right? Difficult to read, right? Let’s see what happens when we click the new “WRAP LINES” button:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/06/output_lines_wrapped.png" alt="" width="2426" height="1282" class="alignnone size-full wp-image-6910" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/06/output_lines_wrapped.png 2426w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_lines_wrapped-150x79.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_lines_wrapped-300x159.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_lines_wrapped-768x406.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_lines_wrapped-1024x541.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_lines_wrapped-80x42.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_lines_wrapped-220x116.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_lines_wrapped-189x100.png 189w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_lines_wrapped-280x148.png 280w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_lines_wrapped-450x238.png 450w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_lines_wrapped-750x396.png 750w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_lines_wrapped-922x487.png 922w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_lines_wrapped-1126x595.png 1126w" sizes="(max-width: 2426px) 100vw, 2426px" />][9]

Looking better already. But those `\n` characters are annoying. So let’s click “SHOW NEWLINES”:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/06/output_newlines_rendered.png" alt="" width="2428" height="1280" class="alignnone size-full wp-image-6911" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/06/output_newlines_rendered.png 2428w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_newlines_rendered-150x79.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_newlines_rendered-300x158.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_newlines_rendered-768x405.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_newlines_rendered-1024x540.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_newlines_rendered-80x42.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_newlines_rendered-220x116.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_newlines_rendered-190x100.png 190w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_newlines_rendered-280x148.png 280w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_newlines_rendered-451x238.png 451w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_newlines_rendered-750x395.png 750w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_newlines_rendered-924x487.png 924w, https://stackstorm.com/wp/wp-content/uploads/2017/06/output_newlines_rendered-1129x595.png 1129w" sizes="(max-width: 2428px) 100vw, 2428px" />][10]

Much more readable!

Here’s a few other changes we’ve made:

  * Actions parameters are now listed with required parameters first, followed by alphabetical order
  * Drop-down lists now work properly on Windows browsers (Yes. Yes, in 2017, cross-platform browser compatibility is still a hassle).
  * You can now enter an array of objects as a parameter

### Pack-Related Changes

We’ve made a few changes to pack configuration and management. Here’s some things to watch out for:

  * Packs that use the old-style `config.yaml` will now generate a warning on reload. Version 2.4 will raise a fatal error if you still have the old-style configuration. **Upgrade any remaining packs to `config.schema.yaml` now**. Check the [docs for details][11].
  * If your `config.schema.yaml` defines an item as having a default value, but `required: false`, it will now return that default value if you didn’t define it in your configuration. Makes much more sense than the previous approach, where the default value was only returned if you had `required: true`.
  * Invalid semver version strings (e.g. `2.0`) are no longer supported. You must switch to full semver-style version strings, e.g. `2.0.2`. This was originally deprecated in StackStorm v2.1.0.
  * The `dest_server` parameter has been removed from the `linux.scp` action. Going forward simply specify the server as part of the source and / or destination arguments.
  * New actions in the ChatOps pack: `chatops.match`, `chatops.match_and_execute` and `chatops.run`.

### New RBAC/LDAP Features

Lots of improvements here for our Enterprise users. The biggest one is that you can now automatically grant roles, based upon [LDAP group membership][12]. This makes it **much** simpler to manage users in LDAP environments. Just add new users to the right groups in LDAP/AD, and they’ll get granted the right roles.

We’ve added new API and CLI options to retrieve user role assignment information. Check out commands like `st2 role list`, `st2 role-assignment-list`, and more. Actions run through the API will also now include the `rbac` dictionary with `user` and `roles_action_context` attributes.

We’ve also added RBAC controls for more endpoints, such as traces, API\_KEY\_CREATE, timers, webhooks, policies and more.

Thanks to one of our favorite customers for their help developing & testing these capabilities.

Note: RBAC, LDAP and Workflow Designer are only available in Brocade Workflow Composer. Check [this table for feature comparison, and sign up for a free 90-day trial][13].

## Miscellaneous Bugfixes & Improvements

Here’s a few smaller bugfixes and improvements:

  * You can now provide a custom list of attribute names to mask in log messages, by setting the `log.mask_secrets_blacklist` configuration option.
  * Trigger payload validation can now be disabled (you were always _meant_ to be able to, but that was broken).
  * Lower default TTLs can be set for user access tokens.
  * Variables and parameter values now support non-ASCII (Unicode) characters.
  * Fixed bug with querying Mistral task status that could result in 100% CPU usage.

And as always, here’s the full [changelog][14].

## New & Updated Packs

We’ve added quite a few new and updated packs over the last few months. Here’s just a few:

New packs:  
* [Active Directory][15] thanks to [Nick][16] @ [Encore Technologies][17]  
* [Netbox][18] &#8211; DigitalOcean IPAM tool  
* [A10][19] &#8211; A10 ADC  
* [Prometheus][20] &#8211; Prometheus Monitoring/TSDB

Updates:  
* [PagerDuty][21] &#8211; new library, APIv2 and aliases. If you’re using PagerDuty, you must upgrade before PagerDuty shuts down their old API.  
* [Kubernetes][22] &#8211; updates for v1.5.  
* [Kafka][23] &#8211; GCP Stackdriver support.  
* [AWS][24] &#8211; ChatOps aliases.  
* [Azure][25] &#8211; Resource Manager support.

NB: All Exchange packs have been updated to use `config.schema.yaml`. You should upgrade your packs, and migrate their configuration before StackStorm 2.4 is released.

## A Thank You

As ever, thank you to you, our user, contributors and friends, for the bug reports and code contributions. Here’s **just a few** of those who’ve helped out recently:  
[Cody A Ray][26], [Andrew Regan][27], [John Anderson][28], [Sean Reifschneider][29], [Carles Figuerola][30], [Anthony Shaw][31], [Nick Maludy][32], [nullkarma][33]

There are many others, and we have not forgotten you. Thanks for everything you do!

## How Do I Upgrade?

As usual: Backup first. You can then use `apt/yum` to upgrade the ST2 packages.

A few things to watch for:

  * Pack validation has been tightened up with recent versions. You may need to modify your packs, especially if you’re upgrading from pre-2.1 versions. Pay attention to warnings and errors when ST2 is restarted. A good design pattern is to set up a new ST2 system, and load your packs and workflows into that system, to check that everything validates correctly.
  * Update the `st2` pack before starting the rest of the upgrades, with `st2 pack install st2`

Read the [general upgrade guidelines][34], and check the version-specific [upgrade notes][35] for more details.

If you run into problems, join our [Slack community][36] for help.

## So What’s Next?

We’re already working on our next release. Our current plan is to knock off some of the annoying little [bugs and issues][37] that have been hanging around for a while. It’s not as exciting as new features, but we know that it makes a real difference to you. If you’ve got a pet-peeve, make sure that it’s logged &#8211; or if someone else has already logged it, add a ‘+1’.

We are working on features too: major ones are Pack installation & configuration via the Web UI, and a new `st2.ask` feature, which will let you pause workflows and seek approval before continuing.

Questions/issues/suggestions for new features? Hit us up on [Slack][36], or via [GitHub][37].

 [1]: https://api.stackstorm.com
 [2]: https://stackstorm.com/wp/wp-content/uploads/2017/06/st2_api_docs.png
 [3]: https://github.com/StackStorm/st2/pull/2727
 [4]: https://github.com/enykeev
 [5]: https://www.openapis.org/
 [6]: https://github.com/leleSahil
 [7]: https://github.com/StackStorm/st2web/pull/351
 [8]: https://stackstorm.com/wp/wp-content/uploads/2017/06/execution_output_before.png
 [9]: https://stackstorm.com/wp/wp-content/uploads/2017/06/output_lines_wrapped.png
 [10]: https://stackstorm.com/wp/wp-content/uploads/2017/06/output_newlines_rendered.png
 [11]: https://docs.stackstorm.com/reference/pack_configs.html
 [12]: https://docs.stackstorm.com/rbac.html#automatically-granting-roles-based-on-the-user-ldap-group-membership
 [13]: https://stackstorm.com/#ewc
 [14]: https://docs.stackstorm.com/changelog.html
 [15]: https://github.com/StackStorm-Exchange/stackstorm-activedirectory
 [16]: https://github.com/nmaludy
 [17]: https://github.com/EncoreTechnologies/
 [18]: https://github.com/StackStorm-Exchange/stackstorm-netbox
 [19]: https://github.com/StackStorm-Exchange/stackstorm-acos
 [20]: https://github.com/StackStorm-Exchange/stackstorm-prometheus
 [21]: https://github.com/StackStorm-Exchange/stackstorm-pagerduty
 [22]: https://github.com/StackStorm-Exchange/stackstorm-kubernetes
 [23]: https://github.com/StackStorm-Exchange/stackstorm-kafka
 [24]: https://github.com/StackStorm-Exchange/stackstorm-aws
 [25]: https://github.com/StackStorm-Exchange/stackstorm-azure
 [26]: https://github.com/codyaray
 [27]: https://github.com/andrew-regan
 [28]: http://blog.lampwins.com
 [29]: http://www.jafo.ca
 [30]: https://github.com/Carles-Figuerola
 [31]: https://github.com/tonybaloney
 [32]: https://github.com/EncoreTechnologies
 [33]: https://github.com/nullkarma
 [34]: https://docs.stackstorm.com/install/upgrades.html
 [35]: https://docs.stackstorm.com/upgrade_notes.html
 [36]: https://stackstorm.com/community-signup
 [37]: https://github.com/StackStorm/st2/issues