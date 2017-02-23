---
id: 181
title: My routine when setting up debian hosts
date: 2016-07-08T08:16:22+00:00
author: Manuel Reithuber
layout: post
guid: http://manuel.reithuber.net/?p=181
permalink: /2016/07/setting-up-debian-hosts/
categories:
  - Linux
tags:
  - debian
  - deployment
  - docker
  - server
  - ubuntu
---
In this post I&#8217;ll try to sum up the steps I take right after I get my hands on a vanilla [debian](https://www.debian.org) installation (the same applies to [Ubuntu](http://www.ubuntu.com) or other debian derivatives).

Some of these commands are interactive (they can be automated though). I&#8217;m not doing this often enough to justify an automation.

First I install a few convenience packages (depending on the installation, some of them may already be present)

    apt-get update && apt-get upgrade
    apt-get install locales openssh-server sudo ntp wget curl mosh less most vim bash-completion htop iftop iotop python3-pip smartmontools rsync git
    

After that, I&#8217;ll set up locales and the system&#8217;s timezone

    dpkg-reconfigure locales tzdata
    

&#8230; as well as the host name (the first sets the current host name, the second one persists it across reboots)

    hostname newdebian.example.com
    echo 'newdebian.example.com' > /etc/hostname
    

Configuring VI:

    cat > /etc/vim/vimrc.local <<EOF
    syntax on
    set background=dark
    set incsearch
    set smartcase
    set autowrite
    EOF
    

After that I create a user (and add them to the `sudo` group)

    adduser manuel
    adduser manuel sudo
    

Then I add my SSH public key (there&#8217;s the [`ssh-copy-id` command](http://askubuntu.com/a/4833) that does the same thing, but I personally prefer the manual way):

    mkdir /home/manuel/.ssh
    cat >> /home/manuel/.ssh/authorized_keys # paste your public key (usually in ~/.ssh/id_rsa.pub) and press CTRL+D
    chown manuel:manuel /home/manuel/.ssh/ -R
    

Recently I&#8217;ve started dockerizing all my services. To install a (recent) version of [Docker](https://www.docker.com), I use the shell script they provide:

    curl -fsSL https://get.docker.com/ | sh
    

&#8230; only allow non-password root logins via SSH (i.e using SSH keys)

    # edit /etc/ssh/sshd_config, find the `PermitRootLogin` line and change its value to `without-password`
    sed -i 's/^PermitRootLogin.*$/PermitRootLogin without-password/' /etc/ssh/sshd_config
    /etc/init.d/ssh restart
    

**Important**: After editing `sshd_config` and restarting the SSH server, always open a new terminal and make sure you haven&#8217;t locked yourself out of the machine!

After I&#8217;ve come this far, I usually reboot the system (if it&#8217;s an actual system we&#8217;re talking about 😉 )

    shutdown -r now