---
title: Using StackStorm to Auto-Invite Users to a Slack Organization
author: st2admin
type: post
date: 2015-07-01T01:45:41+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/06/30/using-stackstorm-to-auto-invite-users-to-a-slack-organization/
dsq_thread_id:
  - 3893799200
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home

---
**June 30, 2015**  
_by Patrick Hoolboom_

Slack is an amazing tool but sending invitations was a little bit of a pain point for us. So we figured (like we do), let&#8217;s automate it! Before we dig in to how we did this, if you haven&#8217;t signed up for the StackStorm-Community, do it now: <a href="https://stackstorm.com/community-signup" target="_blank">StackStorm-Community </a>

## [][1]{#user-content-a-shout-out.anchor}A Shout Out

First, I&#8217;d like to thank the academy&#8230;wait&#8230;wrong speech. In all seriousness, I found the following blog and it made writing these automation so simple. I have to give credit where credit is due:

<a href="https://levels.io/slack-typeform-auto-invite-sign-ups/" target="_blank">levels.io/slack-typeform-auto-invite-sign-ups</a>

So go tweet at him, or send him chocolates or ponies. He deserves it!

<!--more-->

## [][2]{#user-content-why.anchor}Why?

We have been using Slack for internal communication for quite a while now. We love it. The search functionality, the doc uploads, all of it is fantastic for us. As we began maturing our ChatOps story, we did almost all of that development work through Slack.

Conversely, a majority of our customer interactions were done via Google Groups or our IRC channel (#stackstorm on Freenode). Neither of these methods were inherently bad but they missed a lot of the fun features you get from using Slack or another rich chat client. Who doesn&#8217;t want images to automatically show up in the room when a link is posted? 🙂

So as we were working on a way for people to test out our ChatOps integration we decided to use a separate Slack organization. We got all the fun features of Slack plus we also easily have a StackStorm bot in the room with all sorts of neat actions for people to use.

[<img loading="lazy" class=" size-medium wp-image-3761 aligncenter" src="http://stackstorm.com/wp/wp-content/uploads/2015/06/687474703a2f2f692e696d6775722e636f6d2f396a6f64777a382e706e67-300x151.png" alt="687474703a2f2f692e696d6775722e636f6d2f396a6f64777a382e706e67" width="300" height="151" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/06/687474703a2f2f692e696d6775722e636f6d2f396a6f64777a382e706e67-300x151.png 300w, https://stackstorm.com/wp/wp-content/uploads/2015/06/687474703a2f2f692e696d6775722e636f6d2f396a6f64777a382e706e67.png 795w" sizes="(max-width: 300px) 100vw, 300px" />][3]

## [][4]{#user-content-how.anchor}How?

### [][5]{#user-content-prerequisites.anchor}Prerequisites

Beyond a working StackStorm installation, the following four integration packs are required for this to work.

  * <a href="https://github.com/StackStorm/st2incubator/tree/master/packs/typeform" target="_blank">typeform</a>
  * <a href="https://github.com/StackStorm/st2-slack" target="_blank">st2-slack</a>
  * <a href="https://github.com/stackstorm/st2-mysql" target="_blank">st2-mysql</a>
  * <a href="https://github.com/StackStorm/st2-community" target="_blank">st2-community</a>

### [][6]{#user-content-design.anchor}Design

First, it wasn&#8217;t easy figuring out exactly what a &#8220;public&#8221; Slack organization would be. I kept thinking there would be some specific designator for this, but there isn&#8217;t. So we spun up:

<a href="https://stackstorm-community.slack.com/" target="_blank">stackstorm-community.slack.com</a>

By default, only people with email addresses from the domain you specified when setting up the org could sign up through the Slack interface. In order to invite the community, we needed an admin to send them an invitation. This started to smell like a good opportunity for automation.

After reading through <a href="https://levels.io/slack-typeform-auto-invite-sign-ups/" target="_blank">@levelsio&#8217;s blog</a> I knew how he had done it, but I wanted to do it a little different. This was the design I had in mind:

  1. Typeform polling sensor periodically pulls completed form submissions and emits triggers with new users.
  2. A rule would match on this trigger and fire a simple action chain workflow
  3. The action chain workflow would do two things 
      1. Add the user registration information to a MySQL db
      2. Send out the Slack invitation.

### [][7]{#user-content-typeform-sensor.anchor}Typeform Sensor

This seemed simple enough. I started out writing the Typeform sensor using the API endpoint information I had gotten from the blog as a jumping off point.

If anyone wants to skip over my beautiful prose and just read code, the sensor is located here:

<a href="https://github.com/StackStorm/st2incubator/blob/master/packs/typeform/sensors/registration_sensor.py" target="_blank">Typeform Sensor</a>

I needed a way to validate that the sensor only emitted triggers on new user registrations. I realized that Slack will not send an invitation to the same email address more than once so I used email as my uniqueness constraint. The sensor retrieves the completed list of submissions from the Typeform API, then queries the MySQL database to see if that user is already in there. If they are, it skips them. Otherwise, it emits a trigger with the new user information.

For the sensor metadata, you can see that the parameters all map to fields on the form (except the date_* fields which are metadata sent from the Typeform API) but the only one required is email. This matches the setup of the form.

<a href="https://github.com/StackStorm/st2incubator/blob/master/packs/typeform/sensors/registration_sensor.yaml" target="_blank">registration_sensor.yaml</a>

    ---
      class_name: "TypeformRegistrationSensor"
      entry_point: "registration_sensor.py"
      description: "Sensor which monitors for new Typeform registrations"
      poll_interval: 60
      trigger_types:
        -
          name: "registration"
          description: "Trigger which indicates a new registration"
          payload_schema:
            type: "object"
            properties:
              email:
                type: "string"
                required: true
              first_name:
                type: "string"
              last_name:
                type: "string"
              source:
                type: "string"
              newsletter:
                type: "string"
              referer:
                type: "string"
              date_land:
                type: "string"
              date_submit:
                type: "string"
    

**NOTE:**

_I had created the MySQL database prior to writing the sensor. In order to use this yourself, you will need to follow the Typeform integration pack README._

**Configuration**

The Typeform pack requires a bit of configuration. You&#8217;ll need to go to the admin page of your Typeform account and get your API key. You&#8217;ll also need to pull the form id from the URL of your Typeform form. The URL looks like this: <a style="font-family: Georgia, 'Times New Roman', 'Bitstream Charter', Times, serif; font-size: 16px; line-height: 1.5; background-color: #ffffff;" href="https://stackstorm.typeform.com/to/K76GRP" target="_blank">https://stackstorm.typeform.com/to/K76GRP</a>

In our case, the form ID is **K76GRP**

Add both the API key, and the form id to your Typeform pack config.yaml. Also add in the credentials for your database while you are there.

### [][8]{#user-content-shiny-new-slack-actions.anchor}Shiny New Slack Actions

An interesting side effect of revisiting our Slack integration was that we ended up with a whole bunch of shiny new Slack actions! The new Slack pack is located here:

  * <a href="https://github.com/StackStorm/st2-slack" target="_blank">st2-slack</a>

The action that matters for this use case is `slack.users.admin.invite`. This action lets us send an invitation to our Slack organization to any email address, whether or not the domain matches the one we set the organization up for. Woohoo!

This is another chance for me to plug <a href="https://levels.io/slack-typeform-auto-invite-sign-ups/" target="_blank">@levelsio&#8217;s blog</a>. The admin API is **not** documented. He had discovered this and saved me quite a bit of work. 🙂

#### [][9]{#user-content-configuration-1.anchor}Configuration

Now, this does require a little set up on the Slack side. You&#8217;ll need to get an **admin** api token and add it to the **admin **section of the Slack pack config.yaml. The admin API token is slightly different than the API token used to access the other actions. You&#8217;ll need to create an application at the following link and use that token: <a href="https://api.slack.com/applications" target="_blank">Slack Applications</a>

Also in the admin section of the config.yaml, you will need to configure your Slack organization name. This is the name as it appears in the beginning of the organization&#8217;s url. In our case, it would be `stackstorm-community`.

**_https://stackstorm-community.slack.com_**

### [][10]{#user-content-workflow.anchor}Workflow

This part is pretty straight forward. An action chain that writes the data to the database and sends the slack invite&#8230;two sequential steps.

<a href="https://github.com/StackStorm/st2-community/blob/master/actions/chains/register_and_invite.yaml" target="_blank">Action Chain: register_and_invite.yaml</a>

    ---
      chain:
        -
          name: "insert_registration"
          ref: "mysql.insert"
          params:
            db: "community"
            table: "user_registration"
            data: "{{registration_data}}"
          publish:
            email: "{{registration_data.email}}"
            first_name: "{{registration_data.first_name}}"
          on-success: "send_slack_invite"
        - 
          name: "send_slack_invite"
          ref: "slack.users.admin.invite"
          params: 
            email: "{{email}}"
            first_name: "{{first_name}}"
    
      default: "insert_registration"
    

<a href="https://github.com/StackStorm/st2-community/blob/master/actions/register_and_invite.yaml" target="_blank">Action Metadata: register_and_invite.yaml</a>

    ---
      name: "register_and_invite"
      runner_type: "action-chain"
      description: "Send Slack invitation based on Typeform submissins"
      enabled: true
      entry_point: "chains/register_and_invite.yaml"
      parameters:
        registration_data:
          type: "object"
          required: true
          description: "Registration data as formatted when sent from Typeform"
    

Simple enough.

### [][11]{#user-content-rule.anchor}Rule

This was also quite easy to write. Nothing magic here.

<a href="https://github.com/StackStorm/st2-community/blob/master/rules/typeform_invite.yaml" target="_blank">typeform_invite.yaml</a>

    ---
    name: "typeform_invite"
    enabled: true
    description: "Write to DB and send invite on new user submission"
    trigger:
      pack: "typeform"
      type: "typeform.registration"
    criteria: {}
    action:
      ref: community.register_and_invite
      parameters:
        registration_data: "{{trigger}}"
    

## [][12]{#user-content-conclusion.anchor}Conclusion

And that&#8217;s it. Users can now fill out the Typeform form and get an invitation to the StackStorm-Community Slack Org! Overall, a pretty simple process. One really big aspect of automating this through the StackStorm platform is the visibility I have through the CLI or UI. If a complaint comes in that their invitation hasn&#8217;t arrived yet, I can check the status of the workflow through the Web UI or CLI. Or even get visibility in to the actual trigger that was emitted by the sensor through the `trigger-instance list` functionality we recently added to the CLI. So, everyone come sign up! <a href="https://stackstorm.com/community-signup" target="_blank">StackStorm-Community</a>

Also, feel free to tweet about us <a href="https://twitter.com/stack_storm" target="_blank">@Stack_Storm</a>, contact us at <a href="mailto:support@stackstorm.com" target="_blank">support@stackstorm.com</a>, or even check out the IRC channel on Freenode #stackstorm. Though, if you use the last one we&#8217;ll probably point you back to the StackStorm-Community Slack Channels!

 [1]: https://github.com/StackStorm/blogs/blob/master/2015/06/autoinvite_to_slack.md#a-shout-out
 [2]: https://github.com/StackStorm/blogs/blob/master/2015/06/autoinvite_to_slack.md#why
 [3]: http://stackstorm.com/wp/wp-content/uploads/2015/06/687474703a2f2f692e696d6775722e636f6d2f396a6f64777a382e706e67.png
 [4]: https://github.com/StackStorm/blogs/blob/master/2015/06/autoinvite_to_slack.md#how
 [5]: https://github.com/StackStorm/blogs/blob/master/2015/06/autoinvite_to_slack.md#prerequisites
 [6]: https://github.com/StackStorm/blogs/blob/master/2015/06/autoinvite_to_slack.md#design
 [7]: https://github.com/StackStorm/blogs/blob/master/2015/06/autoinvite_to_slack.md#typeform-sensor
 [8]: https://github.com/StackStorm/blogs/blob/master/2015/06/autoinvite_to_slack.md#shiny-new-slack-actions
 [9]: https://github.com/StackStorm/blogs/blob/master/2015/06/autoinvite_to_slack.md#configuration-1
 [10]: https://github.com/StackStorm/blogs/blob/master/2015/06/autoinvite_to_slack.md#workflow
 [11]: https://github.com/StackStorm/blogs/blob/master/2015/06/autoinvite_to_slack.md#rule
 [12]: https://github.com/StackStorm/blogs/blob/master/2015/06/autoinvite_to_slack.md#conclusion