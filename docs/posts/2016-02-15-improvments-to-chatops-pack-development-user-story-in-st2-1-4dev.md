---
title: Improvements to ChatOps Pack Development User Story in ST2 1.4dev
author: st2admin
type: post
date: 2016-02-15T22:34:17+00:00
url: /2016/02/15/improvments-to-chatops-pack-development-user-story-in-st2-1-4dev/
dsq_thread_id:
  - 4582531158
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Blog
  - Tutorials
tags:
  - chatops
  - StackStorm

---
**February 15, 2016**  
_by <a href="https://uk.linkedin.com/in/jonmiddleton" target="_blank">Jon Middleton</a>, Optimisation Project Lead @ Pulsant Limited_

In the post <a href="https://stackstorm.com/2016/01/25/stackstorm-quicktip-shorten-pack-development-feedback-loop/" target="_blank">StackStorm QuickTip: ChatOps your pack dev workflow</a> James Fryman gave a ChatOPS alias recipe to reduce the friction for deploying packs and then in the _Random Thoughts_ section asked:

> _This action is tied directly to the `packs.install`. What about a workflow? Seems like that would be a better way to structure this._ 

This resonated with me as I had already started working on an internal pack that did just that, as I thought attempting to deploy a pack via an alias (and action) contained within the same pack would be madness (or just lead to interesting race conditions). In the last week, our _Pull Request_ has been merged, documentation has been included in st2docs ([link][1]) for a workflow that fulfils the above random thought and should be released with 1.4.

So introducing `packs.deploy`, an action written in Mistral to handle the mapping of names for Git repositories to the information required to carry out the `packs.install` action.

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2016/02/packs-deplploy-mistral-flow.png" alt="packs-deplploy-mistral-flow" width="948" height="499" class="aligncenter wp-image-5433 size-full" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/02/packs-deplploy-mistral-flow.png 948w, https://stackstorm.com/wp/wp-content/uploads/2016/02/packs-deplploy-mistral-flow-300x158.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/02/packs-deplploy-mistral-flow-768x404.png 768w" sizes="(max-width: 948px) 100vw, 948px" /> 

<!--more-->

## Great! But can I use this to deploy my own Pack(s)?

Yes you can! All you need to do to set up `packs.deploy` so that you can deploy from one of your own repositories is to add the following to `/opt/stackstorm/packs/packs/config.yaml` under `repositories:` for each of your packs.

<my-github-user></my-github-user>

<pre class="EnlighterJSRAW" data-enlighter-language="null">MyAwesomePackRepo:
repo: "https://github.com//my-st2.git"
subtree: true</pre>

&nbsp;

If you don&#8217;t have a `packs` directory, just set `subtree` to `false`.

## Right, I&#8217;ve Done That, How Do I Use it?

The ChatOPS command has been simplifed to the following (as the Git URL is stored in the config file):

<pre class="EnlighterJSRAW" data-enlighter-language="null">! pack deploy {{repo_name}} {{packs}} {{branch=master}} - Download StackStorm packs via ChatOps</pre>

And the ChatOPS responses have been simplified too, so that it&#8217;s using the ChatOPS formatting from StackStorm 1.2:

<a href="http://stackstorm.com/wp/wp-content/uploads/2016/02/image-pack-deploy-awsome.png" rel="attachment wp-att-5432"><img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2016/02/image-pack-deploy-awsome.png" alt="image-pack-deploy-awsome" width="597" height="162" class="aligncenter size-full wp-image-5432" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/02/image-pack-deploy-awsome.png 597w, https://stackstorm.com/wp/wp-content/uploads/2016/02/image-pack-deploy-awsome-300x81.png 300w" sizes="(max-width: 597px) 100vw, 597px" /></a>

## The Cool Stuff! A.k.a. automated deployment

The `packs.deploy` action can also be used for automated deployment, you just need to add the following to the definition above

<pre class="EnlighterJSRAW" data-enlighter-language="null">auto_deployment:
branch: "master"
notify_channel: "my-chatops-channel"
</pre>

And then set up an StackStorm rule that triggers `packs.deploy` with the right parameters (see the docs). There should be an example rule for BitBucket Server merged into the `BitBucket` pack before the release of 1.4). Thus a checkin on _master_ happens the action will run and the following will be posted in your `notify_channel`.

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2016/02/image-auto-deployment-changelog-message.png" alt="image-auto-deployment-changelog-message" width="853" height="112" class="aligncenter size-full wp-image-5431" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/02/image-auto-deployment-changelog-message.png 853w, https://stackstorm.com/wp/wp-content/uploads/2016/02/image-auto-deployment-changelog-message-300x39.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/02/image-auto-deployment-changelog-message-768x101.png 768w" sizes="(max-width: 853px) 100vw, 853px" /> 

## Future Features?

This is another iteration of the pack deployment user story which further reduces friction. What else would be advantageous and supply another incremental reduction of friction?

  * A sensor for GitHub / BitBucket that can detect auto-deployments for repositories that contain more than a single pack and only deploy the ones that have changes.
  * Integration with _Continuous Integration_, so that only packs that pass are deployed.
  * Lock out other users from deploying the same pack from a different branch until it&#8217;s reverted to master, so features being tested are not reverted.
  * A queuing system for requested pack deployments, which informs the user when it&#8217;s their turn to deploy and that they may complete the process via a confirmation.

> @Bot: Say \_alas! ear wax!\_ to complete your deployment of \*AwesomePack\* from \*MyAwesomePackRepo\* branch \_Feature/factor-out-earwax-beans\_.
> 
> @jjm: alas! ear wax!
> 
> @Bot: @jjm: Deploying \*AwesomePack\* from \*MyAwesomePackRepo\* for you&#8230;

  * A rule running from a timer that checks when a non-deployment branch (e.g. _dev_) was deployed, and automatically rolls it back to _master_ after a  
    configured amount of time (e.g. 1 hour).
  * Announcements of new features into _#general_ in a more friendly and descriptive format than a change log.
  * If you&#8217;re using a private repository and using OAuth2 tokens these will be contained in the URL, which will then be placed in chat. This could be worked round  
    with a new conf option and masking it from chat. However the token will still be stored in the Git config, so it may be best to use SSH deployment keys.

 [1]: https://docs.stackstorm.com/latest/chatops/pack_deploy.html