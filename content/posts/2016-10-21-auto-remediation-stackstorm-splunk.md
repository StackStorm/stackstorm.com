---
title: 'Auto-Remediation with StackStorm & Splunk'
author: st2admin
type: post
date: 2016-10-21T20:13:26+00:00
url: /2016/10/21/auto-remediation-stackstorm-splunk/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5246830889
tcb2_ready:
  - 1
categories:
  - Blog
  - Tutorials
tags:
  - Auto-remediation
  - chatops
  - networking
  - Splunk
  - syslog
  - tutorials
  - workflows

---
**Oct 21, 2016**  
_by Siddharth Krishna_

[**Splunk**][1] is a great tool for collecting and analyzing log data. StackStorm is a great tool for automated event-driven remediation. So what happens when we stick them together? Here’s how to use Splunk to collect syslog data and trigger event-based network remediation workflows using **StackStorm**!

<!--more-->

## Syslog as an event source

**Syslog** for events and errors from the network devices can be tapped to trigger troubleshooting and auto-remediation actions on those devices. For example, if a &#8216;link down&#8217; event occurs, the syslog message can be used to auto-trigger an action that would log into the device and try to bring the interface back up. In parallel, an IT ticket can also be auto-created with the relevant interface details. Notification of the event and the automated workflow can optionally be sent to a Slack channel (ChatOps).

One option is to have StackStorm itself act as the syslog server and run a sensor that polls the log file to match specific log strings. This method, although workable, has its performance limitations, and it doesn’t give us a nice tool for searching historical logs. Instead we can use something like Splunk, which is a log aggregation and analysis system. Splunk includes alert functionality &#8211; we can filter syslog messages, extract relevant fields, and trigger actions such as making a webhook request to StackStorm.

Here’s how to configure an auto-remediation workflow using Brocade VDX switches, Splunk and StackStorm:

> NB this guide assumes that you have a working StackStorm/BWC system, and a Splunk server. 

## VDX Configuration

Configure all VDX switches to send syslog messages to the Splunk server:

`logging syslog-server <splunk-ip-address> use-vrf mgmt-vrf`

## Setting up Splunk

We&#8217;re using the default Splunk [Search & Reporting][2] App here. You could also use the [Brocade Splunk App][3].

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchingapp-1024x433.png" alt="splunksearchingapp" width="1024" height="433" class="aligncenter size-large wp-image-6157" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchingapp-1024x433.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchingapp-150x63.png 150w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchingapp-300x127.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchingapp-768x325.png 768w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchingapp-80x34.png 80w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchingapp-220x93.png 220w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchingapp-237x100.png 237w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchingapp-280x118.png 280w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchingapp-510x215.png 510w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchingapp-750x317.png 750w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchingapp-975x412.png 975w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchingapp-710x300.png 710w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchingapp.png 1136w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

If your server does not currently accept syslog input, add it by going to:

_Settings -> Data -> Data Inputs -> UDP -> New_

Input UDP port 514 (default syslog port) and Source Type as ‘syslog’

Refer [here][4] for more on configuring data inputs on Splunk.

Splunk should now start displaying live syslog events from the switches in its search result.

_Search -> Data Summary -> Search Type: syslog_

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchsyslog-1024x395.png" alt="splunksearchsyslog" width="1024" height="395" class="aligncenter size-large wp-image-6158" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchsyslog-1024x395.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchsyslog-150x58.png 150w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchsyslog-300x116.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchsyslog-768x296.png 768w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchsyslog-80x31.png 80w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchsyslog-220x85.png 220w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchsyslog-250x97.png 250w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchsyslog-280x108.png 280w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchsyslog-510x197.png 510w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchsyslog-750x290.png 750w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchsyslog-975x376.png 975w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchsyslog-1190x459.png 1190w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchsyslog-777x300.png 777w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchsyslog.png 1303w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

Use the output of `show logging raslog` on a switch to identify an event or error of interest from its log string. In this case, we want to dynamically detect and act upon a link flap for which we need to tap syslog

`[NSM-1003], 48201, SW/0 | Active | DCE, INFO, LEAF2,  Interface TenGigabitEthernet 102/0/48 is link down.`

<div id="gist41100987" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-vdx_raslog_output" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-vdx_raslog_output-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-vdx_raslog_output-LC1" class="blob-code blob-code-inner js-file-line">
                  LEAF2# show logging raslog reverse count 10
                </td>
              </tr>
              
              <tr>
                <td id="file-vdx_raslog_output-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-vdx_raslog_output-LC2" class="blob-code blob-code-inner js-file-line">
                  NOS: 7.0.1
                </td>
              </tr>
              
              <tr>
                <td id="file-vdx_raslog_output-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-vdx_raslog_output-LC3" class="blob-code blob-code-inner js-file-line">
                  2016/10/11-12:13:31, [NSM-1019], 48207, SW/0 | Active | DCE, INFO, LEAF2, Interface TenGigabitEthernet 102/0/48 is administratively up.
                </td>
              </tr>
              
              <tr>
                <td id="file-vdx_raslog_output-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-vdx_raslog_output-LC4" class="blob-code blob-code-inner js-file-line">
                  2016/10/11-12:13:27, [SEC-1203], 48206, SW/0 | Active, INFO, LEAF2, Login information: Login successful via TELNET/SSH/RSH. IP Addr: 10.254.2.86.
                </td>
              </tr>
              
              <tr>
                <td id="file-vdx_raslog_output-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-vdx_raslog_output-LC5" class="blob-code blob-code-inner js-file-line">
                  2016/10/11-12:13:27, [SEC-1206], 48205, SW/0 | Active, INFO, LEAF2, Login information: User [admin] Last Successful Login Time : Tue Oct 11 12:13:20 2016.
                </td>
              </tr>
              
              <tr>
                <td id="file-vdx_raslog_output-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-vdx_raslog_output-LC6" class="blob-code blob-code-inner js-file-line">
                  2016/10/11-12:13:23, [SEC-3022], 48204, SW/0 | Active, INFO, LEAF2, Event: logout, Status: success, Info: Successful logout by user [admin].
                </td>
              </tr>
              
              <tr>
                <td id="file-vdx_raslog_output-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-vdx_raslog_output-LC7" class="blob-code blob-code-inner js-file-line">
                  2016/10/11-12:13:20, [SEC-1203], 48203, SW/0 | Active, INFO, LEAF2, Login information: Login successful via TELNET/SSH/RSH. IP Addr: 10.254.2.86.
                </td>
              </tr>
              
              <tr>
                <td id="file-vdx_raslog_output-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-vdx_raslog_output-LC8" class="blob-code blob-code-inner js-file-line">
                  2016/10/11-12:13:20, [SEC-1206], 48202, SW/0 | Active, INFO, LEAF2, Login information: User [admin] Last Successful Login Time : Tue Oct 11 12:12:23 2016.
                </td>
              </tr>
              
              <tr>
                <td id="file-vdx_raslog_output-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-vdx_raslog_output-LC9" class="blob-code blob-code-inner js-file-line">
                  2016/10/11-12:13:16, [NSM-1003], 48201, SW/0 | Active | DCE, INFO, LEAF2, Interface TenGigabitEthernet 102/0/48 is link down.
                </td>
              </tr>
              
              <tr>
                <td id="file-vdx_raslog_output-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-vdx_raslog_output-LC10" class="blob-code blob-code-inner js-file-line">
                  2016/10/11-12:13:16, [NSM-1020], 48200, SW/0 | Active | DCE, INFO, LEAF2, Interface TenGigabitEthernet 102/0/48 is administratively down.
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/sidkrishna/05ad300b6454c9f920add05c93e6bfcc/raw/c019b5950d5be8e249830123a462bae0a8b1ae07/vdx_raslog_output" style="float:right">view raw</a> <a href="https://gist.github.com/sidkrishna/05ad300b6454c9f920add05c93e6bfcc#file-vdx_raslog_output">vdx_raslog_output</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

On splunk, create a search criteria to filter out the event. Here, we use the following:

`sourcetype=syslog NSM-1003 process=raslogd | fields + host, interface, syslog_text`

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchcriteria-1024x271.png" alt="splunksearchcriteria" width="1024" height="271" class="aligncenter size-large wp-image-6156" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchcriteria-1024x271.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchcriteria-150x40.png 150w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchcriteria-300x80.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchcriteria-768x204.png 768w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchcriteria-80x21.png 80w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchcriteria-220x58.png 220w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchcriteria-250x66.png 250w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchcriteria-280x74.png 280w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchcriteria-510x135.png 510w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchcriteria-750x199.png 750w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchcriteria-975x258.png 975w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchcriteria-1190x315.png 1190w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchcriteria-960x254.png 960w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunksearchcriteria.png 1332w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

Stricter search criteria are recommended for greater filter accuracy. Once your search pattern is set up correctly, save it as a Splunk _Alert_ with alert type as &#8220;Real-time&#8221; in order to capture the event live.

_Save As -> Alert | Alert-type: Real-time, Trigger alert when: Per-Result_

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkalerts-1024x364.png" alt="splunkalerts" width="1024" height="364" class="aligncenter size-large wp-image-6154" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkalerts-1024x364.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkalerts-150x53.png 150w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkalerts-300x107.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkalerts-768x273.png 768w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkalerts-80x28.png 80w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkalerts-220x78.png 220w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkalerts-250x89.png 250w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkalerts-280x100.png 280w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkalerts-510x181.png 510w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkalerts-750x267.png 750w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkalerts-975x347.png 975w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkalerts-1190x423.png 1190w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkalerts-844x300.png 844w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkalerts.png 1240w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

Splunk provides multiple options for Trigger Actions &#8211; Run a script, Send an Email, _Webhook_. You can run a script that makes a cURL call to StackStorm webhook URL or, for simplicity, use Splunk&#8217;s webhook option. StackStorm&#8217;s custom webhook URL is:

`https://{STACK_STORM_HOSTNAME}/api/v1/webhooks/splunk_link_flap?st2-api-key=XXXXXXXXXXXXXXXXXXXXXXXX`

For successful action execution, relevant fields or parameters need to be correctly extracted from the event log message and passed via the webhook call to StackStorm. For example, to be able to auto-remediate a ‘link down’ event i.e. do a &#8220;shut; not shut&#8221; on the switch, the switch&#8217;s IP address and an interface name are must. Splunk&#8217;s field extraction capability is useful in auto-generating regexp to pull out the field values from the log string. These &#8220;field:value&#8221; pairs are then passed in the webhook JSON payload. More on field extractions can be found [here][5].

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkfieldext-1024x379.png" alt="splunkfieldext" width="1024" height="379" class="aligncenter size-large wp-image-6155" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkfieldext-1024x379.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkfieldext-150x55.png 150w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkfieldext-300x111.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkfieldext-768x284.png 768w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkfieldext-80x30.png 80w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkfieldext-220x81.png 220w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkfieldext-250x92.png 250w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkfieldext-280x104.png 280w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkfieldext-510x189.png 510w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkfieldext-750x277.png 750w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkfieldext-975x361.png 975w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkfieldext-1190x440.png 1190w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkfieldext-811x300.png 811w, https://stackstorm.com/wp/wp-content/uploads/2016/10/splunkfieldext.png 1284w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

## StackStorm/BWC Configuration

A [custom webhook][6] rule mapping the webhook trigger to the action workflow is created within StackStorm/BWC.

The custom webhook rule for ‘link flap’ defines the following:

  * Webhook trigger URL: “splunk\_link\_flap”, complete webhook URL to be configured on Splunk is &#8220;https://bwc/api/v1/webhooks/splunk\_link\_flap”
  * Action Reference: Name of the workflow to be executed when the webhook is triggered
  * Action Parameters (originally extracted by Splunk and passed via webhook):
  * Host: IP Address of the switch/device
  * Interface: Interface that went down

<div id="gist41100987" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-rule_list" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-rule_list-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-rule_list-LC1" class="blob-code blob-code-inner js-file-line">
                  brocade@bwc-2:~$ st2 rule list --pack=st2-demos
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_list-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-rule_list-LC2" class="blob-code blob-code-inner js-file-line">
                  +-----------------------------------------+-----------+--------------------------------+---------+
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_list-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-rule_list-LC3" class="blob-code blob-code-inner js-file-line">
                  | ref | pack | description | enabled |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_list-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-rule_list-LC4" class="blob-code blob-code-inner js-file-line">
                  +-----------------------------------------+-----------+--------------------------------+---------+
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_list-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-rule_list-LC5" class="blob-code blob-code-inner js-file-line">
                  | st2-demos.splunk_bgp_down_webhook_rule | st2-demos | Splunk bgp down webhook rule | True |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_list-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-rule_list-LC6" class="blob-code blob-code-inner js-file-line">
                  | st2-demos.splunk_link_flap_webhook_rule | st2-demos | Splunk link flap webhook rule | True |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_list-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-rule_list-LC7" class="blob-code blob-code-inner js-file-line">
                  | st2-demos.splunk_webhook_rule | st2-demos | splunk to chatops webhook Rule | True |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_list-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-rule_list-LC8" class="blob-code blob-code-inner js-file-line">
                  +-----------------------------------------+-----------+--------------------------------+---------+
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/sidkrishna/05ad300b6454c9f920add05c93e6bfcc/raw/c019b5950d5be8e249830123a462bae0a8b1ae07/rule_list" style="float:right">view raw</a> <a href="https://gist.github.com/sidkrishna/05ad300b6454c9f920add05c93e6bfcc#file-rule_list">rule_list</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

### Rule Definition:

splunk\_link\_flap.yaml  


<div id="gist41100987" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-splunk_link_flap-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-splunk_link_flap-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-splunk_link_flap-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-splunk_link_flap-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-splunk_link_flap-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s"><span class="pl-pds">"</span>splunk_link_flap_webhook_rule<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-splunk_link_flap-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-splunk_link_flap-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">enabled</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-splunk_link_flap-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-splunk_link_flap-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Splunk link flap webhook rule<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-splunk_link_flap-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-splunk_link_flap-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-splunk_link_flap-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-splunk_link_flap-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">trigger</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-splunk_link_flap-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-splunk_link_flap-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s"><span class="pl-pds">"</span>core.st2.webhook<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-splunk_link_flap-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-splunk_link_flap-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">parameters</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-splunk_link_flap-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-splunk_link_flap-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">url</span>: <span class="pl-s"><span class="pl-pds">"</span>splunk_link_flap<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-splunk_link_flap-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-splunk_link_flap-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-splunk_link_flap-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-splunk_link_flap-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">criteria</span>: <span class="pl-s">{}</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-splunk_link_flap-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-splunk_link_flap-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-splunk_link_flap-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-splunk_link_flap-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-splunk_link_flap-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-splunk_link_flap-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">ref</span>: <span class="pl-s">st2-demos.link_flap_remediation</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-splunk_link_flap-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-splunk_link_flap-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">parameters</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-splunk_link_flap-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-splunk_link_flap-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">host</span>: <span class="pl-s"><span class="pl-pds">"</span>{{trigger.body.result.host}}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-splunk_link_flap-yaml-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-splunk_link_flap-yaml-LC17" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">interface</span>: <span class="pl-s"><span class="pl-pds">"</span>{{trigger.body.result.interface}}<span class="pl-pds">"</span></span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/sidkrishna/05ad300b6454c9f920add05c93e6bfcc/raw/c019b5950d5be8e249830123a462bae0a8b1ae07/splunk_link_flap.yaml" style="float:right">view raw</a> <a href="https://gist.github.com/sidkrishna/05ad300b6454c9f920add05c93e6bfcc#file-splunk_link_flap-yaml">splunk_link_flap.yaml</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

### Rule Details:

<div id="gist41100987" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-rule_get" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-rule_get-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-rule_get-LC1" class="blob-code blob-code-inner js-file-line">
                  brocade@bwc-2:~$ st2 rule get st2-demos.splunk_link_flap_webhook_rule
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-rule_get-LC2" class="blob-code blob-code-inner js-file-line">
                  +-------------+------------------------------------------------------------+
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-rule_get-LC3" class="blob-code blob-code-inner js-file-line">
                  | Property | Value |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-rule_get-LC4" class="blob-code blob-code-inner js-file-line">
                  +-------------+------------------------------------------------------------+
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-rule_get-LC5" class="blob-code blob-code-inner js-file-line">
                  | id | 57f66fcb0048394cfa1d955a |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-rule_get-LC6" class="blob-code blob-code-inner js-file-line">
                  | uid | rule:st2-demos:splunk_link_flap_webhook_rule |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-rule_get-LC7" class="blob-code blob-code-inner js-file-line">
                  | ref | st2-demos.splunk_link_flap_webhook_rule |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-rule_get-LC8" class="blob-code blob-code-inner js-file-line">
                  | pack | st2-demos |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-rule_get-LC9" class="blob-code blob-code-inner js-file-line">
                  | name | splunk_link_flap_webhook_rule |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-rule_get-LC10" class="blob-code blob-code-inner js-file-line">
                  | description | Splunk link flap webhook rule |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-rule_get-LC11" class="blob-code blob-code-inner js-file-line">
                  | enabled | True |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-rule_get-LC12" class="blob-code blob-code-inner js-file-line">
                  | action | { |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-rule_get-LC13" class="blob-code blob-code-inner js-file-line">
                  | | "ref": "st2-demos.link_flap_remediation", |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-rule_get-LC14" class="blob-code blob-code-inner js-file-line">
                  | | "parameters": { |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-rule_get-LC15" class="blob-code blob-code-inner js-file-line">
                  | | "interface": "{{trigger.body.result.interface}}", |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-rule_get-LC16" class="blob-code blob-code-inner js-file-line">
                  | | "host": "{{trigger.body.result.host}}" |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-rule_get-LC17" class="blob-code blob-code-inner js-file-line">
                  | | } |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-rule_get-LC18" class="blob-code blob-code-inner js-file-line">
                  | | } |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-rule_get-LC19" class="blob-code blob-code-inner js-file-line">
                  | criteria | |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-rule_get-LC20" class="blob-code blob-code-inner js-file-line">
                  | tags | |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-rule_get-LC21" class="blob-code blob-code-inner js-file-line">
                  | trigger | { |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L22" class="blob-num js-line-number" data-line-number="22">
                </td>
                
                <td id="file-rule_get-LC22" class="blob-code blob-code-inner js-file-line">
                  | | "type": "core.st2.webhook", |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L23" class="blob-num js-line-number" data-line-number="23">
                </td>
                
                <td id="file-rule_get-LC23" class="blob-code blob-code-inner js-file-line">
                  | | "ref": "core.70b0b76b-5edf-47d8-bb03-19528c4fe1d2", |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L24" class="blob-num js-line-number" data-line-number="24">
                </td>
                
                <td id="file-rule_get-LC24" class="blob-code blob-code-inner js-file-line">
                  | | "parameters": { |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L25" class="blob-num js-line-number" data-line-number="25">
                </td>
                
                <td id="file-rule_get-LC25" class="blob-code blob-code-inner js-file-line">
                  | | "url": "splunk_link_flap" |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L26" class="blob-num js-line-number" data-line-number="26">
                </td>
                
                <td id="file-rule_get-LC26" class="blob-code blob-code-inner js-file-line">
                  | | } |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L27" class="blob-num js-line-number" data-line-number="27">
                </td>
                
                <td id="file-rule_get-LC27" class="blob-code blob-code-inner js-file-line">
                  | | } |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L28" class="blob-num js-line-number" data-line-number="28">
                </td>
                
                <td id="file-rule_get-LC28" class="blob-code blob-code-inner js-file-line">
                  | type | { |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L29" class="blob-num js-line-number" data-line-number="29">
                </td>
                
                <td id="file-rule_get-LC29" class="blob-code blob-code-inner js-file-line">
                  | | "ref": "standard", |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L30" class="blob-num js-line-number" data-line-number="30">
                </td>
                
                <td id="file-rule_get-LC30" class="blob-code blob-code-inner js-file-line">
                  | | "parameters": {} |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L31" class="blob-num js-line-number" data-line-number="31">
                </td>
                
                <td id="file-rule_get-LC31" class="blob-code blob-code-inner js-file-line">
                  | | } |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_get-L32" class="blob-num js-line-number" data-line-number="32">
                </td>
                
                <td id="file-rule_get-LC32" class="blob-code blob-code-inner js-file-line">
                  +-------------+------------------------------------------------------------+
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/sidkrishna/05ad300b6454c9f920add05c93e6bfcc/raw/c019b5950d5be8e249830123a462bae0a8b1ae07/rule_get" style="float:right">view raw</a> <a href="https://gist.github.com/sidkrishna/05ad300b6454c9f920add05c93e6bfcc#file-rule_get">rule_get</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

When the ‘link down’ syslog is detected by Splunk, and the webhook to StackStorm called, the trigger instance payload contains the values for the various Splunk fields and parameters. These include the host IP address and the interface name (as per configured field extractions) along with other standard ones such as search link, search ID, raw log message etc. See this example below:

<div id="gist41100987" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-trigger_instance_get" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-trigger_instance_get-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-trigger_instance_get-LC1" class="blob-code blob-code-inner js-file-line">
                  brocade@bwc-2:~$ st2 trigger-instance get 57fcd76500483912504332d3
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-trigger_instance_get-LC2" class="blob-code blob-code-inner js-file-line">
                  +-----------------+--------------------------------------------------------------+
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-trigger_instance_get-LC3" class="blob-code blob-code-inner js-file-line">
                  | Property | Value |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-trigger_instance_get-LC4" class="blob-code blob-code-inner js-file-line">
                  +-----------------+--------------------------------------------------------------+
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-trigger_instance_get-LC5" class="blob-code blob-code-inner js-file-line">
                  | id | 57fcd76500483912504332d3 |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-trigger_instance_get-LC6" class="blob-code blob-code-inner js-file-line">
                  | trigger | core.70b0b76b-5edf-47d8-bb03-19528c4fe1d2 |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-trigger_instance_get-LC7" class="blob-code blob-code-inner js-file-line">
                  | occurrence_time | 2016-10-11T12:13:25.078000Z |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-trigger_instance_get-LC8" class="blob-code blob-code-inner js-file-line">
                  | payload | { |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-trigger_instance_get-LC9" class="blob-code blob-code-inner js-file-line">
                  | | "body": { |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-trigger_instance_get-LC10" class="blob-code blob-code-inner js-file-line">
                  | | "results_link": "http://Splunk:8000/app/search/searc |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-trigger_instance_get-LC11" class="blob-code blob-code-inner js-file-line">
                  | | h?q=%7Cloadjob%20rt_scheduler__admin__search__testt_at_14757 |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-trigger_instance_get-LC12" class="blob-code blob-code-inner js-file-line">
                  | | 23889_25.32%20%7C%20head%201%20%7C%20tail%201&earliest=0&lat |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-trigger_instance_get-LC13" class="blob-code blob-code-inner js-file-line">
                  | | est=now", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-trigger_instance_get-LC14" class="blob-code blob-code-inner js-file-line">
                  | | "app": "search", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-trigger_instance_get-LC15" class="blob-code blob-code-inner js-file-line">
                  | | "search_name": "testt", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-trigger_instance_get-LC16" class="blob-code blob-code-inner js-file-line">
                  | | "result": { |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-trigger_instance_get-LC17" class="blob-code blob-code-inner js-file-line">
                  | | "_si": "", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-trigger_instance_get-LC18" class="blob-code blob-code-inner js-file-line">
                  | | "_confstr": |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-trigger_instance_get-LC19" class="blob-code blob-code-inner js-file-line">
                  | | "source::udp:514|host::10.254.4.118|syslog", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-trigger_instance_get-LC20" class="blob-code blob-code-inner js-file-line">
                  | | "_raw": "Oct 11 05:13:24 10.254.4.118 Oct 11 |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-trigger_instance_get-LC21" class="blob-code blob-code-inner js-file-line">
                  | | 12:13:16 LEAF2 raslogd: [log@1588 |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L22" class="blob-num js-line-number" data-line-number="22">
                </td>
                
                <td id="file-trigger_instance_get-LC22" class="blob-code blob-code-inner js-file-line">
                  | | value="RASLOG"][timestamp@1588 |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L23" class="blob-num js-line-number" data-line-number="23">
                </td>
                
                <td id="file-trigger_instance_get-LC23" class="blob-code blob-code-inner js-file-line">
                  | | value="2016-10-11T12:13:16.980022"][msgid@1588 |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L24" class="blob-num js-line-number" data-line-number="24">
                </td>
                
                <td id="file-trigger_instance_get-LC24" class="blob-code blob-code-inner js-file-line">
                  | | value="NSM-1003"][seqnum@1588 value="48201"][attr@1588 |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L25" class="blob-num js-line-number" data-line-number="25">
                </td>
                
                <td id="file-trigger_instance_get-LC25" class="blob-code blob-code-inner js-file-line">
                  | | value=" SW/0 | Active | DCE | WWN |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L26" class="blob-num js-line-number" data-line-number="26">
                </td>
                
                <td id="file-trigger_instance_get-LC26" class="blob-code blob-code-inner js-file-line">
                  | | 10:00:00:27:f8:c7:42:e9"][severity@1588 |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L27" class="blob-num js-line-number" data-line-number="27">
                </td>
                
                <td id="file-trigger_instance_get-LC27" class="blob-code blob-code-inner js-file-line">
                  | | value="INFO"][swname@1588 value="LEAF2"][arg0@1588 |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L28" class="blob-num js-line-number" data-line-number="28">
                </td>
                
                <td id="file-trigger_instance_get-LC28" class="blob-code blob-code-inner js-file-line">
                  | | value="TenGigabitEthernet 102/0/48" desc="InterfaceName"] |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L29" class="blob-num js-line-number" data-line-number="29">
                </td>
                
                <td id="file-trigger_instance_get-LC29" class="blob-code blob-code-inner js-file-line">
                  | | BOM Interface TenGigabitEthernet 102/0/48 is link down. ", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L30" class="blob-num js-line-number" data-line-number="30">
                </td>
                
                <td id="file-trigger_instance_get-LC30" class="blob-code blob-code-inner js-file-line">
                  | | "_time": "1476188004", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L31" class="blob-num js-line-number" data-line-number="31">
                </td>
                
                <td id="file-trigger_instance_get-LC31" class="blob-code blob-code-inner js-file-line">
                  | | "host": "10.254.4.118", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L32" class="blob-num js-line-number" data-line-number="32">
                </td>
                
                <td id="file-trigger_instance_get-LC32" class="blob-code blob-code-inner js-file-line">
                  | | "_sourcetype": "syslog", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L33" class="blob-num js-line-number" data-line-number="33">
                </td>
                
                <td id="file-trigger_instance_get-LC33" class="blob-code blob-code-inner js-file-line">
                  | | "syslog_text": "Interface TenGigabitEthernet |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L34" class="blob-num js-line-number" data-line-number="34">
                </td>
                
                <td id="file-trigger_instance_get-LC34" class="blob-code blob-code-inner js-file-line">
                  | | 102/0/48 is link down.", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L35" class="blob-num js-line-number" data-line-number="35">
                </td>
                
                <td id="file-trigger_instance_get-LC35" class="blob-code blob-code-inner js-file-line">
                  | | "_kv": "1", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L36" class="blob-num js-line-number" data-line-number="36">
                </td>
                
                <td id="file-trigger_instance_get-LC36" class="blob-code blob-code-inner js-file-line">
                  | | "interface": "TenGigabitEthernet 102/0/48", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L37" class="blob-num js-line-number" data-line-number="37">
                </td>
                
                <td id="file-trigger_instance_get-LC37" class="blob-code blob-code-inner js-file-line">
                  | | "_indextime": "1476188004", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L38" class="blob-num js-line-number" data-line-number="38">
                </td>
                
                <td id="file-trigger_instance_get-LC38" class="blob-code blob-code-inner js-file-line">
                  | | "_serial": "33" |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L39" class="blob-num js-line-number" data-line-number="39">
                </td>
                
                <td id="file-trigger_instance_get-LC39" class="blob-code blob-code-inner js-file-line">
                  | | }, |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L40" class="blob-num js-line-number" data-line-number="40">
                </td>
                
                <td id="file-trigger_instance_get-LC40" class="blob-code blob-code-inner js-file-line">
                  | | "sid": |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L41" class="blob-num js-line-number" data-line-number="41">
                </td>
                
                <td id="file-trigger_instance_get-LC41" class="blob-code blob-code-inner js-file-line">
                  | | "rt_scheduler__admin__search__testt_at_1475723889_25.32", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L42" class="blob-num js-line-number" data-line-number="42">
                </td>
                
                <td id="file-trigger_instance_get-LC42" class="blob-code blob-code-inner js-file-line">
                  | | "owner": "admin" |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L43" class="blob-num js-line-number" data-line-number="43">
                </td>
                
                <td id="file-trigger_instance_get-LC43" class="blob-code blob-code-inner js-file-line">
                  | | }, |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L44" class="blob-num js-line-number" data-line-number="44">
                </td>
                
                <td id="file-trigger_instance_get-LC44" class="blob-code blob-code-inner js-file-line">
                  | | "headers": { |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L45" class="blob-num js-line-number" data-line-number="45">
                </td>
                
                <td id="file-trigger_instance_get-LC45" class="blob-code blob-code-inner js-file-line">
                  | | "X-Request-Id": "10e3026f-9586-464b- |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L46" class="blob-num js-line-number" data-line-number="46">
                </td>
                
                <td id="file-trigger_instance_get-LC46" class="blob-code blob-code-inner js-file-line">
                  | | aae2-a0984fa290f1", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L47" class="blob-num js-line-number" data-line-number="47">
                </td>
                
                <td id="file-trigger_instance_get-LC47" class="blob-code blob-code-inner js-file-line">
                  | | "Accept-Encoding": "identity", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L48" class="blob-num js-line-number" data-line-number="48">
                </td>
                
                <td id="file-trigger_instance_get-LC48" class="blob-code blob-code-inner js-file-line">
                  | | "X-Forwarded-For": "10.254.3.40", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L49" class="blob-num js-line-number" data-line-number="49">
                </td>
                
                <td id="file-trigger_instance_get-LC49" class="blob-code blob-code-inner js-file-line">
                  | | "Content-Length": "1101", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L50" class="blob-num js-line-number" data-line-number="50">
                </td>
                
                <td id="file-trigger_instance_get-LC50" class="blob-code blob-code-inner js-file-line">
                  | | "User-Agent": "Splunk/D54F2F0C- |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L51" class="blob-num js-line-number" data-line-number="51">
                </td>
                
                <td id="file-trigger_instance_get-LC51" class="blob-code blob-code-inner js-file-line">
                  | | CD71-490F-9050-7A6C8E09328B", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L52" class="blob-num js-line-number" data-line-number="52">
                </td>
                
                <td id="file-trigger_instance_get-LC52" class="blob-code blob-code-inner js-file-line">
                  | | "Host": "bwc,bwc", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L53" class="blob-num js-line-number" data-line-number="53">
                </td>
                
                <td id="file-trigger_instance_get-LC53" class="blob-code blob-code-inner js-file-line">
                  | | "X-Real-Ip": "10.254.3.40", |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L54" class="blob-num js-line-number" data-line-number="54">
                </td>
                
                <td id="file-trigger_instance_get-LC54" class="blob-code blob-code-inner js-file-line">
                  | | "Content-Type": "application/json" |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L55" class="blob-num js-line-number" data-line-number="55">
                </td>
                
                <td id="file-trigger_instance_get-LC55" class="blob-code blob-code-inner js-file-line">
                  | | } |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L56" class="blob-num js-line-number" data-line-number="56">
                </td>
                
                <td id="file-trigger_instance_get-LC56" class="blob-code blob-code-inner js-file-line">
                  | | } |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L57" class="blob-num js-line-number" data-line-number="57">
                </td>
                
                <td id="file-trigger_instance_get-LC57" class="blob-code blob-code-inner js-file-line">
                  | status | processed |
                </td>
              </tr>
              
              <tr>
                <td id="file-trigger_instance_get-L58" class="blob-num js-line-number" data-line-number="58">
                </td>
                
                <td id="file-trigger_instance_get-LC58" class="blob-code blob-code-inner js-file-line">
                  +-----------------+--------------------------------------------------------------+
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/sidkrishna/05ad300b6454c9f920add05c93e6bfcc/raw/c019b5950d5be8e249830123a462bae0a8b1ae07/trigger_instance_get" style="float:right">view raw</a> <a href="https://gist.github.com/sidkrishna/05ad300b6454c9f920add05c93e6bfcc#file-trigger_instance_get">trigger_instance_get</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

These field values can now be directly accessed from the StackStorm webhook rule using `{{trigger.body.result.xxx}}` e.g. `{{trigger.body.result.host}}`.

Upon successful enforcement, the rule executes the auto-remediation workflow with execution ID as shown below:

<div id="gist41100987" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-rule_enforcement_get" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-rule_enforcement_get-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-rule_enforcement_get-LC1" class="blob-code blob-code-inner js-file-line">
                  brocade@bwc-2:~$ st2 rule-enforcement get 57fcd76500483912504332d7
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_enforcement_get-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-rule_enforcement_get-LC2" class="blob-code blob-code-inner js-file-line">
                  +---------------------+-----------------------------------------+
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_enforcement_get-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-rule_enforcement_get-LC3" class="blob-code blob-code-inner js-file-line">
                  | Property | Value |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_enforcement_get-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-rule_enforcement_get-LC4" class="blob-code blob-code-inner js-file-line">
                  +---------------------+-----------------------------------------+
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_enforcement_get-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-rule_enforcement_get-LC5" class="blob-code blob-code-inner js-file-line">
                  | id | 57fcd76500483912504332d7 |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_enforcement_get-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-rule_enforcement_get-LC6" class="blob-code blob-code-inner js-file-line">
                  | rule.ref | st2-demos.splunk_link_flap_webhook_rule |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_enforcement_get-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-rule_enforcement_get-LC7" class="blob-code blob-code-inner js-file-line">
                  | trigger_instance_id | 57fcd76500483912504332d3 |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_enforcement_get-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-rule_enforcement_get-LC8" class="blob-code blob-code-inner js-file-line">
                  | execution_id | 57fcd76500483912504332d6 |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_enforcement_get-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-rule_enforcement_get-LC9" class="blob-code blob-code-inner js-file-line">
                  | failure_reason | |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_enforcement_get-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-rule_enforcement_get-LC10" class="blob-code blob-code-inner js-file-line">
                  | enforced_at | 2016-10-11T12:13:25.126358Z |
                </td>
              </tr>
              
              <tr>
                <td id="file-rule_enforcement_get-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-rule_enforcement_get-LC11" class="blob-code blob-code-inner js-file-line">
                  +---------------------+-----------------------------------------+
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/sidkrishna/05ad300b6454c9f920add05c93e6bfcc/raw/c019b5950d5be8e249830123a462bae0a8b1ae07/rule_enforcement_get" style="float:right">view raw</a> <a href="https://gist.github.com/sidkrishna/05ad300b6454c9f920add05c93e6bfcc#file-rule_enforcement_get">rule_enforcement_get</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

In this example, the workflow for link flap remediation does the following:

  1. Notify &#8220;link down&#8221; event on Slack with the Host IP address and Interface name
  2. Pull configuration details for the given interface from the switch and post it to the Slack channel
  3. Try to bring the interface back up by executing &#8220;shut; no shut&#8221; on the switch
  4. Pull interface details `show interface detail` from the switch and post the output to Slack
  5. Create a Zendesk IT ticket for the event occurrence and attach relevant logs

<div id="gist41100987" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-execution_get" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-execution_get-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-execution_get-LC1" class="blob-code blob-code-inner js-file-line">
                  brocade@bwc-2:~$ st2 execution get 57fcd76500483912504332d6
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-execution_get-LC2" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-execution_get-LC3" class="blob-code blob-code-inner js-file-line">
                  id: 57fcd76500483912504332d6
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-execution_get-LC4" class="blob-code blob-code-inner js-file-line">
                  action.ref: st2-demos.link_flap_remediation
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-execution_get-LC5" class="blob-code blob-code-inner js-file-line">
                  parameters:
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-execution_get-LC6" class="blob-code blob-code-inner js-file-line">
                  host: 10.254.4.118
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-execution_get-LC7" class="blob-code blob-code-inner js-file-line">
                  interface: TenGigabitEthernet 102/0/48
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-execution_get-LC8" class="blob-code blob-code-inner js-file-line">
                  status: succeeded (24s elapsed)
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-execution_get-LC9" class="blob-code blob-code-inner js-file-line">
                  start_timestamp: 2016-10-11T12:13:25.152697Z
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-execution_get-LC10" class="blob-code blob-code-inner js-file-line">
                  end_timestamp: 2016-10-11T12:13:49.681257Z
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-execution_get-LC11" class="blob-code blob-code-inner js-file-line">
                  +--------------------------+------------------------+-------------------------------+------------------------+-------------------------------+
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-execution_get-LC12" class="blob-code blob-code-inner js-file-line">
                  | id | status | task | action | start_timestamp |
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-execution_get-LC13" class="blob-code blob-code-inner js-file-line">
                  +--------------------------+------------------------+-------------------------------+------------------------+-------------------------------+
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-execution_get-LC14" class="blob-code blob-code-inner js-file-line">
                  | 57fcd765004839121e5d8927 | succeeded (0s elapsed) | notify_on_slack | chatops.post_message | Tue, 11 Oct 2016 12:13:25 UTC |
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-execution_get-LC15" class="blob-code blob-code-inner js-file-line">
                  | 57fcd766004839121e5d8929 | succeeded (5s elapsed) | show_run_interface | clicrud.ops_command | Tue, 11 Oct 2016 12:13:26 UTC |
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-execution_get-LC16" class="blob-code blob-code-inner js-file-line">
                  | 57fcd76b004839121e5d892c | succeeded (1s elapsed) | send_show_run_interface_to_sl | chatops.post_message | Tue, 11 Oct 2016 12:13:31 UTC |
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-execution_get-LC17" class="blob-code blob-code-inner js-file-line">
                  | | | ack | | |
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-execution_get-LC18" class="blob-code blob-code-inner js-file-line">
                  | 57fcd76c004839121e5d892e | succeeded (1s elapsed) | bring_up_msg_to_slack | chatops.post_message | Tue, 11 Oct 2016 12:13:32 UTC |
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-execution_get-LC19" class="blob-code blob-code-inner js-file-line">
                  | 57fcd76e004839121e5d8931 | succeeded (6s elapsed) | bring_up_link | clicrud.config_command | Tue, 11 Oct 2016 12:13:34 UTC |
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-execution_get-LC20" class="blob-code blob-code-inner js-file-line">
                  | 57fcd775004839121e5d8933 | succeeded (4s elapsed) | show_interface_detail | clicrud.ops_command | Tue, 11 Oct 2016 12:13:41 UTC |
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-execution_get-LC21" class="blob-code blob-code-inner js-file-line">
                  | 57fcd779004839121e5d8936 | succeeded (0s elapsed) | send_interface_details_to_sla | chatops.post_message | Tue, 11 Oct 2016 12:13:45 UTC |
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L22" class="blob-num js-line-number" data-line-number="22">
                </td>
                
                <td id="file-execution_get-LC22" class="blob-code blob-code-inner js-file-line">
                  | | | ck | | |
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L23" class="blob-num js-line-number" data-line-number="23">
                </td>
                
                <td id="file-execution_get-LC23" class="blob-code blob-code-inner js-file-line">
                  | 57fcd77a004839121e5d8938 | succeeded (3s elapsed) | create_zendesk_tkt | zendesk.create_ticket | Tue, 11 Oct 2016 12:13:46 UTC |
                </td>
              </tr>
              
              <tr>
                <td id="file-execution_get-L24" class="blob-num js-line-number" data-line-number="24">
                </td>
                
                <td id="file-execution_get-LC24" class="blob-code blob-code-inner js-file-line">
                  +--------------------------+------------------------+-------------------------------+------------------------+-------------------------------+
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/sidkrishna/05ad300b6454c9f920add05c93e6bfcc/raw/c019b5950d5be8e249830123a462bae0a8b1ae07/execution_get" style="float:right">view raw</a> <a href="https://gist.github.com/sidkrishna/05ad300b6454c9f920add05c93e6bfcc#file-execution_get">execution_get</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

## Slack Channel

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2016/10/slackchannel.png" width="1134" height="955" alt="" class="alignnone size-medium" /> 

All code examples used here are available in the [StackStorm st2_demos repo on GitHub][7].

This is just one example of a syslog-driven auto-remediation workflow. Workflows can be custom-built with actions and integrations for your environment. Use Jira instead of Zendesk? No problem! Quickly modify the workflow to use Jira instead! Use Hipchat? No problem, modify your `st2chatops2` setup to use that! Easy.

What are you doing with event-driven remediation with StackStorm? Jump into our [community][8] and let us know!

 [1]: https://www.splunk.com
 [2]: http://docs.splunk.com/Documentation/Splunk/6.1.7/Overview/Searchingandreporting
 [3]: https://splunkbase.splunk.com/app/1909/
 [4]: http://docs.splunk.com/Documentation/Splunk/6.5.0/Data/Configureyourinputs
 [5]: http://docs.splunk.com/Documentation/Splunk/6.4.3/Knowledge/ExtractfieldsinteractivelywithIFX
 [6]: https://bwc-docs.brocade.com/webhooks.html#registering-a-custom-webhook
 [7]: https://github.com/StackStorm/st2_demos
 [8]: https://stackstorm.com/community-signup