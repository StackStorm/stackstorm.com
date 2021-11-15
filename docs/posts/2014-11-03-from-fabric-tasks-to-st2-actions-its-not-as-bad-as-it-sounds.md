---
title: From Fabric Tasks To StackStorm Actions, It’s Not As Bad As It Sounds
author: st2admin
type: post
date: 2014-11-03T04:52:11+00:00
excerpt: '<a href="/2014/11/02/from-fabric-tasks-to-st2-actions-its-not-as-bad-as-it-sounds/"READ MORE</a>'
url: /2014/11/03/from-fabric-tasks-to-st2-actions-its-not-as-bad-as-it-sounds/
dsq_thread_id:
  - 3184444741
tcb2_ready:
  - 1
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home

---
**November 3, 2014**

_By Patrick Hoolboom_

### Basics

Within the StackStorm <a href="https://github.com/StackStorm-Exchange/exchange-misc/tree/master/fabric" target="_blank">community repo</a> there is a script called metagenerator.py. If you run this script against an existing fabfile, it will generate all the necessary meta data to add the Fabric tasks into St2 as actions. Also included with this integration is an action needed to execute the actions.

To get setup you need to clone this repo to somewhere on your machine:

<pre>git clone https://github.com/StackStorm-Exchange/exchange-misc.git</pre>

Once you have the repo cloned, cd into fabric/actions

<pre>cd exchange-misc/fabric/actions</pre>

<!--more-->

You will now need to copy your fabfile into the lib directory and run the metagenerator.py script

<pre>cp /path/to/fabfile.py lib/
python metagenerator.py
</pre>

Once the script finishes, you will have metadata files for all of your Fabric tasks. If you wish to add additional descriptions to any of the actions or their parameters, you can just edit the appropriate json file. After you are done copy the entire fabric folder into your repo root in St2 (default is /opt/stackstorm) and reload the St2 content.

<pre>cd ../../
cp -R fabric /opt/stackstorm/
st2ctl reload
</pre>

All of your Fab tasks should now show up as actions in the St2 action library.

### How and Why

The end user had built out a fair amount of tasks using Fabric and needed a quick way for St2 to consume them. When I started down this road I wasn&#8217;t sure how exactly I was going to convert many, many Fabric tasks into what we needed to be able to load them in to the system as St2 Actions. Each task needed to be turned in to it&#8217;s own standalone action with a separate metadata file. The trick was, there were a fair number of dependancies in this Fabfile. I decided the best course of action was to script out a solution to generate the metadata for every task along with the expected parameters. I dug in a bit and realized I could key off of the decorators that Fabric uses to identify it&#8217;s tasks. This didn&#8217;t help with the fuction parameters, and they were key to making this actually useful. Due to the nature of how Fabric wraps the callable tasks I wasn&#8217;t able to inspect the args even from the unwrapped task. Instead, I scraped the source from the fabfiles to get the find the function prototypes and broke apart any parameters that were being passed in. Then with some messy scripting I broke them apart and built a dictionary out of them using any default values that were listed in the function definition. A little more mystical equine hackery later, and I actually had a script that would take any Fabfile and convert it into fully consumeable St2 Actions. Now you an leverage your fab actions in a much more collaborative way, while taking full advantage of St2 audit 🙂

If you can&#8217;t tell, I am a bit proud of this one. 🙂

The full metagenerator.py file along with the README.md can be found here:

  * [Exchange Fabric][1]

Please feel free test this out and let me know of any bugs. Either via IRC, or GitHub. If you have improvements, feel free to submit a PR 🙂  
&nbsp;

 [1]: https://github.com/StackStorm-Exchange/exchange-misc/tree/master/fabric