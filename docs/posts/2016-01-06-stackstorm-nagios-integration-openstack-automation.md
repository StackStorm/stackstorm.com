---
title: 'Stackstorm: from Nagios integration to Openstack automation'
author: Dmitri Zimine
type: post
date: 2016-01-07T01:17:26+00:00
url: /2016/01/06/stackstorm-nagios-integration-openstack-automation/
dsq_thread_id:
  - 4468457140
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Blog
  - Community
tags:
  - chatops
  - nagios

---
**January 07, 2016**  
_by Igor Cherkaev aka eMptywee_

Recently I&#8217;ve been playing around Stackstorm &#8211; a platform for integration and automation of day-to-day tasks, monitoring events, existing scripts and deployment tools.

I am going to explain how easy it is to wrap your daily tasks into Stackstorm actions and workflows and how to provide a simple way of execution for complex tasks.

I&#8217;ve been thinking for a while and initially I was going to bring everything up in one blog post. But later, it didn&#8217;t seem like a good idea. That being said, I&#8217;d rather break it into multiple posts, no matter how many there would be. Anyway, it seems to me that it&#8217;d be more practical and easier to read and understand.

## Nagios

Let&#8217;s start with integrating Nagios alerts into Stackstorm. Assuming that you already have Stackstorm version 1.2.0+ installed, configured and running, as well as there&#8217;s Nagios running somewhere else that is capable of processing alerts and handling events. If not, please, proceed to <www.stackstorm.com> and <www.nagios.org> (installation and initial configuration of these two tools is beyond the scope of this post). Both tools are open source and free to use and have extensive documentation on installation and basic configuration.

First of all, I was happy to find an existing Nagios integration pack [on StackStorm community repo][1], but my joy ended really quickly as I found it not working. Secondly, [this StackStorm tutorial][2] helped me to get started.

<!--more-->

Although it talks about sensu and victorops (monitoring and paging tools), you can easily apply the logic to Nagios. With the help from Stackstorm support team (they are really cool guys and they reside on Slack, see <https://stackstorm.com/community> for details) I was able to patch the st2 service handler python script to make it work (see diff here <https://www.diffchecker.com/vzsiskbg>). Don&#8217;t worry, later I&#8217;ll post a link to the github repository with all the files you need.

Also, don&#8217;t forget to apply for a trial [Enterprise Stackstorm edition][3]! You will get a very cool Flow Visual Editor that will let you create really nice workflows with a drag of your mouse! I highly recommend to at least try it. It won&#8217;t hurt, I promise.

## Deploying the pack

Let&#8217;s go ahead and deploy our example nagios pack (the repository itself is located at https://github.com/emptywee/e_nagios):

<pre><code class="sh">st2 run packs.install packs=e_nagios register=all repo_url=https://github.com/emptywee/e_nagios.git
</code></pre>

Don&#8217;t worry if you see that re-loading rules throw some exceptions due to non-existing triggers. It&#8217;s all right at this point of time. The trigger will be created once you run the st2 service handler script from the nagios server (assuming that it can easily connect to your stackstorm server over ports 9100 and 9101 and the username-password pair is correct, and the latest stackstorm version supports accessing auth and API endpoints on 443 port as well, but I haven&#8217;t tried this approach yet). But this shouldn&#8217;t happen since we have all rules disabled by default in the pack. Let&#8217;s go ahead and enable `nagios_service_chat.yaml` rule. Simply edit it with your favorite editor in /opt/stackstorm/packs/e_nagios/rules/ and switch `enabled` to `true`.

## Adjusting rules

Let&#8217;s take a brief look at the rule itself (`nagios_service_chat.yaml`):

<pre><code class="yaml">---
name: notify_chat
pack: e_nagios
description: Post to chat when nagios service state changes
enabled: true
trigger:
 type: e_nagios.service_state_change
criteria:
 trigger.attempt:
   pattern: 2
   type: gt
action:
 ref: chatops.post_message
 parameters:
   message: NAGIOS {{trigger.service}} ID:{{trigger.event_id}} STATE:{{trigger.state}}[{{ trigger.state_id }}]/{{trigger.state_type}}
     {{trigger.msg}}
   channel: '563b5f7f21f7a36d7bd5baaf'
</code></pre>

`trigger:` &#8211; is the trigger name that will make this rule fire up the action when certain criteria are met. In our case here we will post a message to our chatops (be it Slack, Lets-chat, HipChat or any other that is supported by Hubot). Plugging in chatops has become a simple task since v1.2.0 of Stackstorm has been released. So make sure you have chatops up and running to fully utilize all features, comfort, flexibility, and other bells and whistles of Stackstorm platform.

`criteria:` &#8211; with only AND logic so far you can specify when exactly you&#8217;d like the action to be executed. In this example we want the bot to report to chatops whenever any service or host changes its state into HARD state (usually after 3 consecutive checks with the same result).

`action:` &#8211; what should be executed when the criteria are met. In our case here we will just post a message to the specific channel. If you are using Slack, the channel should be more readable and meaningful name. Don&#8217;t hesitate to alter it to your needs.

Don&#8217;t forget to reload the rules:

<pre><code class="sh">st2ctl reload --register-rules
</code></pre>

There&#8217;s another way to temporary enable rules:

<pre><code class="sh">st2 rule enable e_nagios.notify_chat
</code></pre>

But it will get disabled back after the next reload of the rules unless you modify respective YAML file with the rule definition (so-called meta-data).

## Setting up Nagios

If you take a look at the st2 service handler script, you may notice that it is you who decides what to pass from Nagios to Stackstorm rules. Because it&#8217;s up to you to put anything you want into the payload that the script will send to Stackstorm. All these `trigger.service`, `trigger.msg` and alike are just parts of a payload that is formed on the Nagios host. With tens and hundreds of macros available in Nagios you may choose those that fit your needs. Here&#8217;s a link to the standard Nagios macros:  
<https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/3/en/macrolist.html>

Here&#8217;s what you should do on the Nagios host. First of all, you need to upload `st2service_handler.py` script and `st2service_handler.conf` to the Nagios host and place them somewhere you like, make sure that Nagios can execute the script from that location. Make the script executable. Secondly, you need to define a check command with macros you found in the link just above. In my case I uploaded the script into the `/opt/nagios/libexec/` directory and have Nagios with NRPE setup, so I define it in the master `nrpe.cfg` file:

<pre><code class="sh">command[st2nagios]=/opt/nagios/libexec/st2service_handler.py /opt/nagios/libexec/st2service_handler.conf $SERVICEEVENTID$ "$SERVICEDESC$" $SERVICESTATE$ $SERVICESTATEID$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTNAME$
</code></pre>

Then apply this command to `global_service_event_handler` in `nagios.cfg`:

<pre><code class="sh">global_service_event_handler=st2nagios
</code></pre>

That is it! We are almost done with the Nagios part. A good thing would be running the command manually as the nagios user:

<pre><code class="sh">$ whoami
nagios
$ /opt/nagios/libexec/st2service_handler.py /opt/nagios/libexec/st2service_handler.conf 123456 "Disk /var/log" WARNING 1 HARD 3 remote_host_name
Registered trigger type with st2.
POST: url: https://st2.example.com:9101/webhooks/st2/, body: {'trigger': 'e_nagios.service_state_change', 'payload': {'attempt': '3', 'service': 'Disk /var/log', 'event_id': '123456', 'state': 'WARNING', 'state_type': 'HARD', 'host': 'remote_host_name', 'msg': '[WARNING] Service/Host warning alert!', 'state_id': '1'}}
Sent nagios event to st2. HTTP_CODE: 202
</code></pre>

This will register a trigger. After that you can safely reload rules that rely on the `e_nagios.service_state_change` trigger. Also, running it manually will let you test your rules and actions without actually forcing Nagios to generate real alerts. That is a good thing, isn&#8217;t it?

So, in short, we are basically filling in our own payload and passing it from Nagios to Stackstorm. Just make sure that `st2service_handler.py` script has all the fields defined and in the correct order if you are about to add or remove Nagios macros from the event command.

The relevant part about it in `st2service_handler.py` is:

<pre><code class="python">def _get_payload(host, service, event_id, state, state_id, state_type, attempt):
   payload = {}
   payload['host'] = host
   payload['service'] = service
   payload['event_id'] = event_id
   payload['state'] = state
   payload['state_id'] = state_id
   payload['state_type'] = state_type
   payload['attempt'] = attempt
   payload['msg'] = STATE_MESSAGE.get(state, 'Undefined state.')
   return payload
def main(args):
   event_id = args[1]
   service = args[2]
   state = args[3]
   state_id = args[4]
   state_type = args[5]
   attempt = args[6]
   host = args[7]
   body = {}
   body['trigger'] = ST2_TRIGGERTYPE_REF
   body['payload'] = _get_payload(host, service, event_id, state, state_id, state_type, attempt)
   _post_event_to_st2(_get_st2_webhooks_url(), body)
</code></pre>

The order is defined by the array index of `args` passed to the main function. This is very important.

## Verifying in chatops

Best way to verify it&#8217;s working is run the command manually from the Nagios host. You should see your bot reporting to the channel as it&#8217;s set in the rule.

![bot reports Nagios alerts][4] 

Simple, eh? Now with what we have achieved so far, we can move forward and enhance our alert handling service.

## Enhancing alert handling

Although it&#8217;s very exciting to receive alerts in the chat room, it doesn&#8217;t make you much happier than you already are, and it certainly doesn&#8217;t relieve you from manually going and checking what exactly triggered the alert and take remedial actions.

Your use-case and real world scenarios might be slightly different, but a disk space auto-remediation is a common task that everyone runs into during their day-to-day operations. You don&#8217;t really want to be awaken by a call early in the morning just to log in remotely and clean up some log files that filled up the whole disk. So it makes a really good example to deal with.

That&#8217;s where the `nagios_service_disk.yaml` rule comes handy. Let&#8217;s take a look at it:

<pre><code class="yaml">---
name: check_disk
pack: e_nagios
description: Check disk usage and trigger remediation
enabled: true
trigger:
 type: e_nagios.service_state_change
criteria:
 trigger.service:
   pattern: "^Disk"
   type: matchregex
 trigger.state_type:
   pattern: "HARD"
   type: matchregex
 trigger.state_id:
   pattern: "0"
   type: gt
action:
 ref: e_nagios.remediate_disk_workflow
 parameters:
   hostname: "{{ trigger.host }}"
   directory: "{{ trigger.service | regex_replace('^Disk\\s*', '') }}" 
</code></pre>

Pretty similar to the one above that just posts messages to the chat room, right? Don&#8217;t forget to enable it, as it comes disabled by default. Although we utilize the same trigger, criteria here are slightly different. We are matching service description to a certain regex pattern, and we explicitly matching hard state of the alert, and catching state ID greater than zero (since in Nagios 0 means RECOVERY, 1 &#8211; WARNING, 2 &#8211; CRITICAL). We do not want to automatically fire an action on recovery alerts, right? At least in this case. One thing is also important here, and I once spent a lot of time figuring out why my rule didn&#8217;t work properly. The thing is that **you really should wrap your patterns in double-quotes** when you define your criteria. Even if it&#8217;s an integer (see `trigger.state_id` criterion as an example).

That being said, once we receive an alert with the matching criteria Stackstorm will execute the defined action and do some magic with the parameters we are passing to that action. Namely, the action is called `e_nagios.remediate_disk_workflow` and is defined under actions/ directory of the pack. We also pass hostname that triggered the alert and stripping `Disk` part out of the service description, leaving only the directory of the mounted partition itself (assuming that disk monitoring service has appropriate service description defined in the Nagios config, don&#8217;t hesitate to adjust to your own environment here). Yes, Stackstorm supports Jinja2 filters in the rules definition when you pass parameters to actions!

## Disk Space Remediation Action

It&#8217;s time to design our auto-remediation action! Here&#8217;s how it looks (and it does really look nice) in the Visual Flow tool that comes in the Enterprise Stackstorm edition:

![Visual Flow workflow design][5] 

The workflow itself is pretty simple and consists of the following steps:

  1. Report in the chatops that we received the task to check the disk space;
  2. Run the disk check action that confirms the alert from Nagios;
  3. If the disk usage is above the defined threshold, run an auto-remediation action, else report in the chat room that it was a false positive alert from Nagios;
  4. If the auto-remediation action completes with no errors try to check the disk space usage again, else report about the error in the chat room;
  5. If the disk space usage comes below the defined threshold assume that auto-remediation succeeded and report about it in the chatops, else report in the chat room that the auto-remediation failed.

Suffice to say that reporting to the channel can be substituted or extended to reporting via email or any other means to page you and ask for manual intervention. The good thing here is that the scripts that do all the job can be written in any language you like, just make sure they can be executed remotely on the host that is being checked.

Before we can design our workflows in the Visual Flow, we need to define two basic actions for our needs:

  1. check\_dir\_size
  2. disk_remediate

The meta-data for the `check_dir_size` action is defined in YAML and looks like this:

<pre><code class="yaml">description: 'Check the total percentage of disk taken up by a specified directory'
enabled: true
entry_point: check_dir_size.py
name: check_dir_size
parameters:
 action:
   description: "Run as an action.  (Outputs structured data)"
   default: true
   immutable: true
   type: boolean
 directory:
   description: "The directory to check"
   required: true
   type: string
 threshold:
   description: "Maximum percentage of disk space that can be consumed by the directory."
   default: 80
   type: integer
 debug:
   description: "Turn on debug output"
   default: false
   type: boolean
 sudo:
   default: true
   immutable: true
runner_type: remote-shell-script
</code></pre>

Three things to pay attention to: `entry_point`, `parameters` and `runner_type`. Since it&#8217;s a `remote-shell-script` runner, there&#8217;s an implied parameter `hosts` that this action will require (see [https://docs.stackstorm.com/runners.html][6] for details, for instance in case you need to provide password authentication). `entry_point` points to the script name that should reside in the same directory. `parameters` declares all parameters that will be passed to the script, their types and other options. As a homework you may want to transform the alert level (Warning or Critical) coming from Nagios into threshold level for the script. But it should be done in the workflow that is depicted earlier when we talked about the Visual Flow instrument.  
And the most interesting action is the `disk_remediate` action. Let&#8217;s take a look at the meta-data of the action:

<pre><code class="yaml">description: 'Try to remediate disk space issues'
enabled: true
entry_point: disk_remediate.pl
name: disk_remediate
parameters:
 action:
   description: "Run as an action.  (Outputs structured data)"
   default: true
   immutable: true
   type: boolean
 directory:
   description: "The directory to check"
   required: true
   type: string
 debug:
   description: "Turn on debug output"
   default: false
   type: boolean
 sudo:
   default: true
   immutable: true
runner_type: remote-shell-script
</code></pre>

Basically it looks very similar to the first one. And here&#8217;s where your imagination comes forward. The dummy auto-remediation script may look something like this:

<pre><code class="Perl">#!/usr/bin/perl
use strict;
use Getopt::Long;
#use JSON;

my $directory;
my $debug;
my %output;

GetOptions(
   "directory=s" =&gt; \$directory,
   "debug"      =&gt; \$debug
);

if ( !defined( $directory ) )
{
   $output{ 'result' } = 'fail';
   $output{ 'reason' } = "Directory is not provided!";
   finish( 1 );
}

if($directory eq '/var/log')
{
# do something with /var/log
}
elsif ($directory eq '/var')
{
# do something with /var
}
elsif ($directory eq '/home')
{
# do something with /home
}
elsif ($directory eq '/opt')
{
# do something with /opt
}

$output{'result'} = 'success';
finish(0);

sub finish
{
   my $exit_code = shift || 0;
   #my $json = encode_json \%output;
   #print "$json\n";
   exit( $exit_code );
}
</code></pre>

Who writes in Perl nowadays you&#8217;d ask? I don&#8217;t know. Some old farts like me, probably. But you may go ahead and use your favorite Bash, Python or Ruby. All that matters is that it should be executable remotely on the host, where the disk issue is appeared and reported by Nagios. You may want to compress logs, upload them, move them, just delete them, enable compression in logrotate configuration or even try to extend logical volumes if you have some spare space left when such need arises. It&#8217;s completely up to you what to do. I have disabled JSON output in the dummy script since JSON module is not installed by default on the Linux distributions. In general it&#8217;s a good idea to produce outcome in JSON format, since it then can be easily adopted and published by actions in a workflow.

And in the end the whole workflow after you put everything together will look like (which is also shown on the picture in the beginning of the chapter, but in Visual Flow representation):

<pre><code class="yaml">---
version: '2.0'

e_nagios.remediate_disk_workflow:
 type: direct
 input:
   - hostname
   - directory
   - threshold
   - channel
 tasks:
   lets_work:
     # [466, 27]
     action: chatops.post_message
     input:
       channel: &lt;% $.channel %&gt;
       message: "epsibot is trying to take care of the disk space issue on &lt;% $.hostname %&gt; in &lt;% $.directory %&gt;"
     on-success:
       - check_dir_size
   check_dir_size:
     # [289, 149]
     action: e_nagios.check_dir_size
     input:
       hosts: &lt;% $.hostname %&gt;
       directory: &lt;% $.directory %&gt;
       threshold: &lt;% $.threshold %&gt;
     on-success:
       - hubot_error
     on-error:
       - remediate
   hubot_report:
     # [485, 568]
     action: chatops.post_message
     input:
       channel: &lt;% $.channel %&gt;
       message: "epsibot has cleared &lt;% $.directory %&gt; on &lt;% $.hostname %&gt; and it is now less than &lt;% $.threshold %&gt; percent!"
   hubot_error:
     # [114, 274]
     action: chatops.post_message
     input:
       channel: &lt;% $.channel %&gt;
       message: "Alert from Nagios was false positive for &lt;% $.directory %&gt; on &lt;% $.hostname %&gt;!"
   remediate:
     # [489, 233]
     action: e_nagios.disk_remediate
     input:
       hosts: &lt;% $.hostname %&gt;
       directory: &lt;% $.directory %&gt;
     on-success:
       - check_dir_size2
     on-error:
       - hubot_rem_fail
   check_dir_size2:
     # [485, 410]
     action: e_nagios.check_dir_size
     input:
       hosts: &lt;% $.hostname %&gt;
       directory: &lt;% $.directory %&gt;
       threshold: &lt;% $.threshold %&gt;
     on-success:
       - hubot_report
     on-error:
       - hubot_rem_fail
   hubot_rem_fail:
     # [82, 464]
     action: chatops.post_message
     input:
       channel: &lt;% $.channel %&gt;
       message: "Auto-remediation failed for &lt;% $.directory %&gt; on &lt;% $.hostname %&gt;. Please check manually."
</code></pre>

As I mentioned earlier we can actually pass how critical the alert was (was it just a warning or the situation is critical) and act accordingly by altering the threshold or telling our script to be more aggressive.

At last, let&#8217;s look at the workflow&#8217;s metadata, as it contains parameters that tie it to the rule we started from:

<pre><code class="yaml">---
 name: "remediate_disk_workflow"
 runner_type: mistral-v2
 description: "Remediation workflow for diskspace alerts"
 enabled: true
 entry_point: "workflows/remediate_disk_workflow.yaml"
 parameters:
   hostname:
     type: "string"
     description: "Host to remediate disk space on"
   directory:
     type: "string"
     description: "Directory to prune if over the threshold"
   threshold:
     type: "integer"
     description: "threshold for check diskspace action. percentage"
     default: 75
   channel:
     type: "string"
     default: "563b5f7f21f7a36d7bd5baaf"
     description: "Channel to post messages to"
   context:
     default: {}
     immutable: true
     type: object
   task:
     default: null
     immutable: true
     type: string
</code></pre>

For example, we can define an array in the metadata with threshold levels for critical and warning alerts and use it to pass different numbers to disk check scripts later in the workflow. Think about it on your own and try to implement.

Hope that helps to get your started with auto-remediation and guard your sleep at night. There are a few other rules in the pack worth looking at, e.g. triggering actions on &#8220;proc&#8221; and &#8220;load&#8221; Nagios service alerts. That being said, you may want to restart processes when Nagios reports them down.

We will talk about Stackstorm and Openstack integration in the next series of my posts.

* * *

_This guest post is originally posted at [https://emptywee.blogspot.com][7]_

 [1]: https://github.com/StackStorm-Exchange/stackstorm-nagios
 [2]: https://stackstorm.com/2015/10/05/auto-remediation-out-of-disk-space/
 [3]: https://stackstorm.com/product/#enterprise
 [4]: http://1.bp.blogspot.com/-HvUZN4pt-YY/Vo2pWgw5-aI/AAAAAAAAfPU/cBLKCh8IbbM/s1600/image001.png "Bot reports Nagios alerts in the chatops"
 [5]: http://4.bp.blogspot.com/-8_vreXYrnDo/Vo2pjte-vII/AAAAAAAAfPc/mp33ENEpUxY/s1600/image003.png "Visual Flow workflow design tool"
 [6]: https://docs.stackstorm.com/runners.html#remote-script-runner-remote-shell-script
 [7]: https://emptywee.blogspot.com/2016/01/part-i-stackstorm-from-nagios.html