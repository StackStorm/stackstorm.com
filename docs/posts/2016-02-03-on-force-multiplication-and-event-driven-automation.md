---
title: On Force Multiplication and Event Driven Automation
author: st2admin
type: post
date: 2016-02-03T17:31:09+00:00
url: /2016/02/03/on-force-multiplication-and-event-driven-automation/
dsq_thread_id:
  - 4548679006
categories:
  - Blog
  - Tutorials

---
**February 3, 2016**  
By James Fryman

Recently, I have found myself reflecting on the statement &#8220;Be a force multiplier&#8221;. This usually comes to mind when faced with some sort of burn-out: hearing in indirectly from a colleauge or friend, or experiencing it first hand. The intent is good and aligns well with some core tenants of DevOps. Force multiplication fits into the DevOps ethos by encouraging the need to cross-train and collaborate. By working together and sharing knowledge about respective domains (Development or Operations), team members gain empathy for each other. This in turn has a downstream effect of now enabling better collaboration around the repair/growth/operation/expansion of the delivery pipeline.

The only challenge that I have seen over and over again is that by the time that this idea of &#8220;force multiplication&#8221; is needed in a team, one or more major bottlenecks exist. These bottlenecks are often real and a result of an imbalance of resources. Servers arriving faster than there are resources to rack/stack/configure/turn-up. DBAs cannot handle the number of schema changes needed to be reviewed/tested/deployed. Developers must wait on a certain person or persons who have access to publish a package before it can &#8220;go live&#8221;. You probably have your own bottleneck that you see very clearly in your own mind.

<!--more-->

The next question: Have you (or someone you know) attempted to be a &#8220;force multiplier&#8221;? The answer always is complex, but a there is always a common theme in noble attempts at team cleanup: lack of training. Think about it: have you been taught how to be a force multiplier? How to build well formed teams? How to effectively pass on knowledge? To compound issues even further, our current incentive structure actually celebrates the &#8220;Heroes&#8221; and &#8220;Unicorns&#8221; of the world, calling out these as examples of success. Our economy rewards those first to market, and team building and normalization is often not on high priority for budding startups of today. Unless improvement efforts have _direct impact_ to the bottom line, then it often is not a priority. The folks that are brave enough to still even take on the challenge of being a &#8220;Force Multiplier&#8221; in these conditions often find little success because knowledge transfer must happen in synchronous fashions: code-pairing, over-the-shoulder demonstrations, etc. These are expensive activities in both time and energy. Opportunity cost is now lost because one resource is cross-training another. Eventually the benefics will be realized, but not today&#8230;

The amount of work is too large. As a result, the can is kicked down the road until such a time that the pain is unbearable and something _must_ be done. At this point, everyone wants to burn down the offending code and start again. But next time, we&#8217;ll learn. We won&#8217;t make the same mistakes we did last time.

## Bite-sized changes

The problem is that when looking at the road in front of you, you&#8217;re constantly optimizing for the next day or week as opposed to months and years ahead. In the world of quarterly returns, this is the incentive that drives us. Thus, by the time problems are real problems, it is easy to immediatly begin the bikeshed conversation and begin designing v2. The next step is to re-adjust what the optimization factor. Growing the meat-cloud and getting additional resources often takes too long (3-6+ month onboard), the time cost of cross-training can be too much, and over-working resources can only go so far. What is the answer?

> Level the playing field 

One of the ideas that I share around ChatOps and Event Driven Automation is to [expose small tasks to users][1]. By doing this, you allow team members and others in your company to &#8220;consume&#8221; actions that you curate. As the curator, you can expose safe actions to users and allow them to do things once relegated to a single individual or team. I&#8217;d like to share a real-world story with you and show you how we solved it.

## Bottlenecks at StackStorm

Recently, our team was bottlenecked in releasing updates to our Puppet module for StackStorm. The team could make changes all day long in the test environment, but to get changes out to the world was dependent on a single person releasing code to the Puppet Forge. Non-ideal. Let&#8217;s break it down. To release a module to the forge, a user must know:

  * Know how to make a change to the puppet module. 
      * Update module itself
      * Update metadata
      * Update git repository (tags)
  * Know how properly package up the module for release to the forge
  * Know the credentials for the Puppet Forge.

At face value, this seems minor. Throw these commands into a README, and let others just copy/paste commands. But, my team is not full of Puppet experts. They are developers, eager to help solve interesting problems. But, because of this barrier to release, the natural reaction was to shy away from making changes. Not at all because of capability or willingness, but to avoid the pain of friction involved with releasing the code. This meant that any change to the codebase usually required at least two people (change and release). Likewise, any changes that were small or simple&#8230; naturally got relegated to Puppet people because they knew how to manage the debt and navigate the waters.

Intead, let&#8217;s sprinkle some magic ChatOps dust.

### The Setup

First, let&#8217;s setup our user interface: ChatOps. UX is a topic that will come up over and over again with ChatOps, so the best place to begin is to decide how to expose commands to colleagues and users. The first thing to setup is the ChatOps Alias.

    ---
    name: "publish-puppet-st2"
    description: "Release puppet-st2"
    action_ref: "stackstorm.publish-puppet-st2"
    formats:
      - "puppet publish puppet-st2 {{branch}}"
    
    

Source: [https://github.com/stackstorm-packs/st2-publish\_puppet\_forge/blob/master/aliases/publish-puppet-st2.yaml][2]

I want an all-encompasing command that a user should have to input a minimal amount of information toward. The goal is to have a big red button that can be mashsed, and magically a Puppet module is released. This should now happen anytime a user types in `!puppet publish puppet-st2 <somebranch>`, StackStorm will run the `stackstorm.publish-puppet-st2` action with the `branch` attribute set to whatever the user types in. We choose to re-use the `puppet` namespace since it is already populated with similar actions.

The next step is to setup some accompanying Action Metadata for the new `stackstorm.publish-puppet-st2` action. We&#8217;ll want this to run a new workflow that will take care of all the actions we discussed above. The only variable that I need to get from the user is the `branch` parameter, so writing the [metadata should be a snap][3]. We&#8217;ll only take a look at the workflow today.

    ---
    vars:
      run_host: 'localhost'
      repo_dir: '/tmp/puppet-st2'
      repo_url: 'git@github.com:StackStorm/puppet-st2.git'
      forge_file: '~/.puppetforge.yml'
      forge_username: '{{ system.puppetforge_username }}'
      forge_password: '{{ system.puppetforge_password }}'
    chain:
      -
        name: 'clone-puppet-module-from-git'
        ref: 'core.remote'
        params:
          cmd: 'git clone {{ repo_url }} {{ repo_dir }} -b {{ branch }}'
          hosts: '{{ run_host }}'
        on-success: 'bootstrap-puppet-module'
        on-failure: 'cleanup'
      -
        name: 'bootstrap-puppet-module'
        ref: 'core.remote'
        params:
          hosts: '{{ run_host }}'
          cmd: 'bundle install'
          cwd: '{{ repo_dir }}'
        on-success: 'cleanup-vendored-gems'
        on-failure: 'cleanup'
      -
        name: 'cleanup-vendored-gems'
        ref: 'core.remote'
        params:
          hosts: '{{ run_host }}'
          cmd: 'rm -rf vendor'
          cwd: '{{ repo_dir }}'
        on-success: 'set-puppetforge-credentials'
        on-failure: 'cleanup'
      -
        name: 'set-puppetforge-credentials'
        ref: 'core.remote'
        params:
          hosts: '{{ run_host }}'
          cmd: "echo \"---\nurl: https://forgeapi.puppetlabs.com\nusername: {{ forge_username }}\npassword: {{ forge_password }}\" > {{ forge_file }}"
        on-success: 'tag-puppet-module'
        on-failure: 'cleanup'
      -
        name: 'tag-puppet-module'
        ref: 'core.remote'
        params:
          cmd: 'bundle exec rake module:tag'
          hosts: '{{ run_host }}'
          cwd: '{{ repo_dir }}'
        on-success: 'build-puppet-module'
        on-failure: 'cleanup'
      -
        name: 'build-puppet-module'
        ref: 'core.remote'
        params:
          cmd: 'bundle exec rake build'
          hosts: '{{ run_host }}'
          cwd: '{{ repo_dir }}'
        on-success: 'upload-module-to-forge'
        on-failure: 'cleanup'
      -
        name: 'upload-module-to-forge'
        ref: 'core.remote'
        params:
          cmd: 'bundle exec rake module:push'
          hosts: '{{ run_host }}'
          cwd: '{{ repo_dir }}'
        on-success: 'push-git-tags'
        on-failure: 'cleanup'
      -
        name: 'push-git-tags'
        ref: 'core.remote'
        params:
          cmd: 'git push origin --tags'
          hosts: '{{ run_host }}'
          cwd: '{{ repo_dir }}'
        on-success: 'cleanup'
        on-failure: 'cleanup'
      -
        name: 'cleanup'
        ref: 'core.remote'
        params:
          hosts: '{{ run_host }}'
          cmd: 'if [ -d {{ repo_dir }} ]; then rm -rf {{ repo_dir }}; fi'
        on-success: 'remove-puppetfile-credentials'
        on-failure: 'remove-puppetfile-credentials'
      -
        name: 'remove-puppetfile-credentials'
        ref: 'core.remote'
        params:
          hosts: '{{ run_host }}'
          cmd: 'if [ -f {{ forge_file }} ]; then rm -rf {{ forge_file }}; fi'
    

Source: [https://github.com/stackstorm-packs/st2-publish\_puppet\_forge/blob/master/actions/workflows/publish-puppet-st2.yaml][4]

At the top of the file includes our `vars` section. The `puppet-blacksmith` application was not built to be run with multiple users, so our workflow needs to be able to adapt. As such, we need to know that the gem will expect a credential file (`forge_file`) with a username (`forge_username`) and password (`forge_password`). We also need to know where our staging directory is (`repo_dir`), where the upstream target is (`repo_url`). Simple enough. The next few steps, `clone-puppet-module-from-git`, `bootstrap-puppet-module`, `cleanup-vendored-gems`, and `set-puppetforge-credentials` ensure the build host is setup properly. These actions serially download the repository from Upstream, runs all bootstrap commands, attempts to ensure a prestine directory, and then sets up the `puppet-blacksmith` forge file. At this point, nothing has actually been done. Just some preparation. It&#8217;s important to note the 3rd step here (`cleanup-vendored-gems`). This was a small step that was often forgotten, and ended up creating archives in the size of Megabytes as opposed to Kilobytes which is more reasonable and expected.

The final steps, `tag-puppet-module`, `build-puppet-module`, `upload-module-to-forge`, and `push-git-tags`, are where the bulk of work occurs.The next steps are focused on running several rake tasks, as well as then tagging the git repository and re-publishing the package upstream. Most of these actions were enabled by the `puppet-blacksmith` gem, but now are encapsulated in a nice workflow that is easily consumable.

And sure enough, if you build it, they will come&#8230;

![https://cloud.githubusercontent.com/assets/20028/12429874/3f5246de-beb2-11e5-8c7c-ffd595575100.png][5] 

![(https://cloud.githubusercontent.com/assets/20028/12429875/3f536e1a-beb2-11e5-8fc2-e340758daca7.png][6] 

Techniques like this directly enable force multiplication within your team. Essentially, your role shifts from a person &#8220;responsible&#8221; for delivering to the person for &#8220;enabling&#8221; delivery. This is a very small example, but powerful. Enabling others on your team to be a force multiplier enables them to keep working, enables you to focus on more important things, and also creates a new degree of transparency that may not have existed before. Everyone knows when software is released, anyone has the ability to do this. Add up enough of these small building blocks, and suddenly team members are more apt to take risk and help drive change knowing there is a safety net behind them.

## Worth Consideration

Two very interesting points were presented to me that are worth discussion here:

> Agile Manifesto, rule #1: Individuals and interactions over processes and tools. Tools that tries to enforce a workflow of a human? GTFO! 

How far does this paridigm extend? For sure, &#8220;process&#8221; is the worst. When invoked, it usually means a large amount of paperwork or rules that must be strictly adhered to. Downside is that many of said process is manual in nature, and as a result error-prone. Likewise, companies that implement a tool before either _understanding what they want to acheive_ or at the very least, [_defining a set of principles_][7], tools end up shaping how the company works as opposed to the other way around. The point here is that humans are in charge.

Agreed. What is unreasonable here is the underlying expecation that exists here and across the IT industry: technologists must know an immense amount about an immense number of things. Even in my own domains of expertise, I can think of nothing more demotivating than trying to remember how to deploy code that I haven&#8217;t touched in 3+ months. Eventually I&#8217;ll remember, but it&#8217;s a drag and introduces unnecessary friction. Now, play that out in a larger team and multiply.

> I will become redundant 

I have yet to see this happen. What instead happens is collaboration. Developers can focus on shipping and keeping their code up-to-date without bugging operations, and operations can care about aggregate problems (capacity, power, storage) as opposed to transactional tasks like &#8220;push this code&#8221; or &#8220;reset this password&#8221;. Most devs I know are not afraid to get dirty, but its not where they would rather spend time. Devs wanna develop. If you can enable them with better tools to do exactly that, everyone wins. The glucose you were once burning on smaller tasks can and often do become self-service, and you get to go and create even more cool interfaces for users to consume.

## Wrap Up

Bottlenecks exist. They can and will continue to pop up as companies grow and expand. Sometimes you may find yourself in a situation where bottlenecks accumuluate over time as a result of technical debt, while othertimes you join a new team and that debt may already be gaining interest on amounts owed. Either way, the situation exists where something needs to be done. Instead of going directly for the RPG, burning down the house and starting over, consider smaller approaches to enable others to do the things you do.

Some thoughts to take with you today:

  * Tend your technology garden: curate, don&#8217;t operate
  * Make small, transparent changes for lasting effect
  * Grow it together: don&#8217;t control the change

Until next time!

 [1]: https://youtu.be/37LmuHToYjQ?t=19m23s
 [2]: https://github.com/stackstorm-packs/st2-publish_puppet_forge/blob/master/aliases/publish-puppet-st2.yaml
 [3]: https://github.com/stackstorm-packs/st2-publish_puppet_forge/blob/master/actions/publish-puppet-st2.yaml
 [4]: https://github.com/stackstorm-packs/st2-publish_puppet_forge/blob/master/actions/workflows/publish-puppet-st2.yaml
 [5]: https://cloud.githubusercontent.com/assets/20028/12429874/3f5246de-beb2-11e5-8c7c-ffd595575100.png
 [6]: https://cloud.githubusercontent.com/assets/20028/12429875/3f536e1a-beb2-11e5-8fc2-e340758daca7.png
 [7]: http://blog.websages.com/2010/12/10/jameswhite-manifesto/