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
  - postgres
  - tutorial
---
This article is meant to be a short tutorial on how to setup PG/Q for your databases.

PG/Q is a PostgreSQL module providing a queuing system. It's developed by Skype and published under the terms of the BSD license.
  
It's part of the [SkyTools](https://developer.skype.com/SkypeGarage/DbProjects/SkyTools) package.

### Notes

  * You need root privileges on your database server
  * PG/Q uses a ticker process to distribute the events to the consumers. That's why you have be able to run a daemon process on the database server.
  * The pgqadm python script is called pgqadm.py if you're not installing the .deb from the Debian Sid repositories
  * If you find errors in this howto, please contact me

### SkyTools Installation

**There are package in debian sid** that'll do the trick (called `skytools` and `skytools-modules-8.3`) but however, if your debian doesn't provice packages or you just want a more recent version, here's how to build the debian packages yourself:

#### Download SkyTools

Go to the [download page](http://pgfoundry.org/frs/?group_id=1000206 "SkyTools download page") and download the most recent source package.

Unzip it either graphically or with the following command:

```bash
tar xfz skytools-2.1.9.tar.gz
```

<!--snip-->

Change to the newly extracted directory:

```bash
cd skytools-2.1.9
```

#### Building the package

To make sure you've got the required dependencies installed, run (**as root**):

```bash
apt-get install postgresql libpq-dev postgresql-server-dev-8.3 python python-dev
```

And for the Package creation:

```bash
apt-get install devscripts yada
```

After that you just have to start the build process using

```bash
make deb83
```

If you've got an older/newer postgresql-server version, `deb82`, `deb81` or anything like that.

After make is finished, there should be two .deb files in the parent directory:

```bash
cd ..
ls -l *.deb
```

will output something like that:

    -rw-r--r-- 1 manuel manuel 136304 16. Jul 09:52 skytools_2.1.9_i386.deb
    -rw-r--r-- 1 manuel manuel  47572 16. Jul 09:52 skytools-modules-8.3_2.1.9_i386.deb

Now just run `dpkg -i` to install them:

```bash
dpkg -i skytools_2.1.9_i386.deb skytools-modules-8.3_2.1.9_i386.deb
```

### Create pgqadm configuration

`pgqadm` is a command line tool for PG/Q that helps you setup your database and provides an event ticker to distribute the events to the consumers.

I recommend to create a new user for pgqadmin:

```bash
adduser --system pgqadm
su pgqadm -s /bin/bash
cd ~
mkdir cfg log pid
```

and in your database:

```sql
CREATE ROLE pgqadm LOGIN;
```

It's not necessary to provide a password for pgqadm because we'll use IDENT authentication to connect to the database (unless you've configured your system not to).

`pgqadm` needs a config file for every database it should manage:

```ini
[pgqadm]

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
```

Modify the config file to suit your needs and save it (e.g. as <span>/home/pgqadm/cfg/dbname.ini</span>).

### Setup your Database

To enable PG/Q for your database, several tables and functions have to be created. pgqadm does this for you if you invoke

```bash
pgqadm /home/pgqadm/cfg/dbname.ini install
```

### Autostart pgqadm ticker daemon

Unless the pgqadm ticker is started, no events can be recieved.

I'd recommend writing an init script to start it for all your databases:

<https://svn.fakeroot.at/svn/pgq/pgqadm_ticker>

save this script as `/etc/init.d/pgqadm_ticker` and make it executable:

```bash
chmod +x /etc/init.d/pgqadm_ticker
```

use update-rc.d to automatically start it

```bash
update-rc.d pgqadm_ticker defaults
```

That should be it. Now just start the deamon manually (you just need to do this the first time)

```bash
/etc/init.d/pgqadm_ticker start
```

### Use PG/Q

The following commands are all SQL statements.
  
It's also possible to use `pgqadm` for these tasks. Read the manual page of pgqadm for further help.

First you have to create a queue:

```sql
pgq.create_queue('queueName');
```

#### Producer side

After that, events can be created (e.g. in trigger functions):

```sql
pgq.insert_event('queueName', 'eventType', 'data');
```

#### Consumer side

To receive events, you have to register a "Consumer":

```sql
pgq.register_consumer('queueName', 'consumerName');
```

Every consumer will receive all of the events.

Pseudo-code:

```
int8 batchId;
-- infinite loop
  batchId = pgq.next_batch('queueName', 'consumerName');
  if (batchId == null) then sleep(delayInterval);
  else {

  }
  pgq.finish_batch(batchId);
-- end infinite loop
```

#### Sources

  * [SkyTools installation guide](http://skytools.projects.postgresql.org/doc/INSTALL.html)
  * [PG/Q SQL API overview](http://skytools.projects.postgresql.org/doc/pgq-sql.html)
  * pgqadm man page
