---
title: StackStorm at ServerlessConf, SFO, July 31 – Aug 1, 2018
author: st2admin
type: post
date: 2018-07-27T21:28:00+00:00
url: /2018/07/27/stackstorm-at-serverlessconf-sfo-july-31-aug-1-2018/
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
tags:
  - events
  - serverless

---
_July 27, 2018_  
_by Lakshmi Kannan_

For all the people in a hurry, StackStorm will be at [ServerlessConf in San Francisco][1] July 31-Aug 1, 2018. Winson Chan and Dmitri Zimine will be speakers from StackStorm talking about our new workflow engine and serverless functions. We also have a booth with cool demos showcasing our new multi-cloud serverless orchestrator &#8211; [Orquesta][2] and our [new workflow engine][3]. Of course, we will have some cool swags! Stop by and don’t be a stranger! For all the people who are enjoying your Friday afternoon like I am, read the longer version.

<!--more-->

It’s time to tell you a story!

When we started StackStorm, we wanted to build a IFTT (If-this-then-that) for devops people. We embraced the openstack workflow engine [Mistral][4] and even contributed heavily to its development and operational simplicity. Like with any project, we learnt a lot from customer use of mistral workflows via our [Slack community][5]. We spent a lot of time looking into usability (syntax/DSL), data management, state transitions and operational easiness. In fact, we learnt enough and were preposterous about starting our own workflow engine. Luckily, we had some saner people in the team to ask us tough questions and keep us from throwing something out there for the sake of yet-another-open-source-project-with-a-cool-sounding-name. Finally, with release of [StackStorm v2.8][6], we open sourced our new workflow engine that captures our learnings in the workflow space.

In a parallel world, serverless happened. There was [AWS lambda][7], then [Microsoft][8] came with guns blazing and [Google did not want to feel left out][9]. Our inital response to serverless buzz was in [2014][10]. We were learning a few things ourselves from [StackStorm exchange][11] on how people wanted to write functions and run them much ahead of these giant cloud providers. We translated our understanding to first [blog posts][12] and then, we took the show via code approach by building a [serverless plugin][13] to let you run StackStorm actions as serverless functions. [Watch][14] Dmitri talk about it.

And the story forms substance!

<img src="https://media.giphy.com/media/3o7TKzhPqGvUDm3pba/giphy.gif" alt="LegoBlocks" align="middle" /> 

So on one hand, we have this new workflow engine with a DSL that can orchestrate tasks &#8211; on the another hand, we have an exchange full of actions that you can readily run as serverless functions. And the cloud providers are letting people run functions magically in their cloud with almost zero touch. We are in a sweet spot! We can connect all these functions and orchestrate them with our new workflow engine and serverless plugin. We call this Orquesta (Spanish for orchestra). You can pass state from these tasks, conditionally run new functions from output of another action etc. The possibilities are open to your to imagination and your programming skills ;).

Good story, eh? Well, you can see a trailer at the ServerlessConf. Ping us on Slack or email us at <info@stackstorm.com> to get a 20% off on serverless conference ticket. Bring your curiosity and let us show you what we’ve built! May the demo gods be with us! Worst case, we can all drink Gibraltar and wonder why cortado was thus named by San Franciscans!

Follow [@Stack_Storm][15] for live updates from the booth! We may or may not post macarena dance moves!

(Note: Don’t call people from San Francisco San Franciscans. They don’t like it. I decided to use it anyways because I don’t live there anymore.)

 [1]: https://sf.serverless.io
 [2]: https://orquesta.cloud
 [3]: https://github.com/StackStorm/orquesta
 [4]: https://docs.openstack.org/mistral/latest/
 [5]: https://stackstorm.com/community-signup
 [6]: https://stackstorm.com/2018/07/10/stackstorm-2-8-ui-changes-new-workflow-engine-and-more/
 [7]: https://aws.amazon.com/lambda/
 [8]: https://azure.microsoft.com/en-us/services/functions/
 [9]: https://cloud.google.com/serverless/
 [10]: https://stackstorm.com/2014/11/20/stackstorm-vs-aws-lambda-event-driven-computing-vs-event-driven-operations/
 [11]: https://exchange.stackstorm.org
 [12]: https://stackstorm.com/2017/10/10/event-grid-event-gateway-explained-part2/
 [13]: https://stackstorm.com/2017/12/14/stackstorm-exchange-goes-serverless/
 [14]: https://www.youtube.com/watch?v=GApuwM9tz-Q
 [15]: https://twitter.com/Stack_Storm