---
title: Is it (pseudo)random? (part 1)
date: 2017-03-21T12:00:34+0100
author: Manuel Reithuber
layout: post
permalink: /2017/03/is-it-pseudorandom-1/
categories:
  - coding
tags:
  - prng
  - linux
  - programming
---


Nearly every software project needs random number generators in one way or another. Sometimes all you want to do is roll a dice or shuffle a list
(like a deck of cards or the songs in a playlist).  
Or you use random string identifiers for your web applications (like the [video URLs on youtube](https://www.youtube.com/watch?v=gocwRvLhDf8)
or the document IDs in pretty much any NoSQL database). And there are good reasons to use random instead of sequential IDs, but that's another topic.  

The extreme end of dealing with randomness is obviously cryptography. But the details on that blow way past the scope of this series of blog posts.  
So if you're looking for advice on that: do plenty of research (*and: NEVER do your own crypto!*)

Whatever your use case, I'd argue that you should take one thing into consideration: predictability.  
If you write a simple dice or card game (or pretty much all client software - again: other than crypto), you probably won't (and shouldn't have to)
care much about the quality of your random data.

But as soon as we're talking about web services predictability becomes an issue. You wouldn't want people to guess your 'secret' IDs - or the random numbers your online
game servers generate.

Sometimes on the other hand you even want that predictability: Let's look at Microsoft's FreeCell game. It allows you to see (and select) the individual game's ID so you
can replay specific games or challenge others. Internally, the game uses that ID as seed (initial value) for its PRNG ([PseudoRandom Number Generator](https://en.wikipedia.org/wiki/Pseudorandom_number_generator)).  
And whenever you seed a PRNG with the same value, you'll get the same sequence of random-looking numbers (hence the prefix 'pseudo').  
For a card game that's perfect (since you're gonna use a RNG to shuffle the deck anyway).

*it's probably worth mentioning that FreeCell is a so called [perfect information game](https://en.wikipedia.org/wiki/Perfect_information) - you can see all the
cards from the very beginning, so 'cheating the RNG' doesn't really make sense there anyway*

When you generate hard-to-guess IDs or crypto keys though, that kind of predictability is an absolute no-go.

But we're getting ahead of ourselves. This part of the (three part) series will cover the basics of generating non-sensitive random numbers.

<!--snip-->

### Part 1: The basics

[![XKCD's comic on random numbers](https://imgs.xkcd.com/comics/random_number.png)](https://xkcd.com/221/)

The easiest way to generate random numbers in C is `rand()` (yes, we're gonna write a little C, but the concepts will apply to your favorite programming language as well).  
And one of the first things you learn about `rand()` is that it's pretty much useless unless you call `srand()` first.  

Let's look at a little example program without `srand()`:


```c
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

int main() {
	// who need's srand()
	for (int i = 0; i < 5; i++) {
		printf("%02d ", rand()%100);
	}
	printf("\n");
	return 0;
}
```

If we compile and run it a few times, we'll notice a little problem:

```sh
$ gcc rand.c -o rand
$ ./rand
07 49 73 58 30
$ ./rand
07 49 73 58 30
$ ./rand
07 49 73 58 30
```

As we've said before, simple PRNGs are deterministic and will therefore behave the same whenever you seed them with the same value
(or forget to seed them at all).  

In C, the PRNG can be seeded using `srand(int seed)`. Pretty much any example code you find on the internet will use `time(NULL)` as parameter value
(a.k.a. the number of seconds since the UNIX epoch - `1970-01-07T00:00:00Z`).

Let's expand our example:

```c
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

int main(int argc, char *argv[]) {
	if (argc > 2) {
		fprintf(stderr, "USAGE: %s [seed] - with seed being either an integer value or 'now'\n", argv[0]);
		return 1;
	} else if (argc == 2) {
		int seed;
		if (!strcmp(argv[1], "now")) {
			seed = time(NULL);
		} else {
			char *endp = NULL;
			seed = strtol(argv[1], &endp, 10);
			// error handling omitted for brevity
		}
		//printf(": seed: %d\n", seed);
		srand(seed);
	}
	for (int i = 0; i < 5; i++) {
		printf("%02d ", rand()%100);
	}
	printf("\n");
	return 0;
}
```

Now you can provide your own seed value as commandline parameter (or the string 'now' to use `time(NULL)`).  
Let's have a look:

```sh
$ gcc srand.c -o srand
$ ./srand
07 49 73 58 30
$ ./srand 1234
38 52 78 17 41
$ ./srand 1234
38 52 78 17 41
$ ./srand 1235
45 01 04 28 71
$ ./srand now
87 86 88 04 52
$ ./srand now
94 35 14 15 82

```

As predicted, we're getting the same results as above if we don't seed, the same results each time we seed with the same values and completely different
results if we even just slightly modify alter our seed.

Also, `time(NULL)` seems to do a good job. But does it really? `time(NULL)` only has second granularity, so if you seed more than once a second, you're
in trouble again:

```sh
$ for i in `seq 5`; do ./srand now; sleep .2; done
96 10 40 46 18
96 10 40 46 18
96 10 40 46 18
03 59 66 04 01
03 59 66 04 01
```

This could become a problem if you write a short lived program that gets invoked several times a second - or if you deploy
multiple instances of your application simultaneously (you're gonna see a lot of conflicts for your supposedly random IDs
if two of your applications happen to seed at the same time).

A rather simple way to improve things is to use `gettimeofday()` instead of `time()`. That function gives you microsecond granularity and therefore makes collisions
much less likely. But it doesn't effectively prevent them - or help in terms of predictability.


But enough for now. In part two I'll have a closer look at some common ways to improve the quality of your random seed.
