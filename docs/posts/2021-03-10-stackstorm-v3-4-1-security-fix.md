---
title: StackStorm v3.4.1 – Security fix
author: Tomaz Muraus
type: post
date: 2021-03-10T20:18:53+00:00
url: /2021/03/10/stackstorm-v3-4-1-security-fix/
thrive_post_fonts:
  - '[]'
  - '[]'
categories:
  - Blog
  - Community
  - News
tags:
  - release
  - release announcement

---
**Mar 16, 2021**

_by [Tomaz Muraus][1] and [@blag][2]_

<p dir="ltr" id="docs-internal-guid-713159ba-7fff-8f80-08d7-bac26f0a94d0">
  <span>Today we are announcing StackStorm v3.4.1, a bug fix release which fixes a security issue which has been uncovered recently.</span>
</p>

<p dir="ltr">
  <span>The issue affects anyone who is running StackStorm under Python 3 and doesn’t have a system locale / encoding which is used for StackStorm service processes (st2api, st2actionrunner, etc.) set to UTF-8. Under such conditions, if StackStorm receives a payload with unicode characters which also results in the payload being logged, StackStorm process would go into an infinite-loop trying to decode that payload. This would cause the affected service to have a high CPU utilization and also service log file to grow either until the process is killed or all the available disk space is exhausted (basically result in a DoS).</span>
</p>

<p dir="ltr">
  <span>If you are running StackStorm under Python 3, you are strongly encouraged to upgrade to this release.</span>
</p>

<p dir="ltr">
  <span>For more details, please see the sections below.</span>
</p>

<p dir="ltr">
  Post will be updated with CVE ID once it&#8217;s assigned.
</p>

<p dir="ltr">
  <!--more-->
</p>

<p dir="ltr">
  <!--more-->
</p>

## Affected Installations / deployments

<p dir="ltr" id="docs-internal-guid-4f8cc666-7fff-1a1c-4d07-3020c713b227">
  <span>Any StackStorm installation which is using Python 3 and doesn’t have the system locale / encoding used for StackStorm services set to utf-8 is affected.</span>
</p>

<p dir="ltr">
  <span>Until StackStorm v3.4.0 <a href="https://stackstorm.com/2021/03/04/v3-4-0-released/">which was released recently</a>, StackStorm was still using Python 2.7 on most distros except RHEL / CentOS 8 and Ubuntu Bionic 18.04. StackStorm already used Python 3 on those operating systems.<br /></span>
</p>

<p dir="ltr">
  <span>It’s worth noting that nowadays that the system and processes locales are almost always set to utf-8, and when locales are either not being set, or set to C.ascii, is is usually a system misconfiguration.</span>
</p>

<h2 dir="ltr" id="docs-internal-guid-c83eaa8c-7fff-51be-4053-b322e77d499d">
  <span>The bug</span>
</h2>

<p dir="ltr" id="docs-internal-guid-ccb86944-7fff-7490-1000-e1f64fca163c">
  <span>The actual bug and security vulnerability is located in the piece of code which is responsible for routing any data which is written to standard error (those are mostly just exception stack traces) to the logger method and logging this data under ERROR log level.</span>
</p>

<p dir="ltr">
  <span>Under normal scenario when encountering unicode data and system / process locale (encoding) not being set to utf-8, trying to decode this utf-8 data to an ascii string would result in an exception because the character we are trying to decode is out of range for the current locale (which is usually ascii in such scenarios). That exception would then simply just be logged to the log file like any other.</span>
</p>

<p dir="ltr">
  <span>Due to the bug in the code, under such scenario, the code would incorrectly try to decode this data in an infinite-loop instead of simply bailing out on first attempt trying to decode this data.</span>
</p>

<p dir="ltr">
  <span>The bug was initially uncovered by one of the end to end tests, but at that time it was assumed it was just a flaky test and not an actual bug since we could not reproduce it on all operating systems, or during manual user testing for the 3.4.0 release.</span>
</p>

<p dir="ltr">
  <span>A couple of days later, I was working on a different change when I encountered the same issue. After digging in a lot, I was able to track down and pinpoint the root cause.</span>
</p>

<p dir="ltr">
  <span>One of the main reasons why the issue wasn’t detected faster was because of the nature of it &#8211; as mentioned above, these days it’s quite uncommon to have a system which is not configured with utf-8 locale.</span>
</p>

<h2 dir="ltr" id="docs-internal-guid-36912738-7fff-bafa-4f6d-9d764eb97d93">
  <span>The fix</span>
</h2>

<p dir="ltr" id="docs-internal-guid-9b68801d-7fff-d22d-dd71-6ab6ad191c23">
  <span>The fix includes modifying our custom logger method described above to decode the underlying byte string and removing any characters which are not in the ascii range before passing that data to the underlying log formatter method.</span><span></span>
</p>

<p dir="ltr">
  <span>Now if this issue occurs, the process will simply just log an error / exception when trying to log unicode data when process encoding is not set to utf-8 (as it should have done out of the box).</span><span></span>
</p>

<p dir="ltr">
  <span>Having said that, even though it will now work correctly under non-utf-8 encodings, you are still strongly recommended to set your system locale (and encoding for StackStorm services processes) to utf-8 to ensure a good experience when working with unicode data. </span>
</p>

<p dir="ltr">
  <span>To do so, ensure that the encoding part of <code>LC_MESSAGES</code> or <code>LANG</code> in <code class="EnlighterJSRAW" data-enlighter-language="null">/etc/locale.conf</code> is set to <code class="EnlighterJSRAW" data-enlighter-language="null">UTF-8</code>. To set your locale for American English with <code class="EnlighterJSRAW" data-enlighter-language="null">UTF-8</code></span><span>encoding, use this:<br /></span>
</p>

<pre class="EnlighterJSRAW" data-enlighter-language="null">LANG=en_US.UTF-8
LC_MESSAGES=en_US.UTF-8</pre>

<p class="EnlighterJSRAW" data-enlighter-language="null">
  Or, for example, a German locale with American English log messages, you can use:
</p>

<pre class="EnlighterJSRAW" data-enlighter-language="null">LANG=de_DE.UTF-8
LC_MESSAGES=en_US.UTF-8</pre>

<p dir="ltr">
  For more information on locales, check the <a href="https://www.freedesktop.org/software/systemd/man/locale.conf.html">documention on freedesktop.org</a>.
</p>

<p dir="ltr">
  <span>On that note, we have also added a small change to the code which will print a warning on service startup in case the encoding for that service is not set to utf-8 as shown below.</span><span></span>
</p>

<pre class="EnlighterJSRAW" data-enlighter-language="null">WARNING [-] Detected a non utf-8 locale / encoding (fs encoding: ascii, default encoding: utf-8, locale: unable to retrieve locale: unknown locale: invalid). Using a non utf-8 locale while working with unicode data will result in exceptions and undefined behavior. You are strongly encouraged to configure all the StackStorm services to use utf-8 encoding (e.g. LANG=en_US.UTF-8).</pre>

<h2 dir="ltr" id="docs-internal-guid-36912738-7fff-bafa-4f6d-9d764eb97d93">
  <span>Conclusion<br /></span>
</h2>

<span id="docs-internal-guid-a98c6343-7fff-1dea-a08c-96d0ab20a9a0">If you fall under affected deployments (you are running StackStorm under Python 3 and using locale / encoding other than utf-8), you are strongly encouraged to upgrade to v3.4.1.</span>

If you are a researcher or user that discovers a security issue please reach out to security@stackstorm.com (<https://stackstorm.com/security/>).

 [1]: https://www.github.com/Kami
 [2]: https://github.com/blag