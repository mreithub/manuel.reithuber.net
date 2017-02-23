---
id: 109
title: MP3-Support für Chromium
date: 2013-01-23T17:36:38+00:00
author: Manuel Reithuber
layout: post
guid: http://manuel.reithuber.net/?p=109
permalink: /2013/01/mp3-support-fur-chromium/
categories:
  - Uncategorized
---
Ich hab&#8217; mich in der Vergangenheit immer wieder mal mit dem HTML5 Audio Element gespielt und versucht, Icecast-Streams damit wiederzugeben. Während dies im Firefox tadellos funktioniert, macht Chrome Probleme. Der Stream lädt zwar (was im DOM Inspector zu sehen ist), aber wiedergegeben wird nichts.

Meine Vermutung war zuerst, dass Chrome (oder genauer gesagt: Chromium aus den Ubuntu-Repos) das gesamte File cached bevor er zu spielen beginnt.

Als ich heute wieder auf das Problem stieß, kam mir die Idee, dass die Unterstützung für das proprietäre MP3-Format in der  Open-Source-Version des Browsers fehlen könnte, was durch eine Websuche schnell bestätigt wurde.

Um das Problem zu lösen, reicht ein einfaches:

> sudo apt-get install chromium-codecs-ffmpeg-extra

Nach einem Neustart des Browsers funktioniert nun auch die Wiedergabe von Shoutcast- bzw. Icecast-Streams im MP3-Format. Jetzt muss ich mich nur noch entscheiden, welche Javascript-Library ich als Fallback-Lösung für ältere Browser verwenden will (btw: [audio.js](http://kolber.github.com/audiojs/ "audio.js on github") sieht vielversprechend aus)