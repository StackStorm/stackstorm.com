---
title: The Return Of Workflows
author: st2admin
type: post
date: 2015-04-10T17:43:45+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/04/10/the-return-of-workflows/
dsq_thread_id:
  - 3671070002
categories:
  - Blog
  - Community
  - Home

---
**April 10, 2015**

_by Dmitri Zimine_

_This article originally appeared April 9, 2015 on <a href="http://devops.com/features/return-workflows/" target="_blank">DevOps.com</a>._

Recently workflows have emerged as a fundamental part of the operational wiring at companies as diverse as AWS, Facebook, HP, LinkedIn, Spotify, and Pinterest, which just [open sourced Pinball][1]. We’ve witnessed a spike of interest in workflow-based automation, and a few interesting implementations coming to the open-source world in just the last year or two: [Mistral][2] and [TaskFlow][3] from OpenStack ecosystem, [Score][4] from HP, [Azkaban][5] from LinkedIn, [Luigi][6] from Spotify, and [dray.it][7] by CenturyLink for the Docker ecosystem, to name a few.

Workflows are used to orchestrate operations in infrastructure and applications, automate complex CI/CD processes, coordinate map/reduce jobs, and handle jobs to containers.

It is not surprising that when it comes to higher level automation and orchestration, workflows are widely used. To quote the Pinterest blog: “In realistic settings it’s not uncommon to encounter a workflow composed of hundreds of nodes. Building, running and maintaining workflows of that complexity requires specialized tools. A Bash script won’t do.” Workflows are superior to scripts in concept and in practicality.

<!--more-->

**Conceptually**, workflow separates the “recipe” from underlying details, giving an extra level of flexibility and mobility. Modify the process to your liking by modifying the workflow “blueprint,” without hacking hardwired code – like adding ticket updates on key steps for business process conformance. Or take an autoscaling workflow built for Rackspace cloud, and use it to scale an AWS cluster.

**Practically**, workflows are better in operations.

1)   Workflow is an execution plan expressed as a directed graph of tasks – simple to define, to reason, and to visualize.  
2)   Workflow engine serves as a ‘messaging fabric,’ carrying structured data between different application domains.  
3)   The state of workflow executions is clear and easy to track: see which steps are running, which are complete, and what has failed.  
4)   It is possible to provide reliability and crash recovery<a href="http://devops.com/features/return-workflows/#_ftn1" name="_ftnref1">[1]</a>, and good workflow engines do it.  
5)   There are other convenient frills. How good is logging in your scripts? i18n, anyone?

What makes a good workflow engine? The answer is “it depends.” It depends on the details of the job the workflow is designed to do, and how broad or narrow is the scope of the functionality. Below, I’ll highlight some architecture choices, features, functionality, and properties that I see as most relevant for using workflows in automation and orchestration.

### 1. Functionality

The core workflow functionality is to execute the tasks in the right order and pass down the data. In [workflow lingo][8], they are called flow control patterns, and data patterns.

**1.1 Flow control**

The workflows are known to have over [40 control patterns][9]. But 15 years of using workflow in system automation shows that few patterns are used in practice. The no-frills essentials are ‘sequential execution with conditions, passing data down the line.’ Parallel execution is often desired. But once you split to run tasks in parallel, you need to join them, and there are 16 distinct ways to do it. Handling joins is a high step of complexity in implementation, and in usability. Different workflow engines balance power and complexity differently.

<a href="https://github.com/knipknap/SpiffWorkflow/wiki" target="_blank">Spiff workflow</a> implements all (!) control patterns. <a  href="http://docs.stackstorm.com/actionchain.html" target="_blank">ActionChain</a> opted for simplicity of sequential execution, as the name suggests. So does <a  href="http://dray.it/" target="_blank">Dray.it</a> – the workflow there is a sequence of “jobs” – in this case, docker image executions. <a href="https://github.com/pinterest/pinball" target="_blank">Pinball</a> splits for parallel execution but only supports “[synchronization][10]” join – and continues on completion of all input branches. Pinball’s pluggable token-based design is a powerful abstraction to add joins, conditions, and more. [Mistral][11] tries to balance power with simplicity of use: it supports conditional transitions, parallel executions, various joins, and deals with multi-instances, handling collections of inputs at engine.

<img loading="lazy" class="aligncenter wp-image-6107" src="http://devops.com/wp-content/uploads/2015/04/workflow.jpg" alt="workflow" width="560" height="431" /> 

<p style="text-align: center;">
  (please click link to see this illustration in a Flash animation):
</p>

<p style="text-align: center;">
  <a href="http://www.workflowpatterns.com/patterns/control/new/wcp30_animation.php," target="_blank"><em>http://www.workflowpatterns.com/patterns/control/new/wcp30_animation.php</em></a>
</p>

**1.2 Data passing**

Data passing is another workflow functionality essential in system automation. It is an ability to use workflow input and upstream task outputs as inputs or conditions in downstream tasks. Publishing a named variable to execution context is a convenience feature offered by many engines.

Structural data commonly passed as JSON. Ansible Playbook, StackStorm [ActionChain][12], and most others use [Jinja templating][13] for data manipulation. Jinja is widely adopted and well documented; a power user can do nice hacks with it. The challenge we faced is preserving types outside of Jinja templates. After all its templating engine, not a query language. [Mistral][11] solved this problem by using [YAQL][14]. YAQL is a modern extension of [JsonPath][15] – simple to use, very powerful, and easily extensible, but currently it suffers from lack of documentation (that is about to change, according to YAQL authors). <a href="http://www.openscore.io/#/" target="_blank">Score</a> workflow offers python syntax in a task definition: while convenient, it brings security concerns. <a href="http://dray.it/" target="_blank">Dray.it</a> makes jobs communicate by passing environment variables and wiring stdouts to stdins (file output channels possible), but doesn’t offer any data transformation on the platform side. <a href="https://github.com/pinterest/pinball" target="_blank">Pinball</a> support for data passing at this time is rudimentary: it uses a convention to publish a string value, and leaves it up to jobs to agree on data formats.

### 2. Extensibility

What it takes to add a new type of action to the workflow? How to write it? How to deploy it? How to upgrade it? Most workflow tools have some answer, few give a rounded one for both development and operations.  <a href="https://github.com/pinterest/pinball" target="_blank">Pinball</a> introduces pluggable job templates, and provides Bash, Python, Hadoop and Hive jobs out of box. However it leaves it up to the jobs to produce expected output format (smart job, simple platform). <a href="https://github.com/knipknap/SpiffWorkflow/wiki" target="_blank">Spiff</a> workflow has pluggable tasks, but it is not dynamic enough, therefore Spiff is most often used with Celery, leveraging its extensibility and remote execution functionality. StackStorm makes its full action library available as workflow building blocks, and brings action execution outputs into a common “message fabric.” Better yet, a workflow becomes an action itself. An ability to operate and run individual actions and workflows alike makes it easy to develop, debug, and operate.

### 3. Reliability

Workflows are long running. Long means: 1) long enough to expect a failure of any component, and the execution must sustain it, and, 2) long enough that I don’t want to start it all over if workflow execution fails for any reason, but rather fix a problem and continue. It all makes reliability a key requirement.

<a href="https://github.com/pinterest/pinball" target="_blank">Pinball</a> gets the highest score on reliability. <a shref="https://github.com/pinterest/pinball/blob/master/ARCHITECTURE.rst" target="_blank">Its fault-tolerant architecture</a> (very similar to the one of [Mistral][11]) is based on atomic state update on each state transition, providing for scale-out masters and workers, fault tolerant executions, crash recovery and “no-downtime upgrade.” [Ansible][16] took a different approach: the playbook execution is not resilient, but the tasks are assumed idempotent, and when they are, it’s safe to re-run the whole playbook. <a href="http://dray.it/" target="_blank">Dray</a> opted for simplicity and [doesn’t seem to come with fault-tolerance][17] yet.

[Luigi][6] workflow brings an interesting architecture where distributed workers pick up workflows and tasks alike, essentially treating workflow handling as just yet another job. It makes a great horizontal scale-out, but currently short on fault tolerance: the [whole workflow execution is run with a worker where it got started][18].

### 4. Workflow definition

Human readable, machine scriptable language for declaring workflow is not just convenience. It’s a necessity for dynamic creation, uploading and updating workflows on a live system, and for treating “infrastructure-as-code.” A solid DSL is a good foundation for building UI on top (and not the other way around!). XML-based workflow languages are left the past; YAML is a new de-facto standard.

StackStorm’s [ActionChain][12] and [Ansible][16] Playbooks offer fun-to-write YAML workflow definitions. It reflects the simplicity of underlying engines at the expense of advanced functionality.

<a  href="https://github.com/knipknap/SpiffWorkflow/wiki" target="_blank">Spiff</a> workflow offers XML, JSON, and pure python programmable definitions. <a href="http://dray.it/" target="_blank">Dray</a> uses JSON. <a  href="https://github.com/pinterest/pinball" target="_blank">Pinball</a> comes with no DSL out of box. It provides a python interface for building workflow programmatically; adding JSON or YAML workflow definition is a matter of writing a parser. According to Pinball team, it’s a “conscious choice to not make the configuration syntax part of the system core in order to give developers a lot of flexibility to define workflow configurations in a way that makes the most sense.”

But honestly two DSL for the same workflow doesn’t make much sense. Check out <a  href="http://www.openscore.io/#/" target="_blank">Score</a>: it has taken this pluggable approach to the end, separating “languages” from workflow by pluggable compiler, with an idea to support multiple languages to the same workflow. However, the capabilities are defined in the workflow, so it’s impossible to introduce a meaningful new construct – like swap Jinga for YAQL, add “_discriminator_” pattern, or introduce _timeout_ keyword – without hacking the workflow handler.  Beyond superficial semantic sugar, syntax and capabilities can’t be truly separated.

[Mistral][11] and TaskFlow took a different tack, supporting pluggable workflow handlers. [Mistral][11] comes with two handlers, representing two types of workflow, with distinct capabilities. A direct workflow explicitly defines the flow of tasks with on-success/on-failure. A ‘reverse’ workflow defines task dependencies on upstream tasks with “requires” keyword, and runs all dependent tasks to satisfy the target task, like make or ant. The base workflow DSL is extended with handler-specific keywords._ _

### 5. Nice GUI

A good graphical representation makes it much easier to comprehend a structure of a workflow and track workflow executions. Building workflows graphically not only excites users, it helps user learn the system and greatly accelerates workflow authoring (you can taste it [here][19]). One problem: as <a href="http://engineering.pinterest.com/post/74429563460/pinball-building-workflow-management" target="_blank">Pinball authors rightly said</a>, “Realistic workflows are 100s of steps.” Guess what, existing UI representations don’t scale well for 100 step workflows. Not just the new ones: anything we saw in the last 20 years <a href="http://devops.com/features/return-workflows/#_ftn2" name="_ftnref2">[2]</a> – they all suck. I believe this UX problem is yet to be solved.

<a href="https://github.com/pinterest/pinball" target="_blank">Pinball</a> doesn’t let great be the enemy of the good: it offers a visual representation of the workflow, and even an ability to build workflows from the UI. <a href="https://github.com/spotify/luigi" target="_blank">Luigi</a> is another one that makes a simple d3 based map “good enough” to show the tasks.

<a href="http://www.openscore.io/#/docs" target="_blank">Score</a> and <a "href="https://wiki.openstack.org/wiki/Mistral%20">Mistral</a> took an alternative approach to make authoring workflows faster and bug-free, supplying <a href="https://github.com/giampierod/mistral-sublime" target="_blank">Sublime plugin</a> for and syntax check. StackStorm’s WebUI (below) brings an efficient representation of workflow executions for [ActionChain][12] and [Mistral][11] workflows. In upcoming releases, we will stand up to a challenge of representing workflow execution plan and visual workflow building.

<img loading="lazy" class="aligncenter wp-image-6108 size-full" src="http://devops.com/wp-content/uploads/2015/04/stackui.jpg" alt="stackui" width="487" height="269" /> 

## Conclusion

StackStorm loves workflows: they are essential for higher-level automation. Customizable CI/CD, autoscaling, automatic failure remediation, automated security response – it is all workflows. Different workflows are optimized differently for different jobs, and there are tastes in play, too. So we made a workflow engine to be a pluggable component. Currently we supply [ActionChain][12] for speed and simplicity, and [Mistral][11] for complex workflow logic and scalable reliable execution.

We liked <a href="https://github.com/pinterest/pinball" target="_blank">Pinball</a>: it is built on simple and powerful abstractions of basic task model and job tokens, it has reliable and scalable architecture, and it provides a good programing interface for workflow and job definitions. We would definitely consider supporting it in StackStorm as it gains maturity and traction.

<p style="color: #6f7072;">
  …
</p>

_ This table summarizes the areas of functionality discussed in the article, however casts no judgement on pragmatic choices each workflow made to optimize for the target usage._

<table>
  <tr>
    <td width="70&quot;">
    </td>
    
    <td width="82">
      Advanced flow control
    </td>
    
    <td width="115">
      Data passing and transforms
    </td>
    
    <td width="80">
      Fault tolerant execution
    </td>
    
    <td width="70">
      YAML/JSON DSL
    </td>
    
    <td width="95">
      Pluggable actions
    </td>
    
    <td width="90">
      Visual Representation
    </td>
  </tr>
  
  <tr>
    <td width="100">
      <a href="https://github.com/pinterest/pinball" target="_blank">Pinball</a>
    </td>
    
    <td width="86">
    </td>
    
    <td width="95">
    </td>
    
    <td width="82">
      +
    </td>
    
    <td width="72">
    </td>
    
    <td width="95">
      +
    </td>
    
    <td width="95">
      +
    </td>
  </tr>
  
  <tr>
    <td width="100">
      <a href="https://github.com/knipknap/SpiffWorkflow/wiki" target="_blank">Spiff</a>
    </td>
    
    <td width="86">
      +
    </td>
    
    <td width="95">
    </td>
    
    <td width="82">
    </td>
    
    <td width="72">
      +
    </td>
    
    <td width="95">
    </td>
    
    <td width="95">
    </td>
  </tr>
  
  <tr>
    <td width="100">
      <a href="https://github.com/spotify/luigi" target="_blank">Luigi</a>
    </td>
    
    <td width="86">
    </td>
    
    <td width="95">
    </td>
    
    <td width="82">
    </td>
    
    <td width="72">
    </td>
    
    <td width="95">
      +
    </td>
    
    <td width="95">
      +
    </td>
  </tr>
  
  <tr>
    <td width="100">
      <a href="https://github.com/ansible/ansible">Ansible</a>
    </td>
    
    <td width="86">
    </td>
    
    <td width="95">
      +
    </td>
    
    <td width="82">
    </td>
    
    <td width="72">
      +
    </td>
    
    <td width="95">
      +
    </td>
    
    <td width="95">
    </td>
  </tr>
  
  <tr>
    <td width="100">
      <a href="http://dray.it/" target="_blank">Dray</a>
    </td>
    
    <td width="86">
    </td>
    
    <td width="95">
    </td>
    
    <td width="82">
    </td>
    
    <td width="72">
      +
    </td>
    
    <td width="95">
    </td>
    
    <td width="95">
    </td>
  </tr>
  
  <tr>
    <td width="100">
      <a href="http://www.openscore.io/#/docs" target="_blank">Score</a>
    </td>
    
    <td width="86">
      +
    </td>
    
    <td width="95">
      +
    </td>
    
    <td width="82">
      +
    </td>
    
    <td width="72">
      +
    </td>
    
    <td width="95">
      +
    </td>
    
    <td width="95">
    </td>
  </tr>
  
  <tr>
    <td width="100">
      <a href="http://docs.stackstorm.com/actionchain.html">ActionChain</a>
    </td>
    
    <td width="86">
    </td>
    
    <td width="95">
      +
    </td>
    
    <td width="82">
    </td>
    
    <td width="72">
      +
    </td>
    
    <td width="95">
      +
    </td>
    
    <td width="95">
    </td>
  </tr>
  
  <tr>
    <td width="100">
      <a href="https://wiki.openstack.org/wiki/Mistral">Mistral</a>
    </td>
    
    <td width="86">
      +
    </td>
    
    <td width="95">
      +
    </td>
    
    <td width="82">
      +
    </td>
    
    <td width="72">
      +
    </td>
    
    <td width="95">
      +
    </td>
    
    <td width="95">
    </td>
  </tr>
</table>

<h3 style="font-weight: 400; color: #6f7072;">
</h3>

### Footnotes and References

_<a href="http://devops.com/features/return-workflows/#_ftnref1" name="_ftn1">[1]</a> Workflow execution model and state is significantly simpler and smaller than the one of a Turing-compliant language, making it practical to persist and restore at every step, at scale._

_<a href="http://devops.com/features/return-workflows/#_ftnref2" name="_ftn2">[2]</a> M$ System Center Orchestrator (formerly Opalis), HP Operations Orchestration (formerly iConclude), BMC Atrium Orchestrator (formerly Realops), CA ITPAM (now dead), VMware vCenter Orchestrator (formerly Dunes), NetIQ Aegis, MaestroDev, Cisco CPO (formerly Tidal), Cisco UCS Director (formerly Cloupia Unified Infrastructure Controller), Citrix Workflow Studio – check them out, see the UIs, and think how they handle 100-step workflow before you cast your judgement._

**The following are the detailed references to the products and tools mentioned in the article for the reader’s convenience.**

  * Pinball, by Pinterest 
      * architecture <https://github.com/pinterest/pinball/blob/master/ARCHITECTURE.rst>
      * intro blog <http://engineering.pinterest.com/post/74429563460/pinball-building-workflow-management>
      * opensoucing Pinball blog <http://engineering.pinterest.com/post/113376157699/open-sourcing-pinball>
      * source https://github.com/pinterest/pinball
  * Spiff Workflow <https://github.com/knipknap/SpiffWorkflow/wiki>
  * Score, by HP: 
      * main page <http://www.openscore.io/#/>
      * docs http://www.openscore.io/#/docs
  * Dray, by CenturyLink <http://dray.it/>
  * Luigi, by Spotify  – <https://github.com/spotify/luigi>
  * Ansible <https://github.com/ansible/ansible>
  * TaskFlow <https://wiki.openstack.org/wiki/TaskFlow>
  * Ozzie from Apache <http://oozie.apache.org/>
  * Azkaban by LinkedIn <http://data.linkedin.com/opensource/azkaban>
  * ActionChain, by StackStorm: <http://docs.stackstorm.com/actionchain.html>
  * Mistral, from OpenStack community <https://wiki.openstack.org/wiki/Mistral> (integrated into [StackStorm][20])

 [1]: http://engineering.pinterest.com/post/113376157699/open-sourcing-pinball
 [2]: http://wiki.openstack.org/wiki/Mistral
 [3]: https://wiki.openstack.org/wiki/TaskFlow
 [4]: http://www.openscore.io/#/
 [5]: http://data.linkedin.com/opensource/azkaban
 [6]: https://github.com/spotify/luigi
 [7]: http://dray.it/
 [8]: http://www.workflowpatterns.com/
 [9]: http://www.workflowpatterns.com/patterns/control/
 [10]: http://www.workflowpatterns.com/patterns/control/basic/wcp3.php
 [11]: https://wiki.openstack.org/wiki/Mistral%20
 [12]: http://docs.stackstorm.com/actionchain.html
 [13]: http://jinja.pocoo.org/
 [14]: https://github.com/stackforge/yaql
 [15]: http://goessner.net/articles/JsonPath/
 [16]: https://github.com/ansible/ansible
 [17]: https://github.com/CenturyLinkLabs/dray/blob/master/job/manager.go#L50
 [18]: http://luigi.readthedocs.org/en/latest/execution_model.html
 [19]: http://taskflow.io/
 [20]: http://stackstorm.com/product/