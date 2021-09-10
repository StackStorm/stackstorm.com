---
title: 'StackStorm 2.8: UI Changes, New Workflow Engine, and More'
author: st2admin
type: post
date: 2018-07-10T13:14:00+00:00
url: /2018/07/10/stackstorm-2-8-ui-changes-new-workflow-engine-and-more/
thrive_post_fonts:
  - '[]'
categories:
  - Community
  - News
tags:
  - release
  - release announcement

---
# 2.8 Release Blog

_July 10th, 2018_  
_by Lindsay Hill_

It has been 3 months since our last <del>confession</del> release. That’s why there’s a _lot_ happening in this release. We are very excited to present the first public release of our new workflow engine, Orquesta. The Web UI has a new look & apps, and we’ve added Python 3 action support. We’ve also added metrics collection to help understand **exactly** what your system is doing. Read on for more!

<!--more-->

## New Workflow Engine: Orquesta

We have been busy this year writing a new Workflow engine: Orquesta. This is a new StackStorm-native workflow engine, written by the StackStorm team. We’ve taken what we’ve learned over the years working on Mistral and ActionChains, and improved upon it. We’ve then tightly integrated it with StackStorm.

Why do this, and what does it mean for you? We’ve done it to provide a better, simpler experience for creating, running and debugging complex workflows. Orquesta runs as a StackStorm sub-component, and uses the same configurations, database and log locations as the rest of the StackStorm services. This makes deployment and troubleshooting simpler.

We can also write a new DSL, addressing gaps, and making it easier to understand. We will be able to address all Action Chain & Mistral use-cases, and more.

OK, enough talk about what & why: What does it look like? Here’s an example workflow definition:

<div id="gist90432725" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-orchestra-rollback-retry-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">version</span>: <span class="pl-c1">1.0</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s">></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> A sample workflow that demonstrates how to handle rollback and retry on error. In this example,</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> the workflow will loop until the file /tmp/done exists. A parallel task will wait for some time</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> before creating the file. When completed, /tmp/done will be deleted.</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"></span><span class="pl-ent">vars</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">file</span>: <span class="pl-s">/tmp/<% str(random(1000000, 9999999)) %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">tasks</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">init</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action</span>: <span class="pl-s">core.local cmd="rm -rf <% ctx().file %>"</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">next</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">when</span>: <span class="pl-s"><% succeeded() %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">do</span>: <span class="pl-s">check, create</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC17" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC18" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">check</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC19" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action</span>: <span class="pl-s">core.local</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC20" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">input</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC21" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">cmd</span>: <span class="pl-s">></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L22" class="blob-num js-line-number" data-line-number="22">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC22" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> echo 'Do something useful here.';</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L23" class="blob-num js-line-number" data-line-number="23">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC23" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> if [ ! -e <%<span class="pl-s1"> ctx().file </span><span class="pl-s1">%</span>> ]; then exit 1; fi</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L24" class="blob-num js-line-number" data-line-number="24">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC24" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"></span> <span class="pl-ent">next</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L25" class="blob-num js-line-number" data-line-number="25">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC25" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">when</span>: <span class="pl-s"><% succeeded() %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L26" class="blob-num js-line-number" data-line-number="26">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC26" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">do</span>: <span class="pl-s">delete</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L27" class="blob-num js-line-number" data-line-number="27">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC27" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">when</span>: <span class="pl-s"><% failed() %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L28" class="blob-num js-line-number" data-line-number="28">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC28" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">do</span>: <span class="pl-s">rollback</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L29" class="blob-num js-line-number" data-line-number="29">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC29" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L30" class="blob-num js-line-number" data-line-number="30">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC30" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">rollback</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L31" class="blob-num js-line-number" data-line-number="31">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC31" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action</span>: <span class="pl-s">core.local</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L32" class="blob-num js-line-number" data-line-number="32">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC32" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">input</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L33" class="blob-num js-line-number" data-line-number="33">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC33" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">cmd</span>: <span class="pl-s">></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L34" class="blob-num js-line-number" data-line-number="34">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC34" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> echo 'Rollback something here.';</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L35" class="blob-num js-line-number" data-line-number="35">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC35" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"> sleep 1;</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L36" class="blob-num js-line-number" data-line-number="36">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC36" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-s"></span> <span class="pl-ent">next</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L37" class="blob-num js-line-number" data-line-number="37">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC37" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-ent">when</span>: <span class="pl-s"><% succeeded() %></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L38" class="blob-num js-line-number" data-line-number="38">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC38" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">do</span>: <span class="pl-s">check</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L39" class="blob-num js-line-number" data-line-number="39">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC39" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L40" class="blob-num js-line-number" data-line-number="40">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC40" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">create</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L41" class="blob-num js-line-number" data-line-number="41">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC41" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action</span>: <span class="pl-s">core.local cmd="sleep 3; touch <% ctx().file %>"</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L42" class="blob-num js-line-number" data-line-number="42">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC42" class="blob-code blob-code-inner js-file-line">
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L43" class="blob-num js-line-number" data-line-number="43">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC43" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">delete</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-orchestra-rollback-retry-yaml-L44" class="blob-num js-line-number" data-line-number="44">
                </td>
                
                <td id="file-orchestra-rollback-retry-yaml-LC44" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">action</span>: <span class="pl-s">core.local cmd="rm -f <% ctx().file %>"</span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    
    <div class="gist-meta">
      <a href="https://gist.github.com/LindsayHill/08d100374aae5508bf4ccd2571eaab10/raw/ef637fb4b53e6bce87347c2da24677229fd29851/orchestra-rollback-retry.yaml" style="float:right">view raw</a> <a href="https://gist.github.com/LindsayHill/08d100374aae5508bf4ccd2571eaab10#file-orchestra-rollback-retry-yaml">orchestra-rollback-retry.yaml</a> hosted with &#10084; by <a href="https://github.com">GitHub</a>
    </div>
  </div>
</div>

Pretty easy to follow, right? Written in YAML, and some of the layout & constructs will be recognizable to Mistral users. As with all StackStorm actions, you’ll need to define the metadata. This is very similar to other actions, but with `runner_type: orquesta`

Check the [docs][1] to learn more, and the [examples directory][2] to see more example code.

> Note: Orquesta is currently in public beta. It is stable, but is not yet feature-complete. We’re going to be [adding more features][3] in the next couple of releases. We’re aiming for GA in StackStorm 3.0. Expect to see a **massively** improved Workflow Designer that works with Orquesta then too.

Astute readers will be asking themselves: “What does this mean for Mistral and Action Chains?” In the short term, they are not going anywhere. But in the longer term, they will be deprecated. Don’t worry: There will be plenty of notice before this happens, and we’ll have tools to help convert your workflows.

## Web UI: New Look, New App: Triggers

In January we migrated our Web UI from [Angular to React][4]. We kept the look and feel the same, but promised there was a reason for doing it &#8211; for future developments. The first fruits of that are now visible:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/07/actions.png" alt="" width="2142" height="1048" class="aligncenter size-full wp-image-7972" scale="0" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/07/actions.png 2142w, https://stackstorm.com/wp/wp-content/uploads/2018/07/actions-150x73.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/07/actions-300x147.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/07/actions-768x376.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/07/actions-1024x501.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2018/07/actions-80x39.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/07/actions-220x108.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/07/actions-204x100.png 204w, https://stackstorm.com/wp/wp-content/uploads/2018/07/actions-280x137.png 280w, https://stackstorm.com/wp/wp-content/uploads/2018/07/actions-486x238.png 486w, https://stackstorm.com/wp/wp-content/uploads/2018/07/actions-750x367.png 750w, https://stackstorm.com/wp/wp-content/uploads/2018/07/actions-975x477.png 975w, https://stackstorm.com/wp/wp-content/uploads/2018/07/actions-1190x582.png 1190w" sizes="(max-width: 2142px) 100vw, 2142px" />][5]

Two things you’ll notice when you login: The colors are different, and hey, what’s this “Triggers” icon here?

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers.png" alt="" width="2150" height="1042" class="aligncenter size-full wp-image-7973" scale="0" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers.png 2150w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-150x73.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-300x145.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-768x372.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-1024x496.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-80x39.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-220x107.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-206x100.png 206w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-280x136.png 280w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-491x238.png 491w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-750x363.png 750w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-975x473.png 975w, https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers-1190x577.png 1190w" sizes="(max-width: 2150px) 100vw, 2150px" />][6]

This page is designed to help answer the age-old question: “Why did my rule not fire like I expected?” In earlier versions, you had to work through the [troubleshooting docs][7] to figure out what was going on, tracing trigger-instances, rules logs, etc.

Now you can do this from the Web UI. Let’s take a simple example, the [sample\_rule\_with_webhook][8] rule in the examples pack.

This matches the webhook URL of `/webhooks/sample`, and the criteria is looking for `{“name”: “st2”}` in the body.

First I’ll doing a test with `curl`:

    lindsaysmacbook:~ lhill$ curl -X POST -H  'Connection: keep-alive' -H  'Accept-Encoding: gzip, deflate' -H  'Accept: */*' -H  'User-Agent: python-requests/2.14.2' -H  'X-Auth-Token: 8d6adce7b59c4605ac381d937d0b6e47' -k https://localhost/api/v1/webhooks/sample -H "Content-Type: application/json" --data '{"key1": "value1"}'
    {
        "key1": "value1"
    lindsaysmacbook:~ lhill$
    

My rule says that it should dump the `{{trigger.body}}` contents to `~/st2.webhook_sample.out` file, but that doesn’t exist. What’s happened?

Let’s check the Triggers app, under core.st2.webhook:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_not_enforced.png" alt="" width="1542" height="970" class="aligncenter size-full wp-image-7974" scale="0" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_not_enforced.png 1542w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_not_enforced-150x94.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_not_enforced-300x189.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_not_enforced-768x483.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_not_enforced-1024x644.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_not_enforced-80x50.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_not_enforced-220x138.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_not_enforced-159x100.png 159w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_not_enforced-238x150.png 238w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_not_enforced-378x238.png 378w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_not_enforced-660x415.png 660w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_not_enforced-774x487.png 774w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_not_enforced-946x595.png 946w" sizes="(max-width: 1542px) 100vw, 1542px" />][9]

We can see “Instance has never been enforced” &#8211; that means that we saw something match this trigger, but it didn’t result in any rule enforcement. Clearly we don’t have the right combination of trigger + criteria.

Our rule criteria says this:

        criteria:
            trigger.body.name:
                pattern: "st2"
                type: "equals"
    

In our body we had `{ “key1”: “value1”}`. Let’s try our curl call again:

    lindsaysmacbook:~ lhill$ curl -X POST -H  'Connection: keep-alive' -H  'Accept-Encoding: gzip, deflate' -H  'Accept: */*' -H  'User-Agent: ython-requests/2.14.2' -H  'X-Auth-Token: 8d6adce7b59c4605ac381d937d0b6e47' -k https://localhost/api/v1/webhooks/sample -H "Content-Type: application/json" --data '{"name": "st2"}'
    {
        "name": "st2"
    }lindsaysmacbook:~ lhill$
    

This looks promising:

    root@1f25dbaeb30b:~# ls -l ~stanley/
    total 4
    -rw-r--r-- 1 stanley stanley 18 Jun 29 01:03 st2.webhook_sample.out
    root@1f25dbaeb30b:~# cat ~stanley/st2.webhook_sample.out
    {u'name': u'st2'}
    root@1f25dbaeb30b:~#
    

And now look at our Web UI:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_enforced.png" alt="" width="1540" height="1088" class="aligncenter size-full wp-image-7975" scale="0" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_enforced.png 1540w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_enforced-150x106.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_enforced-300x212.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_enforced-768x543.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_enforced-1024x723.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_enforced-80x57.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_enforced-220x155.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_enforced-142x100.png 142w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_enforced-212x150.png 212w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_enforced-337x238.png 337w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_enforced-587x415.png 587w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_enforced-689x487.png 689w, https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_enforced-842x595.png 842w" sizes="(max-width: 1540px) 100vw, 1540px" />][10]

We can see the rule that matched, and the Enforcement ID.

There are many other smaller changes to all aspects of the Web UI too. Layouts have been adjusted for better usability, widths changed to display more useful content, etc. Expect to see more tweaks here, and more new apps.

Finally, if you have impaired color vision, you’ll appreciate this change: better visual indications of success or failure:

[<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2018/07/success_fail_icons.png" alt="" width="954" height="772" class="aligncenter size-full wp-image-7976" scale="0" srcset="https://stackstorm.com/wp/wp-content/uploads/2018/07/success_fail_icons.png 954w, https://stackstorm.com/wp/wp-content/uploads/2018/07/success_fail_icons-150x121.png 150w, https://stackstorm.com/wp/wp-content/uploads/2018/07/success_fail_icons-300x243.png 300w, https://stackstorm.com/wp/wp-content/uploads/2018/07/success_fail_icons-768x621.png 768w, https://stackstorm.com/wp/wp-content/uploads/2018/07/success_fail_icons-80x65.png 80w, https://stackstorm.com/wp/wp-content/uploads/2018/07/success_fail_icons-220x178.png 220w, https://stackstorm.com/wp/wp-content/uploads/2018/07/success_fail_icons-124x100.png 124w, https://stackstorm.com/wp/wp-content/uploads/2018/07/success_fail_icons-185x150.png 185w, https://stackstorm.com/wp/wp-content/uploads/2018/07/success_fail_icons-294x238.png 294w, https://stackstorm.com/wp/wp-content/uploads/2018/07/success_fail_icons-513x415.png 513w, https://stackstorm.com/wp/wp-content/uploads/2018/07/success_fail_icons-602x487.png 602w, https://stackstorm.com/wp/wp-content/uploads/2018/07/success_fail_icons-735x595.png 735w" sizes="(max-width: 954px) 100vw, 954px" />][11]

## Python 3 Actions

Want to use Python 3 to run StackStorm actions? Now you can! Use the `--python3` flag when running `st2 pack install`. That pack will then use `python3` when creating the virtual environment.

> Note: This is still an experimental, opt-in feature. It does not represent complete StackStorm support for Python 3.

We **are** working on full Python 3 support for the whole platform. We’ve been putting in a lot of work on the backend, updating our code and tests to work with Python 3. Fingers crossed, we’ll have complete GA-ready Python 3 support for the whole platform early next year.

## Miscellaneous

  * **Metrics:** Added metrics for collecting performance and health information about the various ST2 services and functions. Docs and blog post coming soon.
  * **CLI:** All CLI commands now use `/etc/st2/st2.conf` by default.
  * **Jinja:** New Jinja filters `basename` and `dirname`

All the rest of the gory details are in the [changelog][12].

## Install Time

Packages are available in our apt and yum repos. Follow the standard instructions to [install this version][13], or upgrade following the [General Upgrade Procedure][14].

You know the drill by now: backup first.

And as always, thanks to everyone who contributed in some way, with code, bugs, or even just fixing typos in our docs.

 [1]: https://docs.stackstorm.com/orquesta/index.html
 [2]: https://github.com/StackStorm/st2/tree/master/contrib/examples/actions
 [3]: https://docs.stackstorm.com/orchestra/upcoming.html
 [4]: https://stackstorm.com/2018/01/25/new-year-new-stackstorm-v2-6-released/
 [5]: https://stackstorm.com/wp/wp-content/uploads/2018/07/actions.png
 [6]: https://stackstorm.com/wp/wp-content/uploads/2018/07/triggers.png
 [7]: https://docs.stackstorm.com/troubleshooting/rules.html
 [8]: https://github.com/StackStorm/st2/blob/master/contrib/examples/rules/sample_rule_with_webhook.yaml
 [9]: https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_not_enforced.png
 [10]: https://stackstorm.com/wp/wp-content/uploads/2018/07/webhook_enforced.png
 [11]: https://stackstorm.com/wp/wp-content/uploads/2018/07/success_fail_icons.png
 [12]: https://docs.stackstorm.com/changelog.html
 [13]: https://docs.stackstorm.com/install/index.html
 [14]: https://docs.stackstorm.com/install/upgrades.html#general-upgrade-procedure