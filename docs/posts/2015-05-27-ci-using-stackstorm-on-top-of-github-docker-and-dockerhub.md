---
title: CI Using StackStorm On Top Of GitHub, Docker And DockerHub
author: st2admin
type: post
date: 2015-05-27T18:28:39+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/05/27/ci-using-stackstorm-on-top-of-github-docker-and-dockerhub/
dsq_thread_id:
  - 3798610826
tcb2_ready:
  - 1
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home
tags:
  - CI/CD
  - Docker
  - GitHub

---
**May 27, 2015**

_by Lakshmi Kannan_

In this blog post, we cover CI part of CICD with Docker as an example. At a high level, this blog post will demonstrate how to create a docker image and push it to a registry on every commit to a github repo. You have probably read our own James Fryman&#8217;s excellent <a style="color: #4183c4;" href="http://stackstorm.com/2015/01/20/continuous-integration-and-delivery-the-stackstorm-way/" rel="noreferrer">blog post</a> on continuous delivery with StackStorm in a more traditional environment. If not, I highly recommend reading it. Also, this recent <a style="color: #4183c4;" href="https://blog.docker.com/2015/05/docker-three-ways-ops/" rel="noreferrer">blog post</a> from docker is a great introduction to using docker in continuous delivery. Before diving into the details, below is some motivation for switching to container based immutable infrastructure.

## <a class="anchor" style="color: #4183c4;" href="https://gist.github.com/lakshmi-kannan/2b95e6bae7dc4ed8c6c7#motivation" rel="noreferrer" name="user-content-motivation"></a>Motivation

As Michael Dehaan of Ansible fame notes, <a style="color: #4183c4;" href="http://michaeldehaan.net/post/118717252307/immutable-infrastructure-is-the-future" rel="noreferrer">immutable infrastructure is the way of the future</a>. Containers (especially, Docker) facilitate this by offering users a way to define their infrastructure through simple files (Dockerfile, for example). The role of orchestration tools changes when dealing with immutable infrastructure. A relevant quote from Michael Dehaan&#8217;s blog:

<p style="padding-left: 30px;">
  <em>&#8220;To keep up, I view orchestration systems as needing to embrace workflow, merging with build systems, producing images, and perhaps attempting to provide those higher “cluster level” APIs prior to clouds more natively doing this.&#8221;</em>
</p>

<!--more-->

We agree with this, and also believe **StackStorm is the right tool** to do this. StackStorm provides a flexible, infrastructure as a code, approach to provide orchestration workflows. With StackStorm, you can define high level tasks as actions and glue these tasks together into a workflow. This will help avoid vendor lock-in. For example, &#8220;spin up this image in a container on a cloud host&#8221; is an abstract task that is still valid irrespective of whether you use &#8220;docker&#8221; or any other format and also whether the host is on AWS or Rackspace or Azure or Google compute. It&#8217;s a good time to checkout some of the packs like _aws_, _azure_, _rackspace_ and _softlayer_ in StackStorm community repo <a style="color: #4183c4;" href="https://exchange.stackstorm.org" rel="noreferrer">StackSTorm Exchange</a>.

## <a class="anchor" style="color: #4183c4;" href="https://gist.github.com/lakshmi-kannan/2b95e6bae7dc4ed8c6c7#bash-vs-stackstorm" rel="noreferrer" name="user-content-bash-vs-stackstorm"></a>Bash vs. StackStorm

Hopefully, with the sensors, rules and actions in those packs you are convinced that StackStorm is the tool you want to invest your time in. Let&#8217;s get to how to get an image built and pushed to a registry now, shall we? To recap, here is what we want to achieve as steps:

<ul class="task-list">
  <li>
    Code lives in a github repo
  </li>
  <li>
    Repo contains a Dockerfile
  </li>
  <li>
    An image should be built on commit to repo. (Tests can be run and image can be built on success)
  </li>
  <li>
    Image should be pushed to dockerhub. (Private registries are easily supported as extension)
  </li>
</ul>

Note that what we have above are vendor specific tasks. You&#8217;d soon realize that you can replace github with BitBucket or any preferred source control system (hosted or on premises). Similar argument can be made for Docker.

To restate the tasks in bash:

<ul class="task-list">
  <li>
    git clone repo
  </li>
  <li>
    cd repo && docker build -t ${TAG}
  </li>
  <li>
    docker push ${REPO}:${TAG}
  </li>
</ul>

At a high level, this is probably three lines of bash script and you&#8217;d go write it. There starts the problem. Let&#8217;s say you want to handle failures on steps and do something different or notify users on slack that an image has been pushed. The three line bash code will now become bigger and unwieldy. You cannot run any of these steps in isolation. You&#8217;d have code duplication of some of these steps in every script you write. These scripts will live on multiple computers without any kind of source control. Of course, not everyone does this but you get the drift. StackStorm solves these problems elegantly. You&#8217;d write StackStorm actions for these steps (Scripts can be migrated to StackStorm actions). These steps can now be run independently. You can also organize them in their respective packs so they can be reused later. You can write a workflow that wires tasks together. This will achieve your end goal.

## <a class="anchor" style="color: #4183c4;" href="https://gist.github.com/lakshmi-kannan/2b95e6bae7dc4ed8c6c7#show-me-the-code" rel="noreferrer" name="user-content-show-me-the-code"></a>Show me the code

You are one persistent person. Thanks for sticking around and reading more. I can hear you saying this.

<img loading="lazy" class="aligncenter size-full wp-image-3282" src="http://stackstorm.com/wp/wp-content/uploads/2015/05/leonardo-gif.jpeg" alt="leonardo gif" width="625" height="472" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/05/leonardo-gif.jpeg 625w, https://stackstorm.com/wp/wp-content/uploads/2015/05/leonardo-gif-300x226.jpeg 300w" sizes="(max-width: 625px) 100vw, 625px" /> 

Let&#8217;s get to it then. Here&#8217;s the git clone action meta.  
``

<pre>---
  name: "git_simple_clone"
  runner_type: "remote-shell-script"
  description: "Clone a git repo"
  enabled: true
  entry_point: "git_simple_clone.sh"
  parameters:
    repo:
      type: "string"
      description: "Git repository to clone"
      required: true
      position: 0
    target:
      type: "string"
      description: "Where to clone the repo to"
      required: true
      position: 1
    dir:
      immutable: true
      default: "/home/stanley/"
    sudo:
      immutable: true
      default: false
    cmd:
      immutable: true
      default: ""
    kwarg_op:
      immutable: true
      default: "--"
</pre>

<span style="line-height: 1.5;">This meta tells us that the script git_simple_clone.sh takes in couple of required arguments namely </span>`repo`<span style="line-height: 1.5;"> and </span>`target`<span style="line-height: 1.5;">. This action is very specific and does one thing. Once you have this action registered (</span><a style="color: #4183c4;" href="https://github.com/StackStorm/st2incubator/blob/master/packs/cicd-docker/actions/git_simple_clone.sh" rel="noreferrer">actual shell script</a><span style="line-height: 1.5;">), you can run it anytime for any repo. You can think about putting this in a </span>`git`<span style="line-height: 1.5;"> pack. Note that in this example, the runner used is a </span>`remote-shell-script`<span style="line-height: 1.5;">. This is done so the script can be run on any host. It is not necessary if you want to run this on same box as </span><a style="color: #4183c4;" href="http://docs.stackstorm.com/runners.html" rel="noreferrer">st2 action runners</a><span style="line-height: 1.5;">.</span>

Feel free to <a style="color: #4183c4;" href="https://github.com/StackStorm/st2incubator/blob/master/packs/cicd-docker/actions/" rel="noreferrer">browse</a> the meta and the scripts for the other tasks.

Now that we have the constituent tasks in StackStorm ready, we can wire them together. Here is the action chain workflow that achieve&#8217;s our goal &#8211; Build a docker image on commit and push it to docker hub on git commit.  
``

<pre>---
  chain:
    -
      name: "git_clone"
      ref: "cicd-docker.git_simple_clone"
      params:
        repo: "{{git_repo}}"
        target: "{{target}}"
        hosts: "localhost"
      on-success: "git_checkout_branch"
      on-failure: "notify_clone_error_slack"
    -
      name: "git_checkout_branch"
      ref: "cicd-docker.git_checkout_branch"
      params:
        target: "{{target}}"
        branch: "{{branch}}"
        hosts: "localhost"
      on-success: "build_docker_image"
      on-failure: "notify_co_error_slack"
    -
      name: "build_docker_image"
      ref: "cicd-docker.build_image"
      params:
        dockerfile_path: "{{dockerfile_path}}/"
        tag: "{{docker_repo}}:{{docker_tag}}"
      on-success: "push_docker_image"
      on-failure: "notify_build_image_failed_slack"
    -
      name: "push_docker_image"
      ref: "cicd-docker.push_image"
      params:
        repo: "{{docker_repo}}"
        tag: "{{docker_tag}}"
      on-success: "notify_image_pushed_slack"
      on_failure: "notify_image_push_failed_slack"
    -
      name: "notify_image_pushed_slack"
      ref: "slack.post_message"
      params:
        message: "Docker image pushed for `{{project}}/{{branch}}`..."
        channel: "#lakshmi"
      on-success: "cleanup_repo"
      on-failure: "cleanup_repo"
    -
      name: "notify_build_image_failed_slack"
      ref: "slack.post_message"
      params:
        message: "Docker build image failed for `{{project}}/{{branch}}`..."
        channel: "#lakshmi"
      on-success: "cleanup_repo"
      on-failure: "cleanup_repo"
    -
      name: "notify_image_push_failed_slack"
      ref: "slack.post_message"
      params:
        message: "Docker image push failed for `{{project}}/{{branch}}`..."
        channel: "#lakshmi"
      on-success: "cleanup_repo"
      on-failure: "cleanup_repo"
    -
      name: "notify_clone_error_slack"
      ref: "slack.post_message"
      params:
        message: "Clone failed  for `{{project}}/{{branch}}`..."
        channel: "#lakshmi"
    -
      name: "notify_co_error_slack"
      ref: "slack.post_message"
      params:
        message: "Checkout failed  for `{{project}}/{{branch}}`..."
        channel: "#lakshmi"
      on-success: "cleanup_repo"
      on-failure: "cleanup_repo"
    -
      name: "cleanup_repo"
      ref: "core.remote"
      params:
        cmd: "rm -rf {{target}}"
        hosts: "localhost"

  default: git_clone
</pre>

Notice that the workflow has notification as tasks too. It uses `slack` pack to post notifications to Slack &#8211; our favorite communication tool. In future releases of StackStorm, we are building out notifications as first class concept for tasks so your workflow will not be as verbose.

For this blog post, we picked action chain because of it&#8217;s simplicity. You can write a `mistral` workflow too (See <a style="color: #4183c4;" href="http://docs.stackstorm.com/mistral.html" rel="noreferrer">our mistral documentation</a> for some examples.). The <a style="color: #4183c4;" href="https://github.com/StackStorm/st2incubator/blob/master/packs/cicd-docker/actions/docker_image_build_and_push.yaml" rel="noreferrer">associated meta for this action chain</a> allows you to run this chain with StackStorm CLI.

<pre>st2 run cicd-docker.docker_image_build_and_push \
    git_repo=git@github.com:lakshmi-kannan/mongo-docker.git \
    project=mongo-docker \
    docker_tag=0.3 \
    docker_repo=lakshmi/mongo-unofficial -a
</pre>

You can also see the progress of the workflow using the CLI by doing an `st2 execution get ${id}`.

<pre>(virtualenv)/m/s/s/st2 git:master$ st2 execution get 55563b5032ed3533611a94d4 --tasks
id: 55563b5032ed3533611a94d4
action.ref: cicd-docker.docker_image_build_and_push
status: running
start_timestamp: 2015-05-15T19:30:40.059640Z
end_timestamp: None
+--------------------------+-----------+---------------------+----------------------+----------------------+
| id                       | status    | task                | action               | start_timestamp      |
+--------------------------+-----------+---------------------+----------------------+----------------------+
| 55563b5032ed3533648a9fcb | succeeded | git_clone           | cicd-docker.git_simp | Fri, 15 May 2015     |
|                          |           |                     | le_clone             | 19:30:40 UTC         |
| 55563b5132ed3533648a9fce | succeeded | git_checkout_branch | cicd-docker.git_chec | Fri, 15 May 2015     |
|                          |           |                     | kout_branch          | 19:30:41 UTC         |
| 55563b5232ed3533648a9fd1 | succeeded | build_docker_image  | cicd-                | Fri, 15 May 2015     |
|                          |           |                     | docker.build_image   | 19:30:42 UTC         |
| 55563b5332ed3533648a9fd4 | running   | push_docker_image   | cicd-                | Fri, 15 May 2015     |
|                          |           |                     | docker.push_image    | 19:30:43 UTC         |
+--------------------------+-----------+---------------------+----------------------+----------------------+
</pre>

If you are not a CLI person and you want a shiny UI, we got you covered. Here&#8217;s some mouth watering screen shots for you:

[UI showing parameters typed in.][1]  
<img loading="lazy" class="aligncenter wp-image-3310 size-large" src="http://stackstorm.com/wp/wp-content/uploads/2015/05/skitch-1024x621.jpeg" alt="skitch" width="1024" height="621" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/05/skitch-1024x621.jpeg 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/05/skitch-300x182.jpeg 300w, https://stackstorm.com/wp/wp-content/uploads/2015/05/skitch-1080x655.jpeg 1080w, https://stackstorm.com/wp/wp-content/uploads/2015/05/skitch.jpeg 1280w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

[UI showing the workflow execution in progress.][2]  
<img loading="lazy" class="aligncenter size-large wp-image-3309" src="http://stackstorm.com/wp/wp-content/uploads/2015/05/skitch-2-1024x621.jpeg" alt="skitch 2" width="1024" height="621" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/05/skitch-2-1024x621.jpeg 1024w, https://stackstorm.com/wp/wp-content/uploads/2015/05/skitch-2-300x182.jpeg 300w, https://stackstorm.com/wp/wp-content/uploads/2015/05/skitch-2-1080x655.jpeg 1080w, https://stackstorm.com/wp/wp-content/uploads/2015/05/skitch-2.jpeg 1280w" sizes="(max-width: 1024px) 100vw, 1024px" /> 

Also if you are into <a style="color: #4183c4;" href="https://www.youtube.com/watch?v=fUpSaEOS_BA" rel="noreferrer">chatops</a>, you can kickoff this workflow from within your chat client. We love us some slack (I meant the tool). If you are a curl person, please use <a style="color: #4183c4;" href="https://github.com/jakubroztocil/httpie" rel="noreferrer">httpie</a>. Oh, I was supposed to say you can use our APIs.

There is only one step remaining &#8211; automation. I walked you through how you would decompose the goal on hand into sub-tasks and how to wire them together to achieve the goal. The goal isn&#8217;t complete until _you_ get away from the picture and let computers do their thing. Your only missing step is a webhook that listens for github events and kicks off the docker image workflow. Here is that rule.

<pre>---
    name: "cicd-docker.github_incoming"
    enabled: true
    description: "Webhook listening for pushes to our CI/CD Pipeline from GitHub"
    trigger:
        type: "core.st2.webhook"
        parameters:
            url: "cicd-docker/github"
    criteria:
        trigger.headers['X-Github-Event']:
            pattern: "push"
            type: "eq"
    action:
        ref: "cicd-docker.docker_image_build_and_push"
        parameters:
            project: "{{trigger.body.repository.name}}"
            branch: "{{trigger.body.ref}}"
            user: "{{trigger.body.pusher.name}}"
            commit: "{{trigger.body.after}}"
            detail_url: "{{trigger.body.compare}}"
</pre>

Note: To operate docker without sudo, it is best to add the system_user in StackStorm (`stanley` is the default.) to be added to docker group. Also for docker push to work, your docker hub credentials should already be available for docker daemon. Otherwise, you might see the workflow hang in last step.

You have basically seen how few YAMLs can essentially replace things like <a style="color: #4183c4;" href="https://www.packer.io/" rel="noreferrer">Packer</a> and <a style="color: #4183c4;" href="http://www.containerfactory.io/#/" rel="noreferrer">Container Factory</a> with tools you are already familiar with &#8211; some bash and some YAML.

## <a class="anchor" style="color: #4183c4;" href="https://gist.github.com/lakshmi-kannan/2b95e6bae7dc4ed8c6c7#what-next" rel="noreferrer" name="user-content-what-next"></a>What next?

Well, hold your horses! We&#8217;ll write a follow up blog post about how to promote these images from being dev ready to staging to production ready. Then you&#8217;ll have continuous delivery (CD) part of CICD. We are building it out ourselves so we can walk you with opinionated ways to do this. We certainly believe StackStorm can help a lot there.

We also video blogged about our <a style="color: #4183c4;" href="https://www.youtube.com/watch?v=W3TvPIlmi98&feature=youtu.be&t=2693" rel="noreferrer">openstack integrations</a> during our automation happy hour. Our happy hours will give you a good idea about using StackStorm for some commonly used infrastructure operations automation. You can follow <a style="color: #4183c4;" href="https://twitter.com/Stack_Storm" rel="noreferrer">@Stack_Storm</a> for our happy hour announcements. Your participation will be so vital to make us (you and us) successful.

If this blog post piqued your interests, good or bad, we believe in community participation and would request you to share feedback either via <a style="color: #4183c4;" href="https://github.com/StackStorm/st2/issues" rel="noreferrer">github issues</a> or <a style="color: #4183c4;" href="http://webchat.freenode.net/?channels=stackstorm" rel="noreferrer">IRC</a>. You&#8217;re welcome to open pull requests.

 [1]: https://www.evernote.com/shard/s209/sh/ecd16227-de1c-450c-8c37-adf2e4f36d38/5ce4af45db8c9148
 [2]: https://www.evernote.com/shard/s209/sh/88a2b0f1-b63e-4f8b-8b4e-d3fbbb3512a0/3ca74f1e648587ee