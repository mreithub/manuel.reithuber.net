#!/bin/bash -e

if [ -z $1 ]; then
	echo "USAGE: $0 new-post-url" >&2
	echo "  Will create _posts/YYYY-MM-DD-new-post-url.md" >&2
	exit 1
fi

name="$1"
tgtFile="_posts/$(date '+%Y-%m-%d')-$name.md"

if [ -e "$tgtFile" ]; then
	echo "ERROR: target file exists: $tgtFile" >&2
	exit 1
fi

cat > "$tgtFile" <<EOF
---
title: $name
date: $(date '+%Y-%m-%dT%H:%M:%S%z')
author: Manuel Reithuber
layout: post
permalink: /$(date '+%Y/%m')/$name/
categories:
  - Meta
tags:
  - tag1
  - tag2
---

...

<!--snip-->

...

EOF

# launch editor
if [ -n "$EDITOR" ]; then
	true # we're fine
elif [ -x "/usr/bin/editor" ]; then
	EDITOR=/usr/bin/editor
else
	EDITOR=/usr/bin/vi
fi

"$EDITOR" "$tgtFile"
