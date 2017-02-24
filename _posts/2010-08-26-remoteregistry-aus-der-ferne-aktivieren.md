---
id: 82
title: Remoteregistry aus der Ferne aktivieren
date: 2010-08-26T10:37:50+00:00
author: Manuel Reithuber
layout: post
guid: http://manuel.reithuber.net/?p=82
permalink: /2010/08/remoteregistry-aus-der-ferne-aktivieren/
categories:
  - Windows
tags:
  - windows
  - german
---
Falls der Versuch, sich mit einer Netzwerkregistrierung zu verbinden (wie im vorigen Post [Remotedesktopverbindung aus der Ferne aktivieren](http://manuel.reithuber.net/2010/08/remotedesktopverbindung-aus-der-ferne-aktivieren/)), fehlschlägt, kann diese relativ einfach (ebenfalls übers Netzwerk) aktiviert werden.
  
Benötigt wird dazu nur ein erreichbarer Windows-PC mit Computerverwaltung.

Zuerst muss die Computerverwaltung lokal geöffnet werden (am einfachsten geht das mMn mit einem Rechtsklick auf den _Arbeitsplatz_ (z.b. im Startmenü, am Desktop oder im Explorer) und anschließendem Klick auf _Verwalten_):

[<img class="alignnone size-full wp-image-83" title="computerverwaltung_starten" src="http://manuel.reithuber.net/wp-content/uploads/2010/08/computerverwaltung_starten.png" alt="Computerverwaltung starten" width="207" height="250" />](http://manuel.reithuber.net/wp-content/uploads/2010/08/computerverwaltung_starten.png)

Dann im Menü _Aktion_ auf _Verbindung mit einem anderen Computer herstellen_:

[<img class="alignnone size-full wp-image-84" title="computerverwaltung_verbinden" src="http://manuel.reithuber.net/wp-content/uploads/2010/08/computerverwaltung_verbinden.png" alt="&quot;Verbindung mit einem anderen Computer herstellen&quot;" width="637" height="452" srcset="http://manuel.reithuber.net/wp-content/uploads/2010/08/computerverwaltung_verbinden.png 637w, http://manuel.reithuber.net/wp-content/uploads/2010/08/computerverwaltung_verbinden-300x212.png 300w" sizes="(max-width: 637px) 100vw, 637px" />](http://manuel.reithuber.net/wp-content/uploads/2010/08/computerverwaltung_verbinden.png)

<!--snip-->

[<img class="alignnone size-full wp-image-85" title="computerverwaltung_pc_auswahl" src="http://manuel.reithuber.net/wp-content/uploads/2010/08/computerverwaltung_pc_auswahl.png" alt="Computerverwaltung: PC-Auswahl" width="503" height="227" srcset="http://manuel.reithuber.net/wp-content/uploads/2010/08/computerverwaltung_pc_auswahl.png 503w, http://manuel.reithuber.net/wp-content/uploads/2010/08/computerverwaltung_pc_auswahl-300x135.png 300w" sizes="(max-width: 503px) 100vw, 503px" />](http://manuel.reithuber.net/wp-content/uploads/2010/08/computerverwaltung_pc_auswahl.png)

Dann Links unter _Dienste und Anwendungen_ auf _Dienste_ klicken und rechts den Eintrag _Remoteregistrierung_ auswählen. Anschließend auf _Starten_ klicken:

[<img class="alignnone size-full wp-image-87" title="computerverwaltung_remotereg_starten" src="http://manuel.reithuber.net/wp-content/uploads/2010/08/computerverwaltung_remotereg_starten.png" alt="Remoteregistrierungsdienst starten" width="639" height="453" srcset="http://manuel.reithuber.net/wp-content/uploads/2010/08/computerverwaltung_remotereg_starten.png 639w, http://manuel.reithuber.net/wp-content/uploads/2010/08/computerverwaltung_remotereg_starten-300x212.png 300w" sizes="(max-width: 639px) 100vw, 639px" />](http://manuel.reithuber.net/wp-content/uploads/2010/08/computerverwaltung_remotereg_starten.png)

Sollte der Link _starten_ nicht sichtbar sein, kann es sein, dass der Dienst deaktiviert wurde. Dann einfach auf den Remoteregistrierungs-Eintrag rechtsklicken und die Eigenschaften aufrufen.
  
Im erscheinenden Fenster dann den Starttyp auf _Manuell_ bzw. _Automatisch_ stellen und den Dienst starten (was beim Typ _Automatisch_ von selbst geschehen sollte).
