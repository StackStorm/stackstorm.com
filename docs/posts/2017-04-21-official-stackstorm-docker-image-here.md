---
title: Official StackStorm Docker Image is Here!
author: st2admin
type: post
date: 2017-04-21T19:28:58+00:00
url: /2017/04/21/official-stackstorm-docker-image-here/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5747710901
categories:
  - Blog
  - News
tags:
  - Docker
  - StackStorm

---
<p dir="ltr">
  <strong>Apr 21, 2017</strong><br /> <em>by Warren Van Winckel</em>
</p>

<p dir="ltr">
  <img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2017/04/stackstormondocker.png" alt="StackStorm containers on Docker" class="alignleft wp-image-6761 size-full" width="256" height="182" srcset="https://stackstorm.com/wp/wp-content/uploads/2017/04/stackstormondocker.png 256w, https://stackstorm.com/wp/wp-content/uploads/2017/04/stackstormondocker-150x107.png 150w, https://stackstorm.com/wp/wp-content/uploads/2017/04/stackstormondocker-80x57.png 80w, https://stackstorm.com/wp/wp-content/uploads/2017/04/stackstormondocker-220x156.png 220w, https://stackstorm.com/wp/wp-content/uploads/2017/04/stackstormondocker-141x100.png 141w, https://stackstorm.com/wp/wp-content/uploads/2017/04/stackstormondocker-211x150.png 211w" sizes="(max-width: 256px) 100vw, 256px" />
</p>

<p dir="ltr" id="docs-internal-guid-652d0c46-91d8-b8a9-3e87-43c4134b5709">
  <span>At long last, the official StackStorm Docker image is available on </span><a href="https://hub.docker.com/r/stackstorm/stackstorm"><span>Docker Hub</span></a><span>! Now you can skip the installation hurdles and jump right into evaluating StackStorm, or building automations faster than ever.<br /> </span>
</p>

<p dir="ltr">
  <span>Hello! I’m Warren, one of the newest members of the StackStorm team, and maintainer of the new </span><a href="https://github.com/stackstorm/st2-docker"><span>StackStorm/</span><span>st2-docker</span></a><span> Github repo.</span>
</p>

<p dir="ltr">
  <span>You’ve been asking for StackStorm as a Docker image for a long time. We’ve asked you to use our images, which have served us well internally for our package and build infrastructure. But you deserve something better. Something built especially for you, the user. Here it comes!</span>
</p>

<!--more-->

<p dir="ltr">
  <span>This official image is simple for quick evaluations; convenient for building automations, yet solid enough for light-to-medium production use.</span>
</p>

<p dir="ltr">
  <span>We invited our community docker experts into the <a href="https://stackstorm-community.slack.com/messages/C4QEPNE85/">#docker</a> channel on StackStorm Slack community (</span><a href="https://stackstorm.com/community-signup"><span>you’re welcome to join!</span></a><span>) and we are thankful for everyone’s passionate input. Special thanks to </span><a href="https://gitlab.com/smithx10/st2"><span>Bruce Smith</span></a><span> and </span><a href="https://github.com/shusugmt/docker-st2"><span>Shu Sugimoto</span></a><span>, who have their own implementations and ideas on how to build a docker image for StackStorm. These repositories helped us get going, and ensure we didn’t stray too far from what the community desired.</span>
</p>

<p dir="ltr">
  <span>Why Docker? You know it already, but if you insist, I’ll state the obvious:</span>
</p>

  * <span>Runs consistently across instances, and various host operating systems.</span>
  * <span>Build images once, deploy same image to dev, staging or production.</span>
  * <span>Uses less resources than VM’s such as Vagrant, allowing for denser consolidation.</span>
  * <span>Decouple infrastructure requirements from the application environment.</span>

<p dir="ltr">
  <span>Our current focus is on creating an image that is useful to perform an evaluation of StackStorm in the matter of a few minutes. By design, this image also makes it easy to develop and maintain packs. Let’s jump right in.</span>
</p>

### **How To Use**

<p dir="ltr">
  <span>To give it a quick try, clone </span><span>st2-docker</span><span>, and follow the samples in </span><span style="font-family: terminal,monaco,monospace"><a href="https://github.com/stackstorm/st2-docker">README.md</a></span><span>.</span>
</p>

<p dir="ltr">
  <span style="font-family: terminal,monaco,monospace">  $ git clone <a href="https://github.com/stackstorm/st2-docker">https://github.com/stackstorm/st2-docker</a></span>
</p>

<p dir="ltr">
  <span>Usage is expressed in the </span><span style="font-family: terminal,monaco,monospace">docker-compose.yml</span><span> file for readability. You can run it as is, or translate to </span><a href="https://kubernetes.io"><span>Kubernetes</span></a><span>, </span><a href="https://docs.docker.com/engine/swarm/stack-deploy/"><span>Swarm Stack</span></a><span>, or your favorite orchestration service definition format.<br /> </span>
</p>

<p dir="ltr">
  <span>Here are some of the highlights of our StackStorm image:</span>
</p>

  * <span>Quick, consistent installation. If you’re just trying StackStorm for the first time, no more troubles like “It doesn’t install for me”. If you’re already using Docker, no heart burn on “oh gee, I need to Dockerize it” &#8211; it’s all done for you.</span>
  * <span>It’s ready to go with defaults, but can be configured to fit your needs; explore the Dockerfile to see what you can configure by passing the environment variables.</span>
  * <span>We map an additional pack directory to the host filesystem and refer to it in the StackStorm configuration (<a href="https://www.google.com/url?q=https://docs.stackstorm.com/packs.html%23under-the-hood-pack-basics&sa=D&ust=1492807450522000&usg=AFQjCNG6tSTDnbnqu_VqTlaohG0ntQUqUw" target="_blank" rel="noopener noreferrer">https://docs.stackstorm.com/packs.html#under-the-hood-pack-basics</a>), making it convenient to use your favorite tools to write your StackStorm automations. System packs and the packs from exchange still install under </span><span style="font-family: terminal,monaco,monospace">/opt/stackstorm/packs</span> <span>inside the container.</span>

### **The Future**

<p dir="ltr">
  <span>This is just the beginning. We continue to rapidly improve the implementation and adapt to feedback.</span>
</p>

<p dir="ltr">
  <span>There are many use cases for dockerized StackStorm, and we we know there’s no “one size fits all” solution. For instance, for heavy production loads, a multi-container solution might be a better fit. There are different options for placing Mistral. And for some, even a smaller all-in-one container may be desirable. This work is ongoing.</span>
</p>

<p dir="ltr">
  <span>Are you more inclined to try StackStorm in a Docker container now that it is officially supported? Are there any use cases that we have not considered? We’ve created a <a href="https://stackstorm-community.slack.com/messages/C4QEPNE85/">#docker</a> channel in our </span><a href="https://stackstorm.com/community-signup"><span>Slack community</span></a><span>. That’s probably the best way to contact us, but no matter how you do, we’re looking forward to hearing your thoughts, suggestions, and concerns. </span>
</p>

<p dir="ltr">
  <span>Strong opinions are welcome in the form of a PR. Please start submitting issues against </span><a href="https://github.com/StackStorm/st2-docker"><span>st2-docker</span></a><span>. You will have an influence on how things are implemented.</span>
</p>

<p dir="ltr">
  <span>Let’s continue doing amazing things together!</span>
</p>