---
title: 'StackStorm QuickTip: ChatOps your pack dev workflow'
author: st2admin
type: post
date: 2016-01-25T18:29:28+00:00
url: /2016/01/25/stackstorm-quicktip-shorten-pack-development-feedback-loop/
dsq_thread_id:
  - 4522471914
categories:
  - Blog
  - Community
  - Tutorials

---
_by James Fryman_

Happy Monday! In today&#8217;s StackStorm quick tip, we are going to show you a way to rapidly test and deploy packs. This technique pairs a StackStorm action, [`packs.install`][1], and an [Action-Alias][2] that we will create to allow users to rapidly test and deploy new ChatOps commands for themselves.

Let&#8217;s just dive in!

<!--more-->

    # /opt/stackstorm/packs/st2-flow/aliases/flow_deploy.yaml
    ---
    name: "flow_deploy"
    pack: "st2-flow"
    action_ref: "packs.install"
    formats:
      - display: "flow deploy {{ branch }}"
        representation:
          - "{{register=all}} {{packs=st2-flow}} {{repo_url=git@github.com:websages/st2-flow}} flow deploy {{branch=master}}"
    ack:
      format: "Deploying flow ... standby ..."
    result:
      format: |
        {% if execution.status == 'failed' %}
        Oh no! Failure. Check the execution results in the web console{~}
        {% else %}
        Successfully deployed flow{~}
        {% endif %}
    

Imagine if you asked your colleagues to type in that long line _every single time_ they wanted to deploy a pack. It would never be used. However, a simple ChatOps alias, and now it is simple as a single chat command. Using something like this significantly decreases the barrier to entry of experimentation/learning/growing of StackStorm. Folks will be more apt to try something if they see and use tools that give them nearly immediate feedback and know they can safely revert to a known state if need be.

Easy win.

This also has an added benefit of enabling StackStorm adaptable to change. This is absolutely necessary for a successful implementation. When you get feedback, you can quickly turn concerns into wins and previous folks who might have been detractors will become quick allies. It is not hard to see the possibilities once the lightbulb turns on. You also start teaching everyone _immediately_. Indirectly, team members will see actions being executed, and know that &#8220;this is the way to deploy StackStorm code&#8221;. It&#8217;s quick and painless.

## Random Thoughts

**Q: This action is tied directly to the `packs.install`. What about a workflow? Seems like that would be a better way to structure this.**

A: Yeah, probably. Whip that thing up, and rapidly deploy the fix. Viola. Everyone wins. You _absolutely_ will find better ways to maintain this or a similar command as you learn how your users interact with it. This is functional, and also has no problems being upgraded.

**Q: I would never use this in my environment. There is no security. Anyone can run this command!**

A: That&#8217;s fantastic! I also would not suggest running something this open in a production environment. There is a sliding scale between usability and security. This is very cleary leaning toward the usability end of the spectrum. But, by being able to rapidly iterate, you could build out something like [Confirm ChatOps Action][3] (credit: Igor Cherkaev), and implement the security you need. Combine that with fast iterations, you can grow something suitable for even the most stringent of environments.

**Q: Could I use this pattern to deploy, say my SuperCoolDisruptingApp?**

A: YES! When you provide smart people tools to do their job, you&#8217;ll be amazed how fast they are adopted. Use ChatOps to reduce friction in daily life where possible.

## Let&#8217;s get going!

The keys: do not let great be the enemy of good, and constantly iterate. Your automation journey begins with the first step. Take this with you, it&#8217;s dangerous out there alone.

![dangerous out there!][4] 

_Want to see more StackStorm Quick Tips or have a tip of your own share? Let us know! Send us a tweet: [(@Stack_Storm) with the hashtag `#st2quicktip`][5]_. Visit us at <https://stackstorm.com> to learn more about the product and team.

 [1]: https://github.com/StackStorm/st2/blob/master/contrib/packs/actions/install.meta.yaml
 [2]: https://docs.stackstorm.com/chatops/aliases.html
 [3]: https://stackstorm.com/2016/01/21/stackstorm-and-chatops-actions-with-confirmation/?doing_wp_cron=1453746230.2963230609893798828125
 [4]: http://stackstorm.com/wp/wp-content/uploads/2016/01/1654662.jpg
 [5]: http://ctt.ec/b_j5a