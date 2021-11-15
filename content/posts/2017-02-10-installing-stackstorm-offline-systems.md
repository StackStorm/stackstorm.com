---
title: Installing StackStorm on Offline Systems
author: st2admin
type: post
date: 2017-02-10T17:45:13+00:00
url: /2017/02/10/installing-stackstorm-offline-systems/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5539956299
categories:
  - Blog
  - Tutorials
tags:
  - tutorial

---
**Feb 10, 2017**  
_by Siddharth Krishna_

Want to install StackStorm on a machine that doesn’t have access to the internet? If you’ve got another box on your local network that connects to the public network, you can do this by making it a local package repository server. In this post, we’ll walk you through steps for setting up an apt-mirror server with the required packages and configuring the **offline** client machine to quickly get a full StackStorm installation up and running!

<!--more-->

> **Note:** We are using Ubuntu on the mirror server and therefore going with apt-mirror in the example here. You can build a local Yum repository in case you are running RHEL/CentOS. 

### Setting up the Mirror

1) Let’s assume that you already have an apt-mirror server with packages for an Ubuntu distribution in place: see an example guide [here][1]. As part of this, you would need to install the apache web server as well. It’s used to make the repositories accessible from the client machine (ST2 installation target) over HTTP.

2) The following packages should be made available on the local package repository for a complete installation of StackStorm (including Web UI, Chatops etc.):

  * **ST2:** https://packagecloud.io/StackStorm/stable/ubuntu/
  * **Mongodb:** http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2
  * **Nodejs:** https://deb.nodesource.com/node_6.x 
  * **Nginx:** http://nginx.org/packages/ubuntu/

Add the custom repository URL details for these packages to the apt mirror.list file on the server.

<pre>sudo vi /etc/apt/mirror.list
..
deb https://packagecloud.io/StackStorm/stable/ubuntu/ trusty main
deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse
deb https://deb.nodesource.com/node_6.x trusty main
deb http://nginx.org/packages/ubuntu/ trusty nginx

deb-src https://packagecloud.io/StackStorm/stable/ubuntu/ trusty main
..</pre>

3) Update the mirror to download the required packages on the local mirror:`sudo apt-mirror`

Directories for each of the new packages should get created inside the apt-mirror base path (`set base_path`):

<pre>/aptmirror/mirror/packagecloud.io/StackStorm/stable/ubuntu/
/aptmirror/mirror/repo.mongodb.org/apt/ubuntu/
/aptmirror/mirror/deb.nodesource.com/node_6.x/
/aptmirror/mirror/nginx.org/packages/ubuntu/</pre>

### Making the Repos Accessible

4) Configure the webserver on the local mirror to make the repositories accessible over HTTP from the client machine by creating symbolic links to each of the repos in the `/var/www/html/` directory.

<pre>brocade@apt-mirror:/var/www/html$ ls -l
total 0
lrwxrwxrwx 1 root root 46 Jan  9 04:29 mongodb -&gt; /aptmirror/mirror/repo.mongodb.org/apt/ubuntu/
lrwxrwxrwx 1 root root 44 Jan 10 02:30 nginx -&gt; /aptmirror/mirror/nginx.org/packages/ubuntu/
lrwxrwxrwx 1 root root 46 Jan  9 04:29 nodejs -&gt; /aptmirror/mirror/deb.nodesource.com/node_6.x/
lrwxrwxrwx 1 root root 47 Jan  9 04:29 st2 -&gt; /aptmirror/mirror/packagecloud.io/StackStorm/stable/ubuntu/
lrwxrwxrwx 1 root root 44 Jan  9 02:44 ubuntu -&gt; /aptmirror/mirror/archive.ubuntu.com/ubuntu/
</pre>

Restart the web server: `sudo service apache2 restart`

Verify the repository directory structure in web browser: `http://local-mirror-ip/`

### Setting up the Offline Client System

5) Modify apt sources to point to the local mirror server for all packages – Ubuntu, ST2, MongoDb, NodeJS and Nginx. Replace `mirror` with the hostname or IP of the local mirror server:

<pre>sudo vi /etc/apt/sources.list</pre>

Comment out (#) all existing content and replace with the following:

<pre>deb http://mirror/ubuntu/ trusty main restricted universe multiverse
deb http://mirror/ubuntu/ trusty-security main restricted universe multiverse
deb http://mirror/ubuntu/ trusty-updates main restricted universe multiverse

deb http://mirror/st2 trusty_stable main
deb http://mirror/mongodb/ trusty/mongodb-org/3.2 multiverse
deb http://mirror/nodejs trusty main
deb http://mirror/nginx trusty nginx
</pre>

Update package information: `sudo apt-get update`

### GPG Key Errors?

At this point you might hit some GPG signing errors for the custom packages on the client:

`The following signatures couldn't be verified because the public key is not available: NO_PUBKEY`

To fix this, do the following:

**On Server:**

<pre>sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv
sudo apt-key export &gt; exportedkey
</pre>

Move the exportedkey file to the client.  
Note: In case you are facing errors for multiple keys, you may use the following instead:

<pre>sudo apt-key exportall &gt; exportedkey(s) </pre>

**On Client:**

<pre>sudo apt-key add exportedkey(s)</pre>

Retry `apt-get update`

6) All required packages should now be downloadable from the local mirror server using `sudo apt-get install –y` command. The one-line installation process won&#8217;t work for this system. You&#8217;ll need to follow the manual install steps documented [here][2]. Or better yet, use something like Ansible to configure your system. Note that you do not need to setup any custom repositories on the client system. We have already done this by pointing apt towards the local repository server. Install the dependencies directly using `sudo apt-get install –y st2|st2mistral|mongodb|nginx|nodejs|st2chatops` instead.

### What Next?

You should now have StackStorm running. [Verify][3] the installation. Since its in offline system, the usual pack install process won&#8217;t work on it. One of the ways of working around this is to use an [HTTP proxy][4]. In a follow-up blog I&#8217;ll show you how to set that up.

 [1]: http://linoxide.com/ubuntu-how-to/setup-local-repository-ubuntu/
 [2]: https://docs.stackstorm.com/install/deb.html
 [3]: https://docs.stackstorm.com/install/deb.html#verify
 [4]: https://docs.stackstorm.com/reference/proxy.html