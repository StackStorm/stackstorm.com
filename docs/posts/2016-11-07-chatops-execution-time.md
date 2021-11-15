---
title: Execution Time for ChatOps commands
author: Eugen C.
type: post
date: 2016-11-07T17:00:47+00:00
url: /2016/11/07/chatops-execution-time/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5275537132
categories:
  - Blog
  - Community
  - Home
  - Tutorials
tags:
  - chatops
  - 'tips &amp; tricks'

---
**November 7, 2017**  
_by Eugen C. aka <a href="https://github.com/armab/" target="_blank">@armab</a>_

Did you know you can do something like this with [StackStorm ChatOps][1]?  
![ChatOps Command Execution time][2] 

Looks simple, but it&#8217;s a very useful thing to have in your ChatOps toolset, especially for potentially long-running commands.  
<!--more-->

This small feature was implemented a while ago, but we didn&#8217;t make much of a song and dance about it, so you might have missed it.

  * You can use `execution.elapsed_seconds` Jinja variable in [ChatOps Alias][3] template to get the action duration in seconds (`123.4422`).
  * Additionally, apply Jinja filter [`to_human_time_from_seconds`][4] and make it readable (`2m3s`)

Putting everything together in a Jinja expression:

<pre><code class="yaml">{{ execution.elapsed_seconds | to_human_time_from_seconds }}
</code></pre>

And here is a [ChatOps Alias][5] example with the [Slack attachments API][6] in place:

<pre><code class="yaml"># Example from:
# https://stackstorm.com/2015/06/24/ansible-chatops-get-started-%F0%9F%9A%80/
---
name: chatops.ansible_package_update
action_ref: st2-chatops-aliases.update_package
description: Update package on remote hosts
formats:
  - display: "update &lt;package&gt; on &lt;hosts&gt;"
    representation:
      - "update {{ package }} on {{ hosts }}"
      - "upgrade {{ package }} on {{ hosts }}"
result:
  format: |
    Update package `{{ execution.parameters.package }}` on `{{ execution.parameters.hosts }}` host(s): {~}
    {% if execution.result.stderr %}
    *Exit Status*: `{{ execution.result.return_code }}`
    *Stderr:* ```{{ execution.result.stderr }}```
    *Stdout:*
    {% endif %}
    ```{{ execution.result.stdout }}```
  extra:
    slack:
      color: "{% if execution.result.succeeded %}good{% else %}danger{% endif %}"
      fields:
        - title: Updated nodes
          value: "{{ execution.result.stdout|regex_replace('(?!changed=1).', '')|wordcount }}"
          short: true
        - title: Executed in
          # THIS line
          value: ":timer_clock: {{ execution.elapsed_seconds | to_human_time_from_seconds }}"
          short: true
      footer: "{{ execution.id }}"
      footer_icon: "https://stackstorm.com/wp/wp-content/uploads/2015/01/favicon.png"
</code></pre>

> FYI: Since StackStorm [`v1.4`][7] ChatOps integrates with the [Slack attachments API][8], allowing you to produce nicely formatted message responses like you see in the screenshot. 

Enjoy!

If you have some cool ChatOps ideas &#8211; we&#8217;ll be glad to hear from you via [Feature Request][9] or meet us in [StackStorm Public Slack][10].

 [1]: https://docs.stackstorm.com/chatops/index.html
 [2]: https://i.imgur.com/evtmoCq.png
 [3]: https://docs.stackstorm.com/chatops/aliases.html
 [4]: https://docs.stackstorm.com/reference/jinja.html?highlight=to_human_time_from_seconds#applying-filters-with-jinja
 [5]: https://github.com/armab/st2-chatops-aliases/blob/master/aliases/update_package.yaml
 [6]: https://api.slack.com/docs/messages/builder
 [7]: https://stackstorm.com/2016/06/06/a-brief-history-of-chatops/
 [8]: https://docs.stackstorm.com/chatops/aliases.html#passing-attachment-api-parameters-slack-only
 [9]: https://github.com/StackStorm/hubot-stackstorm
 [10]: https://stackstorm.com/#community