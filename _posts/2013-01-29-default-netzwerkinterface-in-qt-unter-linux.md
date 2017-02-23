---
id: 123
title: Default-Netzwerkinterface in Qt unter Linux
date: 2013-01-29T18:32:02+00:00
author: Manuel Reithuber
layout: post
guid: http://manuel.reithuber.net/?p=123
permalink: /2013/01/default-netzwerkinterface-in-qt-unter-linux/
categories:
  - Linux
---
Manchmal möchte man das Interface herausfinden, auf dem die Default-Route definiert ist.

Ich habe das z.B. verwendet, um [MediaTomb](http://www.mediatomb.cc/) daran zu hindern, im falschen Netzwerk zu horchen.

In Qt unter Linux kann man einfach das file /proc/net/route parsen:

<pre class="brush: cpp; title: ; notranslate" title="">QFile routeFile("/proc/net/route");
QString rc;

if (!routeFile.open(QFile::ReadOnly)) qWarn("Couldn't read routing information: %s", qPrintable(routeFile.errorString()));

QByteArray line;
while (!(line = routeFile.readLine()).isNull()) {
  QList&lt;QByteArray&gt; parts = line.split('\t');
  QByteArray intf = parts[0];
  QByteArray route = parts[1];
  QByteArray mask = parts[7];

  // Find make sure the destination address is 0.0.0.0 and the netmask empty
  if (route == "00000000" &amp;&amp; mask == "00000000") {
    rc = intf;
    break;
  }
}

return rc;
</pre>

In der Shell würde dies z.B. so aussehen:

<pre class="brush: bash; title: ; notranslate" title="">cut -f1,2,8 /proc/net/route --output-delimiter=:|grep 00000000:00000000$|cut -d: -f1
</pre>