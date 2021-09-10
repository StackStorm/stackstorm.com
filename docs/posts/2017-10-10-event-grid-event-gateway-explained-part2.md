---
title: Serverless’ Event Gateway explained for StackStorm users
author: Dmitri Zimine
type: post
date: 2017-10-10T13:52:20+00:00
url: /2017/10/10/event-grid-event-gateway-explained-part2/
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6204439683
categories:
  - Blog
  - Community
tags:
  - event-driven automation
  - review
  - serverless

---
October 10, 2017  
_by <a href="https://twitter.com/dzimine" rel="noopener" target="_blank">Dmitri Zimine</a>_

In [Part 1][1] of the series, I shared my excitement with two new event-driven systems introduced last month: <a href="https://docs.microsoft.com/en-us/azure/event-grid/overview" rel="noopener" target="_blank">Event Grid</a> from Microsoft Azure and <a href="https://serverless.com/event-gateway/" rel="noopener" target="_blank">Event Gateway</a> from <a href="https://serverless.com/" rel="noopener" target="_blank">Serverless.com</a>, and posted some observations on Event Grid.

Before we continue with Event Gateway, let’s bring the “terminology normalization” from [Part 1][1]. In the table below StackStorm terms are used as as a reference point for our blog’s regular readers, along with a short explanation of their meaning for the guests.

<!--more-->

| StackStorm | Event Grid       | Event Gateway      | What is it                                                           |
| ---------- | ---------------- | ------------------ | -------------------------------------------------------------------- |
| Sensors    | Event publishers | N/A (out of scope) | Event sources and a system responsible for ingesting external events |
| Triggers   | Topics           | Events             | System representation of the external event                          |
| Rules      | Subscriptions    | Subscriptions      | Triggers-to-Actions map, filtering, conditions, data passing         |
| Actions    | Event Handlers   | Function           | Target system invocation                                             |



If you’re new to StackStorm, you can refresh refresh the concept of event driven automation at [StackStorm documentation][2].

The common questions to evaluate the event automation products in the family would be:

  * What triggers and actions are possible? What are already available? How can they be extended?
  * How are rules defined? What are the filtering and data transforming capabilities? 
  * What are event delivery guarantees, throughput, and scale characteristics? 

And of course there is something uniquely interesting in each system. What is it?  
With that, let’s continue to Event Gateway!

### Event Gateway by Serverless.com

Event Gateway is defined as “_an open-source communication fabric for serverless architectures. It combines both **API gateway** and **pub/sub** functionality into a single experience_”[[*]][3].

The “**pub/sub**” part is what makes Event Gateway an event router, similar to Azure Event Grid. Event Gateway is emphasized as “Cross-cloud”, built to centralize event handling and react to event with any function on any cloud. This positioning reflects anticipation that serverless solutions are going to be spanning multiple cloud providers.  
The “**API gateway**” part is a separate functionality, yet a part of the end-to-end developer experience: it is intended to optimize the synchronous calls to Function-as-a-Service functions of various cloud providers &#8211; think of AWS API Gateway functionality across the cloud, without dealing with notoriously painful AWS API gateway configuration.

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/10/event-gateway-serverless.png" alt="Event Gateway by Serverless" width="991" height="678" class="aligncenter size-full wp-image-7172" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/10/event-gateway-serverless.png 991w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-gateway-serverless-150x103.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-gateway-serverless-300x205.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-gateway-serverless-768x525.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-gateway-serverless-80x55.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-gateway-serverless-220x151.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-gateway-serverless-146x100.png 146w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-gateway-serverless-219x150.png 219w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-gateway-serverless-348x238.png 348w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-gateway-serverless-607x415.png 607w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-gateway-serverless-712x487.png 712w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-gateway-serverless-870x595.png 870w" sizes="(max-width: 991px) 100vw, 991px" /> 

As a service offering by [Serverless.com][4], Event Gateway is tightly integrated into the [serverless framework][5] for a seamless developer experience. How tightly & how seamlessly? [Austen Collins demo-ed it][6] at [Emit conference][7] and the flow was impressive &#8211; watch the video once they post it, and judge for yourself. (I’ll update the post with the link once the video is posted). Or just try yourself &#8211; it is [open-source][8]: open for contributions, transparent for understanding, and can be run by anyone in their own production cluster. The transparency makes this review an easy job &#8211; look at [the code][8], run the [example][9], and let’s compare notes!

#### Event sources

Event sources are outside of Event Gateway’s scope: the platform doesn’t offers anything like [StackStorm sensors][10] &#8211; a way to plug-in a piece of code to sense an external event. Instead, EventGrid ingests events via HTTP(s) endpoint. A custom event is most similar to StackStorm WebHook trigger type or EventGrid custom topic. When emitted, triggers an asynchronous call to one or more target functions based on subscriptions.

Events identify themselves by a string ID passed in via HTTP header. Namespacing is not enforced but will likely emerge as a convention. Event payload comes in a HTTP request body and parsed by EventGrid if it is JSON. As event types are not registered upfront, thus there is no payload schema, no static check, and no introspection on which payload parameters may be available for subscription filtering. Well, unfortunately there is no filtering either &#8211; I’ll get to it when it comes to subscriptions.

There are also two “built-in” synchronous event types, essential for “just call me” use cases like using functions as client application backends, and function calls across cloud providers (I think of them as part of Event Grid&#8217;s API Gateway functionality):

  * `invoke` event type is used to call functions synchronously. It does not require a subscription: using `invoke` is like calling StackStorm Action API directly instead of going through the Trigger-Rule-Action chain. The function invocation output is sent in the response body “as is”. 
  * `http` event occurs on HTTP requests on the Gateway paths defined by a special `http` subscription type. The event carries `path`, `method`, `query` string, headers and the other parameters of HTTP call to the function defined by the subscription. The function execution results are synchronously sent back to the caller in HTTP response

There is also an internal event types. StackStorm users know how powerful [internal triggers like `st2.generic.actiontrigger`][11] can be in building elaborate chains of event reactions. In EventGrid, [a few system events are defined][12] &#8211; `gateway.event.received`, `gateway.function.invoking`, `gateway.function.invoked`, `gateway.function.invocationFailed` &#8211;  
with [intention to add more][13].Here is an [example of using `internalFunctionError`][14] for error handling. To realize their potential, the system events must become first class citizens, useful in subscriptions, with extra safeguards and usability aids to track the chains of events, break circular dependencies and prevent invocation chain reaction explosions.

#### Functions

Functions must be pre-registered via configuration API. This is referred as “Function discovery&#8221;: it stores information about available functions, allowing the Event Gateway to call them as a reaction to received event. The three function types available today: AWS Lambda, HTTP, and Weighted. Weighted is an interesting concept: the call is load-balanced across a set of functions with probabilities based on each function’s user-assigned “weight”. There will be more function types: the docs already cite Google Cloud Functions, Azure Functions, OpenWhisk Actions. Function providers are not pluggable in the current implementation &#8211; adding a new function type to Event Gateway requires [modification of the platform code][15] &#8211; but it will likely change as more types are implemented. I am particularly looking forward to invoking Step Functions and Logic Apps as the workflows will be used more to tame serverless complexity &#8211; and adding support for them looks pretty easy.

#### Subscriptions

Subscriptions map events to functions. Created via the same configuration API, subscriptions are as simple as Event Gateway’s, even simpler: just `(functionID`, event)\` tuple. It does no filtering on event, and doesn’t offer any data transformation from event payload to function input, passing event payload to function as is. The lack of filtering pushes part of event routing responsibility onto functions: users will have to either mix routing and domain logics in function, or front-face the handlers by a “routing” function. The lack of data transformation creates data coupling between events and functions. This is unfortunate: the promise of Event Gateway is that it “completely decouples functions from one another, reducing communication costs across teams, eliminates effort spent redeploying functions, and allows you to easily share events across functions, HTTP services, even different cloud providers”, and in it current form, it’s not “completely decoupled”. However event filtering is [already on the roadmap][16] and well thought out. Data transformation is not yet in the plans, but from our experience with StackStorm it will be necessary.

A special HTTP subscription is used to define an HTTP API endpoints by mapping paths and methods to synchronous function calls. HTTP subscription is created when the event type is `http`, and takes `path` and `method` parameters. There can be only one http subscription for the same `(method, path)` pair. It was not easy to get my head around special case for `http` at first, but now I find it easy to think about it as API Gateway functionality, and it is a very convenient way to expose functions as REST endpoints.

#### Delivery Guarantee and Scale

Event Gateway is a horizontally scalable stateless service. It relies on strongly consistent DB (etcd, Consul, Zookeeper) for managing state and inter-cluster communications. A cluster can span multiple cloud regions or even various cloud providers.

Delivery guarantee is not specified; from [looking at the code][17] I would guess “at most once” but happy to be corrected. Retry is left to the event emitting clients for the time and [cited as a feature request][18].

#### Serverless Framework Integration

What makes Event Gateway really appealing is the convenience of integration with Serverless framework. User describes the event-action mapping with already familiar syntax in `serverless.yml`, and the framework makes all the calls to register a function & create a subscription:

    functions:
      analytics:
        handler: recordEvents
        events:
          - user.registered
          - user.clicked
    

Here is how the end-to-end developer experience is promising to be, once the Event Gateway is out in production:

  * **Define** your solution as a combination of events, functions, and subscriptions with familiar serverless framework syntax. Use the sync `http` events for client app backend services, `invoke` events to synchronously call functions from functions, and custom async events for orchestrating backend jobs. 
  * **Try locally**: develop and test the solution with Event Gateway automatically deployed and running locally, along with local simulators of FaaS and some other “serverless-offline” goodies. 
  * **Deploy to clouds**: with `sls deploy`, the functions will be deployed to the cloud providers, registered in Event Gateway via functional discovery, and event subscriptions will be created. 
  * **Emit events & profit**!

#### Summary

Event Gateway is currently in beta, and under active development (the development [noticeably slowed down][19] since it’s peak in August, which, I must admit, concerns me). While AWS, Azure, Google GCP & IBM OpenWhisk are mentioned in docs, only AWS is implemented at the time of writing. The hosted service is not available yet: one can run Event Gateway locally via [Serverless framework][5], or [standalone][20].

Event Gateway is hardly useful at the current early preview stage, but looks very promising on its roadmap. A cross-cloud event router is “_the missing piece of serverless architectures_”[[*]][3], and Event Gateway makes a strong claim to this strategic spot. The combination of pub/sub and API gateway functionality provides single developer experience &#8211; the majority of solutions need both types of interactions. In addition, Event Gateway promises to serve as an “event store” &#8211; keep events long after execution to enable [event-sourcing][21]. Open-source model brings trust and carries the potential of a strong community support. I am looking forward to seeing Event Gateway develop towards achieving its grand vision.

 [1]: https://stackstorm.com/2017/10/05/event-grid-event-gateway-explained-part1/
 [2]: https://docs.stackstorm.com/overview.html
 [3]: https://serverless.com/blog/introducing-serverless-event-gateway/
 [4]: https://www.serverless.com
 [5]: https://serverless.com/framework/
 [6]: https://s3-us-west-2.amazonaws.com/emit-website/2017-slides/building+the+communication+fabric+for+serverless+architectures.pdf
 [7]: http://www.emitconference.com
 [8]: https://github.com/serverless/event-gateway
 [9]: https://github.com/serverless/event-gateway-example
 [10]: https://docs.stackstorm.com/sensors.html
 [11]: https://docs.stackstorm.com/sensors.html#internal-triggers
 [12]: (https://github.com/serverless/event-gateway#system-events)
 [13]: https://github.com/serverless/event-gateway/issues/215
 [14]: https://github.com/serverless/event-gateway-example/blob/master/services/errors/serverless.yml
 [15]: http://https://github.com/serverless/event-gateway/blob/master/functions/function.go
 [16]: https://github.com/serverless/event-gateway/issues/169
 [17]: https://github.com/serverless/event-gateway/blob/master/router/router.go#L303-L346
 [18]: https://github.com/serverless/event-gateway/issues/319
 [19]: https://github.com/serverless/event-gateway/graphs/contributors
 [20]: https://github.com/serverless/event-gateway/blob/master/docs/developing.md
 [21]: https://martinfowler.com/eaaDev/EventSourcing.html