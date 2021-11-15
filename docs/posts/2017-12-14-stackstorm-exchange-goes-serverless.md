---
title: StackStorm Exchange goes Serverless
author: Dmitri Zimine
type: post
date: 2017-12-14T09:00:10+00:00
url: /2017/12/14/stackstorm-exchange-goes-serverless/
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6348393626
tcb_editor_disabled:
  - 1
categories:
  - Blog
  - Community
tags:
  - Community
  - exchange
  - serverless

---
Run [StackStorm Exchange][1] actions as AWS Lambda functions. Serverless and Stormless. 100% Open Source.

_December 14, 2017_  
_by [Dmitri Zimine][2]_

[StackStorm Exchange][1] is an open source catalog of reusable actions. Integrations with everything ranging from common-man DevOps tools, suit and tie services like ServiceNow and Remedy to cool kids like Slack or Twilio, to more exotic systems like HUE Lights and Tesla cars. At the time of writing, there are 6500+ actions spread across 130 integration packs. It is Open Source, with a great community of maintainers. Something that makes StackStorm a great wiring tool to build automations integrating a wide breadth of domains.

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-13-at-11.55.32-PM.png" alt="" width="1350" height="746" class="aligncenter size-full wp-image-7556" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-13-at-11.55.32-PM.png 1350w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-13-at-11.55.32-PM-150x83.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-13-at-11.55.32-PM-300x166.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-13-at-11.55.32-PM-768x424.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-13-at-11.55.32-PM-1024x566.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-13-at-11.55.32-PM-80x44.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-13-at-11.55.32-PM-220x122.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-13-at-11.55.32-PM-181x100.png 181w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-13-at-11.55.32-PM-271x150.png 271w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-13-at-11.55.32-PM-431x238.png 431w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-13-at-11.55.32-PM-750x415.png 750w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-13-at-11.55.32-PM-881x487.png 881w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-13-at-11.55.32-PM-1077x595.png 1077w" sizes="(max-width: 1350px) 100vw, 1350px" /> 

But if you’ve taken a red pill and gone wholesale on AWS running serverless, deploying [StackStorm][3] may be not an option. Yet the catalog of reusable functions to integrate with commonly used services is an appealing idea. C’mon there should be 1000 Slack lambdas and 10,000 Twilio lambdas out there already, it doesn’t feel creative to write 10,001? Jealous to Azure with their [great library of reusable connectors][4]? Why can’t YOU grab something ready-to-use?

Now you can! Run StackStorm Exchange actions as lambda functions. Without StackStorm. **Serverless and Stormless.**

> Consider a detailed tutorial [&#8220;Building a community sign-up app with Serverless, StepFunctions, and StackStorm Exchange&#8221;][5] to really get your hands dirty and try this out for real.

<!--more-->

You’ll need AWS account and [Serverless Framework][6] – the most popular serverless framework (errr… I struggle with this sentence but yes, they called it “Serverless Framework”, so watch Caps to tell apart a buzzword from the framework). If you’ve gone serverless (buzzword) you’re likely using Serverless (framework) already. If you haven’t picked one yet, [Serverless][6] is a safe choice.

The framework is a CLI toolkit for deploying and operating serverless architectures, with a pitch line – drums&#8230; &#8211; “Focus on your application, not your infrastructure”. You write your functions as JavaScript, Python, Java, or Go, and point to them in a `serverless.yml` file. The framework does all the infrastructure work to forklift your functions to the cloud, and offers convenient CLI tools that make serverless development workflow fast and enjoyable.

With our new [serverless-plugin-stackstorm][7], you can just point to an action from any integration pack available on StackStorm Exchange. Like this:

<pre><code class="yaml:"># serverless.yml
...
functions:
    # With classic Serverless Python function,
    # point `handler` to an entrypoint in your python code:
    hello_world:
        handler: handler.hello

    # With serverless-plugin-stackstorm,
    # point to an action in a pack from StackStorm Exchange:
    get_github_issue:
        stackstorm:
        action: github.get_issue # &lt;pack.action&gt; ...
</code></pre>

Under the hood, the plugin pulls the integration pack from [StackStorm Exchange][1], builds a python bundle, deploys it on AWS and turn the action to Lambda, mapping the input and output as desired. Don’t be scared when you see a Docker container spinning up: we use it for a build environment to make sure the lambdas will be binary compatible no matter what OS you&#8217;re using in development.

For detailed instructions see the [plugin’s README.md][7]. For some technical highlights, read on.  
Or jump straight to playing with it – and if you like the idea, please give it a star! <a class="github-button" href="https://github.com/stackstorm/serverless-plugin-stackstorm" data-icon="octicon-star" data-size="large" aria-label="Star stackstorm/serverless-plugin-stackstorm on GitHub">Star</a>

* * *

#### Q: Do I need to run StackStorm to use it?

No. It’s Stormless. We reuse StackStorm action-runner runtime to execute actions on AWS Lambda, but it’s already part of the plugin and you don’t have to care. If you are curious about StackStorm – [grab the StackStorm Docker container][8] and play with it. It will help if you want to build packs and contribute to StackStorm Exchange, but it’s not required.

#### Q: Can I still write a function myself?

Yes, you can and you sure will. The business logic goes to your code, and repeatable plumbing comes from reusable integration packs. On this token: once you write something that might be reusable by community, post it up to Exchange for good Open Source karma. We also send nice stickers, mugs and T-shirts!

#### Q: How do I know what the action parameters are?

Use the `info –action`. Like this:

`sls stackstorm info --action slack.post_message`

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.19.44-AM.png" alt="" width="863" height="277" class="size-full wp-image-7555" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.19.44-AM.png 863w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.19.44-AM-150x48.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.19.44-AM-300x96.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.19.44-AM-768x247.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.19.44-AM-80x26.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.19.44-AM-220x71.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.19.44-AM-250x80.png 250w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.19.44-AM-280x90.png 280w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.19.44-AM-510x164.png 510w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.19.44-AM-750x241.png 750w" sizes="(max-width: 863px) 100vw, 863px" /> 

#### Q: But what if my event payload doesn’t match action parameters?

We offer transformation with Jinja syntax to transform the payload to action input: look at the example below. Notice that you can also do this to transform the action output to your desirable shape.

    # serverless.yml
    ...
    functions:
        get_issue:
            events:
                - http:
                    method: GET
                    path: issues/{user}/{repo}/{issue_id}
                    # Sample event payload:
                    # { "pathParameters":
                    # {"user": "StackStorm", "repo": "st2", "issue_id": "3785"}
                    # }
            stackstorm:
                action: github.get_issue
                    input:
                        user: "{{ input.pathParameters.user }}"
                        repo: "{{ input.pathParameters.repo }}"
                        issue_id: "{{ input.pathParameters.issue_id }}"
                    output:
                        statusCode: "{{ 200 if output.exit_code == 0 else 500 }}"
                        body: "{{ output.body }}"
                        state: "{{ output.state }}"
                        full_output: "{{ output }}"
    
    

#### Q: Can I debug and run StackStorm exchange functions locally?

Yes you can:

    sls stackstorm docker run --function get_issue \
    --verbose \
    --passthrough \
    -d '{"pathParameters": {"user": "StackStorm", "repo": "st2", "issue_id": "3785"}}'
    

Note the `--passthrough` option that let you omit action body invocation – this comes in handy when testing or debugging the parameter transformation.

And `--verbose` will output the details on the input and output transformations:

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.14.00-AM.png" alt="" width="860" height="712" class="size-full wp-image-7551" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.14.00-AM.png 860w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.14.00-AM-150x124.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.14.00-AM-300x248.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.14.00-AM-768x636.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.14.00-AM-80x66.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.14.00-AM-220x182.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.14.00-AM-121x100.png 121w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.14.00-AM-181x150.png 181w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.14.00-AM-287x238.png 287w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.14.00-AM-501x415.png 501w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.14.00-AM-588x487.png 588w, https://stackstorm.com/wp/wp-content/uploads/2017/12/Screen-Shot-2017-12-14-at-12.14.00-AM-719x595.png 719w" sizes="(max-width: 860px) 100vw, 860px" /> 

One nugget here: you’ll notice syntax that is different from classic `serverless invoke local`. We run locally in a Docker container for better compatibility with actual AWS Lambda execution environment.

#### Q: Is this the only nugget? What else should I be aware of?

The plugin is hot off the press: we are still improving UX, refining syntax and CLI, speeding up builds and local experience. But once the function is deployed, it’s just your standard AWS Lambda, and as rock-solid as any Lambda. And if you see something – say something: [file bugs][9], share irritations, propose improvements. PRs are the most welcome!

* * *

We are also happy to share that we are bringing Serverless community developers to [StackStorm Exchange][1] as reviewers and co-owners. Both communities &#8211; [StackStorm][10] and [Serverless][11] – will greatly benefit from a growing catalog of reusable functions for your projects, 100% Open Source.

Let&#8217;s rock! Ping us on [StackStorm Slack][12] (signup [here][13]) or [Serverless Gitter][14], or on Twitter [@Stack_Storm][15] & [@goserverless][16] with your feedback.

<!-- Place this tag in your head or just before your close body tag. -->

 [1]: https://exchange.stackstorm.org/
 [2]: https://twitter.com/dzimine
 [3]: https://stackstorm.com/
 [4]: https://docs.microsoft.com/en-us/azure/connectors/apis-list#popular-connectors
 [5]: https://medium.com/@dzimine/tutorial-building-a-community-on-boarding-app-with-serverless-stepfunctions-and-stackstorm-b2f7cf2cc419
 [6]: https://serverless.com/framework/
 [7]: https://github.com/StackStorm/serverless-plugin-stackstorm
 [8]: https://github.com/StackStorm/st2-docker
 [9]: https://github.com/StackStorm/serverless-plugin-stackstorm/issues
 [10]: https://stackstorm.com/#community
 [11]: https://serverless.com/
 [12]: stackstorm-community.slack.com
 [13]: https://stackstorm.com/community-signup
 [14]: https://gitter.im/serverless/serverless
 [15]: https://twitter.com/Stack_Storm
 [16]: https://twitter.com/goserverless