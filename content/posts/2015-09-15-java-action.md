---
title: Turning Java App Into StackStorm Action
author: Dmitri Zimine
type: post
date: 2015-09-15T20:45:34+00:00
url: /2015/09/15/java-action/
dsq_thread_id:
  - 4401149862
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Blog
  - Community
  - Home
  - Tutorials
tags:
  - tutorial

---
**September, 11 2015**  
_by Dmitri Zimine_

A StackStorm user with large investment in Java asked us: &#8220;Can I turn my Java code into StackStorm actions, and how?&#8221;

The answer is &#8220;**Yes you can**, in three basic steps&#8221;:

<img loading="lazy" class="alignnone size-full wp-image-4137" style="float: right;" src="http://stackstorm.com/wp/wp-content/uploads/2015/09/java-st2.png" alt="java-st2" width="262" height="123" /> 

  1. Wrap the Java code in a Java console application;
  2. Take the input as command line arguments
  3. For the best results, output formatted JSON to stdout/stderr &#8211; this way StackStorm will auto-parse it so that you reference them with `dotted.notation` in workflows.

<!--more-->

But before diving into details: how StackStorm can leverages Java assets in StackStorm? They become a part of automation library, with unified API, CLI and UI. You combine them via workflows and rules with other actions and sensors &#8211; thousands on <a href="https://exchange.stackstorm.org" target="_blank">StackStorm Exchange</a> and through integration with Chef, Puppet, Git, monitoring, and others. They become part of your auto-remediation, continuous deployment, security responses, or other solutions. Last, but not the least, StackStorm native <a href="https://stackstorm.com/2015/06/24/ansible-chatops-get-started-%F0%9F%9A%80/" target="_blank">ChatOps integration</a> makes your Java actions runnable from Slack or HipChat or IRC, with few lines of configuration. And if you are NOT Java, check out <a href="https://stackstorm.com/2015/04/20/actions-of-all-flavors-in-stackstorm/" target="_blank">Actions of All Flavors</a> &#8211; an excellent tutorial on turning &#8220;any&#8221; script into action.

Now lets get techy and dive into step-by-step details.

<!--more-->

I am using `default` pack in the example below, adjust accordingly if you are creating your Java action in a new pack.

## 1. Sample Java app

This is the simplest Java app that fits our bill: uses an extra party java library, takes cli arguments, and spits out JSON:

<div id="gist25492107" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-myapp-java" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-java  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-myapp-java-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-myapp-java-LC1" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-c"><span class="pl-c">//</span>opt/stackstorm/packs/default/actions/MyApp.java</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-myapp-java-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-c"><span class="pl-c">//</span> Used https://code.google.com/p/json-simple/, download and save as lib/json-simple-1.1.1.jar</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-myapp-java-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">import</span> <span class="pl-smi">org.json.simple.JSONArray</span>;
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-myapp-java-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">import</span> <span class="pl-smi">org.json.simple.JSONObject</span>;
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-myapp-java-LC5" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-myapp-java-LC6" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">class</span> <span class="pl-en">MyApp</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-myapp-java-LC7" class="blob-code blob-code-inner js-file-line">
                  {
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-myapp-java-LC8" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">public</span> <span class="pl-k">static</span> <span class="pl-k">void</span> <span class="pl-en">main</span>(<span class="pl-k">String</span>[] <span class="pl-v">args</span>)
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-myapp-java-LC9" class="blob-code blob-code-inner js-file-line">
                  {
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-myapp-java-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-smi">JSONObject</span> obj <span class="pl-k">=</span> <span class="pl-k">new</span> <span class="pl-smi">JSONObject</span>();
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-myapp-java-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-smi">JSONArray</span> list <span class="pl-k">=</span> <span class="pl-k">new</span> <span class="pl-smi">JSONArray</span>();
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-myapp-java-LC12" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-myapp-java-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-k">for</span> (<span class="pl-smi">String</span> s<span class="pl-k">:</span> args) {
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-myapp-java-LC14" class="blob-code blob-code-inner js-file-line">
                  list<span class="pl-k">.</span>add(s);
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-myapp-java-LC15" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-myapp-java-LC16" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-myapp-java-LC17" class="blob-code blob-code-inner js-file-line">
                  obj<span class="pl-k">.</span>put(<span class="pl-s"><span class="pl-pds">"</span>description<span class="pl-pds">"</span></span>, <span class="pl-s"><span class="pl-pds">"</span>array of arguments<span class="pl-pds">"</span></span>);
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-myapp-java-LC18" class="blob-code blob-code-inner js-file-line">
                  obj<span class="pl-k">.</span>put(<span class="pl-s"><span class="pl-pds">"</span>args<span class="pl-pds">"</span></span>, list);
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-myapp-java-LC19" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-myapp-java-LC20" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-smi">System</span><span class="pl-k">.</span>out<span class="pl-k">.</span>print(obj);
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-myapp-java-LC21" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-smi">System</span><span class="pl-k">.</span>out<span class="pl-k">.</span>println();
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L22" class="blob-num js-line-number" data-line-number="22">
                </td>
                
                <td id="file-myapp-java-LC22" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-myapp-java-L23" class="blob-num js-line-number" data-line-number="23">
                </td>
                
                <td id="file-myapp-java-LC23" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

I place MyApp.java into `/opt/stackstorm/packs/default/actions/`, and the dependency [json-simple-1.1.1.jar][1] under `/opt/stackstorm/packs/default/actions/lib`. You can keep them wherever you like, and adjust the paths on the next step, when defining action metadata.

Compile and make sure it runs:

<pre class="EnlighterJSRAW" data-enlighter-language="null">$ javac -cp lib/&lt;em&gt;:. MyApp.java
$ java -cp lib/&lt;/em&gt;:. MyApp foo bar
{"args":["foo","bar"],"description":"array of arguments"}
</pre>

<span style="line-height: 1.5;">2. Create action</span>

<div id="gist25492107" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-jaction-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-jaction-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-jaction-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-c"><span class="pl-c">#</span> /opt/stackstorm/packs/default/actions/jaction.yaml</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-jaction-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-jaction-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">name</span>: <span class="pl-s">jaction</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-jaction-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s">Sample of running Java.</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-jaction-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">runner_type</span>: <span class="pl-s"><span class="pl-pds">"</span>local-shell-cmd<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-jaction-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">parameters</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-jaction-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">cmd</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-jaction-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-jaction-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>: <span class="pl-s"><span class="pl-pds">"</span>java MyApp {{p1}} {{p2}}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-jaction-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">cwd</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-jaction-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>: <span class="pl-s"><span class="pl-pds">"</span>/opt/stackstorm/packs/default/actions/<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-jaction-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">immutable</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-jaction-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">env</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-jaction-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-jaction-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">CLASSPATH</span>: <span class="pl-s">lib/*:. </span>
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-jaction-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">p1</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-jaction-yaml-LC17" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-jaction-yaml-LC18" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>: <span class="pl-s"><span class="pl-pds">"</span>do<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-jaction-yaml-LC19" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">p2</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-jaction-yaml-LC20" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-jaction-yaml-LC21" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>: <span class="pl-s"><span class="pl-pds">"</span>something<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-jaction-yaml-L22" class="blob-num js-line-number" data-line-number="22">
                </td>
                
                <td id="file-jaction-yaml-LC22" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

You can see, this action meta data as usual. Few notes on &#8220;secret sauce&#8221; that makes it all work:

  1. I use `local-shell-cmd` runner. It runs an arbitrary command, specified by `cmd` parameter. In our case, it is calling Making the `default` parameter \`immutable\` effectively hardcodes it.
  2. `p1` and `p2` are the parameters I define for the action, they are mapped to the input of MyApp in `cmd` parameter.
  3. `cwd`, &#8220;current working directory&#8221;, is where the command will be executed.
  4. `env` lets me add environment variables to the execution context. That&#8217;s exactly what I need to pass `CLASSPATH`. Given that I already set up the `cwd` as the directory where MyApp is located, classpath is relative to it: `lib/*:.`.

Create the action with the following command:

<pre class="EnlighterJSRAW" data-enlighter-language="null">st2 action create /opt/stackstorm/packs/default/actions/jaction.yaml</pre>

## 3. Run action

<div id="gist25492107" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-running_it" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-text  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-running_it-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-running_it-LC1" class="blob-code blob-code-inner js-file-line">
                  foo@bar:/opt/stackstorm/packs/default/actions$ st2 run default.jaction p1=do p2=something
                </td>
              </tr>
              
              <tr>
                <td id="file-running_it-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-running_it-LC2" class="blob-code blob-code-inner js-file-line">
                  .
                </td>
              </tr>
              
              <tr>
                <td id="file-running_it-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-running_it-LC3" class="blob-code blob-code-inner js-file-line">
                  id: 55d3c11b5b64c44adab13f5c
                </td>
              </tr>
              
              <tr>
                <td id="file-running_it-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-running_it-LC4" class="blob-code blob-code-inner js-file-line">
                  status: succeeded
                </td>
              </tr>
              
              <tr>
                <td id="file-running_it-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-running_it-LC5" class="blob-code blob-code-inner js-file-line">
                  result:
                </td>
              </tr>
              
              <tr>
                <td id="file-running_it-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-running_it-LC6" class="blob-code blob-code-inner js-file-line">
                  {
                </td>
              </tr>
              
              <tr>
                <td id="file-running_it-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-running_it-LC7" class="blob-code blob-code-inner js-file-line">
                  "succeeded": true,
                </td>
              </tr>
              
              <tr>
                <td id="file-running_it-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-running_it-LC8" class="blob-code blob-code-inner js-file-line">
                  "failed": false,
                </td>
              </tr>
              
              <tr>
                <td id="file-running_it-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-running_it-LC9" class="blob-code blob-code-inner js-file-line">
                  "return_code": 0,
                </td>
              </tr>
              
              <tr>
                <td id="file-running_it-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-running_it-LC10" class="blob-code blob-code-inner js-file-line">
                  "stderr": "",
                </td>
              </tr>
              
              <tr>
                <td id="file-running_it-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-running_it-LC11" class="blob-code blob-code-inner js-file-line">
                  "stdout": {
                </td>
              </tr>
              
              <tr>
                <td id="file-running_it-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-running_it-LC12" class="blob-code blob-code-inner js-file-line">
                  "args": [
                </td>
              </tr>
              
              <tr>
                <td id="file-running_it-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-running_it-LC13" class="blob-code blob-code-inner js-file-line">
                  "do",
                </td>
              </tr>
              
              <tr>
                <td id="file-running_it-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-running_it-LC14" class="blob-code blob-code-inner js-file-line">
                  "something"
                </td>
              </tr>
              
              <tr>
                <td id="file-running_it-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-running_it-LC15" class="blob-code blob-code-inner js-file-line">
                  ],
                </td>
              </tr>
              
              <tr>
                <td id="file-running_it-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-running_it-LC16" class="blob-code blob-code-inner js-file-line">
                  "description": "array of arguments"
                </td>
              </tr>
              
              <tr>
                <td id="file-running_it-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-running_it-LC17" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
              
              <tr>
                <td id="file-running_it-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-running_it-LC18" class="blob-code blob-code-inner js-file-line">
                  }
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

**Yes, that&#8217;s it!**

And make a note: the output is parsed as JSON &#8211; to make sure, do `st2 execution --json`.

An arbitrary complex java code will follow this exact pattern: wrap in the console app, pass the parameters, refer the location in the action meta data, supply `CLASSPATH` using `env`, optionally, spit out JSON to conveniently refer the output in the workflows.

## Dev note

Creating a Java action in StackStorm is not hard once you know how. But let&#8217;s admit it, it is not intuitive. The right way to do it is to create Java runner that takes care of all the mechanics for you. And contribute this runner to st2.

If someone in the community got the cycles to do it before we get our hands to this task, please let us know; we will guide, help, review and gladly accept. Check out <a href="https://github.com/StackStorm/st2/pulls?utf8=%E2%9C%93&q=is%3Apr+cloudslang+" target="_blank">this PRs</a> where our HP friends contributed a <a href="http://www.cloudslang.io" target="_blank">CloudSlang</a> runner, for hints and directions.

## What&#8217;s next

Explore the other <a href="http://stackstorm.com/category/tutorials" target="_blank">tutorials</a>. Check out <a href="http://docs.stackstorm.com/actions.html" target="_blank">&#8220;Actions&#8221; documentation</a>, and help improve where we miss out.

Come see us in IRC &#8211; <a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">#stackstorm on freenode.org</a>, or join the <a href="http://stackstorm-community.slack.com" target="_blank">stackstorm-community on Slac</a>k for live discussion on this and other topics (<a href="https://stackstorm.com/community-signup" target="_blank">register here</a>).

Enjoy using StackStorm!

 [1]: http://json-simple.googlecode.com/files/json-simple-1.1.1.