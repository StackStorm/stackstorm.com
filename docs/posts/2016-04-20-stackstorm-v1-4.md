---
title: StackStorm v1.4 is out
author: st2admin
type: post
date: 2016-04-21T01:55:07+00:00
url: /2016/04/20/stackstorm-v1-4/
dsq_thread_id:
  - 4763856008
thrive_post_fonts:
  - '[]'
tcb2_ready:
  - 1
categories:
  - Blog
  - News
tags:
  - release
  - release announcement

---
**April 20, 2016**  
_by Patrick Hoolboom_

<div>
  <p paraid="1002273465" paraeid="{fda7db7b-30a8-4a41-8ec5-256c4684d680}{133}">
    <span xml:lang="EN-US"><span>We are pleased to announce the availability of </span></span><span xml:lang="EN-US"><span>StackStorm</span></span><span xml:lang="EN-US"><span> v1.4.0. As always this release is a mix of new features, </span></span><span xml:lang="EN-US"><span>improvements on existing features and bug fixes. Lets take a </span></span><span xml:lang="EN-US"><span>quick dive into what&#8217;s new &#8211;</span></span>
  </p>
  
  <p paraid="1002273465" paraeid="{fda7db7b-30a8-4a41-8ec5-256c4684d680}{133}">
    </div> 
    
    <div>
      <p paraid="1471666196" paraeid="{cb84a6f8-745a-49e3-9550-f97a2c2f0626}{11}">
        <b><span xml:lang="EN-US"><span>Packages are the new way forward</span></span></b><span> </span>
      </p>
    </div>
    
    <div>
      <p paraid="91866301" paraeid="{cb84a6f8-745a-49e3-9550-f97a2c2f0626}{115}">
        <span xml:lang="EN-US"><span>Have you heard yet that we are now shipping packages i.e. debs and rpms for all our supported platform? We did debut these in beta form with v1.3.2 and are now ready to fully cut-over to installing </span></span><span xml:lang="EN-US"><span>StackStorm</span></span><span xml:lang="EN-US"><span> with standard packages. We are so excited by this that we will be publishing some more blogs about this topic very soon!</span></span><span> </span>
      </p>
    </div>
    
    <div>
      <p paraid="223105043" paraeid="{6d476b0c-8451-4783-bd9a-9cb1e1a13786}{87}">
        <span xml:lang="EN-US"><span>Head on over to <a href="https://docs.stackstorm.com/install/index.html">install docs</a> </span></span><span xml:lang="EN-US"><span>and check out the new install options.</span></span><span> </span>
      </p>
      
      <p>
        <!--more-->
      </p>
    </div>
    
    <div>
      <p paraid="118616658" paraeid="{93801c30-731c-4e20-baf1-673e403fc1e2}{30}">
        <b><span xml:lang="EN-US"><span>ChatOps</span></span></b><b><span xml:lang="EN-US"><span> updates</span></span></b><span> </span>
      </p>
    </div>
    
    <div>
      <p paraid="628815025" paraeid="{26a39b0f-0026-4b81-8d89-80074847546d}{207}">
        <span xml:lang="EN-US"><span>One major update was an ability to provide chat adapter specific extra properties e.g. if you would like to have message show up with different colors in Slack we now have support.</span></span><span> </span>
      </p>
    </div>
    
    <div>
      <div id="{fa1a07be-5558-4941-ba51-5e5b3ae32e5b}{18}" aria-hidden="true">
        <img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2016/04/download.png" alt="download" width="412" height="177" class="wp-image-5631 alignnone" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/04/download.png 810w, https://stackstorm.com/wp/wp-content/uploads/2016/04/download-300x129.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/04/download-768x330.png 768w" sizes="(max-width: 412px) 100vw, 412px" />
      </div>
      
      <p paraid="631661603" paraeid="{93801c30-731c-4e20-baf1-673e403fc1e2}{79}">
        <span></span><span xml:lang="EN-US"></span><span> </span><span xml:lang="EN-US"><span>Stay tuned for more updates in this space.</span></span><span> </span>
      </p>
      
      <p paraid="631661603" paraeid="{93801c30-731c-4e20-baf1-673e403fc1e2}{79}">
        </div> 
        
        <div>
          <p paraid="1759383130" paraeid="{2af6afe7-4da6-4c1b-b0c0-cca9c35879e5}{145}">
            <b><span xml:lang="EN-US"><span>CronTimer</span></span></b><b><span xml:lang="EN-US"><span> improvements</span></span></b><span> </span>
          </p>
        </div>
        
        <div>
          <p paraid="450696534" paraeid="{2af6afe7-4da6-4c1b-b0c0-cca9c35879e5}{186}">
            <span xml:lang="EN-US"><span>Now our implementation of </span></span><span xml:lang="EN-US"><span>cron</span></span><span xml:lang="EN-US"><span> based rules has a </span></span><span xml:lang="EN-US"><span>cron</span></span><span xml:lang="EN-US"><span> expression like support. This means you can use all the common cron expressions such as a-b, a,b,c, a/b, etc. For more information and examples please refer to the <a href="https://docs.stackstorm.com/latest/rules.html#core-st2-crontimer">documentation</a>.</span></span>
          </p>
          
          <p paraid="450696534" paraeid="{2af6afe7-4da6-4c1b-b0c0-cca9c35879e5}{186}">
            </div> 
            
            <div>
              <p paraid="1200888957" paraeid="{63a5e171-fd3c-4392-a06d-7f4b948d530a}{254}">
                <b><span xml:lang="EN-US"><span>Creating </span></span></b><b><span xml:lang="EN-US"><span>Python </span></span></b><b><span xml:lang="EN-US"><span>virtual</span></span></b><b><span xml:lang="EN-US"><span> </span></span></b><b><span xml:lang="EN-US"><span>environments</span></span></b><b><span xml:lang="EN-US"><span> from st2ctl</span></span></b><span> </span>
              </p>
            </div>
            
            <div>
              <p paraid="531815428" paraeid="{d7829f26-7b38-4f31-bd49-8a89cfe40a67}{1}">
                <span xml:lang="EN-US"><span>Now passing &#8211;register-setup-</span></span><span xml:lang="EN-US"><span>virtualenvs</span></span><span xml:lang="EN-US"><span> flag to the </span></span><span xml:lang="EN-US"><span>register-content</span></span><span xml:lang="EN-US"><span> script and </span></span><span xml:lang="EN-US"><span>st2ctl will create Python </span></span><span xml:lang="EN-US"><span>virtual environments for the registered packs. This can be used </span></span><span xml:lang="EN-US"><span>when packs are deployed independent of the packs.install actions or the virtual environments require updates.</span></span><span> This is usually the case in distributed HA deployments where StackStorm components such as action runner and sensor container run on many different servers.</span>
              </p>
              
              <div>
                <p paraid="1200888957" paraeid="{63a5e171-fd3c-4392-a06d-7f4b948d530a}{254}">
                  <b><span xml:lang="EN-US"><span>Python actions can now easily access the datastore</span></span></b>
                </p>
              </div>
              
              <div>
                <p paraid="531815428" paraeid="{d7829f26-7b38-4f31-bd49-8a89cfe40a67}{1}">
                  <span xml:lang="EN-US"><span>All the Python runner actions now get passed in &#8220;action_service&#8221; argument to the constructor. This argument is similar to the &#8220;sensor_service&#8221; in sensors and allows actions, among other things to easily access the datastore.</span></span>
                </p>
                
                <p paraid="531815428" paraeid="{d7829f26-7b38-4f31-bd49-8a89cfe40a67}{1}">
                  </div> 
                  
                  <div>
                    <p paraid="1200888957" paraeid="{63a5e171-fd3c-4392-a06d-7f4b948d530a}{254}">
                      <b><span xml:lang="EN-US"><span>Code framework for action alias tests</span></span></b><span> </span>
                    </p>
                  </div>
                  
                  <div>
                    <p paraid="531815428" paraeid="{d7829f26-7b38-4f31-bd49-8a89cfe40a67}{1}">
                      <span xml:lang="EN-US"><span>We have added code which makes it easier to write unit tests for action aliases. The best way to get started is to have a look at some examples on <a href="https://github.com/StackStorm/st2/blob/master/contrib/packs/tests/test_action_aliases.py">Github</a>.</span></span>
                    </p>
                    
                    <div>
                      <p paraid="936340373" paraeid="{8ae4bc75-f04f-4d3f-a179-8539acd0e277}{56}">
                        <b><span xml:lang="EN-US"><span>Support for timezones in the CLI</span></span></b><span> </span>
                      </p>
                    </div>
                    
                    <div>
                      <p paraid="1316148075" paraeid="{8ae4bc75-f04f-4d3f-a179-8539acd0e277}{106}">
                        <span xml:lang="EN-US"><span>When interacting with CLI all the timestamps are displayed in UTC by default. This was done intentionally to make it easier to collaborate inside a team where members are distributed across different timezones. In addition to that, best practice also is to have all the servers configured to use UTC and this makes correlation easier.</span></span>
                      </p>
                      
                      <p paraid="1316148075" paraeid="{8ae4bc75-f04f-4d3f-a179-8539acd0e277}{106}">
                        Having said that, some people still prefer to have timestamps displayed in their local timezone. Users can now configure &#8220;timezone&#8221; in the CLI config (~/.st2/config) and all the tiemstamps in the CLI will be re-formatted and displayed in the configured timezone.
                      </p>
                      
                      <p paraid="1316148075" paraeid="{8ae4bc75-f04f-4d3f-a179-8539acd0e277}{106}">
                        <img loading="lazy" src="http://stackstorm.com/wp/wp-content/uploads/2016/04/vagrant@vagrant-ubuntu-trusty-64-data-stanley_017-1024x584.png" alt="vagrant@vagrant-ubuntu-trusty-64: -data-stanley_017" width="1024" height="584" class="alignnone wp-image-5633 size-large" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/04/vagrant@vagrant-ubuntu-trusty-64-data-stanley_017-1024x584.png 1024w, https://stackstorm.com/wp/wp-content/uploads/2016/04/vagrant@vagrant-ubuntu-trusty-64-data-stanley_017-300x171.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/04/vagrant@vagrant-ubuntu-trusty-64-data-stanley_017-768x438.png 768w, https://stackstorm.com/wp/wp-content/uploads/2016/04/vagrant@vagrant-ubuntu-trusty-64-data-stanley_017.png 1068w" sizes="(max-width: 1024px) 100vw, 1024px" />
                      </p>
                    </div>
                    
                    <p paraid="531815428" paraeid="{d7829f26-7b38-4f31-bd49-8a89cfe40a67}{1}">
                      </div> </div> 
                      
                      <div>
                        <p paraid="936340373" paraeid="{8ae4bc75-f04f-4d3f-a179-8539acd0e277}{56}">
                          <b><span xml:lang="EN-US"><span>Out-of-box action improvements</span></span></b><span> </span>
                        </p>
                      </div>
                      
                      <div>
                        <p paraid="1316148075" paraeid="{8ae4bc75-f04f-4d3f-a179-8539acd0e277}{106}">
                          <span xml:lang="EN-US"><span>Stock actions like </span></span><span xml:lang="EN-US"><span>core.sendmail, </span></span><span xml:lang="EN-US"><span>linux.wait_for_ssh</span></span><span xml:lang="EN-US"><span>, linux.traceroute and linux.rm get some much needed fixes.</span></span><span> </span>
                        </p>
                        
                        <p paraid="1316148075" paraeid="{8ae4bc75-f04f-4d3f-a179-8539acd0e277}{106}">
                          </div> 
                          
                          <div>
                            <p xml:lang="EN-US" paraid="615541718" paraeid="{6e339914-48f7-432c-a3d9-e4e4bc23666f}{162}">
                              <b><span xml:lang="EN-US"><span>Community contributions</span></span></b><span> </span>
                            </p>
                          </div>
                          
                          <div>
                            <p xml:lang="EN-US" paraid="1309620650" paraeid="{6e339914-48f7-432c-a3d9-e4e4bc23666f}{193}">
                              <span xml:lang="EN-US"><span>The </span></span><span xml:lang="EN-US"><span>StackStorm</span></span><span xml:lang="EN-US"><span> community has been very busy and active over the last few months. There have been some </span></span><span xml:lang="EN-US"><span>new community contributed packs for &#8211;</span></span><span> </span>
                            </p>
                          </div>
                          
                          <ul>
                            <li>
                              <a href="https://github.com/StackStorm-Exchange/stackstorm-alertlogic"><span xml:lang="EN-US"><span>Al</span></span><span xml:lang="EN-US"><span>ertL</span></span><span xml:lang="EN-US"><span>ogic</span></span></a><span> </span>
                            </li>
                            <li>
                              <a href="https://github.com/StackStorm-Exchange/stackstorm-duo"><span xml:lang="EN-US"><span>Duo (2FA)</span></span></a><span> </span>
                            </li>
                            <li>
                              <a href="https://github.com/StackStorm-Exchange/stackstorm-vault"><span xml:lang="EN-US"><span>Vault</span></span></a><span> </span>
                            </li>
                            <li>
                              <a href="https://github.com/StackStorm-Exchange/stackstorm-mssql"><span xml:lang="EN-US"><span>MSSQL</span></span></a><span> </span>
                            </li>
                            <li>
                              <a href="https://github.com/StackStorm-Exchange/stackstorm-orion"><span xml:lang="EN-US"><span>Solarwinds</span></span><span xml:lang="EN-US"><span> Orion</span></span></a><span> </span>
                            </li>
                          </ul>
                          
                          <div>
                            <p xml:lang="EN-US" paraid="1962472075" paraeid="{c2794baa-4344-4949-b31b-f2364c03fc54}{90}">
                              <span xml:lang="EN-US"><span>Plus, a ton of additions and bug fixes across the board. To us the incredible part is that in the last 2 months there have been more community contributions to packs than contributions from </span></span><span xml:lang="EN-US"><span>StackStorm</span></span><span xml:lang="EN-US"><span> members. The </span></span><span xml:lang="EN-US"><span>StackSt</span></span><span xml:lang="EN-US"><span>orm</span></span><span xml:lang="EN-US"><span> community rocks!</span></span><span> </span>
                            </p>
                            
                            <p xml:lang="EN-US" paraid="1962472075" paraeid="{c2794baa-4344-4949-b31b-f2364c03fc54}{90}">
                              <strong>And much more!</strong>
                            </p>
                          </div>
                          
                          <div>
                            <p paraid="1384422509" paraeid="{93801c30-731c-4e20-baf1-673e403fc1e2}{16}">
                              <span xml:lang="EN-US"><span>For a complete list of updates and bug </span></span><span xml:lang="EN-US"><span>fixes</span></span><span xml:lang="EN-US"><span> see the</span></span><span xml:lang="EN-US"><span> </span></span><a href="https://github.com/StackStorm/st2/blob/master/CHANGELOG.rst#140---april-18-2016"><span xml:lang="EN-US"><span>changelog</span></span></a><span xml:lang="EN-US"><span>. Special </span></span><span xml:lang="EN-US"><span>shout</span></span><span xml:lang="EN-US"><span>&#8211;</span></span><span xml:lang="EN-US"><span>out</span></span><span xml:lang="EN-US"><span> to community </span></span><span xml:lang="EN-US"><span>member</span></span><span xml:lang="EN-US"><span>s</span></span><span xml:lang="EN-US"><span> </span></span><span xml:lang="EN-US"><span>Jon Middleton, </span></span><span xml:lang="EN-US"><span>Kale Blankenship, </span></span><span xml:lang="EN-US"><span>David Pitman, </span></span><span xml:lang="EN-US"><span>Andrew </span></span><span xml:lang="EN-US"><span>Regan, </span></span><span xml:lang="EN-US"><span>Cody</span></span><span xml:lang="EN-US"><span> A. Ray</span></span><span xml:lang="EN-US"><span>,</span></span><span xml:lang="EN-US"><span> </span></span><span xml:lang="EN-US"><span>Jamie Evans </span></span><span xml:lang="EN-US"><span>and Paul </span></span><span xml:lang="EN-US"><span>Mulvihill</span></span><span xml:lang="EN-US"><span> </span></span><span xml:lang="EN-US"><span>for contributions and helping us make this release possible.</span></span><span> </span>
                            </p>
                            
                            <p paraid="1384422509" paraeid="{93801c30-731c-4e20-baf1-673e403fc1e2}{16}">
                              </div> 
                              
                              <div>
                                <p paraid="150366353" paraeid="{3e15541f-9411-423a-a5c6-5a36bc2ead42}{243}">
                                  <span xml:lang="EN-US"><span>We hope you try </span></span><span xml:lang="EN-US"><span>StackStorm</span></span><span xml:lang="EN-US"><span> and look forward </span></span><span xml:lang="EN-US"><span>to</span></span><span xml:lang="EN-US"><span> feedback on what works and what does so that we can continually improve </span></span><span xml:lang="EN-US"><span>StackStorm</span></span><span xml:lang="EN-US"><span>. You can find us on t</span></span><span xml:lang="EN-US"><span>he </span></span><a href="https://stackstorm.com/community-signup/"><span title="Sorry, Word Online can't open this link. To go to this link, please open this document in Microsoft Word." xml:lang="EN-US"><span>StackStorm slack community</span></span></a><span xml:lang="EN-US"><span> or tweet us at @</span></span><span xml:lang="EN-US"><span>Stack_Storm</span></span><span xml:lang="EN-US"><span>.</span></span><span> </span>
                                </p>
                              </div>