---
title: StackStorm Centralized Logging with Graylog
author: st2admin
type: post
date: 2017-08-22T23:45:41+00:00
url: /2017/08/22/stackstorm-centralized-logging-graylog/
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
dsq_thread_id:
  - 6087763794
categories:
  - Blog
  - Community
  - Tutorials
tags:
  - Community
  - integrations
  - tutorial

---
**August 22, 2017**  
_By Nick Maludy of [Encore Technologies][1]_

Want to implement centralized logging for your StackStorm deployment? Read on to find out how to send your StackStorm logs to Graylog, and produce pretty dashboards like this:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/08/dashboard.png" alt="" width="975" height="481" class="aligncenter size-full wp-image-6989" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/08/dashboard.png 975w, https://stackstorm.com/wp/wp-content/uploads/2017/08/dashboard-150x74.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/08/dashboard-300x148.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/08/dashboard-768x379.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/08/dashboard-80x39.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/08/dashboard-220x109.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/08/dashboard-203x100.png 203w, https://stackstorm.com/wp/wp-content/uploads/2017/08/dashboard-280x138.png 280w, https://stackstorm.com/wp/wp-content/uploads/2017/08/dashboard-482x238.png 482w, https://stackstorm.com/wp/wp-content/uploads/2017/08/dashboard-750x370.png 750w" sizes="(max-width: 975px) 100vw, 975px" />][2]

<!--more-->

## Background: Centralised Logging and StackStorm

One of the pillars of modern application deployments is aggregating its logs in a centralized logging application such as ELK stack, Splunk or Graylog. Centralized logging allows engineers to format, index and query logs from across their stack and distributed applications and be able to access them in a single pane of glass. StackStorm is a distributed application with multiple services that can benefit greatly from centralized logging aggregation. In this blog post, we&#8217;ll investigate how to configure StackStorm to output structured logs, setup and configure Fluentd to ship these logs, and finally configure Graylog to receive, index and query the logs.

## Structured Logging

Structured logging is a fancy term for writing log output from an application in JSON format. When logs are output in JSON this gives context for all of the information contained in each log message. This context allows log shippers to save precious CPU cycles by not having to parse out this information from plain text logs. It also allows centralized logging applications to effectively index the logs and provide it with multiple fields with which to query.

To demonstrate the difference between plain text logs and structured logs we&#8217;ll take an example from `st2api`. Below is an example of a standard log message that is written to `/var/log/st2/st2api.log`:

<pre><code class="shell">2017-08-19 11:16:38,767 83927760 INFO mixins [-] Connected to amqp://guest:**@127.0.0.1:5672//
</code></pre>

As you can see this has some information such as the timestamp, log level, and several other fields. If we were to try to utilize this in some meaningful way a parser would need to be written to extract the data fields. If the log message was instead written in a standard format (JSON) we could easily parse it and quickly make meaningful use of the fields within the message. Below is the structured logging message that corresponds to the plain text log from above.

<pre><code class="json">{"version": "1.1", "level": 6, "timestamp": 1503174203, "_python": {"name": "kombu.mixins", "process": 76071, "module": "mixins", "funcName": "Consumer", "processName": "MainProcess", "lineno": 231, "filename": "mixins.py"}, "host": "stackstorm.domain.tld", "full_message": "Connected to amqp://guest:**@127.0.0.1:5672//", "short_message": "Connected to %s"}
</code></pre>

This is great, but kind of hard to read. Below is the same log message formatted in a way that&#8217;s easier to read.

<pre><code class="json">{
  "version": "1.1",
  "level": 6,
  "timestamp": 1503174203,
  "_python": {
    "name": "kombu.mixins",
    "process": 76071,
    "module": "mixins",
    "funcName": "Consumer",
    "processName": "MainProcess",
    "lineno": 231,
    "filename": "mixins.py"
  },
  "host": "stackstorm.domain.tld",
  "full_message": "Connected to amqp://guest:**@127.0.0.1:5672//",
  "short_message": "Connected to %s"
}
</code></pre>

This output is in GELF (Graylog Extended Logging Format) JSON format. GELF log messages are nothing more than JSON with a few standard fields in the payload. The GELF payload specification can be found [here][3]. GELF also defines two wire protocol formats, GELF UDP and GELF TCP that detail how GELF JSON log messages can be sent to Graylog.

## Log Shippers

A log shipper is an application that reads in log messages from some source, usually a log file, potentially transforms the message and then transmits it to some destination, usually a log aggregation or centralized logging application. There are several commonly used log shippers out there including [Fluentd][4], [Logstash][5], and [Filebeat][6].

In this article we&#8217;re going to be using Fluentd because it was the easiest one to configure for parsing GELF JSON and shipping to Graylog.

## Architecture

The setup detailed in this blog post will adhere to the following architecture:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/08/pipeline.png" alt="" width="403" height="647" class="aligncenter size-full wp-image-6990" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/08/pipeline.png 403w, https://stackstorm.com/wp/wp-content/uploads/2017/08/pipeline-93x150.png 93w, https://stackstorm.com/wp/wp-content/uploads/2017/08/pipeline-187x300.png 187w, https://stackstorm.com/wp/wp-content/uploads/2017/08/pipeline-50x80.png 50w, https://stackstorm.com/wp/wp-content/uploads/2017/08/pipeline-137x220.png 137w, https://stackstorm.com/wp/wp-content/uploads/2017/08/pipeline-62x100.png 62w, https://stackstorm.com/wp/wp-content/uploads/2017/08/pipeline-148x238.png 148w, https://stackstorm.com/wp/wp-content/uploads/2017/08/pipeline-258x415.png 258w, https://stackstorm.com/wp/wp-content/uploads/2017/08/pipeline-303x487.png 303w, https://stackstorm.com/wp/wp-content/uploads/2017/08/pipeline-371x595.png 371w" sizes="(max-width: 403px) 100vw, 403px" />][7]

First, StackStorm uses the Python `logging` module to write logs to `/var/log/st2/*.log` in GELF JSON format. The log shipper Fluentd monitors those log files for changes, reads in any new messages, converts them into GELF UDP format and sends that to Graylog. Finally, Graylog receives GELF UDP and indexes the log messages.

## Configuring StackStorm Logging

StackStorm uses Python&#8217;s builtin `logging` module for application level logging. In this module there are two key concepts: `formatters` and `handlers`.

A `formatter` takes a log function call in python code and translates that into a string of text.

_Python Logging Call_

<pre><code class="python">server = stackstorm.domain.tld
LOG.debug("Connecting to server %s".format(server))
</code></pre>

_Log String_

<pre><code class="text">2017-08-19 11:16:38,767 DEBUG [-] Connecting to server stackstorm.domain.tld
</code></pre>

`handlers` take the log message strings and writes it to some destination. The builtin `handlers` can write to a file, syslog, UDP, TCP and more.

StackStorm logging configuration files are written in the `logging` module&#8217;s [configuration file format][8]. To configure StackStorm to write structured logs we&#8217;ll be editing the logging config file stored in `/etc/st2/logging.<component>.conf`. StackStorm ships with a formatter `st2common.logging.formatters.GelfLogFormatter` that emits structured logs in GELF format. Luckily StackStorm AUDIT logs utilize the `GelfLogFormatter` so there is a reference already defined that we can reuse. All we need to do is add another `handler` to each config that writes the GELF logs to a new file. We can define a new log handler by adding the following to every logging config:

<pre><code class="ini">&lt;br /># For all components except actionrunner
[handler_gelfHandler]
class=handlers.RotatingFileHandler
level=DEBUG
formatter=gelfFormatter
args=("/var/log/st2/st2&lt;component&gt;.gelf.log",)

# For actionrunner only (needs a different handler classs)
[handler_gelfHandler]
class=st2common.log.FormatNamedFileHandler
level=INFO
formatter=gelfFormatter
args=("/var/log/st2/st2actionrunner.{pid}.gelf.log",)

</code></pre>

Now that we have a new handler defined we need to tell the logger about it. To accomplish this we&#8217;ll need to add `gelfHandler` to the following sections:

<pre><code class="ini">[handlers]
# add ', gelfHandler' the end of the following line
keys=consoleHandler, fileHandler, auditHandler, gelfHandler

[logger_root]
level=INFO
# add ', gelfHandler' the end of the following line
handlers=consoleHandler, fileHandler, auditHandler, gelfHandler
</code></pre>

StackStorm should now be configured to write structured logs to `/var/log/st2/st2<component>.gelf.log`. In order for these changes to be realized we need to restart the StackStorm services. This can be accomplished by either restarting all StackStorm processes:

<pre><code class="shell">st2ctl restart
</code></pre>

Or we can restart just the components we&#8217;ve modified

<pre><code class="shell">systemctl restart st2&lt;component&gt;
</code></pre>

This is a good time to check `/var/log/st2/st2<component>.gelf.log` and make sure logs are present.

Astute readers may be asking &#8220;if the builtin logging facility provides a UDP handler, why not use it to send logs directly to Graylog?&#8221;. The answer is fairly simple, the `DatagramHandler` which writes log strings to UDP does NOT format the messages in GELF UDP format. GELF UDP requires a special header at the beginning of every packet. To accommodate this we&#8217;ll be using Fluentd in the next section to send the log message in GELF UDP format to Graylog.

## Configuring the Log Shipper Fluentd

We&#8217;re going to use Fluentd to read from `/var/log/st2/st2<component>.gelf.log` and transform the log messages into GELF UDP format, then send those UDP packets to Graylog.

First we need to install Fluentd v0.14.

> **Note** Fluentd v0.14 is required if you would like sub-second resolution on your logging timestamps. In Fluentd v0.12 timestamps are rounded to 1-second resolution. This causes the messages in graylog to potentially be viewed out-of-order because Graylog doesn&#8217;t know which message came first within a 1-second interval. 

Below are instructions for installation on RHEL 7, for all other platforms please follow the official documentation [here][9].

> **Note** Fluentd is the name of the log shipping application and it is written by a company called Treasure Data (td). The agent installed on your machine is called `td-agent` and it wraps Fluentd in a service file that&#8217;s specific to your platform. 

<pre><code class="shell"># add GPG key
rpm --import https://packages.treasuredata.com/GPG-KEY-td-agent

# add treasure data repository to yum
cat &gt;/etc/yum.repos.d/td.repo &lt;&lt;'EOF'
[treasuredata]
name=TreasureData
baseurl=http://packages.treasuredata.com/3/redhat/\$releasever/\$basearch
gpgcheck=1
gpgkey=https://packages.treasuredata.com/GPG-KEY-td-agent
EOF

# update your sources
yum check-update

# install the toolbelt
yum install -y td-agent

# start service
systemctl start td-agent
systemctl enable td-agent
</code></pre>

After installation we need to install a Fluentd plugin that implements GELF UDP output formatting.

<pre><code class="shell">/usr/sbin/td-agent-gem install fluent-plugin-gelf-hs
</code></pre>

Next we need to configure Fluentd to tail the new StackStorm log files we configured in the previous section. The default location for the Fluentd config file is `/etc/td-agent/td-agent.conf`:

<pre><code class="shell">export GRAYLOG_SERVER=graylog.domain.tld
export GRAYLOG_GELF_UDP_PORT=12202
cat &gt;&gt; /etc/td-agent/td-agent.conf &lt;&lt; EOF
&lt;source&gt;
  type tail
  format json
  path /var/log/st2/st2actionrunner*.gelf.log
  tag st2actionrunner
  pos_file /var/run/td-agent/st2actionrunner.gelf.log.pos
  enable_watch_timer false
  estimate_current_event true
&lt;/source&gt;

&lt;source&gt;
  type tail
  format json
  path /var/log/st2/st2api.gelf.log
  tag st2api
  pos_file /var/run/td-agent/st2api.gelf.log.pos
  enable_watch_timer false
  estimate_current_event true
&lt;/source&gt;

&lt;source&gt;
  type tail
  format json
  path /var/log/st2/st2auth.gelf.log
  tag st2auth
  pos_file /var/run/td-agent/st2auth.gelf.log.pos
  enable_watch_timer false
  estimate_current_event true
&lt;/source&gt;

&lt;source&gt;
  type tail
  format json
  path /var/log/st2/st2garbagecollector.gelf.log
  tag st2garbagecollector
  pos_file /var/run/td-agent/st2garbagecollector.gelf.log.pos
  enable_watch_timer false
  estimate_current_event true
&lt;/source&gt;

&lt;source&gt;
  type tail
  format json
  path /var/log/st2/st2notifier.gelf.log
  tag st2notifier
  pos_file /var/run/td-agent/st2notifier.gelf.log.pos
  enable_watch_timer false
  estimate_current_event true
&lt;/source&gt;

&lt;source&gt;
  type tail
  format json
  path /var/log/st2/st2resultstracker.gelf.log
  tag st2resultstracker
  pos_file /var/run/td-agent/st2resultstracker.gelf.log.pos
  enable_watch_timer false
  estimate_current_event true
&lt;/source&gt;

&lt;source&gt;
  type tail
  format json
  path /var/log/st2/st2rulesengine.gelf.log
  tag st2rulesengine
  pos_file /var/run/td-agent/st2rulesengine.gelf.log.pos
  enable_watch_timer false
  estimate_current_event true
&lt;/source&gt;

&lt;source&gt;
  type tail
  format json
  path /var/log/st2/st2sensorcontainer.gelf.log
  tag st2sensorcontainer
  pos_file /var/run/td-agent/st2sensorcontainer.gelf.log.pos
  enable_watch_timer false
  estimate_current_event true
&lt;/source&gt;

&lt;source&gt;
  type tail
  format json
  path /var/log/st2/st2stream.gelf.log
  tag st2stream
  pos_file /var/run/td-agent/st2stream.gelf.log.pos
  enable_watch_timer false
  estimate_current_event true
&lt;/source&gt;

&lt;match st2**&gt;
  type gelf 
  host $GRAYLOG_SERVER
  port $GRAYLOG_GELF_UDP_PORT
  protocol udp
  flush_interval 5s
  estimate_current_event true
&lt;/match&gt;
EOF
</code></pre>

> **Note** `estimate_current_event true` is used in the config file because the timestamps emitted by StackStorm are rounded to 1-second resolutions. This is fixed in PR [#3662][10] where a new field `timestamp_f` is added to the GELF logging output. This PR has been merged and should be available in StackStorm `v2.4`. In these versions you can replace `estimate_current_event true` with:
> 
> <pre><code class="shell">time_key timestamp_f
keep_time_key true
</code></pre>

Finally we need to restart Fluentd so that the config file changes are realized:

<pre><code class="shell">systemctl restart td-agent
</code></pre>

Fluentd should now be sending log messages to Graylog, however Graylog is not listening.

## Configuring Graylog

To configure Graylog to receive GELF UDP messages we need to add a new `Input`. In the Graylog WebUI navigate to System > Inputs:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/08/inputs.png" alt="" width="600" height="405" class="aligncenter wp-image-6991" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/08/inputs.png 975w, https://stackstorm.com/wp/wp-content/uploads/2017/08/inputs-150x101.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/08/inputs-300x202.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/08/inputs-768x518.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/08/inputs-80x54.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/08/inputs-220x148.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/08/inputs-148x100.png 148w, https://stackstorm.com/wp/wp-content/uploads/2017/08/inputs-222x150.png 222w, https://stackstorm.com/wp/wp-content/uploads/2017/08/inputs-353x238.png 353w, https://stackstorm.com/wp/wp-content/uploads/2017/08/inputs-615x415.png 615w, https://stackstorm.com/wp/wp-content/uploads/2017/08/inputs-722x487.png 722w, https://stackstorm.com/wp/wp-content/uploads/2017/08/inputs-882x595.png 882w" sizes="(max-width: 600px) 100vw, 600px" />][11]

To add a new input click the dropdown `Select a new input type:` and select `GELF UDP` then press the button `Launch new Input`.

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_input.png" alt="" width="600" height="338" class="aligncenter wp-image-6992" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_input.png 975w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_input-150x85.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_input-300x169.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_input-768x433.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_input-80x45.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_input-220x124.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_input-177x100.png 177w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_input-266x150.png 266w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_input-422x238.png 422w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_input-736x415.png 736w, https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_input-863x487.png 863w" sizes="(max-width: 600px) 100vw, 600px" />][12]

In the new input dialog configure it with the following settings:

  * Global = Yes
  * Name = GELF UDP
  * Port = 12202

Leave all other settings as defaults, and click **Save**.

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/08/input_options.png" alt="" width="500" height="638" class="aligncenter wp-image-6993" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/08/input_options.png 975w, https://stackstorm.com/wp/wp-content/uploads/2017/08/input_options-118x150.png 118w, https://stackstorm.com/wp/wp-content/uploads/2017/08/input_options-235x300.png 235w, https://stackstorm.com/wp/wp-content/uploads/2017/08/input_options-768x980.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/08/input_options-803x1024.png 803w, https://stackstorm.com/wp/wp-content/uploads/2017/08/input_options-63x80.png 63w, https://stackstorm.com/wp/wp-content/uploads/2017/08/input_options-172x220.png 172w, https://stackstorm.com/wp/wp-content/uploads/2017/08/input_options-78x100.png 78w, https://stackstorm.com/wp/wp-content/uploads/2017/08/input_options-187x238.png 187w, https://stackstorm.com/wp/wp-content/uploads/2017/08/input_options-325x415.png 325w, https://stackstorm.com/wp/wp-content/uploads/2017/08/input_options-382x487.png 382w, https://stackstorm.com/wp/wp-content/uploads/2017/08/input_options-466x595.png 466w" sizes="(max-width: 500px) 100vw, 500px" />][13]

Why did we choose port 12202? Graylog, by default, logs its internal logs to udp/12201 so we need to choose a different port to differentiate the inputs. Graylog should now be receiving log messages from StackStorm.

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/08/log_search.png" alt="" width="975" height="494" class="aligncenter size-full wp-image-6994" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/08/log_search.png 975w, https://stackstorm.com/wp/wp-content/uploads/2017/08/log_search-150x76.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/08/log_search-300x152.png 300w, https://stackstorm.com/wp/wp-content/uploads/2017/08/log_search-768x389.png 768w, https://stackstorm.com/wp/wp-content/uploads/2017/08/log_search-80x41.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/08/log_search-220x111.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/08/log_search-197x100.png 197w, https://stackstorm.com/wp/wp-content/uploads/2017/08/log_search-280x142.png 280w, https://stackstorm.com/wp/wp-content/uploads/2017/08/log_search-470x238.png 470w, https://stackstorm.com/wp/wp-content/uploads/2017/08/log_search-750x380.png 750w, https://stackstorm.com/wp/wp-content/uploads/2017/08/log_search-961x487.png 961w" sizes="(max-width: 975px) 100vw, 975px" />][14]

If you’re not seeing any messages flowing in you can always run an action `st2 run` or restart a service `systemctl restart st2api` and this should force logs to be written.

## Conclusion

We’ve introduced you to structured logging and log shippers, then walked you through the configuration and setup of utilizing these technologies to stream StackStorm logs into the centralized logging application Graylog. Now that we have StackStorm logs into Graylog, what can we do with them? In a future blog post I’ll walk you through creating a dashboard that will provide insight and visualization of your StackStorm deployment.

## About The Author

Nick Maludy is the DevOps Manager at [Encore Technologies][1], a company out of Cincinnati Ohio that specializes in Datacenters, Cloud and Managed Services, Professional Services and Hardware Sales. Nick works in the Cloud and Managed Services organization that is focused on providing customers with tailored IT solutions to accelerate their business through automation and modernization.

 [1]: http://www.encore.tech
 [2]: https://stackstorm.com/wp/wp-content/uploads/2017/08/dashboard.png
 [3]: http://docs.graylog.org/en/2.3/pages/gelf.html#gelf-payload-specification
 [4]: https://www.fluentd.org/
 [5]: https://www.elastic.co/products/logstash
 [6]: https://www.elastic.co/products/beats/filebeat
 [7]: https://stackstorm.com/wp/wp-content/uploads/2017/08/pipeline.png
 [8]: https://docs.python.org/2/library/logging.config.html#configuration-file-format
 [9]: https://docs.fluentd.org/v0.14/categories/installation
 [10]: https://github.com/StackStorm/st2/pull/3662
 [11]: https://stackstorm.com/wp/wp-content/uploads/2017/08/inputs.png
 [12]: https://stackstorm.com/wp/wp-content/uploads/2017/08/configure_input.png
 [13]: https://stackstorm.com/wp/wp-content/uploads/2017/08/input_options.png
 [14]: https://stackstorm.com/wp/wp-content/uploads/2017/08/log_search.png