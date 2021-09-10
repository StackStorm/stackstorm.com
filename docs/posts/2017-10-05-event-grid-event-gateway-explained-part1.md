---
title: Microsoft Azure Event Grid explained for StackStorm users
author: Dmitri Zimine
type: post
date: 2017-10-05T20:04:17+00:00
url: /2017/10/05/event-grid-event-gateway-explained-part1/
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6193843158
categories:
  - Blog
  - Community
tags:
  - azure

---
October 05, 2017  
_by <a href="https://twitter.com/dzimine" rel="noopener" target="_blank">Dmitri Zimine</a>_

Two new event-driven systems were introduced last month. <a href="https://docs.microsoft.com/en-us/azure/event-grid/overview" rel="noopener" target="_blank">Event Grid</a> from Microsoft Azure and <a href="https://serverless.com/event-gateway/" rel="noopener" target="_blank">Event Gateway</a> from <a href="https://serverless.com/" rel="noopener" target="_blank">Serverless.com</a> were launched two days apart from each other. An event that triggered these announcements seem to be emitted by <a href="http://emitconference.com" rel="noopener" target="_blank">Emit conference</a> on serverless. Serverless computing became a primary driver for the event-centric approach, and as serverless architectural patterns emerged, the need for a dedicated event router became apparent.

<!--more-->

StackStorm, Event Grid, and Event Gateway are conceptually the same family, despite different target use (devops automation vs serverless) and delivery form-factor (installable vs PaaS). All three are event router services, mapping and routing events from multiple event sources to multiple target systems.

StackStorm pioneered applying the [event-driven computing][1] to DevOps automation. Over 4 years of evolving StackStorm, operating it ourselves, and learning from thousands of the users, who have been running StackStorm in a wide variety of applications and scales, we gained a solid perspective on what works well for this class of products. Here, I’ll use this perspective and experience to review and compare the functionality and feature set of the “new kids on the blog” (pun intended).

First, let’s “normalize” the terminology: I use StackStorm terms as a reference point, as StackStorm blog regulars are dearly familiar with them, and add a short explanation for everyone.

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
With that, let’s start with **Event Grid** first.

## Event Grid by Azure

[Event Grid][3] is defined _“a fully-managed event routing service that allows for uniform event consumption using a publish-subscribe model, reacting to events in near-realtime fashion”_. It is currently in “preview”, supporting only a subset of Azure services. There is documentation and a few examples.

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/10/event-grid-functional-model-1024x577.png" alt="" width="1024" height="577" class="size-large wp-image-7139" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/10/event-grid-functional-model-1024x577.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-grid-functional-model-150x84.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-grid-functional-model-300x169.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-grid-functional-model-768x433.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-grid-functional-model-80x45.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-grid-functional-model-220x124.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-grid-functional-model-178x100.png 178w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-grid-functional-model-266x150.png 266w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-grid-functional-model-423x238.png 423w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-grid-functional-model-737x415.png 737w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-grid-functional-model-865x487.png 865w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-grid-functional-model-1056x595.png 1056w, https://stackstorm.com/wp/wp-content/uploads/2017/10/event-grid-functional-model.png 1282w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

Explaining [how Event Grid is different from some seemingly similar Azure services][4], [Clemens Vasters][5], one of Azure architects, clarifies that it is intended _“for the model where there’s a very large number of different events for different contexts emitted by an application or platform service, and a consumer may be interested in just one particular event type or just one particular context.”_

#### Event publishers

Just like StackStorm’s triggers are backed by Sensors, Azure topic types are backed by Event publishers. Currently, they are:

  * Management operation events from Azure Subscriptions or Resource groups and subscriptions (e.g., ‘VM created’).
  * [Event hubs][6] &#8211; at preview, limited by “Capture” storage event but will likely be a firehose of the interesting events in a future.
  * Custom topics &#8211; a point to post HTTP(s) events &#8211; similar to StackStorm Webhook trigger. They serve as an open extensibility point, offering API to define and submit custom / 3rd party events. Yes, if you’re outside of Azure, HTTP(s) to a custom topic is the way to push event into Event Grid.

I find myself confused by an overlap with [Azure Logic Apps][7]. Logic Apps is primarily an actor/subscriber for an EventGrid, but has it’s own “event-driven” part with an [impressive count of 169 event sources][8] called triggers. Triggers mostly follow “poll” model and publish events to Logic Apps, but they are not event sources for EventGrid, unfortunately. Hopefully this confusion is temporary and our Azure friends will find a way to rationalize it.

#### Topics

Azure Topics are pretty much StackStorm [Webhook trigger types][9]. Looking closer, there is a granular picture of Topic Types, Topics, and Events generated by the topic (similar to StackStorm’s Trigger types, Triggers, and Trigger Instances). As mentioned above, “Custom topics” are not the only source of events &#8211; other Azure system act as Event Sources and emit events &#8211; but they are the one with the open API for solution integration.

Events have id, source reference, subject, and carry a payload in the `data` object, The schema of `data` specific to event publisher and schema-less (unlike StackStorm where the event source may choose to publish the schema to help the user refer data for filtering and data transformation).

#### Event Handlers

Event Handlers are “places where events are sent”, also called “endpoints”. Currently the HTTP/Webhook endpoints, and the Azure Storage Queue are available endpoints, however more event handlers are expected to come. It would be more precise to compare Event Handlers with StackStorm Runners: both abstract a class of endpoints (or “actions). But StackStorm hides this behind “Action” : an action is an action regardless the runner type; even workflow is an action from invocation viewpoint. Event Grid does not offers a dedicated action abstraction of “Action”, like StackStorm or Logic Apps. The target endpoint is defined as part of “Subscription” by endpoint type and endpoint URL (in API, it’s also called [Event Subscription Desitnation][10].

#### Subscriptions

Subscriptions are comparable to Rules in StackStorm: they map events to target endpoints. In Azure’s words, they _“instruct Event Grid on which events on a topic a subscriber is interested in receiving &#8230;, and also holds information on how events should be delivered to the subscriber.”_ Event-to-endpoint mapping is one-to-one. To achieve “fan out” &#8211; map one event to multiple endpoints &#8211; multiple subscriptions must be created.

Filtering is available, but limited to event type and or event subject pattern. There is no filtering based on event data itself. From my experience with StackStorm, this is a problem as it limits the routing capabilities. For example, reaction on a monitoring event is based on severity, which is a field in event data. Architecturally, it pushes part of event routing logic between EventGrid and the target endpoint. This imperfection already shows: [“Message router using Logic apps”][11] is ironically offered as a pattern, where it should be entirely an EventGrid use case.

There is no data transformation: the event data are routed to the target endpoint “as is”. That means the Event Handler needs to know and handle Event Publisher’s data schema. Again, abstraction leaks here: ideally, event routing shall keep entire responsibility of mapping “any” event source to “any” event target without demanding modifications on source or target.  
I suspect these limitations are the result of a conscious architectural trade off to not parse event data to gain high throughput. But it could be solved by making subscriptions only parse the events when user user requested filtering on event data or data transformation.

#### Delivery guarantee

Event Grid clearly declares “at least one” delivery guarantee. That means that once the event is accepted, Event Grid will a) not lose an event, and b) [will retry calling an event target][12] on the backoff schedule until it succeeds, or event expires (4 hours in Preview will turn to 24 hours by release). The lack of control over the retry policy is upsetting: retry may help with 503 Service Unavailable or 408 Request timeout but is no use for “401 unauthorized” or “414 URL too long”. I prefer to model “retry” as an action invocation policy, make it dependent both on action type and invocation content, and user configured configured.

#### In Summary

The most amazing thing about Event Grid is “pricing”: $0.30 for 1 Million operations&#8230; Pause here to reflect: it’s $10 a year for one event per second! This hints a giant scale and suggests the use for solutions where routing of massive event flows required, like IoT, or user click analysis. At the current state the model is still maturing, the terminology exposes the org structure (e.g., same things called differently marketecture, docs, API and CLI), and only few event publishers and handlers are available. Well, this is exactly as Preview is supposed to be. The real world usage will inform the roadmap, and I expect it to mature into in a key building block of Azure PaaS.

## Event Gateway by Serverless.com

… will be covered in Part 2. Stay tuned!

 [1]: https://www.thenewstack.io/tag/event-driven-architecture
 [2]: https://docs.stackstorm.com/overview.html
 [3]: https://docs.microsoft.com/en-us/azure/event-grid/overview
 [4]: https://azure.microsoft.com/en-us/blog/events-data-points-and-messages-choosing-the-right-azure-messaging-service-for-your-data/
 [5]: https://azure.microsoft.com/en-us/blog/author/clemensv/
 [6]: https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-what-is-event-hubs
 [7]: https://docs.microsoft.com/en-us/azure/logic-apps/logic-apps-what-are-logic-apps
 [8]: https://docs.microsoft.com/en-us/azure/connectors/apis-list
 [9]: https://docs.stackstorm.com/webhooks.html
 [10]: https://docs.microsoft.com/en-us/rest/api/eventgrid/eventsubscriptions/create#definitions_eventsubscriptiondestination
 [11]: https://blog.eldert.net/integration-patterns-in-azure-message-router-using-logic-apps/
 [12]: https://docs.microsoft.com/en-us/azure/event-grid/delivery-and-retry