---
title: Double Packs Update
author: st2admin
type: post
date: 2018-02-02T22:28:20+00:00
url: /2018/02/02/double-packs-update/
thrive_post_fonts:
  - '[]'
  - '[]'
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6455183675
categories:
  - Community
  - News
tags:
  - Community
  - exchange

---
_February 2, 2018_  
_by Lindsay Hill_

No packs update over Christmas because we were taking a break &#8211; so here&#8217;s a double helping of updates to packs on the [StackStorm Exchange][1]. We have new packs for Palo Alto Networks, CloudShark, updates to the OpenStack, NetBox, Device42 packs, and a bunch of bugfixes, including Consul, ServiceNow, Cisco Spark and more. Here&#8217;s the details:

<!--more-->

## New Packs This Month

  * [Palo Alto][2]: [Palo Alto Networks][3] firewalls have become very popular, with good reason. Now you can use ST2 to block threats on PAN in response to events.
  * [CloudShark][4]: [CloudShark][5] is like Wireshark in your browser. This pack uploads a PCAP file to CloudShark, and returns the URL to view that in your browser.So you can run something like this:  
    &#8220;\`  
    extreme@EWC:~$ st2 run cloudshark.upload file\_path=/home/stanley/pcaps/st2\_leaf1_fbd3aca6-4ac5-4638-869f-5e2dd4779cc9.pcap  
    ..  
    id: 5a692f9d99c96b2815dbf6b7  
    status: succeeded (2s elapsed)  
    parameters:  
    file\_path: /home/stanley/pcaps/st2\_leaf1_fbd3aca6-4ac5-4638-869f-5e2dd4779cc9.pcap  
    result:  
    exit_code: 0  
    result:  
    filename: st2\_leaf1\_fbd3aca6-4ac5-4638-869f-5e2dd4779cc9.pcap  
    link: https://www.cloudshark.org/captures/ae5b12006b47  
    status_code: 200  
    text: &#8216;{&#8220;id&#8221;:&#8221;ae5b12006b47&#8243;,&#8221;filename&#8221;:&#8221;st2\_leaf1\_fbd3aca6-4ac5-4638-869f-5e2dd4779cc9.pcap&#8221;}&#8217;  
    stderr: &#8221;  
    stdout: &#8221;  
    extreme@EWC:~$  
    &#8220;\`  
    Follow the [the link][6] to see the PCAP:  
    [<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/02/cloudshark_screenshot.png" alt="" width="2240" height="1190" class="aligncenter size-full wp-image-7638" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/02/cloudshark_screenshot.png 2240w, https://stackstorm.com/wp/wp-content/uploads/2018/02/cloudshark_screenshot-150x80.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/02/cloudshark_screenshot-300x159.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/02/cloudshark_screenshot-768x408.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/02/cloudshark_screenshot-1024x544.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2018/02/cloudshark_screenshot-80x43.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/02/cloudshark_screenshot-220x117.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/02/cloudshark_screenshot-188x100.png 188w, https://stackstorm.com/wp/wp-content/uploads/2018/02/cloudshark_screenshot-280x150.png 280w, https://stackstorm.com/wp/wp-content/uploads/2018/02/cloudshark_screenshot-448x238.png 448w, https://stackstorm.com/wp/wp-content/uploads/2018/02/cloudshark_screenshot-750x398.png 750w, https://stackstorm.com/wp/wp-content/uploads/2018/02/cloudshark_screenshot-917x487.png 917w, https://stackstorm.com/wp/wp-content/uploads/2018/02/cloudshark_screenshot-1120x595.png 1120w" sizes="(max-width: 2240px) 100vw, 2240px" />][7]</p> 
    Nifty eh?</li> </ul> 
    
    ## Pack Updates
    
      * [NetBox][8] now supports virtualization endpoints, such as clusters, virtual machines, etc.
      * [Device42][9]: More actions to help with device provisioning and network lifecycle automation. Be sure to read some of their great blogs that [show this in action][10].
      * [OpenStack][11]: Some network-related actions are not available via the Python OpenStack Client. Now you can use these via Neutron. Check the README to learn more.
    
    We also have minor fixes & updates to the [Jira][12], [AWS][13], [Cisco Spark][14], [Salt][15], [ServiceNow][16], [Consul][17], [Napalm][18] and [Ghost2logger][19] packs. If you&#8217;re using any of those packs, you will probably want to update them, with `st2 pack install <pack>`.</pack> 
    
    As always, thanks to everyone who helped in some way.

 [1]: https://exchange.stackstorm.org
 [2]: https://github.com/StackStorm-Exchange/stackstorm-paloalto
 [3]: https://www.paloaltonetworks.com
 [4]: https://github.com/StackStorm-Exchange/stackstorm-cloudshark
 [5]: https://www.cloudshark.org/
 [6]: https://www.cloudshark.org/captures/ae5b12006b47
 [7]: https://stackstorm.com/wp/wp-content/uploads/2018/02/cloudshark_screenshot.png
 [8]: https://github.com/StackStorm-Exchange/stackstorm-netbox/
 [9]: https://github.com/StackStorm-Exchange/stackstorm-device42/
 [10]: https://www.device42.com/blog/2018/01/automated-server-provisioning-with-device42-stackstorm-and-pxe-kickstart/
 [11]: https://github.com/StackStorm-Exchange/stackstorm-openstack/
 [12]: https://github.com/StackStorm-Exchange/stackstorm-jira
 [13]: https://github.com/StackStorm-Exchange/stackstorm-aws
 [14]: https://github.com/StackStorm-Exchange/stackstorm-cisco_spark
 [15]: https://github.com/StackStorm-Exchange/stackstorm-salt
 [16]: https://github.com/StackStorm-Exchange/stackstorm-servicenow
 [17]: https://github.com/StackStorm-Exchange/stackstorm-consul
 [18]: https://github.com/StackStorm-Exchange/stackstorm-napalm
 [19]: https://github.com/StackStorm-Exchange/stackstorm-ghost2logger