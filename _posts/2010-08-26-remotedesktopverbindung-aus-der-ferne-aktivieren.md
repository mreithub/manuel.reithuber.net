---
id: 72
title: Remotedesktopverbindung aus der Ferne aktivieren
date: 2010-08-26T10:06:28+00:00
author: Manuel Reithuber
layout: post
guid: http://manuel.reithuber.net/?p=72
permalink: /2010/08/remotedesktopverbindung-aus-der-ferne-aktivieren/
categories:
  - Windows
tags:
  - mstsc
  - netzwerk
  - windows
---
Gerade erst gestern hatte ich das Problem, mich bei einem Kunden-PC entfernt anmelden zu müssen, bei dem die Remotedesktopverbindung deaktiviert war.

Glücklicherweise lässt sich diese aber per Registry aktivieren (welche wiederum Netzwerktauglich ist).

Dazu öffnet man einfach lokal den Registry-Editor (win+r, regedit):

[<img class="alignnone size-full wp-image-73" title="run_regedit" src="http://manuel.reithuber.net/wp-content/uploads/2010/08/run_regedit.png" alt="Windows-Ausführungs-Dialog: &quot;regedit&quot;" width="355" height="179" srcset="http://manuel.reithuber.net/wp-content/uploads/2010/08/run_regedit.png 355w, http://manuel.reithuber.net/wp-content/uploads/2010/08/run_regedit-300x151.png 300w" sizes="(max-width: 355px) 100vw, 355px" />](http://manuel.reithuber.net/wp-content/uploads/2010/08/run_regedit.png)

klickt im Menü _Datei_ auf _Mit Netzwerkregistrierung verbinden_

[<img class="alignnone size-full wp-image-76" title="regedit_file_connect" src="http://manuel.reithuber.net/wp-content/uploads/2010/08/regedit_file_connect.png" alt="Regedit: Datei/Mit Netzwerkregistrierung verbinden" width="274" height="218" />](http://manuel.reithuber.net/wp-content/uploads/2010/08/regedit_file_connect.png)

[<img class="alignnone size-full wp-image-78" title="regedit_connect" src="http://manuel.reithuber.net/wp-content/uploads/2010/08/regedit_connect.png" alt="PC-Namen eingeben und bestätigen" width="463" height="246" srcset="http://manuel.reithuber.net/wp-content/uploads/2010/08/regedit_connect.png 463w, http://manuel.reithuber.net/wp-content/uploads/2010/08/regedit_connect-300x159.png 300w" sizes="(max-width: 463px) 100vw, 463px" />](http://manuel.reithuber.net/wp-content/uploads/2010/08/regedit_connect.png)

und Navigiert zum Schlüssel

> HKEY\_LOCAL\_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server

Sollte hier die Verbindung fehlschlagen, liegt das sehr wahrscheinlich an einem deaktivierten Remoteregistry-Dienst am Client-Computer (Anleitung zum aktivieren: [Remoteregistry aus der Ferne aktivieren](http://manuel.reithuber.net/2010/08/remoteregistry-aus-der-ferne-aktivieren/))

Dort setzt ihr den Wert _fDenyTSConnections_ auf 0:

[<img class="alignnone size-full wp-image-77" title="regedit_setValue" src="http://manuel.reithuber.net/wp-content/uploads/2010/08/regedit_setValue.png" alt="Registry-Wert fDenyTSConnections auf 0 setzen" width="811" height="449" srcset="http://manuel.reithuber.net/wp-content/uploads/2010/08/regedit_setValue.png 811w, http://manuel.reithuber.net/wp-content/uploads/2010/08/regedit_setValue-300x166.png 300w" sizes="(max-width: 811px) 100vw, 811px" />](http://manuel.reithuber.net/wp-content/uploads/2010/08/regedit_setValue.png)

Quelle:
  
[http://www.admins-tipps.de/Microsoft/Windows\_2003\_Server/Remotedesktop-Verbindungen\_aus\_der\_Ferne\_per\_Registry\_aktivieren.htm](http://www.admins-tipps.de/Microsoft/Windows_2003_Server/Remotedesktop-Verbindungen_aus_der_Ferne_per_Registry_aktivieren.htm)