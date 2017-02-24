---
id: 145
title: Stress-Test für HTTP-Seiten
date: 2013-05-29T12:46:50+00:00
author: Manuel Reithuber
layout: post
guid: http://manuel.reithuber.net/?p=145
permalink: /2013/05/stress-test-fur-http-seiten/
tags:
  - http
  - german
---
Kürzlich war ich auf der Suche nach einem Tool, mit dem ich diesen Blog Stress-Testen konnte. Ich wollte sehen, was passiert, wenn (falls...) einmal unter Last kommt.

Es gibt verschiedene Dienste, die genau das im Internet anbieten, aber eine schnelle Suche hat nur solche zu Tage gebracht, die entweder Geld für die Tests verlangen (was ich bei der Menge des anfallenden Traffics auch verstehe) oder einen Gratis-Test nur gegen Veröffentlichung der Ergebnisse anbieten (z.B. [loadimpact.com](http://loadimpact.com/load-test/manuel.reithuber.net-3279369fdb2f089c751cdc1606f45213 "Test der Hauptseite dieses Blogs mittels LoadImpact")).

Also war ich auf der Suche nach einer leicht zu verwendenden Client-Lösung. Wiederum nach kurzer Web-Recherche stieß ich auf `ab`, was für *Apache Benchmark* steht und angenehmerweise schon mit Apache ausgeliefert wird (z.B. im Paket [apache-utils](http://www.debianhelp.co.uk/apacheab.htm "Link zu einer Debian-Seite, die die Installation von AB erklärt") unter Debian/Ubuntu). Es ist ziemlich einfach zu verwenden (Details in der [manpage](http://linux.die.net/man/1/ab "AB manpage")), hält sich jedoch auch schlicht, d.h. es wird nur die angegebene URL abgefragt, keine Bilder, JavaScript, CSS oder was auch immer noch mit ausgeliefert werden würde. Aber in Verbindung mit der Netzwerk-Requestansicht der Developer-Tools des Browsers (in meinem Fall Chrome) lassen sich die langsameren Requests relativ leicht erkennen:

<div id="attachment_146" style="width: 921px" class="wp-caption alignnone">
  <a href="http://manuel.reithuber.net/wp-content/uploads/2013/05/blogTimingSlow.png" style="text-align: left"><img class="wp-image-146  " alt="Chrome's Request timing zeigt, dass es Verbesserungsbedarf gibt (bzw. gab)" src="http://manuel.reithuber.net/wp-content/uploads/2013/05/blogTimingSlow.png" width="911" height="222" srcset="http://manuel.reithuber.net/wp-content/uploads/2013/05/blogTimingSlow.png 1302w, http://manuel.reithuber.net/wp-content/uploads/2013/05/blogTimingSlow-300x73.png 300w, http://manuel.reithuber.net/wp-content/uploads/2013/05/blogTimingSlow-1024x249.png 1024w" sizes="(max-width: 911px) 100vw, 911px" /></a>
  
  <p class="wp-caption-text">
    Chrome's Request timing zeigt, dass es Verbesserungsbedarf gibt (bzw. gab)
  </p>
</div>
<!--snip-->

<p style="text-align: left;">
  Der erste Request auf die Seite selbst dauert fast 400ms. Apache-AB zeigt ein ähnliches Bild:
</p>

```
$ ab -c 10 -n 150 'http://manuel.reithuber.net/'
This is ApacheBench, Version 2.3 <$Revision: 655654 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking manuel.reithuber.net (be patient).....done
Server Software: Apache/2.2.16
Server Hostname: manuel.reithuber.net
Server Port: 80

Document Path: /
Document Length: 54520 bytes

Concurrency Level: 10
Time taken for tests: 29.540 seconds
Complete requests: 150
Failed requests: 0
Write errors: 0
Total transferred: 8234250 bytes
HTML transferred: 8178000 bytes
Requests per second: 5.08 [#/sec] (mean)
Time per request: 1969.323 [ms] (mean)
Time per request: 196.932 [ms] (mean, across all concurrent requests)
Transfer rate: 272.22 [Kbytes/sec] received

Connection Times (ms)
 min mean[+/-sd] median max
Connect: 11 12 2.8 11 38
Processing: 629 1936 215.9 1962 2257
Waiting: 472 1082 113.1 1097 1244
Total: 643 1948 216.0 1975 2267

Percentage of the requests served within a certain time (ms)
 50% 1975
 66% 2003
 75% 2060
 80% 2098
 90% 2167
 95% 2214
 98% 2242
 99% 2248
 100% 2267 (longest request)
```

Bei zehn parallelen Requests dauerte es im Schnitt fast zwei Sekunden, bis ein User seine Antwort bekommt! Und für 150 Requests war AB 30 Sekunden lang beschäftigt!

Ich wusste bereits, dass eine unoptimierte WordPress-Installation Optimierungsbedarf beim Thema Performance hat, aber damit hätte ich ehrlich gesagt nicht gerechnet (Ein Grund ist, dass bei mir aus Sicherheitsgründen PHP unter suexec läuft und unterschiedliche Websites unterschiedlichen user accounts zugeordnet sind).

Was kann man dagegen machen:

Das Stichwort hier ist Caching. Es gibt diverse WordPress-Plugins, die (z.B. unter Verwendung von [memcached](http://wordpress.org/plugins/memcached/ "memcached Plugin für WordPress")) statische Versionen einer Webseite zwischenspeichern. Aber ich wollte eine wirklich drastische Lösung. Wenn vorhanden, soll Apache direkt eine .html-Seite ausliefern und PHP soll gar nicht erst ausgeführt werden. Mit diesem Ziel im Auge bin ich auf das [really-static](http://wordpress.org/plugins/really-static/ "Really Static WordPress Plugin") WordPress Plugin gestoßen, dessen Ziel es ist, einen statischen Snapshot der WordPress-Seite zu erstellen und aktuell zu halten (es horcht auf Artikel- und Kommentar-Änderungen und aktualisiert automatisch die statischen .html-Seiten).

Es war nicht ganz so leicht, es nach meinen Wünschen einzurichten, aber jetzt werden anstatt der Artikel statische .html-Seiten ausgeliefert, die vom Plugin automatisch aktuell gehalten werden (Update: sollten!!!).

Das really-static Plugin ist mMn noch nicht 100%ig ausgereift (Doku eher dürftig; man sollte mit der Konfiguration nicht zu sehr eigene Wege gehen wollen, da das Plugin sonst streiken könnte; und wenn das Plugin den Dienst (oder in meinem Fall den Einrichtungsassistenten) verweigert, ist die fehlende Struktur des Sourcecodes nicht unbedingt hilfreich). Aber zur Einrichtung des Plugins in einem eigenen Post mehr.

Zuguterletzt lasse ich noch einmal das Benchmark-Tool laufen, um die Performanceverbesserung zu überprüfen:

```
$ ab -c 10 -n 150 'http://manuel.reithuber.net/'

This is ApacheBench, Version 2.3 <$Revision: 655654 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking manuel.reithuber.net (be patient).....done

Server Software: Apache/2.2.16
Server Hostname: manuel.reithuber.net
Server Port: 80

Document Path: /
Document Length: 49624 bytes

Concurrency Level: 10
Time taken for tests: 3.150 seconds
Complete requests: 150
Failed requests: 0
Write errors: 0
Total transferred: 7485900 bytes
HTML transferred: 7443600 bytes
Requests per second: 47.61 [#/sec] (mean)
Time per request: 210.022 [ms] (mean)
Time per request: 21.002 [ms] (mean, across all concurrent requests)
Transfer rate: 2320.53 [Kbytes/sec] received

Connection Times (ms)
 min mean[+/-sd] median max
Connect: 12 37 13.0 38 63
Processing: 99 169 195.8 153 2531
Waiting: 14 39 12.0 37 65
Total: 132 206 193.4 185 2543

Percentage of the requests served within a certain time (ms)
 50% 185
 66% 202
 75% 208
 80% 209
 90% 217
 95% 225
 98% 248
 99% 283
 100% 2543 (longest request)
```

Eine Verbesserung fast um Faktor 10, das kann sich doch sehen lassen 😉
