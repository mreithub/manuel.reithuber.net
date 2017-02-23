---
id: 110
title: MP3-Support for Chromium
date: 2013-01-23T17:46:04+00:00
author: Manuel Reithuber
layout: post
guid: http://manuel.reithuber.net/?p=110
permalink: /2013/01/mp3-support-for-chromium/
categories:
  - Uncategorized
---
I&#8217;ve been playing around with the HTML5 <audio> tag several times now, always having trouble to play back Icecast Streams in Chrome (while they were working in Firefox; both apt-getted from the Ubuntu repos). Chrome was requesting the Stream and actively downloading it (which I observed using Chrome&#8217;s webdev-tools).

First I thought that Chrome (or to be more specific: Chromium) attempts to cache the whole file (probably due to a missing Content-length header) before starting to play.

But when I had the same issue again today I thought that it might be a licensing issue in the open source version of Google&#8217;s browser. A quick web research confirmed that guess.

To solve that problem it&#8217;s sufficient to simply install the ffmpeg-extra codec package for chromium:

> sudo apt-get install chromium-codecs-ffmpeg-extra

After restarting the browser everything works as expected and the only thing I&#8217;ll have to worry about is which javascript plugin to use to properly handle browsers not supporting HTML5 audio ([audio.js](http://kolber.github.com/audiojs/ "audio.js on github") looks promising btw.)