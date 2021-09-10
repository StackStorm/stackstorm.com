---
title: StackStorm 1.2 release announcement
author: st2admin
type: post
date: 2015-12-09T04:09:40+00:00
excerpt: '<a href="#">READ MORE</a>'
url: /2015/12/08/stackstrom-1-2-release-announcement/
dsq_thread_id:
  - 4401106723
tcb2_ready:
  - 1
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - News

---
**December 8, 2015**  
_by Manas Kelshikar_

The holidays are upon us and we decided to celebrate with our v1.2.0 release of StackStorm! StackStorm v1.2.0 follows up as an update to our blockbuster [v1.1.0][1].

StackStorm 1.2 features significant changes to ChatOps, some smaller improvements and plenty of bug fixes. Lets walk through some of the highlights &#8211;

## ChatOps

The ChatOps changes are so extensive that we decided to dedicate a separate blog [here][2]. Once users familiarized themselves with StackStorm-powered ChatOps we received excellent feedback which has been translated into some of the improvements in this release.

The major theme is extending further your control of your ChatOps and especially what is presented in your precious chat real-estate.  We commercially support ChatOps &#8211; and we think improve it greatly versus rolling your own flavor of a bot or directly connecting more and more integrations to chat.

While we were at it we also took the liberty of reworking some StackStorm internals to better suit ChatOps needs thus enabling some of the features and opening up the door for many more future improvements.<!--more-->

## Feature highlights &#8211; more than ChatOps

#### Bastion host support (By <a href="https://github.com/lattwood" target="_blank">Logan Attwood</a>)

StackStorm remote runners now support <a href="https://en.wikipedia.org/wiki/Bastion_host" target="_blank">bastion hosts</a>. If your infrastructure requires bastion hosts to access various parts of the infra then we have you covered. Simply specify the bastion host property to proxy commands over to a remote host.

We love it when community members contribute key features and help to grow StackStorm. Your contributions are welcome and much appreciated.  Thank you Logan!

#### Pack testing

You must already know about StackStorm Packs. Take a look at our community <a href="https://exchange.stackstorm.org" target="_blank">StackStorm Exchange</a> for a wide range of existing packs.

With v1.2.0 we worked to improve the ability to test packs so that packs can get the same rigorous unit testing and integration testing as you would for your applications. These improvements make it easier to manage packs with a CI/CD pipeline so that you can make sure that only quality packs show up in a production StackStorm installation &#8211; this is DevOps getting a little meta.  Infrastructure as code!

Check out the <a href="https://docs.stackstorm.com/development/pack_testing.html" target="_blank">pack testing docs</a> to learn more.

#### Templating support in notifications

Notifications used to only be static strings.  As we strive to provide users more control, we decided to make it so that notifications can now be templatized. This means the notification messages can be more meaningful and fit better into your approach.

Notifications are a convenient way for StackStorm to either email, text, or respond in chat on the completion of an execution &#8211; or maybe you can invent another way to use them. More info about notifications can be found <a href="https://docs.stackstorm.com/chatops/notifications.html" target="_blank">here</a>.

#### Timeout and retry policies

Timeouts are a fact of our modern day Ops life. So we decided to provide these some special meaning and also this allowed us to enable some interesting policies. You can now setup a policy to retry N times on a timeout since often timeout failures resolve on a retry.  Docs for retry policy can be found <a href="https://docs.stackstorm.com/policies.html#retry" target="_blank">here</a>.

#### Improved ActionChain error reporting and validation

StackStorm 1.2 also adds more validation and better error reporting for the simple ActionChain workflow engine. Here we are trying to better report any statically identifiable errors and also to provide visibility into failures.

#### core.noop action

This is a no-op action that can be used as a placeholder action while testing workflows and rules and so forth. Also, this core.noop action is tremendously useful when combined with notifications and other value adds on top of an execution.

#### Serving api and auth off single HTTPS port

Previously, StackStorm deployments required separate ports to serve AUTH and API endpoints (9100 and 9101). We changed this to enable StackStorm to serve all the REST API endpoints off a single HTTPS, and made them &#8220;default&#8221; when you deploy StackStorm with All-in-one installer.

But wait, there is more!  To see the full list features and bug fixes new in v1.2.0 head over to the <a href="https://github.com/StackStorm/st2/releases/tag/v1.2.0" target="_blank">release notes</a>.

As always if you got question or would just like to say hi please head over to <a href="https://stackstorm.com/community/" target="_blank">https://stackstorm.com/community/</a> on how to find us.

 [1]: https://stackstorm.com/2015/11/02/stackstorm-v1-is-out/
 [2]: https://stackstorm.com/2015/12/08/stackstorm-1-2-0-the-new-chatops/