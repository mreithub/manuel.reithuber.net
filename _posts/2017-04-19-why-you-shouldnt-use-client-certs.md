---
title: Why you (probably) don't wanna use SSL client certificates
date: 2017-04-19T17:14:41+0200
author: Manuel Reithuber
layout: post
permalink: /2017/04/why-you-shouldnt-use-client-certs/
categories:
  - Other
tags:
  - ssl
  - programming
  - security
  - rant
---


This is a bit of a fringe issue (outside online banking at least), but in this blog post I'll try to list a few of my issues with
running an API service that uses SSL client certificates to authenticate its users ('client applications' to be more specific).  
In my case the client certificates were already in place, so using them kinda made sense (but looking back, using API keys instead of
client certificates would've saved me a bit of headache).  
If you're thinking about using client certificate based authentication for one of your projects, maybe I'll be able to convince you otherwise.

But let's start:


### Finding help

You're gonna feel pretty much alone with your problems. Most tools and frameworks (read: at least the ones I've used) seem to support client certs,
but I've found it hard to find much help on internet forums or stackoverflow.


### Bug hunting

It is quite hard to pin down and fix certificate issues. You've basically doubled the problem surface of just using server-side certificates
(Missing root certificates, incomplete certificate chain, clients set to the wrong system date, ...).

Client certificate validation errors are often cryptic (no pun intended). Tell me, what's wrong here for example:

    curl: (35) error:14094410:SSL routines:SSL3_READ_BYTES:sslv3 alert handshake failure

Ok great, the handshake failed. But why did it fail, I ask?

And your server probably doesn't even see the failed request(s) (and is therefore unable to handle them with nice and clean error messages)
(unless you configured client certificates to be optional and handle things in your application).


<!--snip-->


### Certificate renewal

Another issue is that your client certificates will expire eventually. And while the same is true for server certificates, exchanging one certificate
on hardware you control is child's play compared to doing the same on countless client devices (oh, and make sure your renewal process is safe).  

If a client is offline for longer periods of time, it might end up missing its designated renewal window.


### Reverse proxies

Let's assume your app exceeds expectations and you want to set up a load balancing reverse proxy. You'll probably want to have your load balancer
to do the SSL termination for you.

That means your app will no longer deal with client certifiates on itself but has to trust some custom request headers set by the load balancer.
If you're not careful, malicious clients could inject these headers (even if you've configured your reverse proxy properly,
there's a chance you (or whoever gets your job in the future) will forget about that little detail when migrating your infrastructure in the future.

And you better make sure there's no way to get around the load balancer and access the app server directly (or they could possible inject these 'trusted' headers).

*I should probably mention that there are special proxying protocols like [Apache's AJP][ajp] that support passing on client certificate information transparently,
but fall short when it comes to other features (AJP for example lacks support for websockets).*

The same is true for CDNs and any other software or service you want to plug between your application and its users. Your whole stack needs to support
(and be properly configured for) client certificates.


### Just use API keys

Yes, client certificates are harder to sniff (it's pretty much impossible to impersonate a client without their private key), but as soon as you use
SSL (I'm talking about plain, server-side certificates here), sniffing the passwords or API keys is not a real issue anyway.

There are a few other minor advantages of client certificates (you could use smartcards, implement stateless servers or - in my case - reuse existing
infrastructure), but these are rarely ever worth the extra time and effort.

So (unless you know what you're doing), just use plain old API keys.

