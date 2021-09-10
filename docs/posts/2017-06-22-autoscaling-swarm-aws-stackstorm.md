---
title: Autoscaling Swarm on AWS with StackStorm
author: Dmitri Zimine
type: post
date: 2017-06-22T08:14:50+00:00
url: /2017/06/22/autoscaling-swarm-aws-stackstorm/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5890708858
tcb2_ready:
  - 1
categories:
  - Blog
  - Community
tags:
  - automation
  - Docker
  - kubernetes
  - swarm

---
**June 22, 2017**  
_by [Dmitri Zimine][1]_

In this blog, we show how to scale out a Docker Swarm Cluster based on container workload, so that you don’t over-provision your AWS cluster and pay for just enough instances to run your containers. Learn how we achieved this, watch the _2 min video_ to see it in action. Read the blog for details. Grab our code recipe and adjust it to your liking and use to auto-scale your Swarm on AWS.

<div style="text-align:center">
</div>

<!--more-->

Capacity planning is a lost battle. With uneven, unpredictable workloads, one just can’t get it right: either over-provision and pay for extra capacity, or under-provision and make users suffer with degraded services. Pick how you lose your money.

Orchestrators such as Docker Swarm and Kubernetes are here to solve the capacity problem. They let you scale the services easily and effectively, creating container instances on demand and scheduling them on the underlying cluster.

> Scaling a service is really easy with Docker Swarm: one command, or one API call  
> &#8220;\`
> 
> docker service scale redis=4
> 
> &#8220;\` 

But what if you run the cluster on AWS, or other public cloud? You have to provision a cluster of ec2 instances and do capacity planning again. Which is a lost battle. Amazon auto-scaling groups is little help, they lose their “auto” magic in case of orchestrators: Elastic Load Balancer is typically irrelevant for Kubernetes and Swarm; and the standard utilization-metric based scaling via CloudWatch alerts becomes inefficient and even dangerous [[ 1 ]][2].

Wouldn’t it be great if the cluster can scale based on the container load? If an orchestrator automagically adjusted the size of the cluster by adding more nodes to handle more load,so that all containers have a node to run and there are no idle nodes? Wouldn’t it be great to not have to pay for idle capacity? Absolutely! Kubernetes [does exactly this natively][3] on AWS and Azure via [auto-scaler][4].

Docker Swarm? no such luck. There’s nothing like the k8b auto-scaler out of the box. But don’t rush to throw away your Docker Swarm. We can help you make it auto-scale. It’s easy with StackStorm, and we will walk you thru on “how exactly” in the rest of this blog.

The idea is simple: When the cluster fills up on load, create extra worker nodes and add them to the cluster. Swarm will take it from there and distribute the load on workers. **An IFTTT-like rule: If a cluster is full, then add worker nodes.**

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/06/ScaleSwarmRule.png" alt="" width="821" height="408" class="aligncenter size-full wp-image-6881" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/06/ScaleSwarmRule.png 821w, https://stackstorm.com/wp/wp-content/uploads/2017/06/ScaleSwarmRule-150x75.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/06/ScaleSwarmRule-300x149.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/06/ScaleSwarmRule-768x382.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/06/ScaleSwarmRule-80x40.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/06/ScaleSwarmRule-220x109.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/06/ScaleSwarmRule-201x100.png 201w, https://stackstorm.com/wp/wp-content/uploads/2017/06/ScaleSwarmRule-280x139.png 280w, https://stackstorm.com/wp/wp-content/uploads/2017/06/ScaleSwarmRule-479x238.png 479w, https://stackstorm.com/wp/wp-content/uploads/2017/06/ScaleSwarmRule-750x373.png 750w" sizes="(max-width: 821px) 100vw, 821px" /> 

The right task for StackStorm. Just specify a few things precise enough for implementation:

**1) How to define a “cluster filled up” event?** A scaling trigger is defined as “too many pending tasks”, or, more strictly, “a count of pending tasks is going above a threshold”. A trigger is emitted by StackStorm “swarm.pending_queue” sensor that polls the Swarm for unscheduled tasks and fires when the count goes above threshold (scale-out) or below threshold (scale-in).

 **2) How to make the swarm cluster tell us that it is “filled up”?** If not given a hint, a swarm scheduler thinks the cluster is bottomless and never stops shoveling the containers on the workers. Swarm CPU shares don’t help: they are modeled after VMware and act exactly as shares; the scheduler still shedule everything, just keep the share-based ratio. Solution? Use memory reservations, and watch “pending tasks” count. Memory is not over-provisioned by default; the scheduler will schedule only the tasks the workers can fit, the rest will be “pending tasks”, waiting for resources (memory) to become available. This will trigger `swarm.pending_queue` described above.

**3) How to create and add worker nodes?** I chose to use [Auto Scaling Groups][5] as a tried and trusted way to scale on AWS, but drop the “auto-” and trigger scaling events from StackStorm. The launch configuration uses a custom AMI with Docker daemon installed and set up, so that new worker instances come up fast. A new node auto-joins the cluster via cloud-init when the instance comes up [[ 2 ]][6].

Using ASG is not the only way: you could easily provision new worker instances with st2 workflow, that offers more control over the provisioning process. Or use ASG for creating the node and set up an st2 rule to join a worker to the cluster on ASG lifecycle events. It is your choice: pick an event, set your rules, build your workflows: define a process that matches your operations.

**4) How to define autoscaling rule?** Rule is simple and self-explanatory:

<pre class="EnlighterJSRAW" data-enlighter-language="yaml">---
name: on_pending_scaleup_aws
pack: swarm
description: "Scale up the Swarm on AWS when pending tasks go over threshold."
enabled: True
 
trigger:
    type: swarm.pending_tasks
    parameters: {}
 
criteria:
    # Crossing threshold up
    trigger.over_threshold:
        type: equals
        pattern: True
 
action:
    ref: aws.autoscaling_update_auto_scaling_group
    parameters:
        AutoScalingGroupName: swarm-workers-tf
        DesiredCapacity: "{{ st2kv.system.count | int + 1 }}"

</pre>

5) **How to simulate a workload?** Easy: just tell the swarm to [scale the service][7]! Create one with memory reservations and scale it out to to fill up the cluster.

<pre class="EnlighterJSRAW" data-enlighter-language="shell">docker service scale redis=4
</pre>

Now everything is ready. [Watch the video][8] to see it all in action.

**What about scale-in?** I will cover it in the next post. Stay tuned. In the mean time, you can write your own, and win a prize from StackStorm.

You can do it in different ways, on different triggers, using different empirics to constitute a scale-in event. For instance, on queue count going down, wait for chill-down time, drain the node and destroy the worker &#8211; a simple 3-steps &#8220;workflow&#8221; action. Or, configure the Swarm with [“binpack strategy”][9] and run a `scale-down-if-i-can` workflow that checks the number of containers on the nodes and decomissions the empty nodes. Or just reduce the AWS desired capacity (if capacity is over-reduced, the `scale-up` rule will bring it back). With StackStorm, you define your process to fit your tools and operations.

> **StackStorm challenge**: create your own Swarm scale-up&down solution and share with the StackStorm community. We will send you a prize. Mention @dzimine or @lhill on \[Slack\](https://stackstorm-community.slack.com) or drop us a line at info@stackstorm.com. 

**In summary:** with this simple StackStorm automation, you can make your Swarm Cluster scale out on AWS with the load, taking exactly as much resources as needed. And more: once you have StackStorm deployed, you will likely find more use to event-driven automation: StackStorm is used for a wide range of automations, from auto-remediation, network automation and security orchestration to serverless, bio-computations, and IoT.

Give it a try and tell us what you think: leave the comments here or join [stackstorm-community on Slack][10] ([sign up here][11] to talk to the team and fellow automators).

### References

  * Autoscaling code and rules in StackStorm automation pack. 
      * Code on GitHub: https://github.com/dzimine/swarm_scaling 
      * To install the pack:  
        `` `st2 pack install  --base_url=https://github.com/dzimine/swarm_scaling` ``
  * Auto-scaling group terraform definition https://github.com/dzimine/serverless-swarm &#8211; run the whole thing to install Swarm, StackStorm and AWS ASG, or look at the moving parts: 
      * Terraform configuration [workers_asg.tf][12]
      * Cloud init template [worker_cloudinit.tpl][13]



### Footnotes

<li id="fn1">
  Research shows that utilization-threshold based scaling often results in instabilities, SLA violations and service unavailability. For instance, see <a href="http://ieeexplore.ieee.org/document/5557965/?reload=true">From Data Center Resource Allocation to Control Theory and Back</a>
</li>
<li id="fn2">
  For the demo, I used provisioning from serverless-swarm. The complexity of ansible/terraform there is relevant to serverless-swarm goals, where we achieved exactly equivalent AWS and local Vagrant configuration. If it is an overkill for your case, provision Swarm and StackStorm your way, and just grab the AWG portion and cloud-init from the template.
</li>

 [1]: https://twitter.com/dzimine
 [2]: #fn1
 [3]: https://community.sdl.com/solutions/content-management/tridion/tridion-developer/b/feed/posts/autoscaling-your-kubernetes-cluster-on-aws
 [4]: https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler/cloudprovider/aws
 [5]: http://docs.aws.amazon.com/autoscaling/latest/userguide/AutoScalingGroup.html
 [6]: #fn2
 [7]: https://docs.docker.com/engine/reference/commandline/service_scale/
 [8]: https://youtu.be/O7mDRVU0TIo
 [9]: http://container-solutions.com/using-binpack-with-docker-swarm/
 [10]: https://stackstorm-community.slack.com
 [11]: https://stackstorm.com/community-signup
 [12]: https://github.com/dzimine/serverless-swarm/blob/master/terraform/workers_asg.tf
 [13]: https://github.com/dzimine/serverless-swarm/blob/master/terraform/worker_cloudinit.tpl