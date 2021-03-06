---
id: 110
title: MP3-Support for Chromium
date: 2013-01-23T17:46:04+00:00
author: Manuel Reithuber
layout: post
guid: http://manuel.reithuber.net/?p=110
permalink: /2013/01/mp3-support-for-chromium/
tags:
  - html5
  - audio
  - mp3
---
I've been playing around with the HTML5 `<audio>` tag for some time now, always having trouble to play back Icecast Streams in Chrome (while they were working in Firefox; both apt-getted from the Ubuntu repos). Chrome was requesting the Stream and actively downloading it (which I observed using Chrome's webdev-tools).

First I thought that Chrome (or to be more specific: Chromium) attempts to cache the whole file (probably due to a missing Content-length header) before starting to play.

But when I had the same issue again today I thought that it might be a licensing issue in the open source version of Google's browser. A quick web research confirmed that guess.

To solve that problem it's sufficient to simply install the ffmpeg-extra codec package for chromium:

```bash
sudo apt-get install chromium-codecs-ffmpeg-extra
```

After restarting the browser everything works as expected and the only thing I'll have to worry about is which javascript plugin to use to properly handle browsers not supporting HTML5 audio ([audio.js](http://kolber.github.io/audiojs/ "audio.js on github") looks promising btw.)
