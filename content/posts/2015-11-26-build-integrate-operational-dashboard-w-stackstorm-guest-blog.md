---
title: Build or Integrate Your Own Operational Dashboard w/ StackStorm (guest blog)
author: st2admin
type: post
date: 2015-11-26T21:08:07+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/11/26/build-integrate-operational-dashboard-w-stackstorm-guest-blog/
dsq_thread_id:
  - 4401340290
tcb2_ready:
  - 1
categories:
  - Blog
  - Community
  - Tutorials
tags:
  - ASP.NET
  - StackStorm

---
**November 26, 2015**  
_by Anthony Shaw of [Dimension Data][1]_

This tutorial will show you how to leverage the power of the StackStorm API to expose your fantastic new workflows built using the Flow (available to Enterprise Edition uses) by [following one of the blogs][2].

In our fictional scenario, we have built 2 complex workflows.

  1. Engage Tractor Beam, this workflow deploys some virtual machines to cloud, uses Hubot to notify the staff and then Puppet to drive the tractor beam.
  2. Open/Close loading bay doors, this workflow takes the desired state of the doors to drive another workflow.

We want to provide our technical operations team with a really simple UI where they can just click these buttons and we hide the magic behind the scenes.

## Starting off

First off, this is a tutorial for ASP.NET 4.5, MVC 5 and WebAPI 2.0, the latest Microsoft Web Development toolkit.

If you want to use another stack, you can follow the patterns here to repeat in another language.

Opening up Visual Studio (here I am using 2013, 2015 would also work), select the ASP.NET Web Application template

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture-1.png" alt="stackstorm-Capture-1" width="941" height="653" class="wp-image-4917 size-full aligncenter" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture-1.png 941w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture-1-300x208.png 300w" sizes="(max-width: 941px) 100vw, 941px" /> 

<span>When prompted, pick out the Single Page Application option, this will install a whole smorgasbord of web-development tools.</span><!--more-->

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture-2.png" alt="stackstorm-Capture-2" width="756" height="568" class="wp-image-4919 size-full aligncenter" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture-2.png 756w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture-2-300x225.png 300w" sizes="(max-width: 756px) 100vw, 756px" /> 

I&#8217;m not going to rely too heavily on these, but if you go ahead and press F5, it&#8217;ll present you with a login screen.

Inside the project Microsoft have already installed a user database and given you a registration system, so you can sign up to your new application by filling in your details.

If you want to replace this authentication mechanism with Active Directory (a more likely replacement in a large org), the provide detailed guides in the readme.

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture2-1024x555.png" alt="stackstorm-Capture2" width="1024" height="555" class="size-large wp-image-4918 aligncenter" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture2-1024x555.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture2-300x163.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture2-1080x586.png 1080w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture2.png 1920w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

<span>At the registration page, fill in some details to get yourself started with your application.</span>

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture3-1024x555.png" alt="stackstorm-Capture3" width="1024" height="555" class="aligncenter wp-image-4920 size-large" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture3-1024x555.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture3-300x163.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture3-1080x586.png 1080w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture3.png 1920w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

<span>Now you&#8217;re logged in, you&#8217;re greeting with this rather useless welcome page.</span>

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture4-1024x555.png" alt="stackstorm-Capture4" width="1024" height="555" class="aligncenter wp-image-4921 size-large" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture4-1024x555.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture4-300x163.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture4-1080x586.png 1080w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture4.png 1920w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

## Installing StackStorm API Client

In Visual Studio, 3rd party packages are distributed via nuget.org. I&#8217;ve been sharing a nuget package for the StackStorm API so I&#8217;ll show you in this tutorial how to use it.

The package is available on [nuget.org][3]

To install the package into your project either use the Nuget Package Manager Console

<pre class="EnlighterJSRAW" data-enlighter-language="null">Install-Package St2.Client</pre>

<span>Or using the GUI you can search for St2.Client under the nuget.org repository and click install.</span>

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture5-1024x630.png" alt="stackstorm-Capture5" width="1024" height="630" class="aligncenter wp-image-4922 size-large" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture5-1024x630.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture5-300x185.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture5-1080x665.png 1080w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture5.png 1288w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

## Simple Example

<span>Now we want to setup a quick API to provide a basic function, so under your controllers directory, add a new controller called ActionController (it will run our actions) </span>

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture6.png" alt="stackstorm-Capture6" width="941" height="653" class="aligncenter wp-image-4923 size-full" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture6.png 941w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture6-300x208.png 300w" sizes="(max-width: 941px) 100vw, 941px" /> 

Back in the StackStorm UI you will already have access to the Examples pack, under this pack you will see a complex workflow action called &#8220;examples.mistral-basic-two-tasks-with-notifications&#8221;.

That is going to be our first action, since it requires no inputs and works every time.

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture7-1024x555.png" alt="stackstorm-Capture7" width="1024" height="555" class="aligncenter wp-image-4924 size-large" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture7-1024x555.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture7-300x163.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture7-1080x586.png 1080w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture7.png 1920w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

<span>In ActionController.cs let&#8217;s write some code to call that workflow as a REST API.</span>

<pre class="EnlighterJSRAW" data-enlighter-language="null">using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Results;
using TonyBaloney.St2.Client;
using TonyBaloney.St2.Client.Models;

namespace ExampleSt2Console.Controllers
{
    [RoutePrefix("api")]
    public class ActionController : ApiController
    {
        private St2Client _st2Client;</pre>

<span>Now, you want to connect to the StackStorm API, so fill in these details of your server. In production you would most likely use an IoC container and inject an ISt2Client instance based on a configuration file, but I&#8217;m not going to bore you with how to do that now.</span>

<pre class="EnlighterJSRAW" data-enlighter-language="null">public ActionController()
{
    _st2Client = new St2Client(
        "https://10.209.120.21:9100", // Auth URL 
        "https://10.209.120.21:9101", // API URL
        "admin",
        "DevAdmin123",
        true); // ignore certificate validation - if using self-signed cert
}</pre>

If you did you and setup a proper certificate when you installed StackStorm, set that last parameter to false.

Now, create a WebAPI action method to engage the tractor beam.

<pre class="EnlighterJSRAW" data-enlighter-language="null">[Route("tractor/engage")]
        [HttpPost]
        public async Task&lt;JsonResult&lt;Execution&gt;&gt; EngageTractorBeam()
        {
            // Get a sign-on token
            await _st2Client.RefreshTokenAsync();

            // Any parameters needed for our action
            Dictionary&lt;string, object&gt; actionParameters = new Dictionary&lt;string, object&gt;();

            // Run our action
            var result = await _st2Client.Executions.ExecuteActionAsync(
                "examples.mistral-basic-two-tasks-with-notifications",
                actionParameters);

            return Json(result);
        }

    }
}</pre>

<span>Now, debug your application by pressing F5 and go to the API link at the top, you&#8217;ll see that WebAPI has documented your new method, so you know it works.</span>

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture8-1024x555.png" alt="stackstorm-Capture8" width="1024" height="555" class="aligncenter wp-image-4925 size-large" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture8-1024x555.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture8-300x163.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture8-1080x586.png 1080w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture8.png 1920w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

<span>Back in Visual Studio, edit the home page contents (Views/Home/_Home.cshtml) to add a link to a function.</span>

<pre class="EnlighterJSRAW" data-enlighter-language="null">&lt;!-- ko with: home --&gt;
&lt;div class="jumbotron"&gt;
    &lt;h1&gt;Rebel Alliance Operations Dashboard&lt;/h1&gt;
    &lt;p class="lead"&gt;This is a dashboard for the technical operations team in the rebel alliance.&lt;/p&gt;
    &lt;p&gt;&lt;a href="http://starwars.net" class="btn btn-primary btn-lg"&gt;Learn more &raquo;&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;
&lt;div class="row"&gt;
    &lt;div class="col-md-6"&gt;
        &lt;h2&gt;Ship Engagement&lt;/h2&gt;
        &lt;p&gt;Actions related to foreign ship engagement.&lt;/p&gt;
        &lt;p data-bind="text: myHometown"&gt;&lt;/p&gt;

        &lt;p&gt;&lt;a data-bind="click: engageTractorBeam" class="btn btn-default" href="#"&gt;Engage Tractor Beam &raquo;&lt;/a&gt;&lt;/p&gt;
    &lt;/div&gt;
    ...
&lt;/div&gt;

&lt;!-- /ko --&gt;</pre>

<span>Now in Scripts/app/home.viewmodel.js if you edit the file and add our action to call the API.</span>

<pre class="EnlighterJSRAW" data-enlighter-language="null">function HomeViewModel(app, dataModel) {
    var self = this;

    self.myHometown = ko.observable("");

    Sammy(function () {
        this.get('#home', function () {
            // Make a call to the protected Web API by passing in a Bearer Authorization Header
            $.ajax({
                method: 'get',
                url: app.dataModel.userInfoUrl,
                contentType: "application/json; charset=utf-8",
                headers: {
                    'Authorization': 'Bearer ' + app.dataModel.getAccessToken()
                },
                success: function (data) {
                    self.myHometown('Your Hometown is : ' + data.hometown);
                }
            });
        });
        this.get('/', function () { this.app.runRoute('get', '#home') });
    });

    self.engageTractorBeam = function() {
        $.ajax({
            method: 'post',
            url: '/api/tractor/engage',
            contentType: "application/json; charset=utf-8",
            headers: {
                'Authorization': 'Bearer ' + app.dataModel.getAccessToken()
            },
            success: function (data) {
                alert('engaged!');
            }
        });
    }
    ...</pre>

<span>Hit F5 then you&#8217;ll see we have our nice dashboard</span>

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture9-1024x555.png" alt="stackstorm-Capture9" width="1024" height="555" class="aligncenter wp-image-4926 size-large" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture9-1024x555.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture9-300x163.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture9-1080x586.png 1080w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture9.png 1920w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

<span>and click that button to engage the tractor beam.</span>

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture10-1024x555.png" alt="stackstorm-Capture10" width="1024" height="555" class="aligncenter wp-image-4927 size-large" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture10-1024x555.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture10-300x163.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture10-1080x586.png 1080w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture10.png 1920w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

<span>There it goes, now let&#8217;s checkout the StackStorm UI and make sure that actually ran our workflow. In the history window you&#8217;ll see it. Check out the output and make sure it was successful.</span><img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture11-1024x555.png" alt="stackstorm-Capture11" width="1024" height="555" class="aligncenter wp-image-4928 size-large" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture11-1024x555.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture11-300x163.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture11-1080x586.png 1080w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture11.png 1920w" sizes="(max-width: 1024px) 100vw, 1024px" />

## Complex Example

Let&#8217;s work on a more complex example, we have an action, &#8220;exampes.mistral-basic&#8221; that requires a parameter, `cmd`, which is the command to run.

Let&#8217;s use that command to open and close our loading bay doors

<pre class="EnlighterJSRAW" data-enlighter-language="null">...
    &lt;div class="col-md-6"&gt;
        &lt;h2&gt;Ship Engagement&lt;/h2&gt;
        &lt;p&gt;Actions related to foreign ship engagement.&lt;/p&gt;
        &lt;p data-bind="text: myHometown"&gt;&lt;/p&gt;

        &lt;p&gt;&lt;a data-bind="click: engageTractorBeam" class="btn btn-default" href="#"&gt;Engage Tractor Beam &raquo;&lt;/a&gt;&lt;/p&gt;
    &lt;/div&gt;

    &lt;div class="col-md-6"&gt;
        &lt;h2&gt;Loading Bay Doors&lt;/h2&gt;
        &lt;p&gt;
            Operations related to the loading bay doors.
        &lt;/p&gt;
        &lt;p&gt;&lt;a data-bind="click: openLoadingDoors" class="btn btn-success" href="#"&gt;Open &raquo;&lt;/a&gt;&lt;/p&gt;
        &lt;p&gt;&lt;a data-bind="click: closeLoadingDoors" class="btn btn-warning" href="#"&gt;Close &raquo;&lt;/a&gt;&lt;/p&gt;
    &lt;/div&gt;
...</pre>

<span>Back in the view model, call the new API methods to include a data in the POST message with the desired door state.</span>

<pre class="EnlighterJSRAW" data-enlighter-language="null">...
self.openLoadingDoors = function () {
    $.ajax({
        method: 'post',
        url: '/api/doors/set',
        headers: {
            'Authorization': 'Bearer ' + app.dataModel.getAccessToken()
        },
        data: '=open' ,
        success: function (data) {
            alert(data.status);
        }
    });
}
self.closeLoadingDoors = function () {
    $.ajax({
        method: 'post',
        url: '/api/doors/set',
        headers: {
            'Authorization': 'Bearer ' + app.dataModel.getAccessToken()
        },
        data: '=close',
        success: function (data) {
            alert(data.status);
        }
    });
}
...</pre>

<span>Then finally we&#8217;ll add our new API action controller</span>

<pre class="EnlighterJSRAW" data-enlighter-language="null">...
[Route("doors/set")]
[HttpPost]
public async Task&lt;JsonResult&lt;Execution&gt;&gt; SetDoorState([FromBody]string state)
{
    // Get a sign-on token
    await _st2Client.RefreshTokenAsync();
</pre>

<span>Now you need to assemble the collection of parameters for the action, this is a dictionary for convenience</span>

<pre class="EnlighterJSRAW" data-enlighter-language="null">// Any parameters needed for our action
// NB: This is really really really insecure. Just an example!
Dictionary&lt;string, object&gt; actionParameters = new Dictionary&lt;string, object&gt;
{
    {"cmd", "echo 'Setting doors to " + state + "'"}
};</pre>

<span>Then run the action using the same function as before.</span>

<pre class="EnlighterJSRAW" data-enlighter-language="null">// Run our action
Execution result = await _st2Client.Executions.ExecuteActionAsync(
    "examples.mistral-basic",
    actionParameters);

string executionId = result.id;</pre>

<span>This time, instead of just firing back the execution reference, let&#8217;s wait for it to finish.</span>

<pre class="EnlighterJSRAW" data-enlighter-language="null">// Wait to complete.
    while (result.status == "running" || result.status == "requested") 
    {
        result = await _st2Client.Executions.GetExecutionAsync(executionId);

        Thread.Sleep(20);
    }

    return Json(result);
}</pre>

<span>Now hit F5 and test it out. Click Open to test the function..</span>

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture12-1024x555.png" alt="stackstorm-Capture12" width="1024" height="555" class="aligncenter wp-image-4929 size-large" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture12-1024x555.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture12-300x163.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture12-1080x586.png 1080w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture12.png 1920w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

&nbsp;

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture14-1024x555.png" alt="stackstorm-Capture14" width="1024" height="555" class="aligncenter wp-image-4931 size-large" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture14-1024x555.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture14-300x163.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture14-1080x586.png 1080w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture14.png 1920w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

&nbsp;

<span>Check in StackStorm UI to make sure it succeeded.</span>

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture13-1024x555.png" alt="stackstorm-Capture13" width="1024" height="555" class="aligncenter wp-image-4930 size-large" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture13-1024x555.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture13-300x163.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture13-1080x586.png 1080w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture13.png 1920w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

&nbsp;

<span>And if you expand the result data on the right-hand panel you can see the full result.</span>

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture15-1024x555.png" alt="stackstorm-Capture15" width="1024" height="555" class="aligncenter wp-image-4932 size-large" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture15-1024x555.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture15-300x163.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture15-1080x586.png 1080w, https://stackstorm.com/wp/wp-content/uploads/2015/11/stackstorm-Capture15.png 1920w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

This toolkit gives you a way of interfacing with StackStorm from .NET, if you&#8217;re using PowerShell or want to script these actions, checkout my PowerShell command library for StackStorm on [powershellgallery.com][4]

Happy hacking.

p.s. StarWars is copyright of LucasFilm/Disney.

&nbsp;

 [1]: http://www.dimensiondata.com
 [2]: https://stackstorm.com/2015/10/02/tutorial-of-the-week-cassandra-auto-remediation/
 [3]: https://www.nuget.org/packages/St2.Client/
 [4]: https://www.powershellgallery.com/packages/St2.Client/