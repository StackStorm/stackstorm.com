---
title: 'Weekly Update: GPG Pack and Refactors'
author: st2admin
type: post
date: 2015-02-18T18:00:51+00:00
excerpt: '<a href="http://stackstorm.com/?p=2606">READ MORE</a>'
url: /2015/02/18/weekly-update-gpg-pack-refactors/
dsq_thread_id:
  - 3527173267
thrive_post_fonts:
  - '[]'
categories:
  - Blog
  - Community
  - Home

---
**February 18, 2015**

_by Manas Kelshikar_

Another busy week is behind us. Follow along this post to see what we have been up to.

###### COMMUNITY AND CONTENT

**GPG Pack**

Pack which allows integration with <a href="https://www.gnupg.org/" target="_blank">GnuPG</a>. The actions supported by this pack include:

<!--more-->

  * list_keys &#8211; List all the keys in the keyring.
  * import_keys &#8211; Import ASCII formatted keys from the provided file.
  * encrypt_file &#8211; Encrypt a file using asymmetric encryption for the provided recipient.
  * decrypt_file &#8211; Action which decrypts asymmetrically encrypted file.

Internally at StackStorm, we use this pack inside our workflow that processes files with debugging information. The encrypt\_file & decrypt\_file actions from this pack are used to encrypt and decrypt files with sensitive information.

Since they are actions, however, you can use them in other useful ways. There are all sorts of workflows that could use encryption.

###### PLATFORM

We’ve been acutely focused on improving workflow execution visibility and fixing bugs this week. Here is an overview of the changes:

  * **Refactors** 
      * Rename ActionExecution to LiveAction.
      * Rename ActionExecutionHistory to ActionExecution.
      * URL changes to match previous updates.
  * **New Features** 
      * Add new nequals (neq) rule criteria operator. This criteria operator performs not equals check on values of an arbitrary type. (_new-feature_)
  * **Bug Fixes** 
      * Fix a bug with template rendering, under some conditions, ending in an infinite loop.
      * Mistral subworkflows kicked off in st2 should include task name.

Our focus on refactors has been to help clarify the models; we have more similar changes in the pipeline. We these changes will make things clearer and result in a better user-experience going forward.

###### EVENTS

**SCALE 13x**

<a href="http://www.socallinuxexpo.org/scale/13x" target="_blank">Scale 13x</a> is almost here and we at StackStorm are stoked about presenting and being part of the event. Check out our <a href="https://pbs.twimg.com/media/B9_bdlsCYAAjQjc.jpg" target="_blank">snazzy flyer</a> below.

<img loading="lazy" class="alignnone wp-image-2585 size-full" src="http://stackstorm.com/wp/wp-content/uploads/2015/02/B9_bdlsCYAAjQjc.jpg" alt="StackStorm_Scale13x" width="599" height="372" srcset="https://stackstorm.com/wp/wp-content/uploads/2015/02/B9_bdlsCYAAjQjc.jpg 599w, https://stackstorm.com/wp/wp-content/uploads/2015/02/B9_bdlsCYAAjQjc-300x186.jpg 300w" sizes="(max-width: 599px) 100vw, 599px" /> 

For more details and information about other events, please visit the <a href="http://stackstorm.com/events/" target="_blank">events page</a> on our website.

If you haven’t already, we invite you to check out our product by <a href="http://docs.stackstorm.com/install/index.html" target="_blank">installing StackStorm</a> and following the <a href="http://docs.stackstorm.com/start.html" target="_blank">quick start</a> instructions — it will take less than 30 minutes to give you a taste of our automation. Share your thoughts and ideas via [stackstorm@googlegroups.com][1], <a href="http://webchat.freenode.net/?channels=stackstorm" target="_blank">#stackstorm on irc.freenode.net</a> or on Twitter <a href="https://twitter.com/Stack_Storm" target="_blank">@Stack_Storm</a>.

 [1]: https://groups.google.com/forum/#!forum/stackstorm