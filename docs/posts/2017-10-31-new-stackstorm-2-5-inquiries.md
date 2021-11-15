---
title: 'New in StackStorm 2.5: Inquiries'
author: st2admin
type: post
date: 2017-10-31T16:29:25+00:00
url: /2017/10/31/new-stackstorm-2-5-inquiries/
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6254168167
categories:
  - Tutorials
tags:
  - new feature

---
<p dir="ltr">
  <strong>October 31, 2017</strong><br /> <em>by Matt Oswalt</em>
</p>

[StackStorm 2.5][1]  introduces one of our most highly requested features: “[Inquiries][2]”. Inquiries are a way of “asking a question” in the middle of a workflow (Mistral or ActionChain), to get additional data before moving on.

For instance, while you can store service credentials in the StackStorm datastore and retrieve them using a Jinja snippet, some services require two-factor authentication. It’s necessary, therefore, to be able to pause the workflow at a certain point, and allow a human to “inject” this data into the workflow midstream. There are a number of other use cases for this functionality, including the simple “I’m about to do something stupid dangerous, should I proceed?”.

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/10/swtn.gif" alt="" width="346" height="195" class="size-full wp-image-7150 aligncenter" />][3]

Before we get into Inquiries and how they work, an important note: we’ve been working hard on making sure the new feature is useful for a variety of use cases, and as robust as possible. However, it is a complex and fairly low-level feature that has a lot of moving parts, and before recommending it for production use, we’d like to spend a release cycle gathering feedback on the API and the user experience. So, for 2.5, we would love for you to use this feature in your test/dev deployments of StackStorm and let us know what you think. Don’t worry, this is not going to stay “alpha” forever! We expect that it will be “production ready” in StackStorm 2.6, due to ship later this year.

<!--more-->

## New Action &#8211; “core.ask”

In order to make use of Inquiries in a workflow, we’re introducing a new action: “core.ask”. In order to “ask a question” in your workflow, simply use this action where you would like this question to be asked.

The “core.ask” action supports a number of parameters, but the most important one by far is the ”schema” parameter. This parameter defines exactly what kind of responses will satisfy the Inquiry, and allow the workflow to continue. When users respond to this Inquiry, the response data that gets sent to the StackStorm API must validate against this schema in order to satisfy the Inquiry and allow the workflow to continue. It sounds a bit complicated, but don’t worry, the “st2” client makes it easy to put together a valid response. We’ll walk through that soon.

Here’s a simple ActionChain that uses “core.ask” to ask for a second-factor authentication parameter using “core.ask”:

<pre class="EnlighterJSRAW" data-enlighter-language="yaml">chain:

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
</pre>

Executing this workflow results in a “pending” status for “task1”, and the ActionChain itself is “paused”.

<pre class="EnlighterJSRAW" data-enlighter-language="text">~$ st2 run examples.chain-test-inquiry
.
id: 59d1ecb632ed353f1f340898
action.ref: examples.chain-test-inquiry
parameters: None
status: paused
result_task: task1
result:
  roles: []
  route: developers
  schema:
    properties:
      secondfactor:
        description: Please enter second factor for authenticating to "foo" service
        required: true
        type: string
    type: object
  ttl: 1440
  users: []
start_timestamp: 2017-10-02T07:37:26.854217Z
end_timestamp: None
+--------------------------+---------+-------+----------+-------------------------------+
| id                       | status  | task  | action   | start_timestamp               |
+--------------------------+---------+-------+----------+-------------------------------+
| 59d1ecb732ed353ec4aa9a5a | pending | task1 | core.ask | Mon, 02 Oct 2017 07:37:27 UTC |
+--------------------------+---------+-------+----------+-------------------------------+
</pre>

The workflow will remain paused until a response is received that validates against the provided schema.

## Viewing and Responding to Inquiries

A new subcommand: “st2 inquiry” has been added to the StackStorm CLI. Using this, you can “list” existing Inquiries, “get” a specific Inquiry, or “respond” to an Inquiry.

“st2 inquiry list” shows a summary of existing Inquiries:

<pre class="EnlighterJSRAW" data-enlighter-language="text">~$ st2 inquiry list
+--------------------------+-------+-------+------------+------+
| id                       | roles | users | route      | ttl  |
+--------------------------+-------+-------+------------+------+
| 59d1ecb732ed353ec4aa9a5a |       |       | developers | 1440 |
+--------------------------+-------+-------+------------+------+
</pre>

Like most other resources in StackStorm, we can use the `get` subcommand to retrieve details about this Inquiry, using its ID provided in the previous output:

<pre class="EnlighterJSRAW" data-enlighter-language="text">~$ st2 inquiry get 59d1ecb732ed353ec4aa9a5a
+----------+--------------------------------------------------------------+
| Property | Value                                                        |
+----------+--------------------------------------------------------------+
| id       | 59d1ecb732ed353ec4aa9a5a                                     |
| roles    |                                                              |
| users    |                                                              |
| route    | developers                                                   |
| ttl      | 1440                                                         |
| schema   | {                                                            |
|          |     "type": "object",                                        |
|          |     "properties": {                                          |
|          |         "secondfactor": {                                    |
|          |             "required": true,                                |
|          |             "type": "string",                                |
|          |             "description": "Please enter second factor for   |
|          | authenticating to "foo" service"                             |
|          |         }                                                    |
|          |     }                                                        |
|          | }                                                            |
+----------+--------------------------------------------------------------+
</pre>

Since the schema is included in the Inquiry details, the client knows what kind of data is required to formulate a valid response. The “st2 respond” command will step through each of the properties in the schema, prompting you with the text in the “description” field for each property:

<pre class="EnlighterJSRAW" data-enlighter-language="text">~$ st2 inquiry respond 59d1ecb732ed353ec4aa9a5a
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
</pre>

If the response is accepted, the valid response payload will be printed to the screen, and the workflow that initially raised the Inquiry will continue. Note that the workflow we showed in the previous example now shows both tasks executed, and marked with a “succeeded” status:

<pre class="EnlighterJSRAW" data-enlighter-language="text">~$ st2 execution get 59d1ecb632ed353f1f340898
id: 59d1ecb632ed353f1f340898
action.ref: examples.chain-test-inquiry
parameters: None
status: succeeded (468s elapsed)
result_task: task2
result:
  failed: false
  return_code: 0
  stderr: ''
  stdout: We can now authenticate to foo service with bar
  succeeded: true
start_timestamp: 2017-10-02T07:37:26.854217Z
end_timestamp: 2017-10-02T07:45:14.123405Z
+--------------------------+------------------------+-------+------------+-------------------------------+
| id                       | status                 | task  | action     | start_timestamp               |
+--------------------------+------------------------+-------+------------+-------------------------------+
| 59d1ecb732ed353ec4aa9a5a | succeeded (0s elapsed) | task1 | core.ask   | Mon, 02 Oct 2017 07:37:27 UTC |
| 59d1ee8932ed353ec4aa9a5d | succeeded (1s elapsed) | task2 | core.local | Mon, 02 Oct 2017 07:45:12 UTC |
+--------------------------+------------------------+-------+------------+-------------------------------+
</pre>

Also notice that the output for this workflow contains the value we passed in to the response, “bar”. You can use the same method to pass a specific field in the response payload to another action.

## Conclusion

This was a very light introduction to Inquiries. Please see the [Inquiries documentation][2] for more information on:

  * How to secure Inquiries and restrict who can respond
  * Notifying users about new Inquiries that require their response
  * Garbage collection for Inquiries &#8211; cleaning them up after a certain period of time

We’re excited to finally release this functionality to you, and we look forward to gathering your feedback on Inquiries. We have a lot more planned that will build on top of this functionality (like tighter Chatops integration with Inquiries) and we want to make sure we get this right. So, get inquiring!

 [1]: https://stackstorm.com/2017/10/26/stackstorm-2-5-hit-streets/
 [2]: https://docs.stackstorm.com/inquiries.html
 [3]: https://stackstorm.com/wp/wp-content/uploads/2017/10/swtn.gif