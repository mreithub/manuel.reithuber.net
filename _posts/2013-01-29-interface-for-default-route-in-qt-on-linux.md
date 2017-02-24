---
id: 118
title: Interface for default route in Qt (on Linux)
date: 2013-01-29T18:32:02+00:00
author: Manuel Reithuber
layout: post
guid: http://manuel.reithuber.net/?p=118
permalink: /2013/01/interface-for-default-route-in-qt-on-linux/
tags:
  - network
  - qt
---
Sometimes one needs to find out programmatically on which interface the default route is on. To do this in Qt, the following snippet can be used on Linux and probably other Unices (where everything's a file ;)).

I used this snippet to prevent [MediaTomb](http://mediatomb.cc/) from listening on the wrong interface, but there are definitely other use cases as well:

```c++
QFile routeFile("/proc/net/route");
QString rc;

if (!routeFile.open(QFile::ReadOnly)) qWarn("Couldn't read routing information: %s", qPrintable(routeFile.errorString()));

QByteArray line;
while (!(line = routeFile.readLine()).isNull()) {
  QList<QByteArray> parts = line.split('\t');
  QByteArray intf = parts[0];
  QByteArray route = parts[1];
  QByteArray mask = parts[7];

  // Find make sure the destination address is 0.0.0.0 and the netmask empty
  if (route == "00000000" && mask == "00000000") {
    rc = intf;
    break;
  }
}

return rc;
```

In the shell, you'd do something like this:

```bash
cut -f1,2,8 /proc/net/route --output-delimiter=:|grep 00000000:00000000$|cut -d: -f1
```

