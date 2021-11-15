---
title: Simple Packet Captures with SLX and CloudShark
author: st2admin
type: post
date: 2018-04-27T03:54:32+00:00
url: /2018/04/26/simple-packet-captures-with-slx-and-cloudshark/
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Tutorials
tags:
  - networking
  - slack
  - StackStorm

---
_April 27, 2018_  
_by Lindsay Hill_

Packet Captures are a necessary evil when you need to prove network innocence. But they&#8217;re tedious to configure, collect & analyze. What if you could simplify the setup, collection and viewing? That&#8217;s what we&#8217;ve done here, combining StackStorm, Extreme Insight Architecture, [CloudShark][1], and of course Slack.

## Demo: Running Packet Captures from Slack

Check out the video here &#8211; we show entering some commands in Slack, which triggers a packet capture on multiple switches. The PCAPs are automatically uploaded to CloudShark, so we can view the packets in our browser:



Read on for more about how to set this up.  
<!--more-->

## Background: What&#8217;s Going on Here?

There&#8217;s a few key technologies in use here:

  1. **Extreme Insight Architecture**: the [Extreme SLX series of switches][2] run a separate &#8216;Guest VM&#8217; in addition to the default SLX-OS VM. This Guest VM is running Ubuntu 14.04. There is an onboard hardware path that connects the packet processor ASIC(s) to this VM. This lets us mirror data plane traffic directly to this guest VM. We can collect it in that VM, and/or copy the data elsewhere.
  2. **[CloudShark][1]**: This is a 3rd-party service that offers &#8220;Wireshark in your browser&#8221; &#8211; upload a PCAP file, and view the packet details in your browser. They have an API for uploading PCAPs. Once a PCAP is uploaded, that file can then be shared with others. This can either run as a hosted SaaS model, or on-premises.
  3. **[Slack][3]**: IRC for hipsters, of course.

Plus of course **StackStorm**, which is the operational &#8216;glue&#8217;, stitching together these elements, co-ordinating inputs, actions and outputs across our environment.

## Setup: System Configuration

Here&#8217;s the basics for how to set this up:

  1. **StackStorm & ChatOps**: [Install & configure StackStorm][4]. Create a Slack team if you don&#8217;t already have one, and [add a Hubot configuration][5], and get a `HUBOT_TOKEN`. Edit the `/opt/stackstorm/chatops/st2chatops.env` file on your StackStorm server, and add that `HUBOT_TOKEN`. Set `HUBOT_ADAPTER=slack`, and restart the st2chatops service. Invite the bot to your Slack channel, and it should start responding to `!help`.
  2. **CloudShark**: You will need an account with CloudShark. You can use either the SaaS offering, or on-premises. Get a CloudShark [API Key][6].
  3. **SLX Setup**: Enable the Guest VM on your SLX switches. Copy stanley&#8217;s public SSH key to `authorized_keys` on the Guest VM. Add entries to DNS or your hosts file so that you can ssh from your StackStorm server to the switches and their guest VM. Use the format `switch_name-tpvm` for the guest VM DNS entries.

## Setup: Packs, Workflows & Aliases

Install the st2_demos pack with `st2 pack install https://github.com/StackStorm/st2_demos`. This contains the alias file `/opt/stackstorm/packs/st2_demos/aliases/multicap.yaml`, and the workflow metadata and definitions, /opt/stackstorm/packs/st2_demos/actions/multicap.yaml and `/opt/stackstorm/packs/st2_demos/actions/workflows/multicap.yaml`. You can of course edit these files, and move them to other packs.

Install the clicrud and CloudShark packs with `st2 pack install clicrud cloudshark`.

Configure the CloudShark pack with `st2 pack configure cloudshark` &#8211; you will need to use your API key from above.

Copy `/opt/stackstorm/packs/clicrud/clicrud.yaml.example` to `/opt/stackstorm/configs/clicrud.yaml`, and configure as required.

Afterwards, run `sudo st2ctl reload --register-all`

## Try it Out!

You should now be ready to test it out. From Slack, run `!help capture`.

If this is responding, try running a capture. Something simple like `multicapture 'port 179' on switches slx1,slx2`.

You can get more complicated, by adding `timeout=30` or `count=20`. If you don&#8217;t specify a timeout or count, it will use the default maximums of 300s or 100 packets.

## Future Improvements

This workflow can be improved, and made more robust. Potential improvements include:

  * Use ACL-based filtering on the SLX
  * Clean up old PCAPs &#8211; both those on the ST2 server, and in CloudShark
  * Modify to work by collecting packets on a server, rather than an SLX
  * Pause (or cancel) the workflow if there are other captures in progress. This could be done within the workflow itself, or by using [policies][7].

 [1]: https://www.cloudshark.org
 [2]: https://www.extremenetworks.com/product/slx-9850-router/
 [3]: https://slack.com
 [4]: https://docs.stackstorm.com/install/index.html
 [5]: http://cloudmark.github.io/Hubot/
 [6]: https://support.cloudshark.org/api/
 [7]: https://docs.stackstorm.com/reference/policies.html