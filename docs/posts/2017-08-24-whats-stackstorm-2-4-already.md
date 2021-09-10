---
title: What’s This? StackStorm 2.4 Already?
author: st2admin
type: post
date: 2017-08-24T17:00:03+00:00
url: /2017/08/24/whats-stackstorm-2-4-already/
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6092541648
categories:
  - Blog
  - Community
  - News
tags:
  - chatops
  - release

---
We had said we were planning on releasing StackStorm 2.4 [in September][1]. Well, we changed our mind: StackStorm 2.4 has just been released. We wanted to get some of these new features out now, rather than wait. Pack UI, Workflow pause & resume, ChatOps fixes, and more. Read on to see what we&#8217;ve done.

## Web UI:

Ooh boy, lots of stuff has been happening here. The first feature you&#8217;ll see is the new &#8220;Packs&#8221; tab:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/08/packs_tab.png" alt="" width="975" height="490" class="aligncenter size-full wp-image-7001" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/08/packs_tab.png 975w, https://stackstorm.com/wp/wp-content/uploads/2017/08/packs_tab-150x75.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/08/packs_tab-300x151.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/08/packs_tab-768x386.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/08/packs_tab-80x40.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/08/packs_tab-220x111.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/08/packs_tab-199x100.png 199w, https://stackstorm.com/wp/wp-content/uploads/2017/08/packs_tab-280x141.png 280w, https://stackstorm.com/wp/wp-content/uploads/2017/08/packs_tab-474x238.png 474w, https://stackstorm.com/wp/wp-content/uploads/2017/08/packs_tab-750x377.png 750w, https://stackstorm.com/wp/wp-content/uploads/2017/08/packs_tab-969x487.png 969w" sizes="(max-width: 975px) 100vw, 975px" />][2]

<!--more-->

There&#8217;s a lot going on here. You can see your installed packs, and available packs. If you select a pack, you can see some information about the pack, and install it.

You can also configure or remove any installed pack:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_pack.png" alt="" width="975" height="546" class="aligncenter size-full wp-image-7002" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_pack.png 975w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_pack-150x84.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_pack-300x168.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_pack-768x430.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_pack-80x45.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_pack-220x123.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_pack-179x100.png 179w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_pack-268x150.png 268w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_pack-425x238.png 425w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_pack-741x415.png 741w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_pack-870x487.png 870w" sizes="(max-width: 975px) 100vw, 975px" />][3]

And check this out:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/08/pack_versions.png" alt="" width="965" height="421" class="aligncenter size-full wp-image-7003" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/08/pack_versions.png 965w, https://stackstorm.com/wp/wp-content/uploads/2017/08/pack_versions-150x65.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/08/pack_versions-300x131.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/08/pack_versions-768x335.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/08/pack_versions-80x35.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/08/pack_versions-220x96.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/08/pack_versions-229x100.png 229w, https://stackstorm.com/wp/wp-content/uploads/2017/08/pack_versions-280x122.png 280w, https://stackstorm.com/wp/wp-content/uploads/2017/08/pack_versions-510x222.png 510w, https://stackstorm.com/wp/wp-content/uploads/2017/08/pack_versions-750x327.png 750w" sizes="(max-width: 965px) 100vw, 965px" />][4]

See how the Jira and Sensu packs above have their version number highlighted? Click on that pack, and you can see your current version and the latest version. It’s a quick and easy way to see which of your installed packs have updates available.

That&#8217;s not the only new thing. Click on the History tab, then click on the timestamp next to an entry.

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_1.png" alt="" width="975" height="442" class="aligncenter size-full wp-image-7004" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_1.png 975w, https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_1-150x68.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_1-300x136.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_1-768x348.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_1-80x36.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_1-220x100.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_1-221x100.png 221w, https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_1-280x127.png 280w, https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_1-510x231.png 510w, https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_1-750x340.png 750w" sizes="(max-width: 975px) 100vw, 975px" />][5]

Click on it again. See that?

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_2.png" alt="" width="975" height="448" class="aligncenter size-full wp-image-7005" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_2.png 975w, https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_2-150x69.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_2-300x138.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_2-768x353.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_2-80x37.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_2-220x101.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_2-218x100.png 218w, https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_2-280x129.png 280w, https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_2-510x234.png 510w, https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_2-750x345.png 750w" sizes="(max-width: 975px) 100vw, 975px" />][6]

When you click on the time, it changes between UTC and your local timezone. Nifty, eh?

We&#8217;ve also made a few other small fixes and changes, including:

  * Position sorting: Parameters are displayed in the Web UI in this order: Firstly, based upon `position` value in the action metadata. Then `required` parameters are displayed in alphabetical order. Finally, any remaining optional parameters are displayed, again in alphabetical order.
  * Arrays can be entered as either JSON or a comma-delimited list.

## Workflow Pause & Resume

Mistral and ActionChain workflows can now be paused and resumed. You can run `st2 execution pause <execution-id>` and `st2 execution resume <execution-id>` to pause and resume a workflow. </execution-id></execution-id>

If you pause a workflow, that status flows down to any sub-workflows. You can then resume that individual sub-workflow, which is handy for testing.

This feature lays the groundwork for our upcoming `st2.ask` feature &#8211; see more below.

## Configuration Values in Action Metadata

Ever wanted to reference a value from your pack configuration in your action parameters? Now you can. Use the `config_context` prefix. For example, if your pack configuration contains `from_number`, you could refer to it in your action metadata like this:

<pre><code class="yaml">---
...
parameters:
from_number:
type: "string"
description: "Your twilio 'from' number in E.164 format. Example +14151234567."
required: false
position: 0
default: "{{config_context.from_number}}"
</code></pre>

## ChatOps

ChatOps has also seen some attention with this release. Some of the key points include upgrading Node.js to 6.x and upgrading hubot-slack to 4.3. This fixes multiple issues related to proxies, user highlighting, and improves reliability when Slack gets disconnected.

We&#8217;ve also fixed some packaging issues here, which should resolve some issues we saw related to Node.js dependencies. Fewer problems all around in future.

If you&#8217;re upgrading, pay attention to the [manual steps][7] to upgrade your Node.js version.

## Custom Filters Now Available in Mistral Workflows

In previous versions of StackStorm, we provided a number of [custom filters][8] to augment what you could do to transform data in your ActionChain workflows. Until version 2.4, these were only available in Jinja snippets rendered within StackStorm, meaning they were not available to Mistral workflows. However, as of 2.4 these have been made available to Mistral workflows as well.

Note also &#8211; if you&#8217;ve used the `st2kv` filter to retrieve values from the datastore, that behavior has been modified slightly. It will now no longer attempt to decrypt any encrypted values by default &#8211; you must specify this as an optional parameter to that function. Take a look at the [upgrade notes][9] for more details.

## Miscellaneous Fixes, Changes and Improvements

  * Pack registration will now fail if your pack contains a `config.yaml` file. This feature was deprecated a while ago, and version 2.3 logged WARNING messages about it. You **must** migrate to [new-style pack configuration][10]. Trust us, it&#8217;s worth it.
  * The default version of MongoDB installed on new systems is now v3.4. You can keep using v3.2 on your existing systems, or upgrade. Up to you.
  * When you install a pack via `st2 pack install {pack}`, it will now tell you how many rules, sensors, and actions it is installing. This gives you a clue that it _might_ take a while if the pack is huge. _cough_ [AWS][11] _cough_.
  * In a related change, we fixed some timeout issues occurring on slower systems when installing large packs. Yes, I&#8217;m still looking at you, AWS pack.
  * Specifying arrays of objects when using `st2 run` is a bit easier now &#8211; see [#3670][12].
  * Logrotate configs are now a bit better behaved with stale st2actionrunner log files.
  * Several issues related to the message bus and queue registration have been resolved. Thanks to John Arnold for his help here.

## Upgrading

Packages are now available in `apt` and `yum` repos. Make sure you backup first, and check the [upgrade notes][13], especially if you&#8217;re upgrading from pre-2.2. It&#8217;s a good time to update your packs too. Check out the Pack UI to quickly see which installed packs have updates available.

As always, if you run into any problems, get in touch via [Slack][14] or [GitHub][15].

## What&#8217;s Next?

We&#8217;re now working on features for 2.5. These include:

  * Streaming API!!! We know, you&#8217;ve been asking for this [FOREVER][16]. Well, we now have WIP code. If you&#8217;re interested in this, please check out PR [#3657][17], and have a read through the comments there.
  * `st2.ask` &#8211; WIP code is [here][18]
  * [Common pack Python &#8216;lib&#8217; directory][19] that can be used by both sensors & actions

We&#8217;re hoping to ship v2.5 in the next two months.

See you on [Slack!][14]

 [1]: https://stackstorm.com/2017/07/28/stackstorm-2-3-2-summer-bugfixes-continues/
 [2]: https://stackstorm.com/wp/wp-content/uploads/2017/08/packs_tab.png
 [3]: https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_pack.png
 [4]: https://stackstorm.com/wp/wp-content/uploads/2017/08/pack_versions.png
 [5]: https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_1.png
 [6]: https://stackstorm.com/wp/wp-content/uploads/2017/08/timezone_2.png
 [7]: https://docs.stackstorm.com/install/upgrades.html#v2-4
 [8]: https://docs.stackstorm.com/reference/jinja.html#custom-jinja-filters
 [9]: https://docs.stackstorm.com/upgrade_notes.html#st2-v2-4
 [10]: https://docs.stackstorm.com/reference/pack_configs.html
 [11]: https://github.com/StackStorm-Exchange/stackstorm-aws
 [12]: https://github.com/StackStorm/st2/pull/3670
 [13]: https://docs.stackstorm.com/upgrade_notes.html
 [14]: https://stackstorm.com/community-signup
 [15]: https://github.com/StackStorm/st2/issues
 [16]: https://github.com/StackStorm/st2/issues/2175
 [17]: https://github.com/StackStorm/st2/pull/3657
 [18]: https://github.com/StackStorm/st2/pull/3537
 [19]: https://github.com/StackStorm/st2/pull/3658