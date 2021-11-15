---
title: Simplified Network Performance Tests with PerfSonar and SLX
author: st2admin
type: post
date: 2018-05-03T17:00:21+00:00
url: /2018/05/03/simplified-network-performance-tests-with-perfsonar-and-slx/
thrive_post_fonts:
  - '[]'
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
_May 3, 2018_  
_by Lindsay Hill_

[PerfSonar][1] is a super handy toolkit for measuring network performance between any two points. Combine this with the Guest VM built into the [Extreme SLX series of switches,][2] and you can easily run performance tests between any two points on your network, measuring performance, latency, jitter, MTU, path taken, etc. Combine that with StackStorm, and you can easily run those tests from Slack. No need to even login to a switch.

## Demo: Network Performance Tests via Slack

Check out the video here. From Slack, we can trigger different tests between any two switches &#8211; [performance][3], [one-way latency measurement][4], or [trace the path][5], showing the path MTU. The results are then shown in Slack:



Read on for more about how to set this up.  
<!--more-->

## Technologies in Use

We&#8217;ve put together a few technologies here:

  1. **Extreme Insight Architecture**: the [Extreme SLX series of switches][2] run a separate &#8216;Guest VM&#8217; in addition to the default SLX-OS VM. This Guest VM is running Ubuntu 14.04. There is an onboard hardware path that connects the packet processor ASIC(s) to this VM. This can act as another server attached to the data plane.
  2. **[PerfSonar][6]**: This is an Open Source toolkit of network measurement tools.
  3. **[Slack][7]**: IRC for hipsters, of course.

Plus of course **StackStorm**, which is the operational &#8216;glue&#8217;, stitching together these elements, co-ordinating inputs, actions and outputs across our environment.

## Setup: System Configuration

Here&#8217;s the basics for how to set this up:

  1. **StackStorm & ChatOps**: [Install & configure StackStorm][8]. Create a Slack team if you don&#8217;t already have one, and [add a Hubot configuration][9], and get a `HUBOT_TOKEN`. Edit the `/opt/stackstorm/chatops/st2chatops.env` file on your StackStorm server, and add that `HUBOT_TOKEN`. Set `HUBOT_ADAPTER=slack`, and restart the st2chatops service. Invite the bot to your Slack channel, and it should start responding to `!help`.
  2. **SLX Setup**: Enable the Guest VM on your SLX switches. Copy stanley&#8217;s public SSH key to `authorized_keys` on the Guest VM. Add entries to DNS or your hosts file so that you can ssh from your StackStorm server to the switches and their guest VM. Use the format `switch_name-tpvm` for the guest VM DNS entries.Set an IP address on `eth1` on each Guest VM. 
    Set a corresponding IP on the SLX side, and configure the Insight port. Set up routing such that each Guest VM can ping every other Guest VM&#8217;s eth1 interface, across the data plane, not via the management network.  
    Install the perfSonar toolkit using these commands:
    
    <div class="highlight-shell">
      <div class="highlight">
        <pre>cd /etc/apt/sources.list.d/
wget http://downloads.perfsonar.net/debian/perfsonar-wheezy-release.list
wget -qO - http://downloads.perfsonar.net/debian/perfsonar-debian-official.gpg.key | apt-key add -
apt-get install perfsonar-toolkit
</pre>
      </div>
    </div>

## Setup: Packs, Workflows & Aliases

Install the st2_demos pack with `st2 pack install https://github.com/StackStorm/st2_demos`.

This contains the alias file `/opt/stackstorm/packs/st2_demos/aliases/bwctl.yaml`, and the workflow metadata and definitions, `/opt/stackstorm/packs/st2_demos/actions/bwctl.yaml` and `/opt/stackstorm/packs/st2_demos/actions/workflows/bwctl.yaml`.

You can of course edit these files, and move them to other packs.

## Try it Out!

You should now be ready to test it out. From Slack, run `!help performance`.

If this is responding, try running a test. Start with a simple `iperf` test, e.g.: `bwctl iperf slx1 slx2`.

This will run an iperf test using the default timeout (60s) and bandwidth (1Gb). After a little over a minute, you should see a response in Slack, showing the measured performance between SLX1 and SLX2. This should be 1Gbps.

You can try running it with unlimited bandwidth, i.e. `bandwidth=0`. You should see maximum performance of ~8.3Gbps. This is around the maximum you can achieve with a Linux VM, using a 10GbE connection.

Try running some other tests:

  * `owamp` &#8211; e.g. `bwctl owamp slx2 slx1`This will measure the one-way latency and hops between slx2 and slx1 (recall that ping measures round-trip time). This can be useful in situations where asymmetric routing may be happening.
  * `tracepath` &#8211; e.g. `bwctl tracepath slx1 slx2` &#8211; this will show you the path between slx1 and slx2. It will also show you the path MTU &#8211; this is very handy if you&#8217;re investigating possible MTU issues.

Try it out, let us know how it goes!

You&#8217;ll also note that you don&#8217;t need to use the SLX Guest VM for this. If you have access to existing servers, you can run those tests between those systems too. You just need to install the perfSonar toolkit.

 [1]: https://www.perfsonar.net/
 [2]: https://www.extremenetworks.com/product/slx-9850-router/
 [3]: https://en.wikipedia.org/wiki/Iperf
 [4]: http://software.internet2.edu/owamp/
 [5]: https://linux.die.net/man/8/tracepath
 [6]: https://www.perfsonar.net
 [7]: https://slack.com
 [8]: https://docs.stackstorm.com/install/index.html
 [9]: http://cloudmark.github.io/Hubot/