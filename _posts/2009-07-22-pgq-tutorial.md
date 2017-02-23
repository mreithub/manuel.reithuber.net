---
id: 3
title: PG/Q Tutorial
date: 2009-07-22T23:46:09+00:00
author: Manuel Reithuber
layout: post
guid: http://manuel.reithuber.net/?p=3
permalink: /2009/07/pgq-tutorial/
categories:
  - Databases
tags:
  - howto
  - pg
  - postgres
  - postgresql
  - tutorial
---
This article is meant to be a short tutorial on how to setup PG/Q for your databases.

PG/Q is a PostgreSQL module providing a queuing system. It&#8217;s developed by Skype and published under the terms of the BSD license.
  
It&#8217;s part of the [SkyTools](https://developer.skype.com/SkypeGarage/DbProjects/SkyTools) package.

### Notes

  * You need root privileges on your database server
  * PG/Q uses a ticker process to distribute the events to the consumers. That&#8217;s why you have be able to run a daemon process on the database server.
  * The pgqadm python script is called pgqadm.py if you&#8217;re not installing the .deb from the Debian Sid repositories
  * If you find errors in this howto, please contact me

### SkyTools Installation

**There are package in debian sid** that&#8217;ll do the trick (called skytools and skytools-modules-8.3) but however, if your debian doesn&#8217;t provice packages or you just want a more recent version, here&#8217;s how to build the debian packages yourself:

#### Download SkyTools

Go to the [download page](http://pgfoundry.org/frs/?group_id=1000206 "SkyTools download page") and download the most recent source package.

Unzip it either graphically or with the following command:

<p class="code">
  tar xfz skytools-2.1.9.tar.gz
</p>

Change to the newly extracted directory:

<p class="code">
  cd skytools-2.1.9
</p>

#### Building the package

To make sure you&#8217;ve got the required dependencies installed, run (**as root**):

<p class="code">
  apt-get install postgresql libpq-dev postgresql-server-dev-8.3 python python-dev
</p>

And for the Package creation:

<p class="code">
  apt-get install devscripts yada
</p>

After that you just have to start the build process using

<p class="code">
  make deb83
</p>

If you&#8217;ve got an older/newer postgresql-server version, <tt>deb82</tt>, <tt>deb81</tt> or anything like that.

After make is finished, there should be two .deb files in the parent directory:

<p class="code">
  cd ..<br /> ls -l *.deb
</p>

will output something like that:

<pre>-rw-r--r-- 1 manuel manuel 136304 16. Jul 09:52 skytools_2.1.9_i386.deb
-rw-r--r-- 1 manuel manuel  47572 16. Jul 09:52 skytools-modules-8.3_2.1.9_i386.deb</pre>

Now just run dpkg -i to install them:

<p class="code">
  dpkg -i skytools_2.1.9_i386.deb skytools-modules-8.3_2.1.9_i386.deb
</p>

### Create pgqadm configuration

pgqadm is a command line tool for PG/Q that helps you setup your database and provides an event ticker to distribute the events to the consumers.

I recommend to create a new user for pgqadmin:

<p class="code">
  adduser &#8211;system pgqadm<br /> su pgqadm -s /bin/bash<br /> cd ~<br /> mkdir cfg log pid
</p>

and in your database:

<p class="code">
  CREATE ROLE pgqadm LOGIN;
</p>

It&#8217;s not necessary to provide a password for pgqadm because we&#8217;ll use IDENT authentication to connect to the database (unless you&#8217;ve configured your system not to).

<span>pgqadm</span> needs a config file for every database it should manage:

<pre class="code">[pgqadm]

# part of the .pid file, should be globally unique
job_name = pgqadm_dbname

# database connection string
db = dbname=dbname

# how often to run maintenance [minutes]
maint_delay_min = 5

# how often to check for activity [secs]
loop_delay = 0.1

logfile = ~/log/%(job_name)s.log
pidfile = ~/pid/%(job_name)s.pid

use_skylog = 0
</pre>

Modify the config file to suit your needs and save it (e.g. as <span>/home/pgqadm/cfg/dbname.ini</span>).

### Setup your Database

To enable PG/Q for your database, several tables and functions have to be created. pgqadm does this for you if you invoke

<p class="code">
  pgqadm /home/pgqadm/cfg/dbname.ini install
</p>

### Autostart pgqadm ticker daemon

Unless the pgqadm ticker is started, no events can be recieved.

I&#8217;d recommend writing an init script to start it for all your databases:

<https://svn.fakeroot.at/svn/pgq/pgqadm_ticker>

save this script as <span>/etc/init.d/pgqadm_ticker</span> and make it executable:

<p class="code">
  chmod +x /etc/init.d/pgqadm_ticker
</p>

use update-rc.d to automatically start it

<p class="code">
  update-rc.d pgqadm_ticker defaults
</p>

That should be it. Now just start the deamon manually (you just need to do this the first time)

<p class="code">
  /etc/init.d/pgqadm_ticker start
</p>

### Use PG/Q

The following commands are all SQL statements.
  
It&#8217;s also possible to use pgqadm for these tasks. Read the manual page of pgqadm for further help.

First you have to create a queue:

<p class="code">
  pgq.create_queue(&#8216;<em>queueName</em>&#8216;);
</p>

#### Producer side

After that, events can be created (e.g. in trigger functions):

<p class="code">
  pgq.insert_event(&#8216;<em>queueName</em>&#8216;, &#8216;<em>eventType</em>&#8216;, &#8216;<em>data</em>&#8216;);
</p>

#### Consumer side

To receive events, you have to register a &#8220;Consumer&#8221;:

<p class="code">
  pgq.register_consumer(&#8216;<em>queueName</em>&#8216;, &#8216;<em>consumerName</em>&#8216;);
</p>

Every consumer will receive all of the events.

Pseudo-code:

<pre>int8 batchId;
-- infinite loop
  batchId = pgq.next_batch('<em>queueName</em>', '<em>consumerName</em>');
  if (batchId == null) then sleep(delayInterval);
  else {

  }
  pgq.finish_batch(batchId);
-- end infinite loop</pre>

#### Sources

  * [SkyTools installation guide](http://skytools.projects.postgresql.org/doc/INSTALL.html)
  * [PG/Q SQL API overview](http://skytools.projects.postgresql.org/doc/pgq-sql.html)
  * pgqadm man page