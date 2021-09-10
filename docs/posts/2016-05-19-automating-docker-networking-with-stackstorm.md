---
title: Network Automation with StackStorm and Docker
author: st2admin
type: post
date: 2016-05-19T14:31:55+00:00
url: /2016/05/19/automating-docker-networking-with-stackstorm/
dsq_thread_id:
  - 4852832092
categories:
  - Blog
  - Community
tags:
  - Docker
  - networking

---
**May 24, 2016**  
_by Matthew Stone_

What is StackStorm going to do with network automation? Ever since we joined Brocade, it&#8217;s been everyone&#8217;s question, and we have been hand-waving some answers. But the talk walks, code talks: let&#8217;s show something really working. Today’s example is on Docker network automation, where StackStorm makes physical networking follow Docker containers as they get created.

Millennial kids should watch my [video with detailed explanations on StackStorm’s YouTube channel][1].

True hackers might jump straight to [automation code on GitHub][2] to see how it is built and try it out on your StackStorm instance.

Or, just read on.



<!--more-->

The evolution of Docker networking has been fun to watch, and with the latest additions to [libnetwork][3], things are getting even better. Docker [recently added Macvlan and Ipvlan][4] to the list of drivers for libnetwork. (Note: At the time of writing these drivers are still considered experimental) These drivers allow Docker containers to speak directly to the physical network. Getting traffic in and out of overlay networks can be a challenge. You need to implement a VTEP on the physical switch or vSwitch to communicate with the rest of the network. Docker decided to solve the problem by allowing you to send traffic tagged with a VLAN ID. Something every network engineer has done. This allows you to treat container networking similarly to how you treat virtual machine networking. I&#8217;ll leave the detailed explanation [to the writeup Docker did on the subject.][4]

Tagging container traffic means you need to coordinate your physical network configuration with your Docker configuration, and do it automatically. We use StackStorm to trigger on creating of Docker network, and fire a workflow that reconfigures the physical network using Brocade VDX switch API. Here is now it’s done, step-by step.

We started by creating a Swarm cluster, connected to a Brocade VDX switch.

<div id="gist36060162" class="gist">
  <div class="gist-file">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-1_docker_info-out" class="file">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8">
              <tr>
                <td id="file-1_docker_info-out-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-1_docker_info-out-LC1" class="blob-code blob-code-inner js-file-line">
                  > docker info
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-1_docker_info-out-LC2" class="blob-code blob-code-inner js-file-line">
                  Containers: 2
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-1_docker_info-out-LC3" class="blob-code blob-code-inner js-file-line">
                  Images: 4
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-1_docker_info-out-LC4" class="blob-code blob-code-inner js-file-line">
                  Server Version: swarm/1.1.3
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-1_docker_info-out-LC5" class="blob-code blob-code-inner js-file-line">
                  Role: primary
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-1_docker_info-out-LC6" class="blob-code blob-code-inner js-file-line">
                  Strategy: spread
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-1_docker_info-out-LC7" class="blob-code blob-code-inner js-file-line">
                  Filters: health, port, dependency, affinity, constraint
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-1_docker_info-out-LC8" class="blob-code blob-code-inner js-file-line">
                  Nodes: 2
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-1_docker_info-out-LC9" class="blob-code blob-code-inner js-file-line">
                  vagrant-ubuntu-trusty-64: 172.28.128.6:2375
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-1_docker_info-out-LC10" class="blob-code blob-code-inner js-file-line">
                  └ Status: Healthy
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-1_docker_info-out-LC11" class="blob-code blob-code-inner js-file-line">
                  └ Containers: 1
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-1_docker_info-out-LC12" class="blob-code blob-code-inner js-file-line">
                  └ Reserved CPUs: 0 / 1
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-1_docker_info-out-LC13" class="blob-code blob-code-inner js-file-line">
                  └ Reserved Memory: 0 B / 514.5 MiB
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-1_docker_info-out-LC14" class="blob-code blob-code-inner js-file-line">
                  └ Labels: executiondriver=, kernelversion=3.13.0-83-generic, operatingsystem=Ubuntu 14.04.4 LTS, storagedriver=aufs
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-1_docker_info-out-LC15" class="blob-code blob-code-inner js-file-line">
                  └ Error: (none)
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-1_docker_info-out-LC16" class="blob-code blob-code-inner js-file-line">
                  └ UpdatedAt: 2016-04-29T16:14:55Z
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-1_docker_info-out-LC17" class="blob-code blob-code-inner js-file-line">
                  vagrant-ubuntu-trusty-64: 172.28.128.5:2375
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-1_docker_info-out-LC18" class="blob-code blob-code-inner js-file-line">
                  └ Status: Healthy
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-1_docker_info-out-LC19" class="blob-code blob-code-inner js-file-line">
                  └ Containers: 1
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-1_docker_info-out-LC20" class="blob-code blob-code-inner js-file-line">
                  └ Reserved CPUs: 0 / 1
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-1_docker_info-out-LC21" class="blob-code blob-code-inner js-file-line">
                  └ Reserved Memory: 0 B / 514.5 MiB
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L22" class="blob-num js-line-number" data-line-number="22">
                </td>
                
                <td id="file-1_docker_info-out-LC22" class="blob-code blob-code-inner js-file-line">
                  └ Labels: executiondriver=, kernelversion=3.13.0-83-generic, operatingsystem=Ubuntu 14.04.4 LTS, storagedriver=aufs
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L23" class="blob-num js-line-number" data-line-number="23">
                </td>
                
                <td id="file-1_docker_info-out-LC23" class="blob-code blob-code-inner js-file-line">
                  └ Error: (none)
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L24" class="blob-num js-line-number" data-line-number="24">
                </td>
                
                <td id="file-1_docker_info-out-LC24" class="blob-code blob-code-inner js-file-line">
                  └ UpdatedAt: 2016-04-29T16:14:55Z
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L25" class="blob-num js-line-number" data-line-number="25">
                </td>
                
                <td id="file-1_docker_info-out-LC25" class="blob-code blob-code-inner js-file-line">
                  Kernel Version: 3.13.0-83-generic
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L26" class="blob-num js-line-number" data-line-number="26">
                </td>
                
                <td id="file-1_docker_info-out-LC26" class="blob-code blob-code-inner js-file-line">
                  Operating System: linux
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L27" class="blob-num js-line-number" data-line-number="27">
                </td>
                
                <td id="file-1_docker_info-out-LC27" class="blob-code blob-code-inner js-file-line">
                  CPUs: 2
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L28" class="blob-num js-line-number" data-line-number="28">
                </td>
                
                <td id="file-1_docker_info-out-LC28" class="blob-code blob-code-inner js-file-line">
                  Total Memory: 1.005 GiB
                </td>
              </tr>
              
              <tr>
                <td id="file-1_docker_info-out-L29" class="blob-num js-line-number" data-line-number="29">
                </td>
                
                <td id="file-1_docker_info-out-LC29" class="blob-code blob-code-inner js-file-line">
                  Name: 96a237d545b4
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="gist36060162" class="gist">
  <div class="gist-file">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-2_docker_network_ls-out" class="file">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8">
              <tr>
                <td id="file-2_docker_network_ls-out-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-2_docker_network_ls-out-LC1" class="blob-code blob-code-inner js-file-line">
                  > docker network ls
                </td>
              </tr>
              
              <tr>
                <td id="file-2_docker_network_ls-out-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-2_docker_network_ls-out-LC2" class="blob-code blob-code-inner js-file-line">
                  NETWORK ID NAME DRIVER
                </td>
              </tr>
              
              <tr>
                <td id="file-2_docker_network_ls-out-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-2_docker_network_ls-out-LC3" class="blob-code blob-code-inner js-file-line">
                  45a14a2a8a5a vagrant-ubuntu-trusty-64/host host
                </td>
              </tr>
              
              <tr>
                <td id="file-2_docker_network_ls-out-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-2_docker_network_ls-out-LC4" class="blob-code blob-code-inner js-file-line">
                  d7cd20ce6a9b vagrant-ubuntu-trusty-64/none null
                </td>
              </tr>
              
              <tr>
                <td id="file-2_docker_network_ls-out-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-2_docker_network_ls-out-LC5" class="blob-code blob-code-inner js-file-line">
                  c5d83e381f1f vagrant-ubuntu-trusty-64/host host
                </td>
              </tr>
              
              <tr>
                <td id="file-2_docker_network_ls-out-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-2_docker_network_ls-out-LC6" class="blob-code blob-code-inner js-file-line">
                  70e091519778 vagrant-ubuntu-trusty-64/bridge bridgeb
                </td>
              </tr>
              
              <tr>
                <td id="file-2_docker_network_ls-out-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-2_docker_network_ls-out-LC7" class="blob-code blob-code-inner js-file-line">
                  3208fb94f122 vagrant-ubuntu-trusty-64/bridge bridge
                </td>
              </tr>
              
              <tr>
                <td id="file-2_docker_network_ls-out-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-2_docker_network_ls-out-LC8" class="blob-code blob-code-inner js-file-line">
                  21602e11db6e vagrant-ubuntu-trusty-64/none null
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

As you can see this cluster has two healthy nodes and only the default networks created.

Before we get into the other details let&#8217;s briefly look at the current Ve interfaces on the Brocade VDX switch and see how that output will change based on the workflow.

<div id="gist36060162" class="gist">
  <div class="gist-file">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-3_show_ip_ve-out" class="file">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8">
              <tr>
                <td id="file-3_show_ip_ve-out-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-3_show_ip_ve-out-LC1" class="blob-code blob-code-inner js-file-line">
                  Spine-198976# show ip int brief | inc Ve
                </td>
              </tr>
              
              <tr>
                <td id="file-3_show_ip_ve-out-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-3_show_ip_ve-out-LC2" class="blob-code blob-code-inner js-file-line">
                  Ve 10 10.1.1.21 default-vrf up up
                </td>
              </tr>
              
              <tr>
                <td id="file-3_show_ip_ve-out-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-3_show_ip_ve-out-LC3" class="blob-code blob-code-inner js-file-line">
                  Ve 20 20.1.1.21 default-vrf up up
                </td>
              </tr>
              
              <tr>
                <td id="file-3_show_ip_ve-out-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-3_show_ip_ve-out-LC4" class="blob-code blob-code-inner js-file-line">
                  Ve 30 30.1.1.21 default-vrf up up
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

These three existing Ve interfaces are for services outside of the docker deployment we&#8217;ll use in this example.

With the Swarm cluster in place I started exploring Docker&#8217;s event API. This is an HTTP based streaming API that notifies any subscribers of cluster-wide events. Things like container creation, network creation, etc get pushed to this API. I wrote a simple Sensor that subscribes to the event API and fires a Trigger when a new network is created:

<div id="gist36060162" class="gist">
  <div class="gist-file">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-4_sensor-py" class="file">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-python ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8">
              <tr>
                <td id="file-4_sensor-py-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-4_sensor-py-LC1" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">from</span> st2reactor.sensor.base <span class="pl-k">import</span> Sensor
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-4_sensor-py-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">import</span> re
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-4_sensor-py-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">import</span> json
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-4_sensor-py-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">import</span> uuid
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-4_sensor-py-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">import</span> requests
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-4_sensor-py-LC6" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">import</span> ipaddress
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-4_sensor-py-LC7" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-4_sensor-py-LC8" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">def</span> <span class="pl-en">run</span>(<span class="pl-smi"><span class="pl-smi">self</span></span>):
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-4_sensor-py-LC9" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-c"><span class="pl-c">#</span> Values hardcoded for briefety of example, you should use </span>
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-4_sensor-py-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-c"><span class="pl-c">#</span> self._config and put parameters to config.yaml in the pack.</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-4_sensor-py-LC11" class="blob-code blob-code-inner js-file-line">
                  r <span class="pl-k">=</span> requests.get(<span class="pl-s"><span class="pl-pds">'</span>http://172.28.128.4:3376/events<span class="pl-pds">'</span></span>, <span class="pl-v">stream</span><span class="pl-k">=</span><span class="pl-c1">True</span>)
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-4_sensor-py-LC12" class="blob-code blob-code-inner js-file-line">
                  key <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">"</span>REPLACE WITH SWARM KEY<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-4_sensor-py-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">for</span> chunk <span class="pl-k">in</span> r.raw.read_chunked():
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-4_sensor-py-LC14" class="blob-code blob-code-inner js-file-line">
                  event <span class="pl-k">=</span> json.loads(chunk)
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-4_sensor-py-LC15" class="blob-code blob-code-inner js-file-line">
                  netwk_data <span class="pl-k">=</span> requests.get(<span class="pl-s"><span class="pl-pds">'</span>http://172.28.128.4:3376/networks/<span class="pl-c1">%s</span><span class="pl-pds">'</span></span> <span class="pl-k">%</span> event[<span class="pl-s"><span class="pl-pds">'</span>Actor<span class="pl-pds">'</span></span>][<span class="pl-s"><span class="pl-pds">'</span>Attributes<span class="pl-pds">'</span></span>][<span class="pl-s"><span class="pl-pds">'</span>name<span class="pl-pds">'</span></span>])
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-4_sensor-py-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">if</span> event[<span class="pl-s"><span class="pl-pds">'</span>Action<span class="pl-pds">'</span></span>] <span class="pl-k">==</span> <span class="pl-s"><span class="pl-pds">'</span>create<span class="pl-pds">'</span></span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-4_sensor-py-LC17" class="blob-code blob-code-inner js-file-line">
                  netwk_data <span class="pl-k">=</span> json.loads(netwk_data.content)
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-4_sensor-py-LC18" class="blob-code blob-code-inner js-file-line">
                  vlan <span class="pl-k">=</span> re.findall(<span class="pl-s"><span class="pl-pds">'</span>eth[0-9]+\.([0-9]+)<span class="pl-pds">'</span></span>, netwk_data[<span class="pl-s"><span class="pl-pds">'</span>Options<span class="pl-pds">'</span></span>][<span class="pl-s"><span class="pl-pds">'</span>parent<span class="pl-pds">'</span></span>])[<span class="pl-c1"></span>]
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-4_sensor-py-LC19" class="blob-code blob-code-inner js-file-line">
                  network <span class="pl-k">=</span> ipaddress.ip_network(netwk_data[<span class="pl-s"><span class="pl-pds">'</span>IPAM<span class="pl-pds">'</span></span>][<span class="pl-s"><span class="pl-pds">'</span>Config<span class="pl-pds">'</span></span>][<span class="pl-c1"></span>][<span class="pl-s"><span class="pl-pds">'</span>Subnet<span class="pl-pds">'</span></span>])
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-4_sensor-py-LC20" class="blob-code blob-code-inner js-file-line">
                  data <span class="pl-k">=</span> <span class="pl-c1">dict</span>(<span class="pl-v">action</span><span class="pl-k">=</span>event[<span class="pl-s"><span class="pl-pds">'</span>Action<span class="pl-pds">'</span></span>],
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-4_sensor-py-LC21" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-v">rbridge</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">"</span>21<span class="pl-pds">"</span></span>,
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L22" class="blob-num js-line-number" data-line-number="22">
                </td>
                
                <td id="file-4_sensor-py-LC22" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-v">subnet</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">"</span><span class="pl-c1">%s</span>/<span class="pl-c1">%s</span><span class="pl-pds">"</span></span> <span class="pl-k">%</span> (network[<span class="pl-c1">1</span>], network.prefixlen),
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L23" class="blob-num js-line-number" data-line-number="23">
                </td>
                
                <td id="file-4_sensor-py-LC23" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-v">vlan</span><span class="pl-k">=</span>vlan,
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L24" class="blob-num js-line-number" data-line-number="24">
                </td>
                
                <td id="file-4_sensor-py-LC24" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-v">channel</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">"</span>docker<span class="pl-pds">"</span></span>,
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L25" class="blob-num js-line-number" data-line-number="25">
                </td>
                
                <td id="file-4_sensor-py-LC25" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-v">host</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">"</span>10.254.4.105<span class="pl-pds">"</span></span>,
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L26" class="blob-num js-line-number" data-line-number="26">
                </td>
                
                <td id="file-4_sensor-py-LC26" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-v">username</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">"</span>admin<span class="pl-pds">"</span></span>,
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L27" class="blob-num js-line-number" data-line-number="27">
                </td>
                
                <td id="file-4_sensor-py-LC27" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-v">password</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">"</span>password<span class="pl-pds">"</span></span>)
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L28" class="blob-num js-line-number" data-line-number="28">
                </td>
                
                <td id="file-4_sensor-py-LC28" class="blob-code blob-code-inner js-file-line">
                  trigger <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>docker.NetworkEvent<span class="pl-pds">'</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L29" class="blob-num js-line-number" data-line-number="29">
                </td>
                
                <td id="file-4_sensor-py-LC29" class="blob-code blob-code-inner js-file-line">
                  trace_tag <span class="pl-k">=</span> uuid.uuid4().hex
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L30" class="blob-num js-line-number" data-line-number="30">
                </td>
                
                <td id="file-4_sensor-py-LC30" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-c1">self</span>._sensor_service.dispatch(<span class="pl-v">trigger</span><span class="pl-k">=</span>trigger, <span class="pl-v">payload</span><span class="pl-k">=</span>data,
                </td>
              </tr>
              
              <tr>
                <td id="file-4_sensor-py-L31" class="blob-num js-line-number" data-line-number="31">
                </td>
                
                <td id="file-4_sensor-py-LC31" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-v">trace_tag</span><span class="pl-k">=</span>trace_tag)
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

Next, I created an action that pushes the needed configuration changes to the VDX. The building blocks of it is [VDX pack][5] that I auto-generated from VDX [YANG model][6] &#8211; an interesting topic that I’ll save for a separate blog. The network reconfiguration action is a workflow that uses these building blocks, and looks like this:

<div id="gist36060162" class="gist">
  <div class="gist-file">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-5_rule-yaml" class="file">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8">
              <tr>
                <td id="file-5_rule-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-5_rule-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-5_rule-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-5_rule-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s">network-trigger</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-5_rule-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-5_rule-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">pack</span>: <span class="pl-s">docker</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-5_rule-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-5_rule-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s">Triggered when a docker network event happens.</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-5_rule-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-5_rule-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">enabled</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-5_rule-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-5_rule-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">trigger</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-5_rule-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-5_rule-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s">docker.NetworkEvent</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-5_rule-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-5_rule-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">criteria</span>: <span class="pl-s">{}</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-5_rule-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-5_rule-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-5_rule-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-5_rule-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">parameters</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-5_rule-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-5_rule-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">channel</span>: <span class="pl-s"><span class="pl-pds">'</span>{{trigger.channel}}<span class="pl-pds">'</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-5_rule-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-5_rule-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">host</span>: <span class="pl-s"><span class="pl-pds">'</span>{{trigger.host}}<span class="pl-pds">'</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-5_rule-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-5_rule-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">password</span>: <span class="pl-s"><span class="pl-pds">'</span>{{trigger.password}}<span class="pl-pds">'</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-5_rule-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-5_rule-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">rbridge_id</span>: <span class="pl-s"><span class="pl-pds">'</span>{{trigger.rbridge}}<span class="pl-pds">'</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-5_rule-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-5_rule-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">subnet</span>: <span class="pl-s"><span class="pl-pds">'</span>{{trigger.subnet}}<span class="pl-pds">'</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-5_rule-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-5_rule-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">username</span>: <span class="pl-s"><span class="pl-pds">'</span>{{trigger.username}}<span class="pl-pds">'</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-5_rule-yaml-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-5_rule-yaml-LC17" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">vlan</span>: <span class="pl-s"><span class="pl-pds">'</span>{{trigger.vlan}}<span class="pl-pds">'</span></span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

Lastly, I set up a Rule, to fire a workflow when the sensor fires a trigger:

<div id="gist36060162" class="gist">
  <div class="gist-file">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-6_workflow-yaml" class="file">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8">
              <tr>
                <td id="file-6_workflow-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-6_workflow-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">version</span>: <span class="pl-s"><span class="pl-pds">'</span>2.0<span class="pl-pds">'</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-6_workflow-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-6_workflow-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">docker.docker-network-tor</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-6_workflow-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s">Workflow to add TOR VLAN interfaces for docker MACVLAN Networks.</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-6_workflow-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">input</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-6_workflow-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s">rbridge_id</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-6_workflow-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s">subnet</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-6_workflow-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s">vlan</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-6_workflow-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s">channel</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-6_workflow-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s">host</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-6_workflow-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s">username</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-6_workflow-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s">password</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-6_workflow-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">task-defaults</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-6_workflow-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">on-error</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-6_workflow-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s">notify_fail</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-6_workflow-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-6_workflow-yaml-LC17" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">tasks</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-6_workflow-yaml-LC18" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">add_ve_interface</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-6_workflow-yaml-LC19" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action</span>: <span class="pl-s">vdx.interface_vlan_interface_vlan_vlan_name</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-6_workflow-yaml-LC20" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">input</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-6_workflow-yaml-LC21" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s"><% $.vlan %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L22" class="blob-num js-line-number" data-line-number="22">
                </td>
                
                <td id="file-6_workflow-yaml-LC22" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">vlan_name</span>: <span class="pl-s"><span class="pl-pds">"</span>Docker Network<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L23" class="blob-num js-line-number" data-line-number="23">
                </td>
                
                <td id="file-6_workflow-yaml-LC23" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">host</span>: <span class="pl-s"><% $.host %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L24" class="blob-num js-line-number" data-line-number="24">
                </td>
                
                <td id="file-6_workflow-yaml-LC24" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">username</span>: <span class="pl-s"><% $.username %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L25" class="blob-num js-line-number" data-line-number="25">
                </td>
                
                <td id="file-6_workflow-yaml-LC25" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">password</span>: <span class="pl-s"><% $.password %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L26" class="blob-num js-line-number" data-line-number="26">
                </td>
                
                <td id="file-6_workflow-yaml-LC26" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">publish</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L27" class="blob-num js-line-number" data-line-number="27">
                </td>
                
                <td id="file-6_workflow-yaml-LC27" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">status_message</span>: <span class="pl-s"><span class="pl-pds">"</span>Successfully added VE Interface<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L28" class="blob-num js-line-number" data-line-number="28">
                </td>
                
                <td id="file-6_workflow-yaml-LC28" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">on-success</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L29" class="blob-num js-line-number" data-line-number="29">
                </td>
                
                <td id="file-6_workflow-yaml-LC29" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s">add_global_ve_int</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L30" class="blob-num js-line-number" data-line-number="30">
                </td>
                
                <td id="file-6_workflow-yaml-LC30" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">add_global_ve_int</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L31" class="blob-num js-line-number" data-line-number="31">
                </td>
                
                <td id="file-6_workflow-yaml-LC31" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action</span>: <span class="pl-s">vdx.interface_vlan_interface_ve_gve_name</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L32" class="blob-num js-line-number" data-line-number="32">
                </td>
                
                <td id="file-6_workflow-yaml-LC32" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">input</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L33" class="blob-num js-line-number" data-line-number="33">
                </td>
                
                <td id="file-6_workflow-yaml-LC33" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">gve_name</span>: <span class="pl-s"><% $.vlan %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L34" class="blob-num js-line-number" data-line-number="34">
                </td>
                
                <td id="file-6_workflow-yaml-LC34" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">host</span>: <span class="pl-s"><% $.host %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L35" class="blob-num js-line-number" data-line-number="35">
                </td>
                
                <td id="file-6_workflow-yaml-LC35" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">username</span>: <span class="pl-s"><% $.username %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L36" class="blob-num js-line-number" data-line-number="36">
                </td>
                
                <td id="file-6_workflow-yaml-LC36" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">password</span>: <span class="pl-s"><% $.password %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L37" class="blob-num js-line-number" data-line-number="37">
                </td>
                
                <td id="file-6_workflow-yaml-LC37" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">publish</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L38" class="blob-num js-line-number" data-line-number="38">
                </td>
                
                <td id="file-6_workflow-yaml-LC38" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">status_message</span>: <span class="pl-s"><span class="pl-pds">"</span>Successfully added global VE Interface<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L39" class="blob-num js-line-number" data-line-number="39">
                </td>
                
                <td id="file-6_workflow-yaml-LC39" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">on-success</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L40" class="blob-num js-line-number" data-line-number="40">
                </td>
                
                <td id="file-6_workflow-yaml-LC40" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s">set_ve_ip</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L41" class="blob-num js-line-number" data-line-number="41">
                </td>
                
                <td id="file-6_workflow-yaml-LC41" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">set_ve_ip</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L42" class="blob-num js-line-number" data-line-number="42">
                </td>
                
                <td id="file-6_workflow-yaml-LC42" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action</span>: <span class="pl-s">vdx.rbridge_id_interface_ve_ip_ip_config_address_address</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L43" class="blob-num js-line-number" data-line-number="43">
                </td>
                
                <td id="file-6_workflow-yaml-LC43" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">input</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L44" class="blob-num js-line-number" data-line-number="44">
                </td>
                
                <td id="file-6_workflow-yaml-LC44" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">rbridge_id</span>: <span class="pl-s"><% $.rbridge_id %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L45" class="blob-num js-line-number" data-line-number="45">
                </td>
                
                <td id="file-6_workflow-yaml-LC45" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s"><% $.vlan %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L46" class="blob-num js-line-number" data-line-number="46">
                </td>
                
                <td id="file-6_workflow-yaml-LC46" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">address</span>: <span class="pl-s"><% $.subnet %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L47" class="blob-num js-line-number" data-line-number="47">
                </td>
                
                <td id="file-6_workflow-yaml-LC47" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">host</span>: <span class="pl-s"><% $.host %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L48" class="blob-num js-line-number" data-line-number="48">
                </td>
                
                <td id="file-6_workflow-yaml-LC48" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">username</span>: <span class="pl-s"><% $.username %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L49" class="blob-num js-line-number" data-line-number="49">
                </td>
                
                <td id="file-6_workflow-yaml-LC49" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">password</span>: <span class="pl-s"><% $.password %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L50" class="blob-num js-line-number" data-line-number="50">
                </td>
                
                <td id="file-6_workflow-yaml-LC50" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">publish</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L51" class="blob-num js-line-number" data-line-number="51">
                </td>
                
                <td id="file-6_workflow-yaml-LC51" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">status_message</span>: <span class="pl-s"><span class="pl-pds">"</span>Successfully set VE IP Address<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L52" class="blob-num js-line-number" data-line-number="52">
                </td>
                
                <td id="file-6_workflow-yaml-LC52" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">on-success</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L53" class="blob-num js-line-number" data-line-number="53">
                </td>
                
                <td id="file-6_workflow-yaml-LC53" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s">no_shut_ve</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L54" class="blob-num js-line-number" data-line-number="54">
                </td>
                
                <td id="file-6_workflow-yaml-LC54" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">no_shut_ve</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L55" class="blob-num js-line-number" data-line-number="55">
                </td>
                
                <td id="file-6_workflow-yaml-LC55" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action</span>: <span class="pl-s">vdx.rbridge_id_interface_ve_shutdown</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L56" class="blob-num js-line-number" data-line-number="56">
                </td>
                
                <td id="file-6_workflow-yaml-LC56" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">input</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L57" class="blob-num js-line-number" data-line-number="57">
                </td>
                
                <td id="file-6_workflow-yaml-LC57" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">rbridge_id</span>: <span class="pl-s"><% $.rbridge_id %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L58" class="blob-num js-line-number" data-line-number="58">
                </td>
                
                <td id="file-6_workflow-yaml-LC58" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s"><% $.vlan %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L59" class="blob-num js-line-number" data-line-number="59">
                </td>
                
                <td id="file-6_workflow-yaml-LC59" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">delete_shutdown</span>: <span class="pl-c1">True</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L60" class="blob-num js-line-number" data-line-number="60">
                </td>
                
                <td id="file-6_workflow-yaml-LC60" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">host</span>: <span class="pl-s"><% $.host %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L61" class="blob-num js-line-number" data-line-number="61">
                </td>
                
                <td id="file-6_workflow-yaml-LC61" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">username</span>: <span class="pl-s"><% $.username %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L62" class="blob-num js-line-number" data-line-number="62">
                </td>
                
                <td id="file-6_workflow-yaml-LC62" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">password</span>: <span class="pl-s"><% $.password %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L63" class="blob-num js-line-number" data-line-number="63">
                </td>
                
                <td id="file-6_workflow-yaml-LC63" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">publish</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L64" class="blob-num js-line-number" data-line-number="64">
                </td>
                
                <td id="file-6_workflow-yaml-LC64" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">status_message</span>: <span class="pl-s"><span class="pl-pds">"</span>Successfully noshut VE Interface<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L65" class="blob-num js-line-number" data-line-number="65">
                </td>
                
                <td id="file-6_workflow-yaml-LC65" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">on-success</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L66" class="blob-num js-line-number" data-line-number="66">
                </td>
                
                <td id="file-6_workflow-yaml-LC66" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s">no_shut_ve_global</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L67" class="blob-num js-line-number" data-line-number="67">
                </td>
                
                <td id="file-6_workflow-yaml-LC67" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">no_shut_ve_global</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L68" class="blob-num js-line-number" data-line-number="68">
                </td>
                
                <td id="file-6_workflow-yaml-LC68" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action</span>: <span class="pl-s">vdx.interface_vlan_interface_ve_global_ve_shutdown</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L69" class="blob-num js-line-number" data-line-number="69">
                </td>
                
                <td id="file-6_workflow-yaml-LC69" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">input</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L70" class="blob-num js-line-number" data-line-number="70">
                </td>
                
                <td id="file-6_workflow-yaml-LC70" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">gve_name</span>: <span class="pl-s"><% $.vlan %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L71" class="blob-num js-line-number" data-line-number="71">
                </td>
                
                <td id="file-6_workflow-yaml-LC71" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">delete_global_ve_shutdown</span>: <span class="pl-c1">True</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L72" class="blob-num js-line-number" data-line-number="72">
                </td>
                
                <td id="file-6_workflow-yaml-LC72" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">host</span>: <span class="pl-s"><% $.host %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L73" class="blob-num js-line-number" data-line-number="73">
                </td>
                
                <td id="file-6_workflow-yaml-LC73" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">username</span>: <span class="pl-s"><% $.username %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L74" class="blob-num js-line-number" data-line-number="74">
                </td>
                
                <td id="file-6_workflow-yaml-LC74" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">password</span>: <span class="pl-s"><% $.password %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L75" class="blob-num js-line-number" data-line-number="75">
                </td>
                
                <td id="file-6_workflow-yaml-LC75" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">publish</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L76" class="blob-num js-line-number" data-line-number="76">
                </td>
                
                <td id="file-6_workflow-yaml-LC76" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">status_message</span>: <span class="pl-s"><span class="pl-pds">"</span>Successfully noshut VE Interface<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L77" class="blob-num js-line-number" data-line-number="77">
                </td>
                
                <td id="file-6_workflow-yaml-LC77" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">on-success</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L78" class="blob-num js-line-number" data-line-number="78">
                </td>
                
                <td id="file-6_workflow-yaml-LC78" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s">notify_success</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L79" class="blob-num js-line-number" data-line-number="79">
                </td>
                
                <td id="file-6_workflow-yaml-LC79" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">notify_success</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L80" class="blob-num js-line-number" data-line-number="80">
                </td>
                
                <td id="file-6_workflow-yaml-LC80" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action</span>: <span class="pl-s">chatops.post_message</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L81" class="blob-num js-line-number" data-line-number="81">
                </td>
                
                <td id="file-6_workflow-yaml-LC81" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">input</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L82" class="blob-num js-line-number" data-line-number="82">
                </td>
                
                <td id="file-6_workflow-yaml-LC82" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">channel</span>: <span class="pl-s"><% $.channel %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L83" class="blob-num js-line-number" data-line-number="83">
                </td>
                
                <td id="file-6_workflow-yaml-LC83" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">message</span>: <span class="pl-s"><span class="pl-pds">"</span>Docker network has been created on TOR.<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L84" class="blob-num js-line-number" data-line-number="84">
                </td>
                
                <td id="file-6_workflow-yaml-LC84" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">publish</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L85" class="blob-num js-line-number" data-line-number="85">
                </td>
                
                <td id="file-6_workflow-yaml-LC85" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">status_message</span>: <span class="pl-s"><span class="pl-pds">"</span>Sent success message to chatops.<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L86" class="blob-num js-line-number" data-line-number="86">
                </td>
                
                <td id="file-6_workflow-yaml-LC86" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">notify_fail</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L87" class="blob-num js-line-number" data-line-number="87">
                </td>
                
                <td id="file-6_workflow-yaml-LC87" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action</span>: <span class="pl-s">chatops.post_message</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L88" class="blob-num js-line-number" data-line-number="88">
                </td>
                
                <td id="file-6_workflow-yaml-LC88" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">input</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L89" class="blob-num js-line-number" data-line-number="89">
                </td>
                
                <td id="file-6_workflow-yaml-LC89" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">channel</span>: <span class="pl-s"><% $.channel %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L90" class="blob-num js-line-number" data-line-number="90">
                </td>
                
                <td id="file-6_workflow-yaml-LC90" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">message</span>: <span class="pl-s"><span class="pl-pds">"</span>Failed to create docker network on TOR.<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L91" class="blob-num js-line-number" data-line-number="91">
                </td>
                
                <td id="file-6_workflow-yaml-LC91" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">publish</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-6_workflow-yaml-L92" class="blob-num js-line-number" data-line-number="92">
                </td>
                
                <td id="file-6_workflow-yaml-LC92" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">status_message</span>: <span class="pl-s"><span class="pl-pds">"</span>Sent fail message to chatops.<span class="pl-pds">"</span></span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

So let&#8217;s create a docker network and see what happens in StackStorm and Docker. Again, [watch the video][1] to see it in action. Or, follow alone:

<div id="gist36060162" class="gist">
  <div class="gist-file">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-7_docker_network_create-out" class="file">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8">
              <tr>
                <td id="file-7_docker_network_create-out-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-7_docker_network_create-out-LC1" class="blob-code blob-code-inner js-file-line">
                  > docker network create --driver=macvlan --subnet=172.16.112.0/24 -o parent=eth0.112 dockernetwork112
                </td>
              </tr>
              
              <tr>
                <td id="file-7_docker_network_create-out-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-7_docker_network_create-out-LC2" class="blob-code blob-code-inner js-file-line">
                  1d2154903275c95437506e0b714fbff826835c8da63bbfa08cfca8f8d0a8c188
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

The previous command tells the swarm cluster to create a new network named `dockernetwork112` with the subnet of `172.16.112.0/24` and pinned to the host interface `eth0.112`.

Lets now list the networks in the swarm cluster.

<div id="gist36060162" class="gist">
  <div class="gist-file">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-8_docker_network_ls-out" class="file">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8">
              <tr>
                <td id="file-8_docker_network_ls-out-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-8_docker_network_ls-out-LC1" class="blob-code blob-code-inner js-file-line">
                  > docker network ls
                </td>
              </tr>
              
              <tr>
                <td id="file-8_docker_network_ls-out-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-8_docker_network_ls-out-LC2" class="blob-code blob-code-inner js-file-line">
                  NETWORK ID NAME DRIVER
                </td>
              </tr>
              
              <tr>
                <td id="file-8_docker_network_ls-out-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-8_docker_network_ls-out-LC3" class="blob-code blob-code-inner js-file-line">
                  45a14a2a8a5a vagrant-ubuntu-trusty-64/host host
                </td>
              </tr>
              
              <tr>
                <td id="file-8_docker_network_ls-out-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-8_docker_network_ls-out-LC4" class="blob-code blob-code-inner js-file-line">
                  1d2154903275 vagrant-ubuntu-trusty-64/dockernetwork112 macvlan
                </td>
              </tr>
              
              <tr>
                <td id="file-8_docker_network_ls-out-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-8_docker_network_ls-out-LC5" class="blob-code blob-code-inner js-file-line">
                  70e091519778 vagrant-ubuntu-trusty-64/bridge bridge
                </td>
              </tr>
              
              <tr>
                <td id="file-8_docker_network_ls-out-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-8_docker_network_ls-out-LC6" class="blob-code blob-code-inner js-file-line">
                  d7cd20ce6a9b vagrant-ubuntu-trusty-64/none null
                </td>
              </tr>
              
              <tr>
                <td id="file-8_docker_network_ls-out-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-8_docker_network_ls-out-LC7" class="blob-code blob-code-inner js-file-line">
                  c5d83e381f1f vagrant-ubuntu-trusty-64/host host
                </td>
              </tr>
              
              <tr>
                <td id="file-8_docker_network_ls-out-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-8_docker_network_ls-out-LC8" class="blob-code blob-code-inner js-file-line">
                  3208fb94f122 vagrant-ubuntu-trusty-64/bridge bridge
                </td>
              </tr>
              
              <tr>
                <td id="file-8_docker_network_ls-out-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-8_docker_network_ls-out-LC9" class="blob-code blob-code-inner js-file-line">
                  21602e11db6e vagrant-ubuntu-trusty-64/none null
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

Unsurprisingly our new network is now listed and available to attach containers to. In a normal cluster this is where you would log into the physical network and create the related configuration for the network to work correctly. Since we&#8217;ve attached to the event API and have a StackStorm workflow waiting to create the network lets see what happened in the background once we created the network.

Let&#8217;s begin by showing you the execution that ran when the event API created a new network. (I got the hash value by running `st2 execution list`)

<div id="gist36060162" class="gist">
  <div class="gist-file">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-9_st2_execution_get-out" class="file">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8">
              <tr>
                <td id="file-9_st2_execution_get-out-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC1" class="blob-code blob-code-inner js-file-line">
                  vagrant@ip-172-28-128-3:~$ st2 execution get 57238dae3520fd02f700565e
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC2" class="blob-code blob-code-inner js-file-line">
                  id: 57238dae3520fd02f700565e
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC3" class="blob-code blob-code-inner js-file-line">
                  action.ref: docker.docker-network-tor
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC4" class="blob-code blob-code-inner js-file-line">
                  parameters:
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC5" class="blob-code blob-code-inner js-file-line">
                  channel: docker
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC6" class="blob-code blob-code-inner js-file-line">
                  host: 10.254.4.105
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC7" class="blob-code blob-code-inner js-file-line">
                  password: password
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC8" class="blob-code blob-code-inner js-file-line">
                  rbridge_id: '21'
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC9" class="blob-code blob-code-inner js-file-line">
                  subnet: 172.16.112.1/24
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC10" class="blob-code blob-code-inner js-file-line">
                  username: admin
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC11" class="blob-code blob-code-inner js-file-line">
                  vlan: '112'
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC12" class="blob-code blob-code-inner js-file-line">
                  status: succeeded
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC13" class="blob-code blob-code-inner js-file-line">
                  start_timestamp: 2016-04-29T16:37:02.056217Z
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC14" class="blob-code blob-code-inner js-file-line">
                  end_timestamp: 2016-04-29T16:37:40.404525Z
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC15" class="blob-code blob-code-inner js-file-line">
                  +--------------------------+-----------+-------------------+------------------------------+-------------------------------+
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC16" class="blob-code blob-code-inner js-file-line">
                  | id | status | task | action | start_timestamp |
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC17" class="blob-code blob-code-inner js-file-line">
                  +--------------------------+-----------+-------------------+------------------------------+-------------------------------+
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC18" class="blob-code blob-code-inner js-file-line">
                  | 57238db03520fd062929960b | succeeded | add_ve_interface | vdx.interface_vlan_interface | Fri, 29 Apr 2016 16:37:04 UTC |
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC19" class="blob-code blob-code-inner js-file-line">
                  | | | | _vlan_vlan_name | |
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC20" class="blob-code blob-code-inner js-file-line">
                  | 57238db63520fd062929960d | succeeded | add_global_ve_int | vdx.interface_vlan_interface | Fri, 29 Apr 2016 16:37:10 UTC |
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC21" class="blob-code blob-code-inner js-file-line">
                  | | | | _ve_gve_name | |
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L22" class="blob-num js-line-number" data-line-number="22">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC22" class="blob-code blob-code-inner js-file-line">
                  | 57238dbc3520fd062929960f | succeeded | set_ve_ip | vdx.rbridge_id_interface_ve_ | Fri, 29 Apr 2016 16:37:16 UTC |
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L23" class="blob-num js-line-number" data-line-number="23">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC23" class="blob-code blob-code-inner js-file-line">
                  | | | | ip_ip_config_address_address | |
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L24" class="blob-num js-line-number" data-line-number="24">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC24" class="blob-code blob-code-inner js-file-line">
                  | 57238dc23520fd0629299611 | succeeded | no_shut_ve | vdx.rbridge_id_interface_ve_ | Fri, 29 Apr 2016 16:37:22 UTC |
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L25" class="blob-num js-line-number" data-line-number="25">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC25" class="blob-code blob-code-inner js-file-line">
                  | | | | shutdown | |
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L26" class="blob-num js-line-number" data-line-number="26">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC26" class="blob-code blob-code-inner js-file-line">
                  | 57238dc93520fd0629299613 | succeeded | no_shut_ve_global | vdx.interface_vlan_interface | Fri, 29 Apr 2016 16:37:29 UTC |
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L27" class="blob-num js-line-number" data-line-number="27">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC27" class="blob-code blob-code-inner js-file-line">
                  | | | | _ve_global_ve_shutdown | |
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L28" class="blob-num js-line-number" data-line-number="28">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC28" class="blob-code blob-code-inner js-file-line">
                  | 57238dcf3520fd0629299615 | succeeded | notify_success | chatops.post_message | Fri, 29 Apr 2016 16:37:35 UTC |
                </td>
              </tr>
              
              <tr>
                <td id="file-9_st2_execution_get-out-L29" class="blob-num js-line-number" data-line-number="29">
                </td>
                
                <td id="file-9_st2_execution_get-out-LC29" class="blob-code blob-code-inner js-file-line">
                  +--------------------------+-----------+-------------------+------------------------------+-------------------------------+
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

From the output you can see this workflow executed several actions. Creating a VE interface, creating the global VE interface, setting the IP address, no shutting the interface, and notify\_success. We&#8217;ll come back to notify\_success later. For now let&#8217;s look at the other actions which are all actions to send NETCONF formed XML to the VDX to have it create our configuration. If we log into the VDX again and use some show command we can see the additional configuration.

<div id="gist36060162" class="gist">
  <div class="gist-file">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-10_show_ip_ve_2-out" class="file">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8">
              <tr>
                <td id="file-10_show_ip_ve_2-out-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-10_show_ip_ve_2-out-LC1" class="blob-code blob-code-inner js-file-line">
                  Spine-198976# show ip int brief | inc Ve
                </td>
              </tr>
              
              <tr>
                <td id="file-10_show_ip_ve_2-out-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-10_show_ip_ve_2-out-LC2" class="blob-code blob-code-inner js-file-line">
                  Ve 10 10.1.1.21 default-vrf up up
                </td>
              </tr>
              
              <tr>
                <td id="file-10_show_ip_ve_2-out-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-10_show_ip_ve_2-out-LC3" class="blob-code blob-code-inner js-file-line">
                  Ve 20 20.1.1.21 default-vrf up up
                </td>
              </tr>
              
              <tr>
                <td id="file-10_show_ip_ve_2-out-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-10_show_ip_ve_2-out-LC4" class="blob-code blob-code-inner js-file-line">
                  Ve 30 30.1.1.21 default-vrf up up
                </td>
              </tr>
              
              <tr>
                <td id="file-10_show_ip_ve_2-out-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-10_show_ip_ve_2-out-LC5" class="blob-code blob-code-inner js-file-line">
                  Ve 112 172.16.112.1 default-vrf up up
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="gist36060162" class="gist">
  <div class="gist-file">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-11_show_running_config" class="file">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8">
              <tr>
                <td id="file-11_show_running_config-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-11_show_running_config-LC1" class="blob-code blob-code-inner js-file-line">
                  Spine-198976# show running-config rbridge-id 21 interface Ve 112
                </td>
              </tr>
              
              <tr>
                <td id="file-11_show_running_config-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-11_show_running_config-LC2" class="blob-code blob-code-inner js-file-line">
                  rbridge-id 21
                </td>
              </tr>
              
              <tr>
                <td id="file-11_show_running_config-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-11_show_running_config-LC3" class="blob-code blob-code-inner js-file-line">
                  interface Ve 112
                </td>
              </tr>
              
              <tr>
                <td id="file-11_show_running_config-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-11_show_running_config-LC4" class="blob-code blob-code-inner js-file-line">
                  ip proxy-arp
                </td>
              </tr>
              
              <tr>
                <td id="file-11_show_running_config-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-11_show_running_config-LC5" class="blob-code blob-code-inner js-file-line">
                  ip address 172.16.112.1/24
                </td>
              </tr>
              
              <tr>
                <td id="file-11_show_running_config-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-11_show_running_config-LC6" class="blob-code blob-code-inner js-file-line">
                  no shutdown
                </td>
              </tr>
              
              <tr>
                <td id="file-11_show_running_config-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-11_show_running_config-LC7" class="blob-code blob-code-inner js-file-line">
                  !
                </td>
              </tr>
              
              <tr>
                <td id="file-11_show_running_config-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-11_show_running_config-LC8" class="blob-code blob-code-inner js-file-line">
                  !
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

We can see here how StackStorm used the VDX action pack to push the needed configuration to the device. Reducing the time to delivery of the network and freeing up the network engineer to focus on more pressing issues.

The last piece of the workflow was the `notify_success`. This action sends a message into a slack channel which can notify network staff or operational staff of the net network&#8217;s availability.  
This is a simple but powerful example of network automation. Enabling operational staff to capture their repetitive tasks as a workflows is an incredibly powerful concept, for network operators and devops alike. I&#8217;m personally excited to see Brocade doubling down on this event driven, workflow centric, community approach to operations. Expect to see us deliver more network automation capabilities like this over the next few months. Don’t stop there though: Use your imagination and think about how you can tie the network into your workflows!

 [1]: https://www.youtube.com/watch?v=P9G71Ow6GUs
 [2]: https://github.com/StackStorm/dockernetwork-vdx-demo
 [3]: https://github.com/docker/libnetwork
 [4]: https://github.com/docker/docker/blob/master/experimental/vlan-networks.md
 [5]: https://github.com/StackStorm/dockernetwork-vdx-demo/tree/master/vdx
 [6]: https://tools.ietf.org/html/rfc6020