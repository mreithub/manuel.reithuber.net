---
id: 11
title: WordPress auf bplaced.net
date: 2009-08-08T20:18:56+00:00
author: Manuel Reithuber
layout: post
guid: http://manuel.reithuber.net/?p=11
permalink: /2009/08/wordpress-auf-bplaced-net/
categories:
  - Web
tags:
  - bplaced
  - hosting
  - mysql
  - php
  - wordpress
---
Wer einen einfachen und günstigen (um genauer zu sein: kostenlosen und werbefreien) Weg sucht, um an Webspace mit Blogging-System zu kommen, dem kann ich [bplaced.net](http://www.bplaced.net) empfehlen.

Für die, die bplaced noch nicht kennen: Der Wiener Anbieter bietet wahlweise 1 oder 2 GB Webspace mit PHP, MySQL & PostgreSQL. Lediglich URL-Zugriffsfunktionen im PHP sind eingeschränkt, um Missbrauch vorzubeugen.

Für WordPress oder andere Blogging Systeme, CMS, &#8230; sind also (nahezu) perfekte Voraussetzungen geschaffen.

Und das Beste ist: Man kann den bplaced-Account auf beliebige Domains aufschalten. (in meinem Fall z.B. http://manuel.reithuber.net).

Die Installation ist ziemlich einfach:

  * bplaced-Konto erstellen
  * im bplaced-Konto MySQL-DB erstellen z.b. &#8220;username_blog&#8221;
  * WordPress [downloaden](http://wordpress.org/download/)
  * entpacken (z.B.: mit [7Zip](http://www.7-zip.org/))
  * per ftp-client (z.B.: [FileZilla](http://filezilla-project.org/)) den entpackten Ordner auf den Server ftp://_username_.bplaced.net hochladen, z.b. in den ordner /blog
  * Wenn erwünscht, den hochgeladenen Ordner mit einer Domain verknüpfen (und dann evtl. beim Domainanbieter einen CNAME-Eintrag auf username.bplaced.net erstellen).
  * die URL im Browser eingeben (evtl. muss man vllt. ½h warten, bis die Nameserver & bplaced die neue Konfiguration übernommen haben
  * WordPress-Installationsanleitung durchführen und die MySQL-Zugangsdaten eingeben.
  * fertig

Plugin- und Theme-Installation muss man händisch machen (Zip-File lokal herunterladen, entpacken und per FTP in den ordner wp-content/plugins bzw. wp-content/themes hochladen).