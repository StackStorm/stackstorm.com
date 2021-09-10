---
title: 'Watching the watcher:  How to test and debug rules and trace what StackStorm does with triggers?'
author: st2admin
type: post
date: 2016-02-05T01:06:02+00:00
url: /2016/02/04/watching-watcher-test-debug-rules-trace-stackstorm-triggers/
dsq_thread_id:
  - 4552648363
tcb2_ready:
  - 1
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Tutorials

---
**February 4. 2016**  
By Manas Kelshikar

We have always wanted StackStorm to be much more transparent than older run book automation systems so that users trust it &#8211; so they allow StackStorm to do more and more of the work such as quashing 2am pages via auto-remediation.

Recently we’ve added some capabilities that further increase StackStorm’s transparency.

This post focuses on a few features that help follow the breadcrumbs of an event-driven automation. It specifically provides ways to answer the questions &#8211;

>   * **Why does this rule not work?**
>   * **What did StackStorm do with the event that it received?**

We will put these question in context of a StackStorm Auto-remediation. The example for this blog will use StackStorm to auto-remediate an application that at times has poor API response times. The cast for this plot will be StackStorm as the guardian and protector, Sensu as the watcher and an application that must be brought back to the light when it starts erring in its ways.

We will specifically demonstrate the use of `st2-rule-tester` as well as what we call Trace Tags. As always in these kinds of “tutorial” blogs &#8211; we include the actual StackStorm content.

<!--more-->

## The Setup

### Pre-requisites

  1. Install the latest version of StackStorm as per [these instructions][1].
  2. Install Sensu as per [these instructions][2]. It is recommended  
    to keep StackStorm and Sensu on separate instances to isolate the services from each other.
  3. An application that at times has poor API response times and with well understood remediation steps. In this blog we will use a custom [flask based python application][3] that satisfies this requirement.

### Configurations

  1. StackStorm is setup up with the [sensu pack.][4]
  2. Sensu is configured to [send events to StackStorm.][5]
  3. Sensu setup with [check-http.rb][6] plugin.
  4. Following [check added in sensu server][7] 
        {
          "checks": {
            "app_response_check": {
              "handlers": ["default", "st2"],
              "command": "/etc/sensu/plugins/check-http.rb -u http://127.0.0.1:9999/square/10 -t 7",
              "interval": 60,
              "subscribers": [ "app_server" ]
            }
          }
        }
        

  5. StackStorm setup with a custom [application remediation pack][8] specific to the sample application.</p> 

Once the setup and configurations are in place, the application is started and Sensu monitoring is validated by consulting the Uchiwa dashboard. The application can be put in a bad state by running `curl -X POST http://APP_SERVER/bad/10`. Doing so will cause Sensu to recognize that the application is non-responsive and in turn an event is sent to StackStorm via the registered StackStorm event handler.

## Now back to the original questions

If all goes well StackStorm Auto-remediation will fire and fix the applications performance. However, at times things do not work as expected or it is necessary to track down what StackStorm did in response to an external event. Here is how those questions can be answered.

### Why does this rule not work?

Taking a step back, a rule comprises of &#8211;

  * A trigger to handle
  * Some selection criteria
  * An action to execute

Writing a StackStorm rule is a key step in setting up an event-driven automation. Often a non-working rule is symptomatic of using the wrong trigger reference or a bug in the selection criteria. In order to help debugging during rule development and even later if the payload of a Trigger changes StackStorm provides a command line tool `st2-rule-tester`.

Sample rule &#8211;

    ---
      name: on_app_response_check
      description: Sample rule that dogfoods st2.
      pack: app_remediation
      trigger:
        type: sensu.event_handler
      criteria:
        trigger.check.name:
          pattern: "app_response"
          type: "equals"
        trigger.check.output:
          pattern: "CheckHTTP CRITICAL*"
          type: "matchregex"
        trigger.check.status:
          pattern: 2
          type: equals
      action:
        ref: "app_remediation.remediate"
        parameters:
          app_server_host: "127.0.0.1"
          app_server_port: "9999"
      enabled: true
    

Use `st2 trigger-instance list --trigger sensu.event_handler` to get a list of all the `sensu.event_handler` TriggerInstances in StackStorm. Pick a suitable TriggerInstance from the generated list to use with `st2-rule-tester`. Head over to [Triggers and Sensors][9] for a general discussion on Sensor, Triggers and dispatching TriggerInstances.

Sample TriggerInstance already in StackStorm with some details omitted &#8211;

    {
        "id": "569882f7aef3392a8c2a834d",
        "occurrence_time": "2016-01-15T05:26:15.730000Z",
        "payload": {
            ...
            "check": {
                ...
                "name": "app_response_check",
                ...
            },
            ...
        },
        "trigger": "sensu.event_handler"
    }
    

Using `st2-rule-tester` to debug &#8211;

    # st2-rule-tester --rule=/opt/stackstorm/packs/app_remediation/rules/on_app_response_check.yaml --trigger-instance-id=569882f7aef3392a8c2a834d --config-file=/etc/st2/st2.conf
    2016-01-18 17:14:03,338 INFO [-] Connecting to database "st2" @ "0.0.0.0:27017" as user "None".
    2016-01-18 17:14:03,391 INFO [-] Validating rule app_remediation.on_app_response_check for event_handler.
    2016-01-18 17:14:03,430 INFO [-] Validation for rule app_remediation.on_app_response_check failed on criteria -
      key: trigger.check.name
      pattern: app_response
      type: equals
      payload: app_response_check
    2016-01-18 17:14:03,433 INFO [-] 0 rule(s) found to enforce for event_handler.
    2016-01-18 17:14:03,434 INFO [-] === RULE DOES NOT MATCH ===
    

The output identifies that the issue for the specific rule is with the criteria `trigger.check.name`. Fixing that to match  
value from the payload will lead to &#8211;

    # st2-rule-tester --rule=/opt/stackstorm/packs/app_remediation/rules/on_app_response_check.yaml --trigger-instance-id=569882f7aef3392a8c2a834d --config-file=/etc/st2/st2.conf
    2016-01-18 17:26:05,415 INFO [-] Connecting to database "st2" @ "0.0.0.0:27017" as user "None".
    2016-01-18 17:26:05,454 INFO [-] Validating rule app_remediation.on_app_response_check for event_handler.
    2016-01-18 17:26:05,496 INFO [-] 1 rule(s) found to enforce for event_handler.
    2016-01-18 17:26:05,497 INFO [-] === RULE MATCHES ===
    

A full description of the capabilities of this tool can be found [here][10].

### What did StackStorm do with the event that it received?

Once an event-driven automation is setup and StackStorm starts auto-remediation it is often necessary to track  
down from source of the external event what StackStorm did with those events. StackStorm enables this through a feature called Trace Tags which allow a user to correlate events originating in external systems with a StackStorm automation.

Trace tags can be attached to TriggerInstances and ActionExecutions. Usually, Sensors or Webhook payloads tend to include trace tags that apply to TriggerInstances, this implies that it is necessary to have an understanding of the Sensor or the configured Webhook payload. Head over to [documentation][11] for an in-depth discussion on Traces.

Continuing with the previously setup example lets begin with a Sensu event. Sensu event payload can be obtained  
using the [Sensu events API.][12]

Sensu event

    # http http://sensu-server:4567/events
    
    [
        {
            "action": "create",
            "check": {
                ...
            },
            "client": {
                ...
            },
            "id": "03cce13d-3dd9-41a8-a357-b1df62ab0705",
            ...
        }
    ]
    

Each sensu event has a unique `id` field which is used by the [StackStorm Sensu event handler][13] as the Trace Tag for the StackStorm TriggerInstance.

In this case that value is `03cce13d-3dd9-41a8-a357-b1df62ab0705`. Use this value to obtain a StackStorm Trace.

    # st2 trace list --trace-tag 03cce13d-3dd9-41a8-a357-b1df62ab0705
    id: 5698439eaef3392a8c2a832a
    trace_tag: 03cce13d-3dd9-41a8-a357-b1df62ab0705
    start_timestamp: 2016-01-15T00:55:58.625104Z
    +---------------------------+------------------+----------------------------------+
    | id                        | type             | ref                              |
    +---------------------------+------------------+----------------------------------+
    |  5698439eaef3392a8c2a8329 | trigger-instance | sensu.event_handler              |
    |  56983951aef3392ac6e7ba9c | rule             | app_remidiation.on_app_response_ |
    |                           |                  | check                            |
    | +5698439eaef3392a8c2a832c | execution        | app_remediation.remediate        |
    |  5698439faef3392a8c2a832e | trigger-instance | core.st2.generic.actiontrigger   |
    +---------------------------+------------------+----------------------------------+
    

The above Trace consists a list of activities that StackStorm performed. In this case those are the TriggerInstance created by StackStorm, triggered Rule and ActionExecution representing the performed remediation. Further drill down can be performed using familiar CLI commands like `st2 trigger-instance get <trigger-instance-id>`, `st2 rule get <rule-id>` or `st2 execution get <execution-id>`. This list effectively is the answer to question we started out with i.e. &#8220;What did StackStorm do with the event that it received?&#8221;.</execution-id></rule-id></trigger-instance-id> 

## Closing thoughts

Often the remediation steps in response to an event are not obvious. In those cases StackStorm can be setup to aid with troubleshooting &#8211; a practice known as facilitated troubleshooting. By having operators decide the best course of remediation, based on the troubleshooting data gathered by StackStorm, a remediation workflow can then be coded up in StackStorm that replicates trusted manual steps. Facilitated troubleshooting thus becomes a stepping stone to auto-remediation. StackStorm also provides some powerful tools like Flow Workflow editor and GUI based rules editors to aid in authoring of auto-remediations.

With the help of Rules debugging and Traces, StackStorm provides capabilities to quickly build out event-driven automations as well as track the lifetimes of automations. Using StackStorm to maintain and manage your automations helps increase their visibility by making the system observable and traceable leading to increased trust into the automations themselves. Sleep easy, and let StackStorm quash those 2am events for you.

 [1]: https://docs.stackstorm.com/install/all_in_one.html
 [2]: https://sensuapp.org/docs/0.21/installation-overview
 [3]: https://github.com/manasdk/blog-dev/tree/master/api-latency-app
 [4]: https://github.com/StackStorm-Exchange/stackstorm-sensu
 [5]: https://github.com/StackStorm-Exchange/stackstorm-sensu#configure-sensu-to-send-events-to-stackstorm
 [6]: https://github.com/sensu/sensu-community-plugins/blob/master/plugins/http/check-http.rb
 [7]: https://sensuapp.org/docs/0.11/adding_a_check
 [8]: https://github.com/manasdk/blog-dev/tree/master/app_remediation
 [9]: https://docs.stackstorm.com/sensors.html
 [10]: https://docs.stackstorm.com/rules.html#testing-rules
 [11]: https://docs.stackstorm.com/traces.html
 [12]: https://sensuapp.org/docs/latest/api-events
 [13]: https://github.com/StackStorm-Exchange/stackstorm-sensu/blob/master/packs/sensu/etc/st2_handler.py