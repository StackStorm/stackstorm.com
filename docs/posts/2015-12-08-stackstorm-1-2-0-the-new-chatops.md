---
title: 'StackStorm 1.2.0: the new ChatOps'
author: st2admin
type: post
date: 2015-12-08T15:07:00+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/12/08/stackstorm-1-2-0-the-new-chatops/
dsq_thread_id:
  - 4401107739
categories:
  - Blog
  - Community
  - Tutorials
tags:
  - chatops
  - devops
  - slack
  - tutorial

---
**December 8, 2015**  
_by Edward Medvedev_

ChatOps — a concept where a chat bot acts as a control plane for your operations — has always been a core part of StackStorm. It adds context to your actions, automates routine tasks nobody likes, helps team members communicate better and learn from each other, and sometimes it&#8217;s just plain fun. If you&#8217;re new to this, check out the [DevOps Next Steps talk][1] by [James Fryman][2], and if you&#8217;ve been writing Eggdrop scripts in IRC since you were five but never used it in your daily operations, you might also get inspired from the [ChatOps at GitHub talk][3] by Jesse Newland.

Today, we&#8217;re all excited to introduce — as a part of our [1.2.0 release][4] — a completely revamped ChatOps feature list. If you&#8217;re already using our Hubot integration to execute StackStorm actions from chat, stop doing whatever it is you&#8217;re doing and update! If not, it&#8217;s a good time to get started: ChatOps is the way of the future, now more than ever.

<!--more-->

This release is about control. No matter if you use StackStorm for a small personal project or a huge server farm, you want to have full control over what&#8217;s happening, and ChatOps is no exception. Now you can have a bot that&#8217;s truly yours: flexible and fully customizable, behaving exactly the way you want.

Want to have minimalistic and concise status messages? No problem.

Want to give the bot a little bit of character? You got it.

Want to name her Princess Bubblegum, eventually fall in love and heep her in your Ice Kingdom all to yourself? That’s awfully specific, but <del datetime="2015-12-10T20:03:02+00:00">we still got you covered</del> you shouldn&#8217;t do it, because princesses should be happy and free.

Instead, why don’t you name it Ancient Psychic Tandem War Elephant, make it respond to every query using psychic powers and anxiously shoot lasers out of its trunks every time @FinnTheHuman suddenly goes offline?

![][5] 

If you need a full list of changes, see our [release notes][6] and stay tuned for a more detailed post explaining all the new features; for the new ChatOps explanation-plus-tutorial, read on!

&nbsp;

### 1. Under the hood

Our engineers have been working relentlessly to improve key parts of the ChatOps deployment and make it more stable, maintainable, flexible and robust:

  * Hubot-stackstorm script now utilizes `st2client.js` (StackStorm client library), and **EventStream API** for stability and ease of use.</p> 
  * We&#8217;ve placed Hubot into a **[Docker container][7]**, so CentOS 6/7 and RHEL6/7 are now fully supported, and deployment got faster and easier.

  * **Alias parser** has been completely rewritten to allow more flexibility in regard to special characters, multi-word and multi-line matching.

  * 日本語を話しますか。 ChatOps has full **Unicode support** now!

  * The old `hubot` pack is deprecated and replaced by the **new `chatops` pack**. To show ChatOps some more love, this pack is now a part of StackStorm core.

  * Various **stability fixes** have been introduced to fix bugs and issues reported by our amazing [Slack community][8].

&nbsp;

### 2. Acknowledgement options

Every time you issue a command, Hubot acknowledges it with a random message and your execution ID, as well as a link to StackStorm page:

![][9] 

Most of the time this default is sensible, and the StackStorm link is a great way to know more about your action and get additional context. However, sometimes you may find yourself in a situation where it would make sense to modify the message.

What if you just want something different? Maybe you want to strip the IDs and links so that people without StackStorm access won&#8217;t be confused, or you just want to provide your own message, or your action doesn&#8217;t take much time and an acknowledgement seems like an overkill. Luckily, `ack` property is now available in aliases, allowing to configure the message or disable it.

Specify a format line in your alias definition:

    ack:
      format: "Aye-aye, cap'n!"
    

If you want to disable the StackStorm URL at the end, use `append_url`:

    ack:
      format: "Aye-aye, cap'n!"
      append_url: false
    

And if you want to insert execution ID in the format string, just use `{{ execution.id }}`. Simple as that!

![][10] 

You can also turn the message off with `enabled` property.

    ack:
      enabled: false
    

&nbsp;

### 3. Result options

Polly is happy:

![][11] 

But that&#8217;s a lot of information for such a small action, isn&#8217;t it? Let&#8217;s change it to something simple! Same as with `ack`, you can also format `result` if you want to strip the metadata or adjust the template in any other way.

    result:
      format: "Your action is done! {{ execution.result.result }}"
    

![][12] 

Much better now. And in a rare case you&#8217;d like to disable the result output altogether, you can use the `enabled` property here as well.

**Slack-only protip**: Slack uses attachments to format the result message. While we found attachments to be the best way to handle very long messages, sometimes you want part of your message — or all of it — in plaintext. Use `{~}` as a delimiter to do that.

That&#8217;s what `your action is done! {~} {{ execution.result.result }}` will look like:

![][13] 

Putting the delimiter at the end (`your action is done! {{ execution.result.result }}{~}`) will output everything in plaintext:

![][14] 

&nbsp;

### 4. Context and Jinja support

While `{{ execution.id }}` and `{{ execution.result.result }}` are the most common variables you&#8217;re going to need in your aliases, it&#8217;s not everything you can use by far.

Context in `ack` messages includes `execution` and `actionalias`, which in turn has action information in `actionalias.action`. Example: [ack.js][15].

Context in `result` messages is wider: it includes execution status and result, as well as stdout and stderr. Example: [result.js][16].

And here&#8217;s more good news: format strings use [Jinja][17] to render templates, so you can use filters and conditionals, too.

    ack:
      format: "Executing `{{ actionalias.ref }}`, your ID is {{ execution.id[:2] }}..{{ execution.id[-2:] }}"
    result:
      format: "{{ execution.result.result | truncate(47, True) }}"
    

![][18] 

ChatOps pack has a [neat example][19] of all the things you can do with Jinja. If you never used it before, it may look like super-wizard-class hackery, but you probably won&#8217;t need a template that complex, so don&#8217;t worry! When in doubt, look for answers in [Jinja docs][20].

### 5. Extended command parser

Whoa, what&#8217;s that? Is it a bird? Is it a plane? It&#8217;s our new alias parser! While maintaining full backwards compatibility, the new parser for commands is more flexible and supports complex patterns. Here&#8217;s a few things you couldn&#8217;t do before:

#### **Optional arguments everywhere, not just the end of the alias**

ChatOps aliases support optional arguments and arbitrary parameters at the end of the string, but starting with 1.2.0 you can specify default values for every argument no matter its position.

**Before:**

    send a letter {{ content }} {{ protocol=smtp }} {{ addressee=hubot@example.com }}
    

**Now:**

    {{ protocol="smtp" }} send {{ addressee="hubot@example.com" }} a letter: {{ content }}
    

![][21] 

#### **Multi-word and multi-line matching**

If you wanted to pass multiple words as a ChatOps command argument, you had to enclose the match in quotes and use no more than one line. Starting today, lose the quotes and pass long and even multi-line arguments as much as you want. Finally you can make your bot read wonderful poetry!

    read out loud: {{ chapter }}
    

**Before**:

    read out loud: justonewordummmm
    read out loud: "multiple words with quotes, but just one line"
    

**Now**:

![][22] 

#### **Fun with regular expressions**

Now for the most powerful feature: the new parser is regex-based, and you&#8217;re free to unleash the dark powers of regular expressions onto your aliases. This might be a good time to add some character to your bot!

**Before**:

    get my {{ thing }}
    

**Now**:

    (get|accio|fetch|beam)( (a|my|the))? {{ thing }}(,? (right now|immediately|up))?[!.]?
    

This alias will match `accio slippers` as well as `fetch the tennis ball, right now!`:

![][23] 

&nbsp;

### 6. Help representations

Now, let&#8217;s assume that you actually came up with something like `(get|accio|fetch|beam)( (a|my|the))? {{ thing }}(,? (right now|immediately|up))?[!.]?` in your production deployment. Here&#8217;s what Hubot help would look like:

![][24] 

What will happen when people see it? Will your boss give you a raise for being such a smart guy? Will your coworkers go insane trying to comprehend all this? Will you burn at the stake for doing some dark computer magic? We&#8217;ll never know, because now you can explicitly **specify a help entry** for every format string!

    formats:
      - display: "get {{ thing }}"
        representation:
          - "(get|accio|fetch|beam)( (a|my|the))? {{ thing }}(,? (right now|immediately|up))?[!.]?"
    

You can even mix &#8220;display + representation&#8221; objects with ordinary format strings:

    formats:
      - display: "get {{ thing }}"
        representation:
          - "(get|accio|fetch|beam)( (a|my|the))? {{ thing }}(,? (right now|immediately|up))?[!.]?"
      - "get {{ thing }} from {{ location }}"
      - "get {{ thing }} from {{ location }} at {{ time }}"
    

Now the masterfully crafted regex is still working, but stays hidden from public view:

![][25] 

* * *

All good things come to an end, and so does this feature list. Hope you liked it! Go crazy with all that new ChatOps goodness, and don&#8217;t forget to tell us about your awesome bots and integration scenarios in our [Slack community][8] or by [e-mail][26]. Love. ❤️

_— Ed_

 [1]: https://www.youtube.com/watch?v=37LmuHToYjQ
 [2]: https://github.com/jfryman
 [3]: http://www.youtube.com/watch?v=NST3u-GjjFw
 [4]: https://github.com/StackStorm/st2/releases/tag/v1.2.0
 [5]: http://i.imgur.com/AECYh7b.gif
 [6]: https://docs.stackstorm.com/changelog.html#december-07-2015
 [7]: https://hub.docker.com/r/stackstorm/hubot/
 [8]: https://stackstorm.com/community-signup
 [9]: http://i.imgur.com/RRbwmcP.png
 [10]: http://i.imgur.com/7K6uLVF.png
 [11]: http://i.imgur.com/vSm3mxj.png
 [12]: http://i.imgur.com/KKQMYpS.png
 [13]: http://i.imgur.com/WIc7p5W.png
 [14]: http://i.imgur.com/G6JxdkL.png
 [15]: https://gist.github.com/emedvedev/aa006be3f438d492acbc
 [16]: https://gist.github.com/emedvedev/62a50ea9c5b00449ce7b
 [17]: http://jinja.pocoo.org
 [18]: http://i.imgur.com/TV6IdIL.png
 [19]: https://github.com/StackStorm/st2/blob/master/contrib/chatops/actions/templates/default.j2
 [20]: http://jinja.pocoo.org/docs/
 [21]: http://i.imgur.com/TAgD0XA.png
 [22]: http://i.imgur.com/h35KC0q.png
 [23]: http://i.imgur.com/jqtMniL.png
 [24]: http://i.imgur.com/xfQI6bw.png
 [25]: https://i.imgur.com/LtTrFCY.png
 [26]: mailto:support@stackstorm.com