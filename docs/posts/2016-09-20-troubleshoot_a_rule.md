---
title: How to Troubleshoot a Rule
author: Dmitri Zimine
type: post
date: 2016-09-21T02:20:06+00:00
url: /2016/09/20/troubleshoot_a_rule/
dsq_thread_id:
  - 5160308540
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Tutorials
tags:
  - tutorials

---
**Sep 20, 2016**  
_by Dmitri Zimine_

I set up a sensor to watch for a trigger (trigger represents an external event; sensor will fire a trigger-instance of the trigger type when the event is detected). I created a rule: if the trigger happens, and matches the criteria, it should fire an action. I see that event had happened. I expected the actions to fire. But it didn&#8217;t happen. Where did it break?

This is a long read, and may look complicated. But really, it&#8217;s just _three debugging steps_. And it&#8217;s long because I refuse to write briefly, drop bunch of hints on the way and get you distracted. But as they say in math, the thicker the math book the faster it reads. **Brace yourself**.

In the example below, I&#8217;ll be showing you how we debugged our Twitter automation that scans tweets for mentions and posts it to Slack. A pretty good way to keep track on who is trash talking about us! The debugging &#8220;runbook&#8221; is generic and applies to troubleshooting other rules just fine.

First, let&#8217;s look at the trigger chain and review how it works.

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2016/09/trigger-rule-action.png" alt="trigger-rule-action" width="602" height="311" class="aligncenter size-full wp-image-6038" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/09/trigger-rule-action.png 602w, https://stackstorm.com/wp/wp-content/uploads/2016/09/trigger-rule-action-300x155.png 300w" sizes="(max-width: 602px) 100vw, 602px" />  
<!--more-->

An event happens. Sensors captures an event and emits&#8230; what? Previously we said for brevity, &#8220;emits trigger.&#8221; Now it&#8217;s time to get nuanced. It emits a &#8220;trigger-instance&#8221;. WTF? Let&#8217;s see. If a tweet is an event, how many of them do we have? Billions! and they are all of the same &#8211; what? type! They are tweets! So, a tweet is an event type, while each individual tweets are instances of &#8220;tweet&#8221; event type. Good so far? Ok, now `twitter.matched_tweet` is a trigger that corresponds to a tweet event type. And each individual tweet, an instance of &#8220;tweet&#8221; event type, is represented by &#8220;trigger-instance&#8221;. So, simply: trigger is a type, trigger-instance is an instance of this type. Therefore, when an actual tweet goes off, the sensor will emit a trigger-instance. Not clear? Read it again. Rinse. Spit. Continue. Proceed when it&#8217;s clear. Send us a note to break from infinite loop.

  1. An event happens. 
  2. Sensor captures the event, and emits a trigger-instance. 
  3. Trigger-instance goes to a message bus, and hits the rule engine.
  4. Rule engine checks: is trigger instance is of interest to any rule? If so, does it match the rule criteria?

The act of matching the trigger-instance against the rule is called &#8220;rule-enforcement&#8221;. If the rule matches, it schedules an action execution. Execution id is created, and an execution request goes back into the message bus to find an action runner that picks it up to run it, as the name implies.

### **Step 0. Did the external event actually happen?**

Check outside of StackStorm. In this case, I go to Twitter.com and see that tweet.

### **Step 1. Sensor configured and working?**

    $ st2 sensor list
    +-----------------------------+----------+-----------------------------+---------+
    | ref                         | pack     | description                 | enabled |
    +-----------------------------+----------+-----------------------------+---------+
    | ...
    | twitter.TwitterSearchSensor | twitter  | Sensor which monitors       | True    |
    | ...
    
    st2 trigger list --pack=twitter
    +-----------------------+---------+--------------------------------------+
    | ref                   | pack    | description                          |
    +-----------------------+---------+--------------------------------------+
    | twitter.matched_tweet | twitter | Trigger which represents a matching  |
    |                       |         | tweet                                |
    +-----------------------+---------+--------------------------------------+
    

Remember that if you reconfigure a sensor (using config files or new config options), you must reload it for the configurations to take effect: `st2ctl reload-component st2sensorcontainer`. It&#8217;s only for sensors. For actions, new configurations are loaded with `st2ctl reload --register-configs`.

### **Step 2. Did the sensor emit the trigger-instance for an event?**

    # st2 trigger-instance list
    .... loads of output....
    

Oh no! This output is SO NOISY! How can I possibly find anything? How to find the needle in the haystack here? Look at the rule to check the trigger type, and filter by it. It&#8217;s `twitter.matched_tweet`, so:

    st2 trigger-instance list --trigger=twitter.matched_tweet
    +--------------------------+-----------------------+---------------------------+-----------+
    | id                       | trigger               | occurrence_time           | status    |
    +--------------------------+-----------------------+---------------------------+-----------+
    | 57ae23b0d805641b8ed11de1 | twitter.matched_tweet | Fri, 12 Aug 2016 19:29:52 | processed |
    |                          |                       | UTC                       |           |
    | 57ae2ce2d805641b8ed12543 | twitter.matched_tweet | Fri, 12 Aug 2016 20:09:06 | processed |
    |                          |                       | UTC                       |           |
    |...
    | 57ae834bd805641b8ed16c5d | twitter.matched_tweet | Sat, 13 Aug 2016 02:17:47 | processed |
    |                          |                       | UTC                       |           |
    +--------------------------+-----------------------+---------------------------+-----------+
    

If the trigger-instance for the event is not there, something is wrong with the sensor. It may not have captured it, or something else has gone wrong. Check the logs at `/var/log/st2/st2sensorcontainer.log` and debug the sensor.

If the trigger-instance IS here, we move on to the rule.

If you&#8217;re not sure, use `st2 trigger-instance`

Hint: form your ideal CLI output with combinations of `-a` and `-y` or `-j` parameters. Limit the number of records with `-n`, e.g.:

    # st2 trigger-instance list -a "id" "occurence_type" "payload" -y --trigger=twitter.matched_tweet -n 5
    -   id: 57ae6724d805641b8ed155c3
        payload:
            created_at: Sat Aug 13 00:19:01 +0000 2016
            favorite_count: 0
            id: 764254896379932672
            lang: en
            place: null
            retweet_count: 0
            text: '@jiangu In that case, @Stack_Storm presentation at @Brocade. #NFD12'
            url: https://twitter.com/ecbanks/status/764254896379932672
            user:
                description: 'PacketPushers dot net co-founder. Podcaster & writer covering
                    data center design & network engineering. I interview nerds so you
                    don''t have to. CCIE #20655.'
                location: New Hampshire
                name: Ethan Banks
             screen_name: ecbanks
    ...
    

### **Step 3. Did the rule get enforced, matched, and created execution?**

#### _Scenario 1: NO._

It _did not_ get enforced. So the trigger-instance didn&#8217;t reach the rule engine. Go to Step 2, triple-check that the trigger-instance got emitted, and if it did, dive into the logs (run `st2sensorcontainer` with DEBUG) and troubleshoot at RabbitMQ level.

#### _Scenario 2: YES_

It _does get_ enforced but didn&#8217;t create execution. For example:

    $ st2 rule-enforcement list --rule=tweeter.relay_tweet_to_slack
    +--------------------------+------------------+---------------------+--------------+------------------+
    | id                       | rule.ref         | trigger_instance_id | execution_id | enforced_at      |
    +--------------------------+------------------+---------------------+--------------+------------------+
    | 57ae7037d805641b8ed15d18 | tweeter.relay_tw | 57ae7037d805641b8ed |              | Sat, 13 Aug 2016 |
    |                          | eet_to_slack     | 15d16               |              | 00:56:23 UTC     |
    +--------------------------+------------------+---------------------+--------------+------------------+
    

O-oh&#8230;

If &#8220;execution_id&#8221; is empty, it&#8217;s TROUBLE. Either the criteria didn&#8217;t match, or the Jinja template is messed up. Fire up `st2-rule-tester`, and test &#8220;will this trigger instance match this rule?&#8221; All input is conveniently at your disposal &#8211; `rule.ref` and `trigger_instance_id` is in the above output of `rule enforcement list`.

HINT: when copying IDs from table output kills you, remember the `-y` option, it may be handy!

    st2 rule-enforcement list --rule=tweeter.relay_tweet_to_slack -y
    -   enforced_at: '2016-08-13T00:56:23.576716Z'
        id: 57ae7037d805641b8ed15d18
        rule:
            ref: tweeter.relay_tweet_to_slack
        trigger_instance_id: 57ae7037d805641b8ed15d16
    -   enforced_at: '2016-08-13T02:17:47.443764Z'
        execution_id: 57ae834bd805641b8ed16c60
        id: 57ae834bd805641b8ed16c61
        rule:
            ref: tweeter.relay_tweet_to_slack
        trigger_instance_id: 57ae834bd805641b8ed16c5d
    

Here we go, testing the rule!

    st2-rule-tester --trigger-instance-id=57ae7037d805641b8ed15d16 --rule-ref=tweeter.relay_tweet_to_slack
    2016-08-13 01:06:52,158 INFO [-] Connecting to database "st2" @ "0.0.0.0:27017" as user "None".
    2016-08-13 01:06:52,224 INFO [-] Validating rule tweeter.relay_tweet_to_slack for matched_tweet.
    2016-08-13 01:06:52,224 INFO [-] 1 rule(s) found to enforce for matched_tweet.
    2016-08-13 01:06:52,232 ERROR [-] Failed to resolve parameters
        Original error : 'dict object' has no attribute 'errorHereForSure'
    2016-08-13 01:06:52,233 INFO [-] === RULE DOES NOT MATCH ===
    

Aha! I&#8217;ve messed up the Jinja template. To fix it, I edit and update the rule. Before I update, I may want to check it. Note that `st2-rule-tester`can be used in both &#8220;online&#8221; mode, working against real trigger-instance and rule objects in the system, or &#8220;offline mode&#8221;, using rules from file, and trigger-instance captured to the file, or in any combination. Like this &#8211; here I edited the rule definition in a file, and before updating it, trying it with `st2-rule-tester`:

    $ st2-rule-tester --trigger-instance-id=57ae7037d805641b8ed15d16 --rule=relay_tweet_to_slack.yaml
    2016-08-13 01:14:07,084 INFO [-] Connecting to database "st2" @ "0.0.0.0:27017" as user "None".
    2016-08-13 01:14:07,142 INFO [-] Validating rule tweeter.relay_tweet_to_slack for matched_tweet.
    2016-08-13 01:14:07,142 INFO [-] 1 rule(s) found to enforce for matched_tweet.
    2016-08-13 01:14:07,150 INFO [-] Action parameters resolved to:
    2016-08-13 01:14:07,150 INFO [-]    message: A tweet from @dzimine:\nhttps://twitter.com/dzimine/status/764264543321100288
    2016-08-13 01:14:07,150 INFO [-]    channel: #twitter-relay
    2016-08-13 01:14:07,150 INFO [-] === RULE MATCHES ===
    -
    

It works! You can see what kind of action parameters I&#8217;m gonna send to my action from this particular trigger-instance.

Ok, now `st2 rule update tweeter.relay_tweet_to_slack relay_tweet_to_slack.yaml`, rule is fixed.

If the external event is too important to miss, but now it has already happened and not gonna happen again&#8230;you may want to re-fire your automation for it, by re-emitting the trigger-instance, now that the rule is fixed:

    st2 trigger-instance re-emit 57ae7037d805641b8ed15d16
    Trigger instance 57ae7037d805641b8ed15d16 succesfully re-sent.
    

Checking&#8230;Look, now same the trigger-instance appears twice, and the re-emitted one triggered the desired action!

    st2 rule-enforcement list --rule=tweeter.relay_tweet_to_slack
    +--------------------------+----------------------+----------------------+----------------------+----------------------+
    | id                       | rule.ref             | trigger_instance_id  | execution_id         | enforced_at          |
    +--------------------------+----------------------+----------------------+----------------------+----------------------+
    | 57ae7037d805641b8ed15d18 | tweeter.relay_tweet_ | 57ae7037d805641b8ed1 |                      | Sat, 13 Aug 2016     |
    |                          | to_slack             | 5d16                 |                      | 00:56:23 UTC         |
    | 57ae834bd805641b8ed16c61 | tweeter.relay_tweet_ | 57ae834bd805641b8ed1 | 57ae834bd805641b8ed1 | Sat, 13 Aug 2016     |
    |                          | to_slack             | 6c5d                 | 6c60                 | 02:17:47 UTC         |
    +--------------------------+----------------------+----------------------+----------------------+----------------------+
    

### **Conclusion**

We do have this procedure documented in the [Troubleshooting section][1] of our docs. But we know that we&#8217;re short on tutorials, and we&#8217;re working hard to fix it.

Please tell us here, or on [Slack][2], what other areas of StackStorm you&#8217;ve got questions about, and where you want help. Better yet, write it! We will be happy to post your tutorials on our blog, promote them, or make part of our documentation.

Happy automation!

 [1]: https://docs.stackstorm.com/troubleshooting/sensors.html
 [2]: https://stackstorm.com/community-signup