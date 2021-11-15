---
title: Managing AWS Instance Lifecycle With StackStorm
author: st2admin
type: post
date: 2015-01-14T00:38:05+00:00
excerpt: '<a href="http://stackstorm.com/2015/01/14/managing-aws-instance-lifecycle-with-stackstorm/">READ MORE</a>'
url: /2015/01/14/managing-aws-instance-lifecycle-with-stackstorm/
dsq_thread_id:
  - 3418135700
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home
  - Tutorials
tags:
  - devops
  - tutorial

---
**January 13, 2015**

_by Patrick Hoolboom_

###### Introduction

The StackStorm community repo has a rich integration pack for EC2 and Route53 action that you can find inside the [StackStorm Exchange][1]. These actions are incredibly useful but they are just the building blocks. The real power of using StackStorm actions comes when they are stitched together into workflows. I&#8217;ve taken the two basic workflows we use for EC2 instance lifecycle management and genericized them, then added them to the AWS integration pack. I&#8217;m going to go over how these can be used to greatly simplify creation and termination of instances.

###### Why?

At StackStorm we needed a way to rapidly provision VMs that had all of our bootstrapping done&#8230;and it had to be easy to do from the command line or StackStorm UI. This version of the workflow has been simplified to remove some of our internal bootstrapping steps but still reduces the entire process of instance creation, DNS registration, and basic bootstrapping to a single command.

<!--more-->

###### In a Hurry?

The following gets in to the nuts and bolts of how the workflows operate but if you are in a hurry, you can start managing your AWS instance lifecycle with StackStorm by following the requirements section below.

###### Requirements

The workflows used here will require StackStorm to be running and for the following packs to be installed:

  * linux
  * aws

The Linux pack is installed by default. We just need to add the AWS pack:

<pre>st2 pack install aws
</pre>

This will install the integration packs from the community repo and do the initial set up. You will still need to add a set of AWS credentials and default region to the config file. Assuming your packs are installed in the default location, the config file can be found here:

<pre>/opt/stackstorm/configs/aws.yaml
</pre>

You will need to update these lines:

<pre>---
setup:
  region: ""
  aws_access_key_id: ""
  aws_secret_access_key: ""
interval: 20
st2_user_data: "/opt/stackstorm/packs/aws/actions/scripts/bootstrap_user.sh"
</pre>

Once you&#8217;ve added your account info, and run `sudo st2ctl reload --register-configs` you should be able to run any of the AWS actions.

<pre>st2 run aws.ec2_get_all_tags -j


{
    "status": "succeeded", 
    "start_timestamp": "2015-01-12T06:03:07.038000Z", 
    "parameters": {}, 
    "callback": {}, 
    "result": {
        "result": "[Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Use, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:env, Tag:Name, Tag:env, Tag:Name, Tag:Name, Tag:env, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:env, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:env, Tag:env, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name, Tag:Name]", 
        "exit_code": 0, 
        "stderr": "", 
        "stdout": ""
    }, 
    "context": {
        "user": "stanley"
    }, 
    "action": "aws.ec2_get_all_tags", 
    "id": "54b3639b9c99380c7c8b3d81"
}


</pre>

The AWS integration pack is now configured and ready to be used.

###### User Data

The pack has a concept of a default user data file. This gives a simple way of bootstrapping new nodes with the StackStorm system user so further tasks can easily be managed from the platform. The pack ships with the following script at aws/actions/scripts/bootstrap_user.sh

<pre>#!/bin/bash

SYSTEMUSER="stanley"
PUBKEY=""

create_user() {

  if [ $(id -u ${SYSTEMUSER} &&gt; /devnull; echo $?) != 0 ]
  then
    echo "########## Creating system user: ${SYSTEMUSER} ##########"
    useradd ${SYSTEMUSER}
    mkdir -p /home/${SYSTEMUSER}/.ssh
    echo ${PUBKEY} &gt; /home/${SYSTEMUSER}/.ssh/authorized_keys
    chmod 0700 /home/${SYSTEMUSER}/.ssh
    chmod 0600 /home/${SYSTEMUSER}/.ssh/authorized_keys
    chown -R ${SYSTEMUSER}:${SYSTEMUSER} /home/${SYSTEMUSER}
    if [ $(grep ${SYSTEMUSER} /etc/sudoers.d/* &&gt; /dev/null; echo $?) != 0 ]
    then
      echo "${SYSTEMUSER}    ALL=(ALL)       NOPASSWD: ALL" &gt;&gt; /etc/sudoers.d/st2
    fi
  fi
}
</pre>

Edit this script to add the public key for the StackStorm user in the PUBKEY variable. By default, this can be found at/home/stanley/.ssh/stanley_rsa.pub

You can use any script you would like here, but these steps are crucial to bootstrapping the StackStorm user for remote administration.

###### Create VM Workflow

With the setup out of the way we can dive in to the instance creation workflow. There are a few assumptions made in this workflow.

  1. Your DNS is managed via Route53
  2. You are deploying a vanilla linux server
  3. The StackStorm server has access to the private IP address of the new instance.

The create_vm action metadata:

<pre>name: "create_vm"
  runner_type: "action-chain"
  description: "Create a VM, add DNS to Route53"
  enabled: true
  entry_point: "workflows/create_vm.yaml"
  parameters:
    image_id:
      type: "string"
      description: "AWS image id to create instance from"
      required: true
    instance_type:
      type: "string"
      description: "Flavor to use for instance creation"
      default: "t2.medium"
    key_name:
      type: "string"
      description: "SSH key to use during intial instance creation"
      required: true
    base_user:
      type: "string"
      description: "Username for initial ssh test"
      default: "ubuntu"
    keyfile:
      type: "string"
      description: "Path to local private key that corresponds to {{key_name}}"
      required: true
    dns_zone:
      type: "string"
      description: "Route53 DNS Zone to add host to"
      required: true
    hostname:
      type: "string"
      description: "Short hostname"
      required: true
    subnet_id:
      type: "string"
      description: "AWS Subnet ID"
      required: true


</pre>

Notice all of the required fields. We start off with no defaults for those, but I will show you how to make running these actions much easier later on.

The create_vm workflow:

<pre>chain:
    -
      name: "run_instance"
      ref: "aws.ec2_run_instances"
      params:
        image_id: "{{image_id}}"
        instance_type: "{{instance_type}}"
        subnet_id: "{{subnet_id}}"
        key_name: "{{key_name}}"
      on-success: "wait_for_instance"
    -
      name: "wait_for_instance"
      ref: "aws.ec2_wait_for_state"
      params:
        instance_id: "{{run_instance.result[0][0].id}}"
        state: "running"
      on-success: "wait_for_ssh"
    -
      name: "wait_for_ssh"
      ref: "linux.wait_for_ssh"
      params:
        hostname: "{{run_instance.result[0][0].private_ip_address}}"
        username: "stanley"
        keyfile: "{{keyfile}}"
        timeout: 20
        retries: 30
      on-success: "add_name_tag"
    -
      name: "add_name_tag"
      ref: "aws.ec2_create_tags"
      params:
        resource_ids: "{{run_instance.result[0][0].id}}"
        tags: "Name={{hostname}}"
      on-success: "add_cname"
    -
      name: "add_cname"
      ref: "aws.r53_zone_add_cname"
      params:
        name: "{{hostname}}.{{dns_zone}}"
        value: "{{run_instance.result[0][0].private_dns_name}}"
        zone: "{{dns_zone}}"
      on-success: "set_hostname"
    -
      name: "set_hostname"
      ref: "aws.set_hostname_cloud"
      params:
        hosts: "{{run_instance.result[0][0].private_ip_address}}"
        hostname: "{{hostname}}.{{dns_zone}}"
      on-success: "reboot"
    -
      name: "reboot"
      ref: "core.remote_sudo"
      params:
        hosts: "{{run_instance.result[0][0].private_ip_address}}"
        sudo: true
        cmd: "reboot"
      on-success: "wait_for_ssh_post_reboot"
    -
      name: "wait_for_ssh_post_reboot"
      ref: "linux.wait_for_ssh"
      params:
        hostname: "{{run_instance.result[0][0].private_ip_address}}"
        username: "stanley"
        keyfile: "{{keyfile}}"
        timeout: 30
        retries: 10

  default: "run_instance"


</pre>

The steps of the workflow are as follows:

  1. Run a new instance
  2. Wait for the instance state to switch to &#8216;running&#8217;
  3. Wait for SSH to succeed, using the default user for the distro (set to ubuntu by default)
  4. Add a tag that matches the hostname
  5. Add the CNAME to the Route53 zone specified at run time
  6. Set the hostname on the instance and enable preserver_hostname in cloud.cfg
  7. Reboot and wait for the server to come back up
  8. Run the workflow

To run the workflow using the standard action params, the command will look something like this:

<pre>st2 run aws.create_vm hostname= dns_zone=&lt;YOUR_DNS_ZONE&gt; image_id=ami-3d50120d key_name=&lt;AWS_KEYPAIR_NAME&gt; keyfile=/path/to/private/key/file -a
</pre>

The important parts of this are:

  * dns_zone &#8211; The zone to add the CNAME to
  * key\_name &#8211; The key\_name as listed by:st2 run aws.ec2\_get\_all\_key\_pairs
  * keyfile &#8211; local path to the private key that will be used to verify SSH connectivity
  * image\_id &#8211; The image\_id above is a trusty tahr image. If you wish to use a different distro, this will need to be changed.

Once the workflow runs you can check the status with:

<pre>st2 execution list


</pre>

When completed the output should look something like this:

<pre>st2 execution list -n 9
+--------------------------+------------------------+--------------+-----------+-----------------------------+
| id                       | action                 | context.user | status    | start_timestamp             |
+--------------------------+------------------------+--------------+-----------+-----------------------------+
| 54b3759abe916458a731e67f | aws.create_vm          | stanley      | succeeded | 2015-01-12T07:19:54.005000Z |
| 54b3759abe916458a4b57bb9 | aws.ec2_run_instances  | stanley      | succeeded | 2015-01-12T07:19:54.113000Z |
| 54b3759bbe916458a4b57bba | aws.ec2_wait_for_state | stanley      | succeeded | 2015-01-12T07:19:55.134000Z |
| 54b375b1be916458a4b57bbb | linux.wait_for_ssh     | stanley      | succeeded | 2015-01-12T07:20:17.191000Z |
| 54b375d1be916458a4b57bbc | aws.ec2_create_tags    | stanley      | succeeded | 2015-01-12T07:20:49.266000Z |
| 54b375d2be916458a4b57bbd | aws.r53_zone_add_cname | stanley      | succeeded | 2015-01-12T07:20:50.318000Z |
| 54b375d4be916458a4b57bbe | aws.set_hostname_cloud | stanley      | succeeded | 2015-01-12T07:20:52.367000Z |
| 54b375d5be916458a4b57bbf | core.remote_sudo       | stanley      | succeeded | 2015-01-12T07:20:53.408000Z |
| 54b375d6be916458a4b57bc0 | linux.wait_for_ssh     | stanley      | succeeded | 2015-01-12T07:20:54.447000Z |
+--------------------------+------------------------+--------------+-----------+-----------------------------+


</pre>

As you can see above all 9 steps in the workflow completed successfully. Assuming DNS is setup correctly in your environment you should now be able to look up the host you just created, as well run StackStorm commands against it:

<pre>st2 run core.remote hosts=awstest1 hostname
.
+-----------------+-----------------------------------------------------+
| Property        | Value                                               |
+-----------------+-----------------------------------------------------+
| id              | 54b376a4be916458a731e683                            |
| context         | {                                                   |
|                 |     "user": "stanley"                               |
|                 | }                                                   |
| parameters      | {                                                   |
|                 |     "cmd": "hostname",                              |
|                 |     "hosts": "awstest1"                             |
|                 | }                                                   |
| status          | succeeded                                           |
| start_timestamp | 2015-01-12T07:24:20.227000Z                         |
| result          | {                                                   |
|                 |     "awstest1": {                                   |
|                 |         "failed": false,                            |
|                 |         "stderr": "",                               |
|                 |         "return_code": 0,                           |
|                 |         "succeeded": true,                          |
|                 |         "stdout": "awstest1.uswest2.stackstorm.net" |
|                 |     }                                               |
|                 | }                                                   |
| action          | core.remote                                         |
| callback        |                                                     |
+-----------------+-----------------------------------------------------+


</pre>

###### Destroy VM Workflow

The destroy_vm workflow is designed to terminate an instance based on hostname. The definition of the workflow is below:

<pre>---
  chain:
    -
      name: "get_instance_dns"
      ref: "linux.dig"
      params:
        hostname: "{{hostname}}.{{dns_zone}}"
        count: 1
      on-success: "get_instances"
    -
      name: "get_instances"
      ref: "aws.ec2_get_only_instances"
      params: {}
      on-success: "id"
    -
      name: "id"
      ref: "core.local"
      params:
        cmd: "echo '{% for i in get_instances.result -%}{% if (i.private_dns_name + '.') == get_instance_dns.result[0] -%}{{i.id}}{%- endif %}{%- endfor %}'"
      on-success: "destroy_vm"
    -
      name: "destroy_vm"
      ref: "aws.ec2_terminate_instances"
      params:
        instance_ids: "{{id.localhost.stdout}}"
      on-success: "delete_cname"
    -
      name: "delete_cname"
      ref: "aws.r53_zone_delete_cname"
      params:
        zone: "{{dns_zone}}"
        name: "{{hostname}}.{{dns_zone}}"

  default: "get_instance_dns"


</pre>

The workflow performs the following steps:

  1. Looks up the CNAME of the host
  2. Get a list of instances
  3. Filter out the ID of the instance with the appropriate internal dns name.
  4. Terminate the instance
  5. Delete the CNAME entry in Route53

The metadata for this action is fairly straight forward:

<pre>---
  name: "destroy_vm"
  runner_type: "action-chain"
  description: "Destroys a VM and removes it from Route53"
  enabled: true
  entry_point: "workflows/destroy_vm.yaml"
  parameters:
    dns_zone:
      type: "string"
      description: "Route53 DNS Zone to add host to"
      required: true
    hostname:
      type: "string"
      description: "Short hostname"
      required: true


</pre>

The only parameters necessary are dns_zone and hostname. If we run this workflow against our newly created host like so:

<pre>st2 run aws.destroy_vm dns_zone=uswest2.stackstorm.net hostname=awstest1 -a
</pre>

The output of execution list after running this should look like this:

<pre>st2 execution list -n 6
+--------------------------+-----------------------------+--------------+-----------+-----------------------------+
| id                       | action                      | context.user | status    | start_timestamp             |
+--------------------------+-----------------------------+--------------+-----------+-----------------------------+
| 54b37817be916458a731e689 | aws.destroy_vm              | stanley      | succeeded | 2015-01-12T07:30:31.620000Z |
| 54b37817be916458a37fdd53 | linux.dig                   | stanley      | succeeded | 2015-01-12T07:30:31.774000Z |
| 54b37818be916458a37fdd54 | aws.ec2_get_only_instances  | stanley      | succeeded | 2015-01-12T07:30:32.791000Z |
| 54b37819be916458a37fdd55 | core.local                  | stanley      | succeeded | 2015-01-12T07:30:33.819000Z |
| 54b3781abe916458a37fdd56 | aws.ec2_terminate_instances | stanley      | succeeded | 2015-01-12T07:30:34.842000Z |
| 54b3781bbe916458a37fdd57 | aws.r53_zone_delete_cname   | stanley      | succeeded | 2015-01-12T07:30:35.868000Z |
+--------------------------+-----------------------------+--------------+-----------+-----------------------------+


</pre>

###### Next Steps

The workflows as they are written have made provisioning and decommissioning VMs significantly easier. There are a number of other ways we can speed up this process and make them more easily reproducible. The easiest is to define defaults for many of the parameters for the workflows.

###### Create VM

In order to simplify the command for the create vm workflow you can define defaults for most of the paramaters. The simplest would be these:

  * image_id
  * key_name
  * keyfile
  * dns_zone
  * subnet_id

###### Destroy VM

The destroy VM workflow doesn&#8217;t have as many parameters but it can be simplified by setting a default for:

  * dns_zone

###### Improvements

In the next blog I will show some ways to improve these workflows using the StackStorm datastore, and adding additional steps for things like adding apt repos or bootstrapping Puppet.

 [1]: https://exchange.stackstorm.org/