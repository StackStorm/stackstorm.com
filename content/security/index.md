---
title: Security
author: Tomaz Muraus
type: page
date: 2018-12-18T09:19:12+00:00
thrive_post_fonts:
  - '[]'
  - '[]'
tve_content_before_more:
  - |
    <div class="thrv_wrapper thrv_page_section" data-tve-style="1" style="margin-top: -55px !important;">
    <div class="out" style="background-color: #EAEAEA" data-tve-custom-colour="57482091">
    <div class="in darkSec">
    <div class="cck tve_clearfix tve_empty_dropzone">
    <div class="thrv_wrapper thrv-columns"><div class="tcb-flex-row tcb--cols--2">
    <div class="tcb-flex-col tve_empty_dropzone"><div class="tcb-col tve_empty_dropzone"><div class="thrv_wrapper thrv_heading" data-tag="h1"><h1 class="tve_p_right" style="margin-right: 50px !important; margin-top: 50px !important;"><span class="bold_text"><font color="#f4f4f4">Security</font></span></h1></div></div></div>
    <div class="tcb-flex-col tve_empty_dropzone"><div class="tcb-col tve_empty_dropzone"><div class="thrv_wrapper thrv_icon alignleft tcb-icon-display" style="font-size: 40px; border-radius: 0px; margin-left: 50px !important;" data-css="tve-u-167bcae8665"><span data-id="undefined" data-name="lock4" class="tve_sc_icon icon-lock4"></span></div></div></div>
    </div></div>
    </div>
    </div>
    </div>
    </div><div class="thrv_wrapper thrv-columns"><div class="tcb-flex-row tcb--cols--1" style="padding-left: 5px !important; padding-right: 5px !important; padding-bottom: 15px !important; margin-left: 0px !important; margin-bottom: 0px !important;">
    <div class="tcb-flex-col tve_empty_dropzone"><div class="tcb-col tve_empty_dropzone"><div class="thrv_wrapper thrv_text_element tve_empty_dropzone"><h3 class="" style="padding-left: 25px !important;">Security</h3><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">Here at StackStorm we take security very seriously. If you believe you found a security issue or a vulnerability, please report it to us using one of the methods described below.</p></div></div></div>
    </div></div><div class="thrv_wrapper thrv-columns"><div class="tcb-flex-row tcb--cols--1" style="padding-left: 5px !important; padding-right: 5px !important; padding-bottom: 15px !important; margin-left: 0px !important; margin-bottom: 0px !important;">
    <div class="tcb-flex-col tve_empty_dropzone"><div class="tcb-col tve_empty_dropzone"><div class="thrv_wrapper thrv_text_element tve_empty_dropzone"><h3 style="padding-left: 25px !important;">Reporting a Vulnerability</h3><blockquote class="">Please do not report security issues using our public Github repository or Slack chat. Use the private mailing list described bellow.</blockquote><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">If you believe you found a security issue or a vulnerability, please send a description of it to our private mailing list at info@stackstorm.com<br><br>Once you've submitted an issue, you should receive an acknowledgment from one our of team members in 48 hours or less. If further action is necessary, you may receive additional follow-up emails.<br><br></p></div><div class="thrv_wrapper thrv_text_element tve_empty_dropzone"><h3 style="padding-left: 25px !important;">How Are Vulnerabilities Handled</h3><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">We follow the industry de facto standard of <a href="https://en.wikipedia.org/wiki/Responsible_disclosure" target="_blank">Responsible Disclosure</a> for handling security issues. This means we disclose the issue only after a fix for the issue has been developed and released.</p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><br></p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">We of course always give full credit to the person who was reported the issue.</p></div><div class="thrv_wrapper thrv_text_element tve_empty_dropzone thrv-plain-text"><h3 style="padding-left: 25px !important; text-align: left;">Security Vulnerabilities</h3><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">The section below contains a list of security vulnerabilities identified in the past releases. Those issues have been fixed in the latest release so you are always encouraged to run the latest release available.</p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><br></p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><strong>[CVE-2019-9580] Ability to bypass CORS protection mechanism via "null" origin value potentially leading to XSS<br></strong><br><strong>Severity:</strong> High<br><strong>Affected versions:</strong> All the versions prior to 2.9.3 and 2.10.3<br><strong>Description:<br></strong><br>StackStorm API returned "null" value for "Access-Control-Allow-Origin" header when a client sent an unknown origin which was not configured / whitelisted in /etc/st2/st2.conf. As <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin#Directives" target="_blank">Mozilla’s documentation</a> will show, and client behavior will back up, null can result in a successful request from an unknown origin in some clients. Allowing the possibility of XSS style attacks against the StackStorm API.<br><br><strong>Mitigation:</strong> This vulnerability has been fixed in StackStorm v2.9.3 and v2.10.3. You are strongly encouraged to upgrade to that release.<br><strong>Bug fix announcement blog post:</strong> <a href="https://stackstorm.com/2019/03/08/stackstorm-2-9-3-2-10-3/" target="_blank">https://stackstorm.com/2019/03/08/stackstorm-2-9-3-2-10-3/</a></p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><strong>Credits:</strong><br><br>This issue was discovered and reported to us by Barak Tawily and Anna Tsibulskaya.</p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><br></p><div class="tcb-plain-text" data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><strong>[CVE-2018-20345] Invalid access control checks in "GET /v1/keys" API endpoint</strong></div><p data-css="tve-u-167d23fac54" data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">​<br></p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><strong>Severity:</strong> Medium<br><strong>Affected versions:</strong> All the versions prior to 2.9.2 and 2.10.1<br><strong>Description:</strong><br><br>StackStorm API didn't perform correct access control checks in the "GET /v1/keys" API endpoint. This allowed authenticated users to retrieve user-scoped datastore items for arbitrary users by using "?scope=all" and "?user=&lt;username&gt;" query parameter filters.<br><br>NOTE: Enterprise edition with RBAC enabled is not affected. When RBAC is enabled, only users with admin role can utilize "?scope=all" and "?user=&lt;username&gt;" query parameter filter and retrieve / view values for any system user.<br><br><strong>Mitigation:</strong> This vulnerability has been fixed in StackStorm v2.9.2 and v2.10.1. You are strongly encouraged to upgrade to that release.<br><strong>Bug fix announcement blog post:</strong> <a href="https://stackstorm.com/2018/12/20/stackstorm-v2-9-2-and-v2-10-1-a-security-release/" target="_blank">https://stackstorm.com/2018/12/20/stackstorm-v2-9-2-and-v2-10-1-a-security-release/</a></p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><strong>Credits:</strong></p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><br></p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">​This issue was discovered and reported to us by Alexandre Juma.<br><br><br><br></p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><br></p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><br></p></div></div></div>
    </div></div>
tve_save_post:
  - |
    <div class="thrv_wrapper thrv_page_section" data-tve-style="1" style="margin-top: -55px !important;">
    <div class="out" style="background-color: #EAEAEA" data-tve-custom-colour="57482091">
    <div class="in darkSec">
    <div class="cck tve_clearfix tve_empty_dropzone">
    <div class="thrv_wrapper tcb-flex-row tcb--cols--2">
    <div class="tcb-flex-col tve_empty_dropzone"><h1 class="tve_p_right" style="margin-right: 50px !important; margin-top: 50px !important;"><span class="bold_text"><font color="#f4f4f4">Contact</font></span></h1></div>
    <div class="tcb-flex-col tve_empty_dropzone"><div class="thrv_wrapper thrv_icon alignleft" style="font-size: 40px; border-radius: 0px; margin-left: 50px !important;">
    <span data-tve-icon="icon-bubbles" class="tve_sc_icon icon-bubbles tve_white" style="padding: 0px; border-radius: 0px; font-size: 177px; width: 177px; height: 177px;"></span>
    </div></div>
    </div>
    </div>
    </div>
    </div>
    </div><div class="thrv_wrapper tcb-flex-row tcb--cols--2" style="padding-left: 5px !important; padding-right: 5px !important; padding-bottom: 15px !important; margin-left: 0px !important; margin-bottom: 0px !important;">
    <div class="tcb-flex-col tve_empty_dropzone"><div class="thrv_wrapper thrv_custom_html_shortcode"><iframe width="600" height="350" style="border: 0;" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3168.7819497620217!2d-121.9545520842467!3d37.41862847982594!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x808fc854863e2865%3A0x23926d462af7fdb2!2s130+Holger+Way%2C+San+Jose%2C+CA+95134!5e0!3m2!1sen!2sus!4v1464397162074" frameborder="0"></iframe><div class="tve_iframe_cover"></div></div></div>
    <div class="tcb-flex-col tve_empty_dropzone"><h3 class="" style="padding-left: 25px !important;">Brocade Communications Systems, Inc. </h3><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">130 Holger Way&nbsp;</p><p data-unit="px" style="line-height: 25px; margin-bottom: 0px !important; padding-left: 25px !important;">San Jose, CA 95134</p><div class="thrv_wrapper thrv_custom_html_shortcode" style="padding-left: 25px !important;"><a href="https://www.facebook.com/stackstormdevops" target="_blank"><img src="/wp/wp-content/themes/DiviStack/img/ic-facebook.png"></a> <a href="https://twitter.com/Stack_Storm" target="_blank"><img src="/wp/wp-content/themes/DiviStack/img/ic-twitter.png"></a> <a href="https://www.linkedin.com/company/stackstorm" target="_blank"><img src="/wp/wp-content/themes/DiviStack/img/ic-linkedin.png"></a> <a href="https://www.youtube.com/channel/UCColc5CuBJ8-1SnALnkDz8Q/feed" target="_blank"><img src="/wp/wp-content/themes/DiviStack/img/ic-youtube.png"></a><br>
    <br>
    <a href="https://stackstorm.typeform.com/to/K76GRP" target="_blank">Slack Channel Sign-Up</a><br>
    <a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">IRC: #StackStorm on freenode.net</a><br>
    <a href="https://groups.google.com/d/forum/stackstorm" target="_blank">Google Group<br>
    </a>[thrive_2step id='5728']<a href="/subscribe-to-newsletter/" target="_blank">Subscribe to newsletter</a>[/thrive_2step]<br>
    <br>
    <b>General / career inquiries:</b> <a href="mailto:info@stackstorm.com">info@stackstorm.com</a><br>
    <b>Media inquiries:</b> <a href="mailto:stackstorm@mindsharepr.com">stackstorm@mindsharepr.com</a><br>
    <b>Support:</b> <a href="mailto:support@stackstorm.com">support@stackstorm.com</a><br></div></div>
    </div>
tve_custom_css:
  - '@media (min-width: 300px){[data-css="tve-u-167bcae8665"] { font-size: 150px !important; width: 150px !important; height: 150px !important; }#tve_editor [data-css="tve-u-167d23fac54"] { font-size: 22px !important; color: rgb(51, 51, 51) !important; }}[data-tve-custom-colour="57482091"] { background-color: rgb(46, 163, 242) !important; box-shadow: transparent 0px 0px 8px 4px inset, transparent 0px 0px 7px 3px !important; border-color: rgb(102, 102, 102) !important; }'
tve_page_events:
  - 'a:0:{}'
tve_updated_post:
  - |
    <div class="thrv_wrapper thrv_page_section" data-tve-style="1" style="margin-top: -55px !important;">
    <div class="out" style="background-color: #EAEAEA" data-tve-custom-colour="57482091">
    <div class="in darkSec">
    <div class="cck tve_clearfix tve_empty_dropzone">
    <div class="thrv_wrapper thrv-columns"><div class="tcb-flex-row tcb--cols--2">
    <div class="tcb-flex-col tve_empty_dropzone"><div class="tcb-col tve_empty_dropzone"><div class="thrv_wrapper thrv_heading" data-tag="h1"><h1 class="tve_p_right" style="margin-right: 50px !important; margin-top: 50px !important;"><span class="bold_text"><font color="#f4f4f4">Security</font></span></h1></div></div></div>
    <div class="tcb-flex-col tve_empty_dropzone"><div class="tcb-col tve_empty_dropzone"><div class="thrv_wrapper thrv_icon alignleft tcb-icon-display" style="font-size: 40px; border-radius: 0px; margin-left: 50px !important;" data-css="tve-u-167bcae8665"><span data-id="undefined" data-name="lock4" class="tve_sc_icon icon-lock4"></span></div></div></div>
    </div></div>
    </div>
    </div>
    </div>
    </div><div class="thrv_wrapper thrv-columns"><div class="tcb-flex-row tcb--cols--1" style="padding-left: 5px !important; padding-right: 5px !important; padding-bottom: 15px !important; margin-left: 0px !important; margin-bottom: 0px !important;">
    <div class="tcb-flex-col tve_empty_dropzone"><div class="tcb-col tve_empty_dropzone"><div class="thrv_wrapper thrv_text_element tve_empty_dropzone"><h3 class="" style="padding-left: 25px !important;">Security</h3><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">Here at StackStorm we take security very seriously. If you believe you found a security issue or a vulnerability, please report it to us using one of the methods described below.</p></div></div></div>
    </div></div><div class="thrv_wrapper thrv-columns"><div class="tcb-flex-row tcb--cols--1" style="padding-left: 5px !important; padding-right: 5px !important; padding-bottom: 15px !important; margin-left: 0px !important; margin-bottom: 0px !important;">
    <div class="tcb-flex-col tve_empty_dropzone"><div class="tcb-col tve_empty_dropzone"><div class="thrv_wrapper thrv_text_element tve_empty_dropzone"><h3 style="padding-left: 25px !important;">Reporting a Vulnerability</h3><blockquote class="">Please do not report security issues using our public Github repository or Slack chat. Use the private mailing list described bellow.</blockquote><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">If you believe you found a security issue or a vulnerability, please send a description of it to our private mailing list at info@stackstorm.com<br><br>Once you've submitted an issue, you should receive an acknowledgment from one our of team members in 48 hours or less. If further action is necessary, you may receive additional follow-up emails.<br><br></p></div><div class="thrv_wrapper thrv_text_element tve_empty_dropzone"><h3 style="padding-left: 25px !important;">How Are Vulnerabilities Handled</h3><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">We follow the industry de facto standard of <a href="https://en.wikipedia.org/wiki/Responsible_disclosure" target="_blank">Responsible Disclosure</a> for handling security issues. This means we disclose the issue only after a fix for the issue has been developed and released.</p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><br></p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">We of course always give full credit to the person who was reported the issue.</p></div><div class="thrv_wrapper thrv_text_element tve_empty_dropzone thrv-plain-text"><h3 style="padding-left: 25px !important; text-align: left;">Security Vulnerabilities</h3><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">The section below contains a list of security vulnerabilities identified in the past releases. Those issues have been fixed in the latest release so you are always encouraged to run the latest release available.</p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><br></p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><strong>[CVE-2019-9580] Ability to bypass CORS protection mechanism via "null" origin value potentially leading to XSS<br></strong><br><strong>Severity:</strong> High<br><strong>Affected versions:</strong> All the versions prior to 2.9.3 and 2.10.3<br><strong>Description:<br></strong><br>StackStorm API returned "null" value for "Access-Control-Allow-Origin" header when a client sent an unknown origin which was not configured / whitelisted in /etc/st2/st2.conf. As <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin#Directives" target="_blank">Mozilla’s documentation</a> will show, and client behavior will back up, null can result in a successful request from an unknown origin in some clients. Allowing the possibility of XSS style attacks against the StackStorm API.<br><br><strong>Mitigation:</strong> This vulnerability has been fixed in StackStorm v2.9.3 and v2.10.3. You are strongly encouraged to upgrade to that release.<br><strong>Bug fix announcement blog post:</strong> <a href="https://stackstorm.com/2019/03/08/stackstorm-2-9-3-2-10-3/" target="_blank">https://stackstorm.com/2019/03/08/stackstorm-2-9-3-2-10-3/</a></p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><strong>Credits:</strong><br><br>This issue was discovered and reported to us by Barak Tawily and Anna Tsibulskaya.</p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><br></p><div class="tcb-plain-text" data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><strong>[CVE-2018-20345] Invalid access control checks in "GET /v1/keys" API endpoint</strong></div><p data-css="tve-u-167d23fac54" data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">​<br></p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><strong>Severity:</strong> Medium<br><strong>Affected versions:</strong> All the versions prior to 2.9.2 and 2.10.1<br><strong>Description:</strong><br><br>StackStorm API didn't perform correct access control checks in the "GET /v1/keys" API endpoint. This allowed authenticated users to retrieve user-scoped datastore items for arbitrary users by using "?scope=all" and "?user=&lt;username&gt;" query parameter filters.<br><br>NOTE: Enterprise edition with RBAC enabled is not affected. When RBAC is enabled, only users with admin role can utilize "?scope=all" and "?user=&lt;username&gt;" query parameter filter and retrieve / view values for any system user.<br><br><strong>Mitigation:</strong> This vulnerability has been fixed in StackStorm v2.9.2 and v2.10.1. You are strongly encouraged to upgrade to that release.<br><strong>Bug fix announcement blog post:</strong> <a href="https://stackstorm.com/2018/12/20/stackstorm-v2-9-2-and-v2-10-1-a-security-release/" target="_blank">https://stackstorm.com/2018/12/20/stackstorm-v2-9-2-and-v2-10-1-a-security-release/</a></p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><strong>Credits:</strong></p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><br></p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">​This issue was discovered and reported to us by Alexandre Juma.<br><br><br><br></p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><br></p><p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;"><br></p></div></div></div>
    </div></div>
tve_globals:
  - 'a:2:{s:1:"e";s:1:"1";s:8:"font_cls";a:0:{}}'
thrive_tcb_post_fonts:
  - 'a:0:{}'
thrive_icon_pack:
  - 1
tcb2_ready:
  - 1
tcb_editor_enabled:
  - 1

---
<h1 style="margin-right: 50px !important; margin-top: 50px !important;">
  <span>Security</span>
</h1>

<span data-id="undefined" data-name="lock4"></span>

<h3 style="padding-left: 25px !important;">
  Security
</h3>

<p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">
  Here at StackStorm we take security very seriously. If you believe you found a security issue or a vulnerability, please report it to us using one of the methods described below.
</p>

<h3 style="padding-left: 25px !important;">
  Reporting a Vulnerability
</h3>

> Please do not report security issues using our public Github repository or Slack chat. Use the private mailing list described bellow.

<p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">
  If you believe you found a security issue or a vulnerability, please send a description of it to our private mailing list at info@stackstorm.comOnce you&#8217;ve submitted an issue, you should receive an acknowledgment from one our of team members in 48 hours or less. If further action is necessary, you may receive additional follow-up emails.
</p>

<h3 style="padding-left: 25px !important;">
  How Are Vulnerabilities Handled
</h3>

<p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">
  We follow the industry de facto standard of <a href="https://en.wikipedia.org/wiki/Responsible_disclosure" target="_blank" rel="noopener noreferrer">Responsible Disclosure</a> for handling security issues. This means we disclose the issue only after a fix for the issue has been developed and released.
</p>

<p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">
  <p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">
    We of course always give full credit to the person who was reported the issue.
  </p>
  
  <h3 style="padding-left: 25px !important; text-align: left;">
    Security Vulnerabilities
  </h3>
  
  <p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">
    The section below contains a list of security vulnerabilities identified in the past releases. Those issues have been fixed in the latest release so you are always encouraged to run the latest release available.
  </p>
  
  <p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">
    <p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">
      <strong>[CVE-2019-9580] Ability to bypass CORS protection mechanism via &#8220;null&#8221; origin value potentially leading to XSS</strong><strong>Severity:</strong> High<strong>Affected versions:</strong> All the versions prior to 2.9.3 and 2.10.3<strong>Description:</strong>StackStorm API returned &#8220;null&#8221; value for &#8220;Access-Control-Allow-Origin&#8221; header when a client sent an unknown origin which was not configured / whitelisted in /etc/st2/st2.conf. As <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin#Directives" target="_blank" rel="noopener noreferrer">Mozilla’s documentation</a> will show, and client behavior will back up, null can result in a successful request from an unknown origin in some clients. Allowing the possibility of XSS style attacks against the StackStorm API.<strong>Mitigation:</strong> This vulnerability has been fixed in StackStorm v2.9.3 and v2.10.3. You are strongly encouraged to upgrade to that release.<strong>Bug fix announcement blog post:</strong> <a href="https://stackstorm.com/2019/03/08/stackstorm-2-9-3-2-10-3/" target="_blank" rel="noopener noreferrer">https://stackstorm.com/2019/03/08/stackstorm-2-9-3-2-10-3/</a>
    </p>
    
    <p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">
      <strong>Credits:</strong>This issue was discovered and reported to us by Barak Tawily and Anna Tsibulskaya.
    </p>
    
    <p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">
      <p>
        <strong>[CVE-2018-20345] Invalid access control checks in &#8220;GET /v1/keys&#8221; API endpoint</strong>
      </p>
      
      <p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">
        ​
      </p>
      
      <p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">
        <strong>Severity:</strong> Medium<strong>Affected versions:</strong> All the versions prior to 2.9.2 and 2.10.1<strong>Description:</strong>StackStorm API didn&#8217;t perform correct access control checks in the &#8220;GET /v1/keys&#8221; API endpoint. This allowed authenticated users to retrieve user-scoped datastore items for arbitrary users by using &#8220;?scope=all&#8221; and &#8220;?user=<username>&#8221; query parameter filters.NOTE: Enterprise edition with RBAC enabled is not affected. When RBAC is enabled, only users with admin role can utilize &#8220;?scope=all&#8221; and &#8220;?user=<username>&#8221; query parameter filter and retrieve / view values for any system user.<strong>Mitigation:</strong> This vulnerability has been fixed in StackStorm v2.9.2 and v2.10.1. You are strongly encouraged to upgrade to that release.<strong>Bug fix announcement blog post:</strong> <a href="https://stackstorm.com/2018/12/20/stackstorm-v2-9-2-and-v2-10-1-a-security-release/" target="_blank" rel="noopener noreferrer">https://stackstorm.com/2018/12/20/stackstorm-v2-9-2-and-v2-10-1-a-security-release/</a>
      </p>
      
      <p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">
        <strong>Credits:</strong>
      </p>
      
      <p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">
        <p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">
          ​This issue was discovered and reported to us by Alexandre Juma.
        </p>
        
        <p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">
          <p data-unit="px" style="line-height: 20px; margin-bottom: 5px !important; padding-left: 25px !important;">