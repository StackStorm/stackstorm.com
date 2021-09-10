---
title: Genomics Sequencing, StackStorm, and Reading the Source Code of Biology
author: st2admin
type: post
date: 2016-11-15T19:26:11+00:00
url: /2016/11/15/genomics-sequencing-stackstorm-reading-source-code-biology/
thrive_post_fonts:
  - '[]'
dsq_thread_id:
  - 5306702785
categories:
  - Blog
tags:
  - automation
  - Big Data
  - Genomics
  - Genomics Sequencing
  - High Performance Computing
  - Sequencing Operations
  - StackStorm
  - Super Computing

---
**By Dana Christensen**  
_Nov 15, 2016_

The DevOps movement is focused on leading transformational change and driving innovation. At the recent DevOps Enterprise Summit in San Francisco, many of the leaders in the field spoke of driving change through a culture focused on collaboration, community, co-creation, curiosity, continual learning, designing for joy, and meaningful work. I have been impressed with the passion and conviction that leaders in the DevOps movement speak about and emphasize these key principles.. Through determination and focus, living out these key values, and recognizing that everyone has a role to play—we will be able to truly unlock the power of technology to address the many complex global challenges we face today.

An excellent example of leveraging DevOps and technology to address complex global challenges is found in the field of Genomics Research. Through focus on the values spoken about by DevOps thought leaders and innovation at the speed of community—Science, Universities, Government, and Business, powered by advances in IT, are able to join forces to develop and evolve techniques that allow for the reading of the source code of biology—something that is incredibly complex and in parts extremely optimized. Through this important work, we are just beginning to unlock the secrets and miraculous mysteries to life on earth as we know it.

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2016/11/genomics-cartoon.png" alt="genomics-cartoon" width="645" height="306" class="aligncenter wp-image-6283 size-full" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/11/genomics-cartoon.png 645w, https://stackstorm.com/wp/wp-content/uploads/2016/11/genomics-cartoon-150x71.png 150w, https://stackstorm.com/wp/wp-content/uploads/2016/11/genomics-cartoon-300x142.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/11/genomics-cartoon-80x38.png 80w, https://stackstorm.com/wp/wp-content/uploads/2016/11/genomics-cartoon-220x104.png 220w, https://stackstorm.com/wp/wp-content/uploads/2016/11/genomics-cartoon-211x100.png 211w, https://stackstorm.com/wp/wp-content/uploads/2016/11/genomics-cartoon-280x133.png 280w, https://stackstorm.com/wp/wp-content/uploads/2016/11/genomics-cartoon-502x238.png 502w, https://stackstorm.com/wp/wp-content/uploads/2016/11/genomics-cartoon-632x300.png 632w" sizes="(max-width: 645px) 100vw, 645px" /> <!--more-->

### Genomics Sequencing Puts the “Big” in Big Data

The field of genomics puts the “Big” in Big Data. In short, it is projected that by 2025 genomics will produce about 1 zetta-bases per year (that is roughly the same amount in zeta-bytes) &#8211; following a trend of doubling in sequencing capacity every 12 months. Genomics presents some of the most demanding computational requirements that we will face in the coming decade. These challenges will only be met through the power of community—where generative collaboration, co-creation, trust and sharing can can create an environment conducive to creating solutions that will unleash the power of genomics sequencing.

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2016/11/growth-dna-sequencing.png" alt="growth-dna-sequencing" width="656" height="398" class="aligncenter size-full wp-image-6282" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/11/growth-dna-sequencing.png 656w, https://stackstorm.com/wp/wp-content/uploads/2016/11/growth-dna-sequencing-150x91.png 150w, https://stackstorm.com/wp/wp-content/uploads/2016/11/growth-dna-sequencing-300x182.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/11/growth-dna-sequencing-80x49.png 80w, https://stackstorm.com/wp/wp-content/uploads/2016/11/growth-dna-sequencing-220x133.png 220w, https://stackstorm.com/wp/wp-content/uploads/2016/11/growth-dna-sequencing-165x100.png 165w, https://stackstorm.com/wp/wp-content/uploads/2016/11/growth-dna-sequencing-247x150.png 247w, https://stackstorm.com/wp/wp-content/uploads/2016/11/growth-dna-sequencing-392x238.png 392w, https://stackstorm.com/wp/wp-content/uploads/2016/11/growth-dna-sequencing-494x300.png 494w" sizes="(max-width: 656px) 100vw, 656px" /> 

The PLOS article <a href="http://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1002195" target="_blank">Big Data: Astromical or Genomical?</a> provides an interesting overview of the challenges faced when managing this amount of data.

As discussed in the PLOS article, there are four components that comprise the “life cycle” of the Genomics dataset: Acquisition, Storage, Data Distribution, and Analysis. Each of these domains contains it’s own set of challenges for the community.

In the area of data acquisition, in order to sustain the explosive growth in genomic data sequencing, it is critical to advance the development and application of technologies that reduce cost, increase throughput, and minimize human errors—all of which can only be accomplished at scale with automation. This is where [StackStorm][1] fits into the equation.

### StackStorm Event Driven Automation & Big Data Genomics Sequencing

I recently had the opportunity to connect with members of the StackStorm community from SciLifeLab, a national center for molecular bioscience, hosted by Uppsala University, Stockholm University, KTH and the Karolinska Institute. The team there is responsible for the development and operations of SNP&SEQ (<a href="http://www.sequencing.se" target="_blank">http://www.sequencing.se</a>), a technology platform that provides sequencing and genotyping services for researchers, primarily within Sweden, but also some from abroad. Together with a couple of other sequencing platforms in Uppsala and Stockholm, they comprise the National Genomics Infrastructure, NGI, which is the largest technology platform within SciLifeLab, and one of the biggest sequencing centers in Europe (<a href="https://www.scilifelab.se/platforms/ngi/" target="_blank">https://www.scilifelab.se/platforms/ngi/</a>).

This year SNP&SEQ is expected to produce roughly 500 TB of data – following the industry trend of doubling capacity every 12 months. At SciLifeLab, the team’s answer to the challenge of scaling, while lowering costs, increasing throughput, and minimizing human errors is the Arteria Project (<a href="https://arteria-project.github.io/" target="_blank">https://arteria-project.github.io/</a>).

The team has leveraged the power of StackStorm as a hub to automate and streamline their complex sequencing workflows. StackStorm has played an instrumental role in allowing the facility to continue to scale with a relatively small team managing sequence operations. By leveraging StackStorm for automation, the team has been able to focus on the specifics of their “business case” rather than building up their own systems and interfaces.

<img loading="lazy" src="https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-genomics.png" alt="stackstorm-genomics" width="535" height="387" class="aligncenter size-full wp-image-6284" srcset="https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-genomics.png 535w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-genomics-150x109.png 150w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-genomics-300x217.png 300w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-genomics-80x58.png 80w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-genomics-220x159.png 220w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-genomics-138x100.png 138w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-genomics-207x150.png 207w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-genomics-329x238.png 329w, https://stackstorm.com/wp/wp-content/uploads/2016/11/stackstorm-genomics-415x300.png 415w" sizes="(max-width: 535px) 100vw, 535px" /> 

StackStorm is being used primarily to drive their main processing and quality control pipeline. The implementation consists of microservices running on a local compute farm, and a master node running all the StackStorm components. The current StackStorm use case involves sensors, events, and triggers that automate the processing of raw genomics data through a complex workflow that is quite large and long-running—it generally finishes within 24 hours. When the last reports are generated on the remote super-computing center, there are manual processes that kick off delivery of the data to the researcher, and in the case of human DNA, also runs a separate downstream best practice pipeline called <a href="https://github.com/NationalGenomicsInfrastructure/piper" target="_blank">Piper</a>. Incorporating these downstream processes within the main Mistral workflow, so that more of their work gets automated, is work in progress at the moment.

Besides the workflows for sequence processing, the team is also making heavy usage of Stackstorm traces. They tag all their workflow runs with tags unique for each sequencing run, so that they can go back in history and check all associated executions with their <a href="https://github.com/arteria-project/arteria-packs/blob/master/scripts/trace_runfolder.py" target="_blank">custom script</a> .This comes in handy when troubleshooting and also for auditing purposes (which is important for them as they are an accredited facility).

### Innovation at the Speed of Community

StackStorm is a powerful event-driven automation platform, which provides the flexibility and autonomy needed for the team to unleash the team’s creativity&#8211;providing the freedom to innovate and automate genomic sequencing operations. The team’s work caters to the entire Swedish research community—so serves a very wide variety of research including—Cancer, Cardiovascular disease, and Microbial genetics. A list of publications which have used the lab’s resources is available here.

Two examples of recent interesting pre-prints/publications that have carried out sequencing at their facility are

<a href="https://www.scilifelab.se/news/the-first-map-of-genetic-variation-in-sweden/" target="_blank">SweGen</a>: A whole-genome map of genetic variability in a cross section of the Swedish population In which a 1000 Swedish individuals have been sequenced in order to provide a genetic base-line for the population, something which is of great interest to both population genetics, but also in clinical research applications where these samples can then be used as controls.

<a href="https://www.scilifelab.se/research/scientific-highlights/scientific-highlights-2015/an-unprecedented-insight-into-the-origin-of-the-eukaryotic-cell/" target="_blank">Complex archaea that bridge the gap between prokaryotes and eukaryotes</a>: A group using the resources were able to identify what is possible the missing link between prokaryotes (bacteria) and eukaryotes (that part of the evolutionary tree to which e.g. humans belong) by sequencing samples from an hydrothermal vent called Loki&#8217;s Castle.

As a member of the StackStorm team, it is gratifying to know that StackStorm technology is part of the effort to solve these challenges, and to think of the benefits that this research will bring to millions of people around the world.

Interested to learn how [StackStorm][1] can help you address your Genomics or other Big Data challenges? Install StackStorm, join conversation, and help drive innovation at the speed of community.

 [1]: https://stackstorm.com