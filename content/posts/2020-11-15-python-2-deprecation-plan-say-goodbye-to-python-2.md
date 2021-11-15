---
title: 'Python 2 Deprecation Plan: Say goodbye to python 2'
author: Amanda McGuinness
type: post
date: 2020-11-15T21:02:54+00:00
url: /2020/11/15/python-2-deprecation-plan-say-goodbye-to-python-2/
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - News
tags:
  - deployment
  - python 2
  - updates

---
**Nov 16, 2020**

<p dir="ltr">
  <i><span style="font-weight: 400;">By <a href="https://github.com/amanda11">Amanda McGuinness</a> of </span></i><a href="https://www.ammeonsolutions.com/"><i><span style="font-weight: 400;">Ammeon Solutions</span></i></a>
</p>

<p dir="ltr" style="text-align: center;">
  <img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2020/11/Bye-bye-python-3.png" alt="" class="aligncenter wp-image-9287 size-full" width="1200" height="627" srcset="https://stackstorm.com/wp/wp-content/uploads/2020/11/Bye-bye-python-3.png 1200w, https://stackstorm.com/wp/wp-content/uploads/2020/11/Bye-bye-python-3-150x78.png 150w, https://stackstorm.com/wp/wp-content/uploads/2020/11/Bye-bye-python-3-300x157.png 300w, https://stackstorm.com/wp/wp-content/uploads/2020/11/Bye-bye-python-3-768x401.png 768w, https://stackstorm.com/wp/wp-content/uploads/2020/11/Bye-bye-python-3-1024x535.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2020/11/Bye-bye-python-3-80x42.png 80w, https://stackstorm.com/wp/wp-content/uploads/2020/11/Bye-bye-python-3-220x115.png 220w, https://stackstorm.com/wp/wp-content/uploads/2020/11/Bye-bye-python-3-191x100.png 191w, https://stackstorm.com/wp/wp-content/uploads/2020/11/Bye-bye-python-3-280x146.png 280w, https://stackstorm.com/wp/wp-content/uploads/2020/11/Bye-bye-python-3-456x238.png 456w, https://stackstorm.com/wp/wp-content/uploads/2020/11/Bye-bye-python-3-750x392.png 750w, https://stackstorm.com/wp/wp-content/uploads/2020/11/Bye-bye-python-3-932x487.png 932w, https://stackstorm.com/wp/wp-content/uploads/2020/11/Bye-bye-python-3-1139x595.png 1139w" sizes="(max-width: 1200px) 100vw, 1200px" />
</p>

<p dir="ltr">
  <span style="font-weight: 400;">Python 2 reached end-of-life on 1st January 2020.  It served us for a long time, but today Python 2 pulls the project down as more packages drop python 2 support, making maintenance hard. Having to keep the codebase py2-compatible means we can’t take advantage of modern Python 3 features.  Removing Python 2 support and relying on Python 3 only is the required thing to do and now it&#8217;s finally time!</span>
</p>

<p dir="ltr">
  <!--more-->
</p>

<p dir="ltr">
  <span style="font-weight: 400;">Stackstorm releases, including 3.3 still support python 2, but we intend to remove support in StackStorm 3.4. So start planning your migration!</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">In StackStorm 3.3 we have introduced python 2 deprecation warnings, for the following situations:</span>
</p>

<li style="font-weight: 400;">
  <span style="font-weight: 400;">Installation of a pack where the python_versions listed is only python 2</span>
</li>
<li style="font-weight: 400;">
  <span style="font-weight: 400;">Using st2ctl to start, restart or reload when running on a platform that uses python 2 (Ubuntu 16.04 or RedHat/CentOS 7)</span>
</li>
<li style="font-weight: 400;">
  <span style="font-weight: 400;">In the log files of Stackstorm services running with python 2</span>
</li>

## **What do I need to do?**

<p dir="ltr">
  <span style="font-weight: 400;">Most importantly, check that the packs you have developed and the community packs you use support python3. If your personal packs do not, then please start migrating them to support python 3.  If community packs do not list python 3 as supported, then please consider helping to upgrade them to python 3. Please raise any issues found when running any packs on python 3.</span>
</p>

## **Can I use python3 now?**

<span style="font-weight: 400;">Yes, you can. If you run StackStorm on our latest supported OS releases, they will automatically use python 3. Using a StackStorm installation on Ubuntu 18.04 or RedHat/CentOS 8 will automatically use python 3 for packs and the StackStorm services.</span>

## **What if I have an older OS?**

<p dir="ltr">
  <span style="font-weight: 400;">If you’re still on Ubuntu 16.04 LTS or CentOS/RHEL 7, you can still test packs work with python 3 on StackStorm releases that use python 2. Please see <a href="https://docs.stackstorm.com/packs.html#python-versions-in-pack-python-virtual-environment">Python versions in Pack Python Virtual Environment </a></span><span style="font-weight: 400;"> for detailed instructions.</span>
</p>

<p dir="ltr">
  <span style="font-weight: 400;">Once you are happy that your packs work, then you may want to consider upgrading to a newer OS release.</span>
</p>

## **What version of python should I move to?**

<span style="font-weight: 400;">StackStorm currently uses python version 3.6 on its latest supported OS releases. We plan to add support for more python versions in the future.</span>

## **What’s happening next?**

<p dir="ltr">
  <span style="font-weight: 400;">Our current plans for python2 removal are:</span>
</p>

<li style="font-weight: 400;">
  <span style="font-weight: 400;">StackStorm 3.4.0</span> <ul>
    <li style="font-weight: 400;">
      <span style="font-weight: 400;">CentOS/RHEL 7: Update installers to install python3.6 from OS repositories, and ST2 will run using python 3.6</span>
    </li>
    <li style="font-weight: 400;">
      <span style="font-weight: 400;">Ubuntu 16.04: Add a prerequisite that python 3.6 is installed on the StackStorm machine’s using a PPA of the user’s choice. Installers will then use python 3.6, and ST2 will run using python 3.6</span>
    </li>
    <li style="font-weight: 400;">
      <span style="font-weight: 400;">All packs will run with a python3 virtualenv, and so any packs that rely on python 2 code will need to be updated.</span>
    </li>
  </ul>
</li>

<li style="font-weight: 400;">
  <span style="font-weight: 400;">StackStorm 3.5.0</span> <ul>
    <li style="font-weight: 400;">
      <span style="font-weight: 400;">Ubuntu 20.04: Add support for Ubuntu 20.04 and Python 3.8</span>
    </li>
    <li style="font-weight: 400;">
      <span style="font-weight: 400;">Ubuntu 16.04 support removed</span>
    </li>
  </ul>
</li>

## **Participation**

<p dir="ltr">
  <span style="font-weight: 400;">To aid in the python 2 removal, we would welcome help from the community, please see the following related plans, and if you’d like to get involved comment on the issues or in our </span><a href="https://stackstorm.com/community-signup"><span style="font-weight: 400;">Slack Community</span></a><span style="font-weight: 400;">:</span>
</p>

<li style="font-weight: 400;">
  <a href="https://github.com/orgs/StackStorm/projects/15"><span style="font-weight: 400;">Python 2 Deprecation Project</span></a>
</li>
<li style="font-weight: 400;">
  <a href="https://github.com/orgs/StackStorm/projects/12"><span style="font-weight: 400;">Ubuntu 20.04 Support Project</span></a>
</li>

<span style="font-weight: 400;">We welcome and appreciate contributions of any kind (code, tests, documentation, examples, use cases, etc.). If you need help or get stuck at any point then at the </span>[<span style="font-weight: 400;">Slack Community</span>][1] <span style="font-weight: 400;">we will do our best to assist you.</span>

 [1]: https://stackstorm.com/community-signup