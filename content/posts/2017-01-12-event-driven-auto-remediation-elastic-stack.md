---
title: Event Driven Auto-Remediation with the Elastic Stack
author: st2admin
type: post
date: 2017-01-13T02:30:10+00:00
url: /2017/01/12/event-driven-auto-remediation-elastic-stack/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5458612139
categories:
  - Blog
  - Tutorials
tags:
  - Auto-remediation
  - Elastic Stack
  - networking
  - syslog
  - tutorials
  - workflows

---
**Jan 12, 2017**  
_by Siddharth Krishna_

Recently we explained how to use [**Syslog with Splunk & StackStorm**][1] to auto-remediate a link going down on a switch. Splunk is a widely used log management tool but there’s also a popular open source alternative &#8211; [**Elastic Stack**][2] (formerly the ELK Stack: Elasticsearch, Logstash and Kibana). So if you’re using the Elastic Stack, and are looking to automate event remediation in your environment, you&#8217;re at the right place! In this post, we’re taking the same [use case as before][1] and talking about how to set up the Elastic stack to collect syslog data and trigger event-based network remediation workflows using **StackStorm**.

<!--more-->

### Any changes to StackStorm?

No. Everything in relation with StackStorm (webhooks, workflows, actions and integrations) remains the same as documented in the earlier blog. Optionally, you could create a new webhook URL (eg. elk\_link\_flap) specifically for your Elastic Stack setup. Here, our primary focus will be on configuring the Elastic Stack for an end-to-end demonstration of the auto-remediation use case.

<div id="gist43700226" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-stackstorm_elk_webhook" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-stackstorm_elk_webhook-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-stackstorm_elk_webhook-LC1" class="blob-code blob-code-inner js-file-line">
                  name: "elk_link_flap_webhook_rule"
                </td>
              </tr>
              
              <tr>
                <td id="file-stackstorm_elk_webhook-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-stackstorm_elk_webhook-LC2" class="blob-code blob-code-inner js-file-line">
                  enabled: true
                </td>
              </tr>
              
              <tr>
                <td id="file-stackstorm_elk_webhook-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-stackstorm_elk_webhook-LC3" class="blob-code blob-code-inner js-file-line">
                  description: "ELK link flap webhook rule"
                </td>
              </tr>
              
              <tr>
                <td id="file-stackstorm_elk_webhook-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-stackstorm_elk_webhook-LC4" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-stackstorm_elk_webhook-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-stackstorm_elk_webhook-LC5" class="blob-code blob-code-inner js-file-line">
                  trigger:
                </td>
              </tr>
              
              <tr>
                <td id="file-stackstorm_elk_webhook-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-stackstorm_elk_webhook-LC6" class="blob-code blob-code-inner js-file-line">
                  type: "core.st2.webhook"
                </td>
              </tr>
              
              <tr>
                <td id="file-stackstorm_elk_webhook-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-stackstorm_elk_webhook-LC7" class="blob-code blob-code-inner js-file-line">
                  parameters:
                </td>
              </tr>
              
              <tr>
                <td id="file-stackstorm_elk_webhook-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-stackstorm_elk_webhook-LC8" class="blob-code blob-code-inner js-file-line">
                  url: "elk_link_flap"
                </td>
              </tr>
              
              <tr>
                <td id="file-stackstorm_elk_webhook-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-stackstorm_elk_webhook-LC9" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-stackstorm_elk_webhook-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-stackstorm_elk_webhook-LC10" class="blob-code blob-code-inner js-file-line">
                  criteria: {}
                </td>
              </tr>
              
              <tr>
                <td id="file-stackstorm_elk_webhook-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-stackstorm_elk_webhook-LC11" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-stackstorm_elk_webhook-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-stackstorm_elk_webhook-LC12" class="blob-code blob-code-inner js-file-line">
                  action:
                </td>
              </tr>
              
              <tr>
                <td id="file-stackstorm_elk_webhook-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-stackstorm_elk_webhook-LC13" class="blob-code blob-code-inner js-file-line">
                  ref: st2_demos.link_flap_remed_workflow
                </td>
              </tr>
              
              <tr>
                <td id="file-stackstorm_elk_webhook-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-stackstorm_elk_webhook-LC14" class="blob-code blob-code-inner js-file-line">
                  parameters:
                </td>
              </tr>
              
              <tr>
                <td id="file-stackstorm_elk_webhook-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-stackstorm_elk_webhook-LC15" class="blob-code blob-code-inner js-file-line">
                  host: "{{trigger.body.host}}"
                </td>
              </tr>
              
              <tr>
                <td id="file-stackstorm_elk_webhook-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-stackstorm_elk_webhook-LC16" class="blob-code blob-code-inner js-file-line">
                  interface: "{{trigger.body.interface}}"
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/sidkrishna/d7f117bb95f2aa34ec51aa52158a5dbf/raw/34f848645d149c946475088abb4a55c2bc9abe46/stackstorm_elk_webhook" style="float:right">view raw</a> <a href="https://gist.github.com/sidkrishna/d7f117bb95f2aa34ec51aa52158a5dbf#file-stackstorm_elk_webhook">stackstorm_elk_webhook</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

### Set Up Logstash

First step is to define data source for syslog as input and Elasticsearch as the output in the **Logstash** configuration. UDP port 514 is used for syslog. The Logstash configuration file is located at `/etc/logstash/conf.d/`. Create a new config file eg. `lsconfig.conf` if one does not already exist and ensure that there’s only one config file at this location for Logstash to use. Add the following content:

<div id="gist43700226" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-logstash_input_ouput" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-logstash_input_ouput-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-logstash_input_ouput-LC1" class="blob-code blob-code-inner js-file-line">
                  input {
                </td>
              </tr>
              
              <tr>
                <td id="file-logstash_input_ouput-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-logstash_input_ouput-LC2" class="blob-code blob-code-inner js-file-line">
                  udp {
                </td>
              </tr>
              
              <tr>
                <td id="file-logstash_input_ouput-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-logstash_input_ouput-LC3" class="blob-code blob-code-inner js-file-line">
                  port => 514
                </td>
              </tr>
              
              <tr>
                <td id="file-logstash_input_ouput-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-logstash_input_ouput-LC4" class="blob-code blob-code-inner js-file-line">
                  type => syslog
                </td>
              </tr>
              
              <tr>
                <td id="file-logstash_input_ouput-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-logstash_input_ouput-LC5" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-logstash_input_ouput-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-logstash_input_ouput-LC6" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-logstash_input_ouput-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-logstash_input_ouput-LC7" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-logstash_input_ouput-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-logstash_input_ouput-LC8" class="blob-code blob-code-inner js-file-line">
                  output {
                </td>
              </tr>
              
              <tr>
                <td id="file-logstash_input_ouput-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-logstash_input_ouput-LC9" class="blob-code blob-code-inner js-file-line">
                  elasticsearch { hosts => ["127.0.0.1:9200"] }
                </td>
              </tr>
              
              <tr>
                <td id="file-logstash_input_ouput-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-logstash_input_ouput-LC10" class="blob-code blob-code-inner js-file-line">
                  stdout { }
                </td>
              </tr>
              
              <tr>
                <td id="file-logstash_input_ouput-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-logstash_input_ouput-LC11" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/sidkrishna/d7f117bb95f2aa34ec51aa52158a5dbf/raw/34f848645d149c946475088abb4a55c2bc9abe46/logstash_input_ouput" style="float:right">view raw</a> <a href="https://gist.github.com/sidkrishna/d7f117bb95f2aa34ec51aa52158a5dbf#file-logstash_input_ouput">logstash_input_ouput</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

Restart the Logstash service:  
`sudo service logstash start`

### Verify Syslog on Kibana

On **Kibana**, define a new Index Pattern `logstash-*` and select it in the Discover dashboard. Assuming that your network devices are pointing to the Elastic Stack server for syslog, you should now start seeing the syslog messages from the devices on Kibana dashboard.

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/01/kabanadashbaord.png" width="1899" height="581" class="alignnone size-medium" /> 

### Add Field Extractions

To be able to pass relevant information such as the switch interface name (for the link which went down) and IP address to the StackStorm Auto-Remediation workflow, the info has to be first extracted from the log message body. We use [Logstash Filters][3] & [Kibana Fields][4] to do this. Add the following filter to the Logstash config and restart all Elastic Stack services.

<div id="gist43700226" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-logstash_filter" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-logstash_filter-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-logstash_filter-LC1" class="blob-code blob-code-inner js-file-line">
                  filter {
                </td>
              </tr>
              
              <tr>
                <td id="file-logstash_filter-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-logstash_filter-LC2" class="blob-code blob-code-inner js-file-line">
                  if [type] == "syslog" {
                </td>
              </tr>
              
              <tr>
                <td id="file-logstash_filter-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-logstash_filter-LC3" class="blob-code blob-code-inner js-file-line">
                  grok {
                </td>
              </tr>
              
              <tr>
                <td id="file-logstash_filter-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-logstash_filter-LC4" class="blob-code blob-code-inner js-file-line">
                  match => { "message" => "Interface %{GREEDYDATA:interfacename} is link down" }
                </td>
              </tr>
              
              <tr>
                <td id="file-logstash_filter-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-logstash_filter-LC5" class="blob-code blob-code-inner js-file-line">
                  add_field => [ "received_at", "%{@timestamp}"]
                </td>
              </tr>
              
              <tr>
                <td id="file-logstash_filter-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-logstash_filter-LC6" class="blob-code blob-code-inner js-file-line">
                  add_field => [ "received_from", "%{host}" ]
                </td>
              </tr>
              
              <tr>
                <td id="file-logstash_filter-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-logstash_filter-LC7" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-logstash_filter-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-logstash_filter-LC8" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-logstash_filter-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-logstash_filter-LC9" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/sidkrishna/d7f117bb95f2aa34ec51aa52158a5dbf/raw/34f848645d149c946475088abb4a55c2bc9abe46/logstash_filter" style="float:right">view raw</a> <a href="https://gist.github.com/sidkrishna/d7f117bb95f2aa34ec51aa52158a5dbf#file-logstash_filter">logstash_filter</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

Once this is done, fields `interfacename` and `host` will start getting auto-populated for each syslog message. Yes, `interfacename` extraction will work only for “link down” syslog messages but that’s good enough for our demonstration. Of course, you can use more specific grok text pattern matching for better filtering.

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/01/fieldextractions.png" width="1563" height="498" class="alignnone size-medium" /> 

### Sense App for Kibana

The **Sense** App is nice for interacting with the REST API of Elasticsearch. We use it to create a _watch_ to trigger our workflow. It is a convenient way to quickly test out elastic search configurations via the REST interface. Follow the official documentation [here][5] to install Sense.

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/01/sense.png" width="1056" height="396" class="alignnone size-medium" /> 

### Install Watcher, Create a Watch

We use Elasticsearch Watcher Plugin for the alerting functionality required for triggering the StackStorm workflow. After [installing the plugin][6], use Sense to create a watch: an alert which calls a webhook into StackStorm whenever the “link down” syslog message is received from a switch (determined by a match criteria and a condition).

> Watcher helps identify changes in your data that are interesting to you by using the Elasticsearch query language. It provides multiple alerting options with built-in integrations and comes with a powerful webhook output for integration with your existing monitoring infrastructure or any third-party system. 

Watch definition:

<div id="gist43700226" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-watcher_watch" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-watcher_watch-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-watcher_watch-LC1" class="blob-code blob-code-inner js-file-line">
                  PUT _watcher/watch/my_demo_watch
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-watcher_watch-LC2" class="blob-code blob-code-inner js-file-line">
                  {
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-watcher_watch-LC3" class="blob-code blob-code-inner js-file-line">
                  "trigger" : {
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-watcher_watch-LC4" class="blob-code blob-code-inner js-file-line">
                  "schedule" : { "interval" : "5s" }
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-watcher_watch-LC5" class="blob-code blob-code-inner js-file-line">
                  },
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-watcher_watch-LC6" class="blob-code blob-code-inner js-file-line">
                  "input" : {
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-watcher_watch-LC7" class="blob-code blob-code-inner js-file-line">
                  "search": {
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-watcher_watch-LC8" class="blob-code blob-code-inner js-file-line">
                  "request": {
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-watcher_watch-LC9" class="blob-code blob-code-inner js-file-line">
                  "indices": "logstash-*",
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-watcher_watch-LC10" class="blob-code blob-code-inner js-file-line">
                  "body": {
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-watcher_watch-LC11" class="blob-code blob-code-inner js-file-line">
                  "query": {
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-watcher_watch-LC12" class="blob-code blob-code-inner js-file-line">
                  "bool": {
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-watcher_watch-LC13" class="blob-code blob-code-inner js-file-line">
                  "must": {
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-watcher_watch-LC14" class="blob-code blob-code-inner js-file-line">
                  "match_phrase": {
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-watcher_watch-LC15" class="blob-code blob-code-inner js-file-line">
                  "message": "is link down"
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-watcher_watch-LC16" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-watcher_watch-LC17" class="blob-code blob-code-inner js-file-line">
                  },
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-watcher_watch-LC18" class="blob-code blob-code-inner js-file-line">
                  "filter" : {
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-watcher_watch-LC19" class="blob-code blob-code-inner js-file-line">
                  "range": {
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-watcher_watch-LC20" class="blob-code blob-code-inner js-file-line">
                  "@timestamp": {
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-watcher_watch-LC21" class="blob-code blob-code-inner js-file-line">
                  "from": "now-8s",
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L22" class="blob-num js-line-number" data-line-number="22">
                </td>
                
                <td id="file-watcher_watch-LC22" class="blob-code blob-code-inner js-file-line">
                  "to": "now"
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L23" class="blob-num js-line-number" data-line-number="23">
                </td>
                
                <td id="file-watcher_watch-LC23" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L24" class="blob-num js-line-number" data-line-number="24">
                </td>
                
                <td id="file-watcher_watch-LC24" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L25" class="blob-num js-line-number" data-line-number="25">
                </td>
                
                <td id="file-watcher_watch-LC25" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L26" class="blob-num js-line-number" data-line-number="26">
                </td>
                
                <td id="file-watcher_watch-LC26" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L27" class="blob-num js-line-number" data-line-number="27">
                </td>
                
                <td id="file-watcher_watch-LC27" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L28" class="blob-num js-line-number" data-line-number="28">
                </td>
                
                <td id="file-watcher_watch-LC28" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L29" class="blob-num js-line-number" data-line-number="29">
                </td>
                
                <td id="file-watcher_watch-LC29" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L30" class="blob-num js-line-number" data-line-number="30">
                </td>
                
                <td id="file-watcher_watch-LC30" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L31" class="blob-num js-line-number" data-line-number="31">
                </td>
                
                <td id="file-watcher_watch-LC31" class="blob-code blob-code-inner js-file-line">
                  },
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L32" class="blob-num js-line-number" data-line-number="32">
                </td>
                
                <td id="file-watcher_watch-LC32" class="blob-code blob-code-inner js-file-line">
                  "condition" : {
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L33" class="blob-num js-line-number" data-line-number="33">
                </td>
                
                <td id="file-watcher_watch-LC33" class="blob-code blob-code-inner js-file-line">
                  "compare" : { "ctx.payload.hits.total" : { "gt" : 0 }}
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L34" class="blob-num js-line-number" data-line-number="34">
                </td>
                
                <td id="file-watcher_watch-LC34" class="blob-code blob-code-inner js-file-line">
                  },
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L35" class="blob-num js-line-number" data-line-number="35">
                </td>
                
                <td id="file-watcher_watch-LC35" class="blob-code blob-code-inner js-file-line">
                  "actions" : {
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L36" class="blob-num js-line-number" data-line-number="36">
                </td>
                
                <td id="file-watcher_watch-LC36" class="blob-code blob-code-inner js-file-line">
                  "my_webhook" : {
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L37" class="blob-num js-line-number" data-line-number="37">
                </td>
                
                <td id="file-watcher_watch-LC37" class="blob-code blob-code-inner js-file-line">
                  "webhook" : {
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L38" class="blob-num js-line-number" data-line-number="38">
                </td>
                
                <td id="file-watcher_watch-LC38" class="blob-code blob-code-inner js-file-line">
                  "scheme" : "https",
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L39" class="blob-num js-line-number" data-line-number="39">
                </td>
                
                <td id="file-watcher_watch-LC39" class="blob-code blob-code-inner js-file-line">
                  "port" : 443,
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L40" class="blob-num js-line-number" data-line-number="40">
                </td>
                
                <td id="file-watcher_watch-LC40" class="blob-code blob-code-inner js-file-line">
                  "method" : "POST",
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L41" class="blob-num js-line-number" data-line-number="41">
                </td>
                
                <td id="file-watcher_watch-LC41" class="blob-code blob-code-inner js-file-line">
                  "host" : "bwc",
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L42" class="blob-num js-line-number" data-line-number="42">
                </td>
                
                <td id="file-watcher_watch-LC42" class="blob-code blob-code-inner js-file-line">
                  "path" : "/api/v1/webhooks/elk_link_flap?st2-api-key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L43" class="blob-num js-line-number" data-line-number="43">
                </td>
                
                <td id="file-watcher_watch-LC43" class="blob-code blob-code-inner js-file-line">
                  "headers": {
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L44" class="blob-num js-line-number" data-line-number="44">
                </td>
                
                <td id="file-watcher_watch-LC44" class="blob-code blob-code-inner js-file-line">
                  "Content-Type": "application/json"
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L45" class="blob-num js-line-number" data-line-number="45">
                </td>
                
                <td id="file-watcher_watch-LC45" class="blob-code blob-code-inner js-file-line">
                  },
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L46" class="blob-num js-line-number" data-line-number="46">
                </td>
                
                <td id="file-watcher_watch-LC46" class="blob-code blob-code-inner js-file-line">
                  "body" : "{\"host\": \"{{ctx.payload.hits.hits.0._source.host}}\", \"interface\": \"{{ctx.payload.hits.hits.0._source.interfacename}}\"}"
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L47" class="blob-num js-line-number" data-line-number="47">
                </td>
                
                <td id="file-watcher_watch-LC47" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L48" class="blob-num js-line-number" data-line-number="48">
                </td>
                
                <td id="file-watcher_watch-LC48" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L49" class="blob-num js-line-number" data-line-number="49">
                </td>
                
                <td id="file-watcher_watch-LC49" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-watcher_watch-L50" class="blob-num js-line-number" data-line-number="50">
                </td>
                
                <td id="file-watcher_watch-LC50" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/sidkrishna/d7f117bb95f2aa34ec51aa52158a5dbf/raw/34f848645d149c946475088abb4a55c2bc9abe46/watcher_watch" style="float:right">view raw</a> <a href="https://gist.github.com/sidkrishna/d7f117bb95f2aa34ec51aa52158a5dbf#file-watcher_watch">watcher_watch</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

The watch has the following characteristics:

  * **Schedule**: Runs every 5 seconds.
  * **Match Criteria**: Messages in index `logstash-*` containing string &#8220;is link down&#8221; received in the last 8 seconds.
  * **Condition**: If the filtered message count at watch run time is greater than 0.
  * **Actions**: Call a webhook into StackStorm passing parameter values for `host` (switch IP address) and `interfacename` (identity of the interface that went down).

### Putting it together

We are now ready with the configurations and its time to verify our automation. Trigger the event (in this case, link down), confirm that the syslog for the event shows up on the Kibana dashboard and finally validate the execution of the StackStorm workflow to see the programmed auto-remediation in action. That’s it. You now have syslog driven auto-remediation working in your environment with the Elastic Stack!

 [1]: https://stackstorm.com/2016/10/21/auto-remediation-stackstorm-splunk/
 [2]: https://www.elastic.co/webinars/introduction-elk-stack
 [3]: https://www.elastic.co/guide/en/logstash/current/plugins-filters-grok.html
 [4]: https://www.elastic.co/guide/en/kibana/current/managing-fields.html
 [5]: https://www.elastic.co/guide/en/sense/current/installing.html
 [6]: https://www.elastic.co/guide/en/watcher/current/installing-watcher.html#package-installation