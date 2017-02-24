---
id: 65
title: "DNS Dos and Don'ts"
date: 2010-04-08T20:59:20+00:00
author: Manuel Reithuber
layout: post
guid: http://manuel.reithuber.net/?p=65
permalink: /2010/04/dns-dos-and-donts/
categories:
  - Uncategorized
---
Hier mal ein paar Dinge, die man beim Domain-Verwalten beachten sollte und meist selbst &#8220;schmerzvoll&#8221; erfahren musste&#8230;

<!--more-->

_(Alle Domainnamen sind durch example-Domains ersetzt)_

### MX-Record als IP

Heute habe ich auf einer meiner Domains beim Senden einer Nachricht folgenden Bounce bekommen:

<pre class="code">550-It appears that the DNS operator for example.org
550-has installed an invalid MX record with an IP address
550-instead of a domain name on the right hand side.
550 Sender verify failed</pre>

Schnell eine _mail.example.org_ subdomain als A-Record erstellt und den MX eintrag auf diese neue Subdomain geleitet (und 1h bis zum record timeout gewartet&#8230;) und schon funktioniert&#8217;s.

### MX auf einen CNAME eintrag

Ich bin mir nicht mehr genau sicher, aber ich glaube, es lag daran, dass die mail.example.com (auf die der MX-Record zeigte) ihrerseits wiederum ein CNAME auf vhosts.example.com war, dass manche Mails wehement mit der falschen Empfänger-Adresse zugestellt wurden (z.B. me@vhosts.example.com statt me@example.net), was seinerseits wieder einen Einrichtungs-Mehraufwand am Mailserver verursacht.

Ich hab&#8217; daraus auf jeden Fall gelernt, mit CNAME-Einträgen wieder sparsamer umzugehen (auch wenn sie noch so praktisch sind&#8230;).
