---
title: How StackstormExchange Lets You Reuse Integrations With Serverless
author: st2admin
type: post
date: 2018-07-19T01:38:02+00:00
draft: true
private: true
url: /2018/07/18/how-stackstormexchange-lets-you-reuse-integrations-with-serverless/
thrive_post_fonts:
  - '[]'
categories:
  - Uncategorized

---
_<span data-mce-type="bookmark" style="display: inline-block; width: 0px; overflow: hidden; line-height: 0;" class="mce_SELRES_start">﻿</span>July 19, 2018_  
_by Bettina Baumgart_

There is a new trend in the cloud space: [serverless computing.][1] Serverless is eating the world. It grew out of the need to optimize resource usage and costs. Serverless means doing away with the underlying operating system so that code can just run and scale without these dependencies.

<!--more-->

Dmitri Zimini, the co-founder and Chief Engineer of [Stackstorm,][2] recently presented at the [San Francisco Serverless Meetup][3] run by [Serverless][4], the creators of the popular [Serverless Framework][5], an open-source CLI for building serverless architectures.

I recently caught up with Dmitri to better understand how Stackstorm fits into the serverless ecosystem.

_Question:_ Hi Dmitri. Let’s chat about what Stackstorm has to do with serverless. How it fits together. For those that have not heard about it, can you summarize what Stackstorm is?

_Answer:_ Sure, real quick: StackStorm is how people did serverless before AWS Lambda was invented. Think of AWS Lambda plus StepFunctions, plus hundreds of integrations, opensource, installable on prem or on your cloud. Mature &#8211; since 2014, and service-full.

_Question:_ How are people using Stackstorm?

_Answer:_ When DevOps was still new, StackStorm was used by DevOps for event driven automation. Since 2013. Let me just give you enough info about Stackstorm so you can understand the context. It’s “If this &#8211; then that” for your DevOps automation. When something happens &#8211; it catches the event. And the individual actions can be wired into workflows.  
What is really cool about StackStorm is our library of atomic actions. These are ready to use lego blocks that you can wire together into workflows to build cool automations.That makes for nearly perfect glue for everything infrastructure… well, for everything. These lego blocks, these actions, live in what we call [Stackstorm Exchange.][6]

_Question:_ Ok, give me a bit more info about [StackStorm Exchange][7]?

_Answer:_ [StackStorm Exchange][7] is our library of these reusable actions and has proven very popular with the DevOps community. It allows them to grab open-source reusable actions from typical DevOps tools such as ServiceNow and Remedy to the latest for HUE Lights and Tesla cars. With this you can use StackStorm as a tool for automation and remediation across a wide range of domains.

_Question:_ I see, so this is what we do in the traditional world, somebody writes a function and we can reuse them to integrate services, done, move on. Don’t you wish we had something like that for serverless?

_Answer:_ Absolutely, that exactly was our thinking. What if I could reuse all thousands of integrations from StackStorm Exchange in my serverless projects? Recycle StackStorm actions into Lambdas? Reduce the effort and reuse with  
the [Serverless Framework][5].

In the new Serverless world we’ve had a few options, but none of them has become real popular yet. The [AWS Serverless Application Repository][8] is new and has not really taken off yet. [Serverless Components][9], from our friends at Serverless was just recently launched and looks promising, and is beginning to catch interest. But Serverless Components are designed to capture application patterns.What about the smallest building blocks, individual integrations?

We at Stackstorm can fill the gap. Our library of reusable integrations is available today, its our StackStorm Exchange. It is proven, has been used by DevOps since 2014. It’s comprehensive with about 6500 actions spread across 130 integration packs. Some of them are simple, some took pain to build, and they are built, maintained, and used pretty heavily!  
<insert tweet from Brian Nelson here https://twitter.com/brianneisler/status/993936715587829761>

&#8220;Potentially stack storm exchange could be wrapped up into a component itself. We did something similar with the event gateway&#8221; [@brianneisler][10]

_Question:_ Can you tell me a bit more how the Serverless community can take advantage of StackStorm Exchange? What do they have to do?

_Answer:_ You can run StackStorm Exchange actions as AWS Lambda functions. So all you need is an AWS account and a serverless framework. Serverless Framework is a great choice. The framework does all the infrastructure work and offers convenient CLI tools that make serverless development workflow fast. With our [serverless-plugin-stackstorm][11], you can just point to an action from any integration pack available on StackStorm Exchange.

_Question:_ Ok, so serverless can use all actions stored in StackStorm Exchange. Do I have to learn Stackstorm first before I can use it?

_Answer:_ No, let look under the hood. The good news is:

You don’t need to have Stackstorm installed.  
You don’t need to learn it.  
You don’t need to know about it’s existence.  
It is #stormless.

The [serverless-plugin-stackstorm][11] only use one component of Stackstorm: The action runner. The thing that knows how to run the actions from packs on StackStorm Exchange. It handles inputs, outputs, dependencies, runtime. All of this, you don’t need to worry about. It&#8217;s also #serverless, based on the Serverless Framework. Thanks to Serverless for an awesome plugin architecture.

_Question:_ What specifically does the serverless-plugin-stackstorm do?

_Answer:_ The stackstorm plugin does a few things to make it easy:  
● It explores packs, actions, and action parameters from StackStorm Exchange  
● It pulls it all together in a deployment package

What is in a package? It’s the pack, pack’s python requirements, the Stackstorm action runner library that knows how to run the actions from the pack, and the [AWS Lambda][12] handler that makes them work together. The plugin can run the function locally &#8211; we use lambci/docker-lambda image to build and test the python code &#8211; and then deploys it to AWS.

Best if you check out the [serverless-plugin-stackstorm][11] to see for yourself what it does. And get all the glory insides on [Github][13].

_Question:_ Thanks, Dmitri, that was a great overview to better understand how DevOps serverless can leverage all the ready-to-go plugins in StackStorm Exchange. Is there a demo that you have available for those that want to see this in action?

_Answer:_ Yes, I posted a [demo to Github][14].  
And if you have any questions connect with the Community &#8211; Serverless or StackStorm. We also now have the video of the talk I gave at @Serverless [here][15]. You can see on an example on how to go serverless with Stackstorm.

[Join our Support Forum][16]  
[Become a part of our Slack community][17]  
Report an issue on GitHub<a />  
Send us an e-mail</a></p> 

<span data-mce-type="bookmark" style="display: inline-block; width: 0px; overflow: hidden; line-height: 0;" class="mce_SELRES_start">﻿</span>

 [1]: https://en.wikipedia.org/wiki/Serverless_computing
 [2]: https://stackstorm.com/
 [3]: https://www.meetup.com/Serverless/
 [4]: https://serverless.com/
 [5]: https://serverless.com/framework/
 [6]: https://exchange.stackstorm.org
 [7]: https://exchange.stackstorm.org/
 [8]: https://aws.amazon.com/serverless/serverlessrepo/
 [9]: https://serverless.com/blog/what-are-serverless-components-how-use/
 [10]: https://twitter.com/brianneisler/status/993936715587829761
 [11]: https://github.com/StackStorm/serverless-plugin-stackstorm
 [12]: https://aws.amazon.com/lambda/
 [13]: https://github.com/StackStorm
 [14]: https://github.com/dzimine/stormless
 [15]: https://www.youtube.com/watch?v=GApuwM9tz-Q
 [16]: https://forum.stackstorm.com/
 [17]: https://6ktfm1psz9.execute-api.us-west-2.amazonaws.com/dev/index.html