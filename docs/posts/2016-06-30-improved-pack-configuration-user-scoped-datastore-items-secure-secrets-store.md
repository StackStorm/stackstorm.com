---
title: Improved pack configuration, user scoped datastore items and secure secrets store
author: Tomaz Muraus
type: post
date: 2016-06-30T15:35:33+00:00
url: /2016/06/30/improved-pack-configuration-user-scoped-datastore-items-secure-secrets-store/
dsq_thread_id:
  - 4950985422
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Blog
tags:
  - configs
  - configuration
  - datastore
  - integration packs
  - new feature
  - packs
  - secrets

---
**June 30, 2016**  
By Tomaz Muraus

The last couple of months, since the [Brocade acquisition][1], have been pretty busy for us here at StackStorm. We have been getting to know our new friends at Brocade, learning the typical networking use-cases and figuring out how we can use StackStorm to automate them and bring all the DevOps and data-center automation goodness to the networking space, while keeping StackStorm a generic DevOps automation platform.

As always, we have continued to support our users and the community. We also haven’t been slacking with the StackStorm feature development and improvements. We have worked hard to bring you two new releases in the last 2 months &#8211; [StackStorm v1.4][2] and [StackStorm v1.5][3].

StackStorm v1.5 which has been released just recently includes many new features and improvements so if you haven’t already, I would encourage you to go [check it out][3].

Today I will talk about the one of the major new features in StackStorm v1.5 which has been [discussed and requested many times in the past][4] already. That is improved pack configuration.

<!--more-->

## Background

In the previous versions of StackStorm, users would configure packs by editing **config.yaml** file in the pack directory. This approach works fine for simple use cases, but it breaks down for some of the more advanced ones (e.g. you want to use a different configuration value based on the user who has executed an action, etc.).

An example of a more advanced, but a pretty common use case is having two users with two different set of AWS / OpenStack credentials. You want these two users to create VMs and other resources using their credentials on the same instance of StackStorm. In addition to that, users also want to keep those credentials secret from each other. Before StackStorm v1.5 there was no simple and straight-forward way to achieve that.

In StackStorm v1.5, we solved all of those limitations and made the whole thing simple and straight-forward.

Another annoyance was that this config.yaml file was located inside the pack root directory and as such, was part of the pack. This means config was not separated from the code which made updating packs harder. This would get especially hairy if the config.yaml file template was updated upstream and user wanted to update the local pack &#8211; usually this would result in merge conflicts and require manual conflict resolution.

To resolve that and some of the other limitations of the old pack configuration, we have reworked pack configuration. You can learn more about it in the section below.

## Improved Pack Configuration

First thing we did is separated config from the upstream pack code. This means that the content of the pack doesn’t need to be modified by the user anymore. The user can now easily update the pack without worrying that the local config file would be overwritten by the upstream changes or similar.

Pack configuration is now stored inside the new **/opt/stackstorm/configs/** directory. The config file name needs to match the pack name. For example, for pack libcloud, config would previously live in **/opt/stackstorm/packs/libcloud/config.yaml**. The new location now is **/opt/stackstorm/configs/libcloud.yaml**.

This new config format includes some cool new features such as dynamic configuration values which are described in more details below, but if you don’t utilize those new features, the configuration file format is fully backward compatible. This means that migrating to the new approach is very easy. You simply need to move your existing configuration to the new location as shown in the example below:

<div id="gist37241087" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-move-sh" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-shell  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-move-sh-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-move-sh-LC1" class="blob-code blob-code-inner js-file-line">
                  mv /opt/stackstorm/packs/libcloud/config.yaml /opt/stackstorm/configs/libcloud.yaml
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

Keep in mind that this is just an example to give you an idea of how easy it is. We are big believers and advocates of Infrastructure as Code approach so in production scenarios, we would encourage all of our users to follow the same infrastructure as code practices as you do for any other code and config files.

In this case this would mean that at the very least you should version control the whole **/opt/stackstorm/configs/** directory and follow the same review and other practices as you do for any other code and config files.

## Dynamic Configuration Values

In addition to separating config from code, we also introduced some other new features. One of those is dynamic configuration values which allows users to utilize values from the datastore in the config.

To make it easier to understand this new feature, we will first dive into a couple of other features on top of which dynamic configurations values are built.

## User-scoped datastore items

Previously, all the datastore values were stored in a global scope. This means that no matter which user referenced a datastore value in a template using &#8220;{{system.datastore_key}}&#8221; notation, they would all get access to the same value.

In many scenarios this is desired (e.g. shared values, configuration, thresholds, etc.), but in some situations allowing users to scope values to themselves makes a lot more sense. One of the commonly requested features was allowing different users to utilize different sets of API credentials. This is important for security (limiting access) and auditing purposes. Many services such as AWS with IAM roles allow administrators to create different set of credentials for different users with limited access.

With this new feature, users can now set a datastore value which is scoped to themselves. This value is then only visible and accessible to the administrators and user who set the value (that assumes you are running enterprise version of StackStorm with RBAC of course).

For more information on this feature please refer to the documentation &#8211; [Scoping items stored in datastore][5].

## Encrypted datastore items (secrets)

Another feature introduced in StackStorm v1.5 is encrypted datastore values. This has been requested by many of enterprise customers and users.

This features allows users to store encrypted values in the datastore. Values are encrypted using AES256 symmetric encryption. The key file used to encrypt and decrypt values is generated by the StackStorm administrator.

The plaintext version of the encrypted datastore items is only accessible to an administrator and in the case of user-scoped items, also to the user who has set that value.

For more information on limitations and how to utilize this feature, please refer to the documentation &#8211; [Securing secrets in key value store][6].

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2016/06/vagrant@demo-data-stanley_061-300x230.png" alt="vagrant@demo: -data-stanley_061" width="700" height="538" class="aligncenter wp-image-5797" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/06/vagrant@demo-data-stanley_061-300x230.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/06/vagrant@demo-data-stanley_061-768x590.png 768w, https://stackstorm.com/wp/wp-content/uploads/2016/06/vagrant@demo-data-stanley_061.png 978w" sizes="(max-width: 700px) 100vw, 700px" /> 

In the example above we put everything together and set a user-scoped datastore item with key **api_key** and value **user1\_api\_key** which is also a secret. Because this value is also a secret, encrypted value (ciphertext) will be output by default, unless decrypted version is requested using **&#8211;decrypt** CLI flag. As mentioned above, the encrypted and plaintext version of this value can only be seen by the administrator and user who set the value.

## Putting it all together

Now that you have a basic understanding of user-scoped and encrypted datastore items I will explain how to pull everything together, including dynamic config values (values which point to a datastore item).

To utilize datastore item inside the config, you need to use the following Jinja template notation for the config value:

  * Global / system-scoped datastore items &#8211; &#8220;{{system.datastore\_key\_name}}&#8221;
  * User-scoped datastore items &#8211; &#8220;{{user.datastore\_key\_name}}&#8221;

For example:

<div id="gist37048035" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-my_pack-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-my_pack-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-my_pack-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-my_pack-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-my_pack-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">api_key</span>: <span class="pl-s"><span class="pl-pds">"</span>{{user.api_key}}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-my_pack-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-my_pack-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">api_secret</span>: <span class="pl-s"><span class="pl-pds">"</span>{{user.api_secret}}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-my_pack-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-my_pack-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">private_key_path</span>: <span class="pl-s"><span class="pl-pds">"</span>{{system.shared_key_path}}<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-my_pack-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-my_pack-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">region</span>: <span class="pl-s"><span class="pl-pds">"</span>us-west-1<span class="pl-pds">"</span></span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

In the example above, we utilize all the possible options (**api_key** and **api_secret** refer to encrypted user-scoped datastore item, **private_key** uses system scoped datastore item and **region** is a simple static value which doesn’t utilize any of the new features).

For this example config to work you also need a configuration file schema. This is an optional file stored in the root of a pack directory and named **config.schema.yaml**. This file is defined by the pack author and contains types and some other information about possible configuration file items.

This file is optional unless you want to utilize encrypted datastore values. In that case, you will need to declare configuration items as secret in the config schema as shown below (that is required to let StackStorm know that the value is secret and as such needs to be decrypted before use).

<div id="gist37048074" class="gist">
  <div class="gist-file" translate="no">
    <div class="gist-data">
      <div class="js-gist-file-update-container js-task-list-container file-box">
        <div id="file-config-schema-yaml" class="file my-2">
          <div itemprop="text" class="Box-body p-0 blob-wrapper data type-yaml  ">
            <table class="highlight tab-size js-file-line-container" data-tab-size="8" data-paste-markdown-skip>
              <tr>
                <td id="file-config-schema-yaml-L1" class="blob-num js-line-number" data-line-number="1">
                </td>
                
                <td id="file-config-schema-yaml-LC1" class="blob-code blob-code-inner js-file-line">
                  ---
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L2" class="blob-num js-line-number" data-line-number="2">
                </td>
                
                <td id="file-config-schema-yaml-LC2" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">api_key</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L3" class="blob-num js-line-number" data-line-number="3">
                </td>
                
                <td id="file-config-schema-yaml-LC3" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>API key<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L4" class="blob-num js-line-number" data-line-number="4">
                </td>
                
                <td id="file-config-schema-yaml-LC4" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L5" class="blob-num js-line-number" data-line-number="5">
                </td>
                
                <td id="file-config-schema-yaml-LC5" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">secret</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L6" class="blob-num js-line-number" data-line-number="6">
                </td>
                
                <td id="file-config-schema-yaml-LC6" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">required</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L7" class="blob-num js-line-number" data-line-number="7">
                </td>
                
                <td id="file-config-schema-yaml-LC7" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">api_secret</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L8" class="blob-num js-line-number" data-line-number="8">
                </td>
                
                <td id="file-config-schema-yaml-LC8" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>API secret<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L9" class="blob-num js-line-number" data-line-number="9">
                </td>
                
                <td id="file-config-schema-yaml-LC9" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L10" class="blob-num js-line-number" data-line-number="10">
                </td>
                
                <td id="file-config-schema-yaml-LC10" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">secret</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L11" class="blob-num js-line-number" data-line-number="11">
                </td>
                
                <td id="file-config-schema-yaml-LC11" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">required</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L12" class="blob-num js-line-number" data-line-number="12">
                </td>
                
                <td id="file-config-schema-yaml-LC12" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">regions</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L13" class="blob-num js-line-number" data-line-number="13">
                </td>
                
                <td id="file-config-schema-yaml-LC13" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>A list of API regions to<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L14" class="blob-num js-line-number" data-line-number="14">
                </td>
                
                <td id="file-config-schema-yaml-LC14" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L15" class="blob-num js-line-number" data-line-number="15">
                </td>
                
                <td id="file-config-schema-yaml-LC15" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">required</span>: <span class="pl-c1">true</span>
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L16" class="blob-num js-line-number" data-line-number="16">
                </td>
                
                <td id="file-config-schema-yaml-LC16" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">enum</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L17" class="blob-num js-line-number" data-line-number="17">
                </td>
                
                <td id="file-config-schema-yaml-LC17" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s"><span class="pl-pds">"</span>us-west-1<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L18" class="blob-num js-line-number" data-line-number="18">
                </td>
                
                <td id="file-config-schema-yaml-LC18" class="blob-code blob-code-inner js-file-line">
                  - <span class="pl-s"><span class="pl-pds">"</span>us-east-1<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L19" class="blob-num js-line-number" data-line-number="19">
                </td>
                
                <td id="file-config-schema-yaml-LC19" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">default</span>: <span class="pl-s"><span class="pl-pds">"</span>us-east-1<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L20" class="blob-num js-line-number" data-line-number="20">
                </td>
                
                <td id="file-config-schema-yaml-LC20" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">private_key_path</span>:
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L21" class="blob-num js-line-number" data-line-number="21">
                </td>
                
                <td id="file-config-schema-yaml-LC21" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">description</span>: <span class="pl-s"><span class="pl-pds">"</span>Path to the private key file to use<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L22" class="blob-num js-line-number" data-line-number="22">
                </td>
                
                <td id="file-config-schema-yaml-LC22" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">type</span>: <span class="pl-s"><span class="pl-pds">"</span>string<span class="pl-pds">"</span></span>
                </td>
              </tr>
              
              <tr>
                <td id="file-config-schema-yaml-L23" class="blob-num js-line-number" data-line-number="23">
                </td>
                
                <td id="file-config-schema-yaml-LC23" class="blob-code blob-code-inner js-file-line">
                  <span class="pl-ent">required</span>: <span class="pl-c1">false</span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

As you can see in the example above, we define types for all the config items (and you as a pack author are encouraged to do so), but to provide flexibility and make getting started easier, we don’t perform any validation yet.

In the future, we plan to introduce an optional strict validation mode. In that mode, all the static config value types will be validated against the valid types defined in the config schema. We call this “optional typing” and we believe it provides best of the both worlds &#8211; when you need to quickly prototype something and get started you don’t need to do anything, but in production you can enable strict validation mode. With strict validation mode, you will be able to catch a lot of common errors earlier when registering / loading the configs instead of at run time. This provides faster feedback and a better user experience.

Once you have defined the pack config you need to run the **st2-register-content &#8211;register-configs** command. This commands synchronizes config information on the file system with the database. You will need to run it every time you change the config file on disk.

For demonstration purposes, I will use an action which simply prints out the config values. In real life, this action would of course do something with the config values (e.g. authenticate against AWS API or similar) instead of just printing them out.

<img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2016/06/vagrant@demo-data-stanley_063.png" alt="vagrant@demo: -data-stanley_063" width="700" height="494" class="aligncenter wp-image-5798" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/06/vagrant@demo-data-stanley_063.png 987w, https://stackstorm.com/wp/wp-content/uploads/2016/06/vagrant@demo-data-stanley_063-300x212.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/06/vagrant@demo-data-stanley_063-768x542.png 768w" sizes="(max-width: 700px) 100vw, 700px" /> 

In the example above we ran the same action with two different StackStorm users (**user1** and **user2**). As you can see in the output, the actual config value printed are different &#8211; they resolved to a datastore item which is local to a particular user.

User-scoped datastore items and dynamic config values come especially handy in situations where you want to use different credentials for a particular user, different thresholds and so on.

## Quick note on backward compatibility

As mentioned above, existing config files (config.yaml) are fully backward compatible. If you want to separate config from the pack data and / or utilize new features, you simply need to move the existing config to **/opt/stackstorm/configs/my_pack.yaml**. In addition to that, if you want to utilize encrypted datastore values you also need to make sure that the pack contains a valid and correct **config.schema.yaml** file. If that’s not the case yet, we encourage you to contribute one &#8211; writing a config schema is very simple and you will make StackStorm a better place for everyone.

In addition to that, if both files are found (**/opt/stackstorm/packs/my_pack/config.yaml** and **/opt/stackstorm/configs/my_pack.yaml**), configs are merged from left to right and values in the new config have precedence over the old ones.

To make the migration easier, we also plan to support old-style configs for at least a couple of more months. Nevertheless, if you get a chance we would encourage you to migrate to the new and improved approach. This will make your life a lot easier since you will be able to update packs without potential merge conflicts and you will be able to utilize new features.

## Conclusion

We hope you are as excited as we are about the improved pack configuration, user-scoped datastore items, datastore secrets and other new features. Over the coming weeks, we will be updating existing packs inside StackStorm Exchange (add config.schema.yaml file, etc.) so you will be able to leverage this new functionality.

In the mean-time, we encourage you to try play with it and try it out. If a particular pack you are interested in hasn’t been updated yet and is missing a config schema, don’t be afraid. It is easy to add one yourself. If you get stuck or don’t know how to proceed, we are here to help.

As always, if you have questions or feedback, you can reach us at one of our [community channels.][7]

 [1]: https://stackstorm.com/2016/03/29/stackstorm-joining-brocade/
 [2]: https://stackstorm.com/2016/04/20/stackstorm-v1-4/
 [3]: https://stackstorm.com/2016/06/27/stackstorm-v1-5-alive/
 [4]: https://github.com/StackStorm/st2/issues/2542
 [5]: https://docs.stackstorm.com/datastore.html#scoping-items-stored-in-datastore
 [6]: https://docs.stackstorm.com/datastore.html?highlight=scoped#securing-secrets-in-key-value-store-admin-only
 [7]: https://stackstorm.com/community/