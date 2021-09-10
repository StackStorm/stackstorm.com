---
title: 'New Feature: Output Schema'
author: st2admin
type: post
date: 2019-04-10T01:28:58+00:00
url: /2019/04/09/new-feature-output-schema/
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Tutorials
tags:
  - actions
  - output schema

---
_April 9, 2019_  
_by Lindsay Hill_

We added support for [Output Schema][1] in StackStorm 2.9. This feature has been “under the radar” for a while. Time to shed a little light, explain what it is, how to use it, and **why** we added this feature. Read on!

<!--more-->

## Output Schema &#8211; What’s That?

Anyone who has created their own custom [StackStorm action][2] knows all about adding parameters. This defines the expected parameters and their type. For example, the `<a href="https://github.com/StackStorm/st2/blob/master/contrib/examples/actions/orquesta-basic.yam">examples.orquesta-basic</a>` action has this:

<pre class="EnlighterJSRAW" data-enlighter-language="generic" data-enlighter-theme="" data-enlighter-highlight="" data-enlighter-linenumbers="" data-enlighter-lineoffset="" data-enlighter-title="" data-enlighter-group="">parameters:
  cmd:
    required: true
    type: string
  timeout:
    type: integer
    default: 60</pre>

We define the _input_ structure, but we have not defined the _output_ structure. Our action is free to return whatever it wants. This is particularly important for Python actions, which can return any custom object they want.

That’s no big deal when you’re running a single action. But when you are combining multiple actions into a workflow, it’s _really, really_ useful to know what one action’s output looks like, so you can then use it in another action. 

That’s where Output Schema comes in. It lets us define the expected structure of our action _outputs_.

## OK, so How Do I Use It?

The first thing we need to do is enable schema validation. In current versions, this is disabled by default. 

Edit `/etc/st2/st2.conf`, and set this:

<pre class="EnlighterJSRAW" data-enlighter-language="ini" data-enlighter-theme="" data-enlighter-highlight="" data-enlighter-linenumbers="" data-enlighter-lineoffset="" data-enlighter-title="" data-enlighter-group="">[system]
validate_output_schema = True</pre>

Restart all services (`sudo st2ctl restart`).

We’re going to use this simple python action for testing:

<pre class="EnlighterJSRAW" data-enlighter-language="python" data-enlighter-theme="" data-enlighter-highlight="" data-enlighter-linenumbers="" data-enlighter-lineoffset="" data-enlighter-title="" data-enlighter-group="">import sys
import platform

from st2common.runners.base_action import Action


class PrintPythonVersionAction(Action):

    def run(self):
        version = platform.python_version()
        executable = sys.executable

        print('Using Python executable: %s' % (version))
        print('Using Python version: %s' % (executable))


        return { 'version': version,
                 'executable': executable }</pre>

You can see that it will normally return a result object with a `version` and an `executable` string.

So let’s use this metadata:

<pre class="EnlighterJSRAW" data-enlighter-language="raw" data-enlighter-theme="" data-enlighter-highlight="" data-enlighter-linenumbers="" data-enlighter-lineoffset="" data-enlighter-title="" data-enlighter-group="">---
name: python_runner_print_python_version
runner_type: python-script
description: Action which prints version of Python executable which is used.
enabled: true
entry_point: pythonactions/print_python_version.py
parameters: {}
output_schema:
  version:
    type: string
    required: true
  executable:
    type: string
    required: true</pre>

Register the action, then run it. 

<pre class="EnlighterJSRAW" data-enlighter-language="shell" data-enlighter-theme="" data-enlighter-highlight="" data-enlighter-linenumbers="" data-enlighter-lineoffset="" data-enlighter-title="" data-enlighter-group="">vagrant@ubuntu-xenial:~$ st2 run examples.python_runner_print_python_version
.
id: 5ca6d4430761290dc50f1652
status: succeeded
parameters: None
result:
  exit_code: 0
  result:
    executable: /opt/stackstorm/virtualenvs/examples/bin/python
    version: 2.7.12
  stderr: ''
  stdout: 'Using Python executable: 2.7.12
    Using Python version: /opt/stackstorm/virtualenvs/examples/bin/python
    '
vagrant@ubuntu-xenial:~$</pre>

OK, all good so far.

What happens if we change our `return:` line in the Python code?

Let’s make it this:

<pre class="EnlighterJSRAW" data-enlighter-language="python" data-enlighter-theme="" data-enlighter-highlight="" data-enlighter-linenumbers="" data-enlighter-lineoffset="" data-enlighter-title="" data-enlighter-group="">def run(self):
        version = platform.python_version()
        executable = sys.executable

        print('Using Python executable: %s' % (version))
        print('Using Python version: %s' % (executable))


        return { 'version': version }
        # return { 'version': version,
        #          'executable': executable }</pre>

Note how we’re just returning `version` now. 

<pre class="EnlighterJSRAW" data-enlighter-language="shell" data-enlighter-theme="" data-enlighter-highlight="" data-enlighter-linenumbers="" data-enlighter-lineoffset="" data-enlighter-title="" data-enlighter-group="">vagrant@ubuntu-xenial:~$ st2 run examples.python_runner_print_python_version
.
id: 5ca6d4940761290dc50f1655
status: failed
parameters: None
result:
  error: "u'executable' is a required property

Failed validating 'required' in schema['properties'][u'executable']:
    {'additionalProperties': False,
     'properties': {u'executable': {u'required': True,
                                    u'type': u'string'},
                    u'version': {u'required': True, u'type': u'string'}},
     'type': 'object'}

On instance[u'executable']:
    {u'version': u'2.7.12'}"
  message: Error validating output. See error output for more details.
vagrant@ubuntu-xenial:~$</pre>

You can see that schema validation failed &#8211; `executable` is a required property, and we didn’t get that in the result object. So the action failed. If this was part of a workflow, it would take the failure path for that task, or if no failure path was defined, the whole workflow would fail. 

## What’s the Point?

Doesn’t this just add complexity? More config to add when creating a new action?

Yes &#8211; but it is for good reasons. Defining the expected output structure lets us do two things: 

  1. Detect errors earlier, so a workflow can fail when actions don’t behave as expected. The earlier you pick up the error, the less it propagates.
  2. If we know the structure of an action’s _outputs_, we can make it easier to map those to _inputs_ in the next action in our workflow. If you’re creating a workflow in Workflow Designer today, you need to know what the output structure looks like. If this is predefined, we can make this mapping much easier. Watch out for this in a future Workflow Designer update.
    

## What’s Next?

Watch out for `output_schema` to start popping up in packs on [StackStorm Exchange][3]. Try it out with your own packs too. [Let us know][4] if you run into any problems.

In future we will enable output schema validation by default. This will be well-signposted when we do so. We’ll also continue to ignore actions that don’t have any output schema defined.

 [1]: https://docs.stackstorm.com/latest/actions.html#output-schema
 [2]: https://docs.stackstorm.com/actions.html
 [3]: https://exchange.stackstorm.org
 [4]: https://forum.stackstorm.com