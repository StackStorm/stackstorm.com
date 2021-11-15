---
title: StackStorm, Yammer, and cat pictures
author: st2admin
type: post
date: 2016-02-08T18:31:58+00:00
url: /2016/02/08/stackstorm-yammer-cat-pictures/
dsq_thread_id:
  - 4562524599
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Tutorials

---
**February 8, 2016**  
_by Edward Medvedev_

Less than a week ago Microsoft announced a plan to activate Yammer — its corporate social network — for every customer with Office 365 subscription. Yammer will be seamlessly turned on for everyone with a business or education account over the next two months, which means more and more people will rely on it in their daily communication. Pretty exciting!

If you&#8217;re a long-time StackStorm user, chances are you already know what&#8217;s going to happen. After all, we only write articles with words like &#8220;pretty exciting&#8221; in them when we have something great to show, and this one is no exception: today we&#8217;re proud to announce **ChatOps integration with Yammer** for both Community and Enterprise editions of StackStorm!

If you&#8217;re new to ChatOps, it&#8217;s a chat-centric way to enable or extend DevOps — especially when based upon StackStorm. With the help of our powerful rules engine, workflows, and more, you can execute actions from your chat app of choice, keep it visible for your team, and grow your automation patterns over time. Naturally, our own blog has a lot of articles on the topic, like the recent _[On Force Multiplication and Event-driven Automation][1]_ by James Fryman.

<!--more-->

Just like [the last time][2], a charming bot assistant will accompany me in walking you through the installation process. Enter Ancient Psychic Tandem War Elephant.

<center>
  <img src="http://i.imgur.com/ybRZ79d.jpg" />
</center>

&nbsp;

### 1. Yammer account

Your bot will need a separate account and an access token. First, sign up as a new user; that will be your bot&#8217;s account. Activate it and have the profile set up:

![][3] 

Now create a token on <https://www.yammer.com/client_applications>; this step is pretty straightforward. Lastly, make sure your bot is a member or every group you want it to be on, both public and private.

You&#8217;re all set! We can move on to StackStorm.

&nbsp;

### 2. StackStorm installation

Yammer integration is still experimental and takes some extra steps, but it&#8217;s nothing to be afraid of. First, make sure you have a fresh version of StackStorm (currently 1.3.0) installed, and ChatOps fully configured to use any other chat service.

If you&#8217;re doing a fresh install, Yammer won&#8217;t be listed in the Installer UI, so you&#8217;ll have to select any other service to have Hubot installed. You can enter anything you want as credentials: we&#8217;ll overwrite the settings in a moment.

![][4] 

If you already have StackStorm installed, you&#8217;ll have to stop Hubot and update the `stackstorm/hubot` Docker container first:

    service docker-hubot stop
    docker rmi stackstorm/hubot
    docker pull stackstorm/hubot
    service docker-hubot start
    

You&#8217;re all set now. Time to connect Hubot to your Yammer account.

&nbsp;

### 3. Configuring Hubot

StackStorm Hubot container is controlled by the init script at `/etc/init.d/docker-hubot`. Make a backup, then open the script and find the `docker run` line inside `start()`. Depending on the version and the settings it should be around line 68 and look similar to this:

    $docker run \
    --net bridge --detach=true -m 0b -e ST2_AUTH_USERNAME=chatops_bot -e ST2_AUTH_URL=https://aptwe:443/auth -e HUBOT_SLACK_TOKEN=xoxb-18acd902ff28d7aebc778 -e ST2_WEBUI_URL=https://aptwe -e NODE_TLS_REJECT_UNAUTHORIZED=0 -e ST2_AUTH_PASSWORD=x6hgOCD4mWGe9LuOpsXZg0cu4OkCOPNz -e EXPRESS_PORT=8081 -e HUBOT_LOG_LEVEL=debug -e ST2_API=https://aptwe:443/api -e HUBOT_NAME=hubot -e HUBOT_ADAPTER=slack -e HUBOT_ALIAS=! -p 8081:8080 --add-host aptwe:10.0.2.214 \
    --name hubot \
    hubot \
    

Now we&#8217;ll have to change the adapter and add your Yammer token and groups:

  1. Change `HUBOT_ADAPTER` from whatever you have now to `yammer`;
  2. Remove adapter-specific settings like a Slack token;
  3. Add your Yammer token to the list: `-e HUBOT_YAMMER_ACCESS_TOKEN=mytoken`
  4. Add a comma-separated list of the groups: `-e HUBOT_YAMMER_GROUPS=bots,bots-private`

You don&#8217;t have to change anything else. That&#8217;s what your final script should look like:

    $docker run \
    --net bridge --detach=true -m 0b -e ST2_AUTH_USERNAME=chatops_bot -e ST2_AUTH_URL=https://aptwe:443/auth -e ST2_WEBUI_URL=https://aptwe -e NODE_TLS_REJECT_UNAUTHORIZED=0 -e ST2_AUTH_PASSWORD=x6hgOCD4mWGe9LuOpsXZg0cu4OkCOPNz -e EXPRESS_PORT=8081 -e HUBOT_LOG_LEVEL=debug -e ST2_API=https://aptwe:443/api -e HUBOT_NAME=hubot -e HUBOT_ADAPTER=yammer -e HUBOT_YAMMER_ACCESS_TOKEN=mytoken -e HUBOT_YAMMER_GROUPS=bots,bots-private -e HUBOT_ALIAS=! -p 8081:8080 --add-host aptwe:10.0.2.214 \
    --name hubot \
    hubot \
    

Save this script: a future system upgrade might override the settings, so be sure to have a backup. Restart Hubot:

    service docker-hubot restart
    

Now log into your Yammer account and ask the bot for help:

![][5] 

Congratulations! Now you can use StackStorm with Yammer just like you would with any other chat service.

&nbsp;

### 4. Acknowledgement

All this goodness wouldn&#8217;t be possible without the effort of many people contributing into what is now a complete integration story:

  * [Aurélien Thieriot][6], author of the [hubot-yammer][7] adapter. He kindly agreed to let us maintain the module, while remaining a core contributor and the project owner. Pull requests are welcome, as there&#8217;s always work to be done!</p> 
  * [Ron Huang][8] made the adapter compatible with the current Yammer API.

  * [Anthony Shaw][9] of Dimension Data, a valued StackStorm Enterprise customer and a happy Yammer user, brought Yammer to our attention and, in a way, initiated the integration work. In recognition of his contribution over many months of working together we are posting this picture:

<center>
  <img src="http://i.imgur.com/jy6yJBC.png" />
</center>

_StackStorm Enterprise pro-tip: our Enteprise Support plan includes getting a Star Wars picture of your choice featured in our blog._

Finally, Team StackStorm is always available on the [Slack community channel][10] to help answer any of your StackStorm questions and resolve problems.

Love. ❤️

_— Ed_

 [1]: https://stackstorm.com/2016/02/03/on-force-multiplication-and-event-driven-automation/
 [2]: https://stackstorm.com/2015/12/08/stackstorm-1-2-0-the-new-chatops/
 [3]: http://i.imgur.com/XIPx2nd.png
 [4]: http://i.imgur.com/TSsJmqC.png
 [5]: http://i.imgur.com/Gl44LON.png
 [6]: https://github.com/athieriot
 [7]: https://github.com/athieriot/hubot-yammer
 [8]: https://github.com/ronhuang
 [9]: https://github.com/tonybaloney
 [10]: https://stackstorm.com/community-signup