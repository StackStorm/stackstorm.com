---
title: StackStorm v3.3.0 Released
author: Nick Maludy
type: post
date: 2020-10-22T20:04:37+00:00
url: /2020/10/22/stackstorm-v3-3-0-released/
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - News
tags:
  - release

---
<p dir="ltr" id="docs-internal-guid-46cf7f8e-7fff-da9b-b939-3a41905065e8">
  <b>Oct 22, 2020</b>
</p>

<p dir="ltr">
  <i><span>by</span></i><a href="https://github.com/nmaludy"><i><span> </span></i><i><span>Nick Maludy (@nmaludy)</span></i></a> and <a href="https://github.com/blag">@blag</a>
</p>

<p dir="ltr">
  <span>The StackStorm project is pleased to announce that the latest version of StackStorm, v3.3.0, is now publicly available! It has been approximately 5 months since our</span><a href="https://stackstorm.com/2020/04/30/stackstorm-v3-2-0-released/"><span> </span><span>v3.2.0 release</span></a><span> and we are releasing a new version containing important features and bug fixes that move the project forward.</span>
</p>

# **Goals**

<p dir="ltr">
  <span>With this release we&#8217;re driving toward several project goals on the</span><a href="https://docs.stackstorm.com/roadmap.html"><span> </span><span>StackStorm roadmap</span></a><span>. Each of the goals in this release is focused on providing better maintainability and ease of long-term support for the project. Reducing maintenance burden on the development team allows us to put more effort into features.</span>
</p>

<p dir="ltr">
  <span>So, what changed?</span>
</p>

<!--more-->

## **Dropped Support for RHEL6**

<p dir="ltr">
  <span>Red Hat Enterprise Linux/CentOS 6 is reaching the end of its</span><a href="https://access.redhat.com/support/policy/updates/errata"><span> </span><span>maintenance lifecycle on November 20, 2020</span></a><span>. This OS also has some oddities and legacy baggage that makes it a drag on the team with lots of weird conditionals and edge cases. Back in</span><a href="https://stackstorm.com/2020/04/30/stackstorm-v3-2-0-released/"><span> the StackStorm </span><span>v3.2.0</span></a><span> release announcement we warned users of our plans to deprecate RHEL/CentOS 6 and today we&#8217;re happy to announce that we&#8217;ve dropped support for RHEL/CentOS 6! Good news is, we support both RHEL/CentOS 7 and 8.</span>
</p>

## **Dropped Support for HipChat in ChatOps**

<p dir="ltr">
  <a href="https://www.cnet.com/news/slack-is-buying-rival-hipchat-only-to-kill-it-off/"><span>Atlassian discontinued HipChat</span></a><span> Cloud back in Febuary 2019, and now HipChat Server has gone end-of-life as of June 2020. It is recommended by Atlassian to migrate over to Slack as the chat platform of the future, we couldn&#8217;t agree more! Since it&#8217;s time to move on, we&#8217;ve dropped support for HipChat from st2chatops. Thanks for the good memories HipChat!</span>
</p>

## **Deprecation Notice for Python 2**

<p dir="ltr">
  <span>Oh Python 2, you&#8217;ve been a long standing friend but your time has also come. Python 2 was end-of-life on</span><a href="https://www.python.org/doc/sunset-python-2/"><span> </span><span>January 1, 2020</span></a><span>. As of StackStorm v3.3.0 we are beginning the process of deprecating Python 2 and migrating to Python 3. StackStorm already supports Python 3 for its own code base on RHEL/CentOS 8 and Ubuntu 18.04, and it also supports executing Python actions using Python 3. We will begin the work to migrate existing platforms to using Python 3 exclusively and be dropping support for Python 2. Sorry this has taken so long, but both Operating Systems and 3rd party packages that StackStorm depends on have taken a long time to add Python 3 support, we&#8217;ve mostly been blocked by them.</span>
</p>

<p dir="ltr">
  <span>Starting with StackStorm v3.3.0 users will now see warnings on the st2ctl CLI if it is being executed from a Python 2 runtime.</span>
</p>

<pre class="EnlighterJSRAW" data-enlighter-language="null">$ st2ctl status

Deprecation warning: Support for python 2 will be removed in future StackStorm releases. Please ensure that all packs used are python 3 compatible. Your StackStorm installation may be upgraded from python 2 to python 3 in future platform releases. It is recommended to plan the manual migration to a python 3 native platform, e.g. Ubuntu 18.04 LTS or CentOS/RHEL 8.</pre>

<p dir="ltr">
  <span>There will also be a warning printed in the StackStorm system service logs (st2api, st2actionrunner, etc):</span><span><br /></span><span></span>
</p>

<pre class="EnlighterJSRAW" data-enlighter-language="null">Sep 17 14:14:13 testsyslog st2workflowengine[14015]: 2020-09-17 14:14:13,852 WARNING [-] DEPRECATION WARNING. Support for python 2 will be removed in future StackStorm release(s). Please ensure that all packs used are python 3 compatible. Python 3 will already be used if you upgrade to a newer OS release
</pre>

<p dir="ltr">
  <span>On the pack side of the house, a warning will be printed when installing a pack that only supports Python 2:</span><span><br /></span><span><br /></span><span></span>
</p>

<pre class="EnlighterJSRAW" data-enlighter-language="null">$ st2 pack install python2only
&nbsp;&nbsp;&nbsp; [ succeeded ] init_task
&nbsp;&nbsp;&nbsp; [ succeeded ] download_pack
&nbsp;&nbsp;&nbsp; [ succeeded ] make_a_prerun
&nbsp;&nbsp;&nbsp; [ succeeded ] get_pack_dependencies
&nbsp;&nbsp;&nbsp; [ succeeded ] check_dependency_and_conflict_list
&nbsp;&nbsp;&nbsp; [ succeeded ] download_pack
&nbsp;&nbsp;&nbsp; [ succeeded ] make_a_prerun
&nbsp;&nbsp;&nbsp; [ succeeded ] get_pack_dependencies
&nbsp;&nbsp;&nbsp; [ succeeded ] check_dependency_and_conflict_list
&nbsp;&nbsp;&nbsp; [ succeeded ] install_pack_requirements
&nbsp;&nbsp;&nbsp; [ succeeded ] get_pack_warnings
&nbsp;&nbsp;&nbsp; [ succeeded ] register_pack

+-------------+-------------+------------------+---------+------------------+
| ref       &nbsp; | name&nbsp;       | description&nbsp; &nbsp; &nbsp; | version | author &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |
+-------------+-------------+------------------+---------+------------------+
| python2only | python2only | Pack for python2&nbsp;| 0.0.1 &nbsp; | StackStorm       |
+-------------+-------------+------------------+---------+------------------+

DEPRECATION WARNING: Pack Test2 only supports Python 2.x. ST2 will remove support for Python 2.x in a future release.</pre>

<p dir="ltr">
  <span>Stay tuned to our blog for an upcoming post detailing our plans for Python 2 deprecation and transition to Python 3!</span>
</p>

## **Deprecation of Chef Deployment**

<p dir="ltr">
  <span>Our Chef installation method</span><a href="https://github.com/StackStorm/chef-stackstorm"><span> </span><span>chef-stackstorm</span></a><span> hasn&#8217;t received an update in some time and currently has no maintainer. As of right now, this installation method is deprecated and is no longer supported. If you are a Chef developer and want to pick up support for this installation method, please get in touch by joining the <code class="EnlighterJSRAW" data-enlighter-language="null">#chef</code> </span><span>channel in our</span><a href="https://stackstorm.com/community-signup"><span> </span><span>Slack community</span></a><span> .</span>
</p>

## **Overhaul of st2-docker**

<p dir="ltr">
  <span>The Docker installation method</span><a href="https://github.com/StackStorm/st2-docker"><span> </span><span>st2-docker</span></a><span> received an update recently. Its <code class="EnlighterJSRAW" data-enlighter-language="null">docker-compose</code> </span><span>file now pulls containers from the</span><a href="https://github.com/StackStorm/st2-dockerfiles/"><span> </span><span>st2-dockerfiles</span></a><span> repository. This is a positive step forward because now</span><a href="https://github.com/StackStorm/st2-docker"><span> </span><span>st2-docker</span></a><span> now uses the same containers as our Kubernetes helm chart installation method</span><a href="https://github.com/StackStorm/stackstorm-ha"><span> </span><span>stackstorm-ha</span></a><span>.</span>
</p>

## **MongoDB 4.0**

<p dir="ltr">
  <span>MongoDB 4.0 is currently the default database on both RHEL/CentOS 8 and Ubuntu 18.04. In an effort to standardize our support matrix across the various operating systems, we&#8217;re now updating MongoDB to 4.0 on all OSes. This means that if you&#8217;re running RHEL/CentOS 7 or Ubuntu 16.04, you&#8217;ll need to upgrade from MongoDB 3.4 to MongoDB 4.0. However, there is a catch!</span>
</p>

<p dir="ltr">
  <span>When upgrading your RHEL/CentOS 7 or Ubuntu 16.04 system from MongoDB 3.4 to MongoDB 4.0 it is not a direct path. In order to perform this upgrade successfully one will need to first upgrade MongoDB 3.4 to MongoDB 3.6 and then to MongoDB 4.0. These special instructions, including actual commands to run, can be found in our</span><a href="https://docs.stackstorm.com/install/upgrades.html#v2-10"><span> </span><span>Version Specific Upgrade Scripts section</span></a><span> of the StackStorm documentation. If you&#8217;re a</span><a href="https://puppet.com/docs/bolt/latest/bolt.html"><span> </span><span>Puppet Bolt</span></a><span> user, we have a <code class="EnlighterJSRAW" data-enlighter-language="null">st2::upgrade_mongodb</code> </span><span>Plan available to perform these steps in an automated way:</span>
</p>

<pre class="EnlighterJSRAW" data-enlighter-language="null">mkdir modules
git clone https://github.com/StackStorm/puppet-st2 modules/st2
bolt plan run st2::upgrade_mongodb --targets stackstormhost.domain.tld</pre>

## **Mistral Removal**

<p dir="ltr">
  <span>OpenStack Mistral was previously used as StackStorm&#8217;s primary workflow engine. Almost two years ago, back in</span><a href="https://docs.stackstorm.com/roadmap.html"><span> </span><span>StackStorm v2.10 Mistral deprecation was announced</span></a><span> and now in v3.3.0 Mistral has been fully removed from StackStorm. Where do we go from here?</span>
</p>

<p dir="ltr">
  <span>In case you haven&#8217;t heard, StackStorm has developed its own workflow engine called</span><a href="https://docs.stackstorm.com/orquesta/index.html"><span> </span><span>Orquesta</span></a><span>. If you&#8217;re currently still using Mistral for your workflows, we&#8217;ve developed a tool to help ease the transition from Mistral to Orquesta called</span><a href="https://github.com/StackStorm/orquestaconvert"><span> </span><span>orquestaconvert</span></a><span>. It is super easy to get started:</span>
</p>

<pre class="EnlighterJSRAW" data-enlighter-language="null">$ git clone https://github.com/StackStorm/orquestaconvert.git
$ cd orquestaconvert</pre>

<p dir="ltr">
  <span>You can convert a single workflow:</span>
</p>

<pre class="EnlighterJSRAW" data-enlighter-language="null">$ ./bin/orquestaconvert.sh ../stackstorm-mypack/actions/workflows/nasa_apod_twitter_post.yaml</pre>

<p class="EnlighterJSRAW" data-enlighter-language="null">
  <span>Or, even better, convert all of the workflows in a pack:</span>
</p>

<pre class="EnlighterJSRAW" data-enlighter-language="null">$ ./bin/orquestaconvert-pack.sh --action-dir ../stackstorm-mypack/actions</pre>

## **Others**

  * <span>Stripping of authentication headers in webhooks</span>
  * <span>ssh timeouts</span>
  * <span>st2 bug fixes</span>
  * <span>orquesta bug fixes</span>
  * <span>st2web dependencies and security updates</span>

<p dir="ltr">
  <span>There are so many more bug fixes and small changes that including them in this list would make the blog post huge. If you&#8217;re interested in learning more, see a complete list of all changes across our various repositories in our</span><a href="https://github.com/StackStorm/discussions/issues/52"><span> </span><span>discussion post for the v3.3.0 release</span></a><span>.</span>
</p>

# **Future Plans**

<p dir="ltr">
  <span>With all of these house-cleaning items off our plate, the StackStorm team is excited about our future plans, below is a list of items that may be coming in a future versions:</span>
</p>

  * <span>Add support for Ubuntu 20.04</span>
  * <span>Migration from Python 2 to Python 3</span>
  * <span>RBAC functionality (previously enterprise-only)</span>
  * <span>Integrate st2flow workflow composer into the Web UI&nbsp; (previously enterprise-only)</span>
  * <span>Converting ChatOps from Javascript to Python</span>
  * <span>and more!</span>



<p dir="ltr">
  <span>If you’re interested in learning about the other ideas we have for the future and would like to help, please checkout our </span><a href="https://docs.stackstorm.com/roadmap.html"><span>roadmap documentation</span></a><span>.</span>
</p>

# **Calling All JavaScript Developers!**

<p dir="ltr">
  <span>StackStorm&#8217;s front end web UI,</span><a href="https://github.com/StackStorm/st2web"><span> </span><span>st2web</span></a><span>, could really use some help and maintenance. If you are a JavaScript developer or know someone who is looking to help out on an Open Source project, we would love to have you! Please come join our</span><a href="https://stackstorm.com/community-signup"><span> </span><span>Slack community</span></a><span> and we can help you get started.</span>
</p>

# **Get Involved!**

<p dir="ltr">
  <span>The StackStorm project is actively seeking more community contributions. There are so many ways to get started:</span>
</p>

  * <span>Fix a</span>[ <span></span><span>StackStorm Exchange pack issue</span>][1]
  * <span>Create your a StackStorm Exchange pack by forking the</span>[ <span></span><span>exchange-incubator repo</span>][2]
  * <span>Add or fix</span>[ <span></span><span>documentation</span>][3] <span>that ends up on</span>[ <span></span><span>docs.stackstorm.com</span>][4]
  * <span>Contribute an issue or implement a bug fix to</span>[ <span></span><span>StackStorm core</span>][5]
  * <span>Post and answer questions on</span>[ <span></span><span>forum.stackstorm.com</span>][6]
  * <span>Contribute to a live discussion by joining our</span>[ <span></span><span>Slack Community</span>][7]

<p dir="ltr">
  <span>Thank you so much and happy automating!</span>
</p>

 [1]: https://github.com/search?q=org%3AStackStorm-Exchange+is%3Aissue+is%3Aopen+sort%3Aupdated
 [2]: https://github.com/StackStorm-Exchange/exchange-incubator
 [3]: https://github.com/StackStorm/st2docs
 [4]: https://docs.stackstorm.com/
 [5]: https://github.com/StackStorm/st2/issues
 [6]: https://forum.stackstorm.com/
 [7]: https://stackstorm.com/community-signup