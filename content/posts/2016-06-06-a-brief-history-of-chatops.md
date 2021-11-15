---
title: A brief history of ChatOps (at StackStorm)
author: st2admin
type: post
date: 2016-06-07T06:22:16+00:00
url: /2016/06/06/a-brief-history-of-chatops/
dsq_thread_id:
  - 4890074576
tcb2_ready:
  - 1
thrive_post_fonts:
  - '[]'
categories:
  - Blog
tags:
  - chatops

---
**June 7, 2016**  
_by Edward Medvedev_

ChatOps has been a key part of StackStorm from the outset. Even before 1.0, our first public release, you could execute any action or workflow from your chat window and get a bunch of text in response. Like this:

![][1]  
_StackStorm 1.0, September 2015_

Last September (even less than a year ago, to think about it) ChatOps as a defined collaboration model was still relatively new, and the ability to execute a StackStorm action or workflow from chat was enough to excite early adopters. You could make basic workflows and routine actions work, and it made your job a little easier while keeping your teammates in the loop. However, when you wanted to read and share the output, a dumped Python object as a response wasn&#8217;t ideal.

<!--more-->

In December we released StackStorm 1.2, entirely dedicated to ChatOps. Recognizing the need for better output, we introduced custom formatting and Jinja templates to action aliases, so that your bot could give a nicely formatted message in response to a command.

![][2] 

_StackStorm 1.2, December 2015_

This change — along with other features, like regex commands and separate help entries — made interaction with a bot much easier. There was nearly no limit to customization of your ChatOps messages, but sometimes &#8220;nearly&#8221; just doesn&#8217;t quite cut it.

Going from there, how do we make things even better?

We decided to aim higher. Instead of competing with other bots and ChatOps services, we wanted to compete with native integrations. Instead of being a middleware between you and your chat service, we wanted to give you, the user, full flexibility that your chat&#8217;s API provides. Instead of just formatting text, we wanted you to work with images, links, headers, colors and extra fields.

![][3] 

_DataDog integration with Slack_

Good news: it&#8217;s all possible in StackStorm 1.4! Action aliases now allow an additional field called `extra`:

    ---
    name: "kitten"
    description: "Post a kitten picture to cheer people up."
    action_ref: "core.noop"
    formats:
      - "kitten pic"
    ack:
      enabled: false
    result:
      format: "your kittens are here! {~} Regards from the Box Kingdom."
      extra:
        slack:
          image_url: "http://i.imgur.com/Gb9kAYK.jpg"
          fields:
            - title: Kitten headcount
              value: Eight.
              short: true
            - title: Number of boxes
              value: A bunch.
              short: true
          color: "#00AA00"
    

Everything that&#8217;s specified in `extra.<service>` will be passed to that service&#8217;s API as is (see [Slack Attachment API][4]). Every bit of customization that&#8217;s possible with your chat software&#8217;s API can now be achieved in StackStorm:

![][5]  
_StackStorm 1.4, May 2016_

One more thing? Parameters in `extra` support Jinja templating, too, and they have the same context as `output.format`:

    [...]
    formats:
      - "say {{ phrase }} in {{ color }}"
    result:
      extra:
        slack:
          color: "{{execution.parameters.color}}"
    [...]
    

![][6] 

Starting with 1.4, this feature is available for Slack users, and support for other chat providers is, of course, coming soon.

* * *

While this change may not affect everyone, for some use cases it&#8217;s invaluable: you can insert charts and diagrams, preview images, format messages with extra fields, add colors for instant status recognition, and overall have a full-featured alternative for native integrations—one that is powered by StackStorm.

We&#8217;re looking forward to seeing what you can come up with! You&#8217;re welcome to send pull requests into the [contributions repo][7] or visit our [Slack community][8] to get support, share your formatting examples, send pictures of pugs, or just have a chat. ❤️

_— Ed_

 [1]: http://i.imgur.com/aJCOKC9.png
 [2]: http://i.imgur.com/ccus3w1.png
 [3]: https://api.slack.com/img/api/attachment_example_datadog.png
 [4]: https://api.slack.com/docs/attachments
 [5]: http://i.imgur.com/Yf4IeHO.png
 [6]: http://i.imgur.com/ARiRK0G.png
 [7]: https://exchange.stackstorm.org
 [8]: https://stackstorm.com/community-signup