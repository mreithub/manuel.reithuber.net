---
id: 182
title: Migrating from WordPress to Jekyll
date: 2017-02-24T16:58:13+01:00
author: Manuel Reithuber
layout: post
categories:
  - Meta
tags:
  - jekyll
  - wordpress
  - github
---

I've never considered myself much of a writer (which should be evident when you look at the dates of my previous posts :) ).
But every now and then there's some online research (for work or other reasons) that merits a blog post.

I've set up my blog in 2009 on my private server using WordPress. 
And because I wanted to prevent malicious code from taking down the whole server,
I configured each site to run on separate linux user accounts.

Over the years there've been several reasons why I've been kinda unhappy with that setup. I'll try to remember (and maybe
will even look up) some of the details, but I can't guarantee their accuracy.

For one, I never wanted to limit myself to either English or German content. After browsing WordPress' plugin directory
for a bit, I've found a [mulilanguage plugin][polylang]. That worked mostly well but pretty much meant that
from that point on I had to write each blog post twice (and raising that barrier meant fewer posts in the end).

Because I've basically used PHP in CGI mode (for the setuid stuff, remember?), a new interpreter instance had to be started
for each request (at least at some point - I think I moved to a slightly different approach at some point when upgrading
the server). That caused some quite terrible response times (at least that's what the perfectionist inside me thought).  
I ended up installing a plugin that prerendered most pages and spews out static files. A little `mod_rewrite` magic and
all pages were served statically (and apparently a lot of non-essential links broke, but I never seemed to notice until now).

The third issue that kept bugging some part of me was the WYSIWYG editor (that kept producing - at least to the eyes of
someone who writes HTML by hand from time to time - sub-par output).  
At one point I had the idea of looking for a way to write blog posts in MarkDown. And guess what, there's a [plugin][markdown-plugin] for that.  

I'd argue that every single one of these plugins kinda stretches the limits of WordPress in another direction.
And looking back I'm really surprised it actually worked as well as it did.

<!--snip-->

Now - a few years later - and I've recently gave [Jekyll][jekyll] a first try.  
The perfectionist in me is in constant awe for the sheer unlimited performance and scalability you can get by using static site generators.  
(My cynic self on the other hand reminds me that we had all that back in the golden days of MS FrontPage :) ).  

Anyway, being able to write blog posts in MarkDown (and other, similar languages), having everything in my oh-so-beloved git,
getting syntax highlighting out of the box and not having to worry about hosting (thanks, GitHub Pages) feels like heaven right now
(and is definitely worth tinkering with a bit of custom stylesheets, template code and post conversion issues).


In the past couple of months the plan to move to a Jekyll-powered blog began to take form. But I kept feeling a little uneasy
about breaking links to existing blog posts. So I either wanted to migrate them all or scrape a static version of the old blog
and set up redirects.

Finally, yesterday evening I took the initiative and started the migration. I've found both Jekyll import and WordPress export
plugins (I ended up using the [Jekyll-Exporter][jekyll-exporter] WordPress plugin).

The plugin was single-click (it created a zip file for me to download) and did an ok job of converting the existing posts. All
the post URLs seemed to stay the same, but I had to rewrite most code blocks (which did gain me proper syntax highlighting for
much of them) and replace a few stray HTML tags and entities (have a look at the [initial commit][initial-commit] if you're
interested.  
I also decided to remove the German version of posts that were bi-lingual. I guess I could have set up redirects, but I don't
think those old posts will see a lot of requests anyway.

I'll probably add some more features (and a few style improvements), but I'm pretty happy with
what probably boils down to something like four hours of work.

There are a few drawbacks though:
- There's no comment support (obviously) - I could add something like disqus though
- GitHub Pages doesn't support SSL for custom domains. Maybe I'll self-host again some time in the future

And before I forget, here's a few links that helped me customize the Jekyll blog the way I want:
- [How I Added Teaser and Read-more Functionality to My Jekyll Blog on GitHub Pages](http://www.seanbuscay.com/blog/jekyll-teaser-pager-and-read-more/)
- [How to list your jekyll posts by tags](https://www.jokecamp.com/blog/listing-jekyll-posts-by-tag/)



[polylang]: https://wordpress.org/plugins/polylang/
[markdown-plugin]: https://wordpress.org/plugins/wp-markdown/
[static-plugin]: https://wordpress.org/plugins/really-static/
[jekyll]: https://jekyllrb.com/
[jekyll-exporter]: https://wordpress.org/plugins/jekyll-exporter/
[initial-commit]: https://github.com/mreithub/manuel.reithuber.net/commit/be198911aa149859ae5656352f02ddb1933c2750
