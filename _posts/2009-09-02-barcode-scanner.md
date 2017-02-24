---
id: 35
title: Barcode Scanner
date: 2009-09-02T12:48:27+00:00
author: Manuel Reithuber
layout: post
guid: http://manuel.reithuber.net/?p=35
permalink: /2009/09/barcode-scanner/
categories:
  - Android
  - Apps
tags:
  - android
  - apps
---
<div id="attachment_47" style="width: 490px" class="wp-caption alignnone">
  <img class="size-full wp-image-47" title="barcode_search" src="http://manuel.reithuber.net/wp-content/uploads/2009/09/barcode_search.png" alt="Screenshot: Programm auf Barcode-Suche" width="480" height="320" srcset="http://manuel.reithuber.net/wp-content/uploads/2009/09/barcode_search.png 480w, http://manuel.reithuber.net/wp-content/uploads/2009/09/barcode_search-300x200.png 300w" sizes="(max-width: 480px) 100vw, 480px" />
  
  <p class="wp-caption-text">
    Screenshot: Programm auf Barcode-Suche
  </p>
</div>

Mit diesem Programm beginne ich meine Serie der Android Software Vorstellungen.

Der <a href="http://code.google.com/p/zxing/" target="_blank">ZXing Barcode Scanner</a> ist ein hilfreiches Tool, um (wie der Name schon sagt) Barcodes zu scannen.

Er ist Teil des ZXing Project ("Zebra Crossing"), einer Java-Barcode-Library, die unter der Apache License vertrieben wird.

<!--snip-->

<div id="attachment_45" style="width: 310px" class="wp-caption alignnone">
  <img class="size-medium wp-image-45" title="barcode_product" src="http://manuel.reithuber.net/wp-content/uploads/2009/09/barcode_product-300x200.png" alt="Screenshot: eingescannter Barcode aus der Wikipedia" width="300" height="200" srcset="http://manuel.reithuber.net/wp-content/uploads/2009/09/barcode_product-300x200.png 300w, http://manuel.reithuber.net/wp-content/uploads/2009/09/barcode_product.png 480w" sizes="(max-width: 300px) 100vw, 300px" />
  
  <p class="wp-caption-text">
    Screenshot: eingescannter Barcode aus der Wikipedia
  </p>
</div>

<div id="attachment_44" style="width: 310px" class="wp-caption alignnone">
  <img class="size-medium wp-image-44" title="barcode_isbn" src="http://manuel.reithuber.net/wp-content/uploads/2009/09/barcode_isbn-300x200.png" alt="Screenshot: Eingescannte ISBN eines Buchs" width="300" height="200" srcset="http://manuel.reithuber.net/wp-content/uploads/2009/09/barcode_isbn-300x200.png 300w, http://manuel.reithuber.net/wp-content/uploads/2009/09/barcode_isbn.png 480w" sizes="(max-width: 300px) 100vw, 300px" />
  
  <p class="wp-caption-text">
    Screenshot: Eingescannte ISBN eines Buchs
  </p>
</div>

Dabei werden neben den normalen 1D-Barcodes, wie sie auf fast jedem Produkt zu finden sind, auch zweidimensionale QR Codes erkannt.

<div id="attachment_46" style="width: 310px" class="wp-caption alignnone">
  <img class="size-medium wp-image-46" title="barcode_qrcode" src="http://manuel.reithuber.net/wp-content/uploads/2009/09/barcode_qrcode-300x200.png" alt="Screenshot eines eingescannten QR-Codes" width="300" height="200" srcset="http://manuel.reithuber.net/wp-content/uploads/2009/09/barcode_qrcode-300x200.png 300w, http://manuel.reithuber.net/wp-content/uploads/2009/09/barcode_qrcode.png 480w" sizes="(max-width: 300px) 100vw, 300px" />
  
  <p class="wp-caption-text">
    Screenshot eines eingescannten QR-Codes
  </p>
</div>

Diese QR-Codes können beliebigen Text und/0der Links enthalten und werden immer häufiger eingesetzt (u.a. ab jetzt auch hier):

[sqrcode]market://search?q=pname:com.google.zxing.client.android[/sqrcode]

Beispielsweise ist im obigen Tag eine Android Market URL enthalten, die (wenn man den Code einscannt und auf "Open browser" klickt) automatisch den Android Market lädt und die entsprechende Applikation gesucht.

Als Alternative muss ich noch den <a href="http://www.ixellence.com/index.php?option=com_content&view=article&id=141&Itemid=225&lang=en" target="_blank">ixMAT Barcode Scanner</a> nennen, der zwar die gleiche GUI verwendet, aber mehr Barcodetypen unterstützt:

[sqrcode]market://search?q=pname:com.ixellence.ixmat.android.community[/sqrcode]
