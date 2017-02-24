---
id: 15
title: Bash history tricks
date: 2009-08-09T00:50:09+00:00
author: Manuel Reithuber
layout: post
guid: http://manuel.reithuber.net/?p=15
permalink: /2009/08/bash-history-tricks/
categories:
  - Linux
---
In addition to the possibility to view/edit your `~/.bash_history` manually, I've collected some little tips for the bash history:

  * **Hide single commands from the bash history**  
      If your command line begins with a space character, it won't be logged.

  * **Log a command for later execution**  
    If you've just typed a long command line and realized that there's other stuff to do before executing it, jump to its beginning (with `Home`) and type `#`. The command will then be treated as comment and won't be executed. As soon as you've finished running all the other instructions use the history to get back to your comment. Remove the `#` and execute it.

  * **disable .bash_history file**  
    one simple way to disable the .bash_history file is to remove the write permission to it:
    ```bash
    chmod -w ~/.bash_history
    ```

    If you first edit your .bash_history file manually you can turn it into a permanent history list with all your favourite commands.

  * **use the reverse search**  
    press Ctrl+R and then enter your search string. To edit the command (and exit the search mode) use tab or one of the position keys.

    The reverse-i-search always brings you the first match before the current history position

  * **full history processing**  
    The _history_ command lists the whole saved bash command history.

    You could use it e.g. to show the last 10 commands:
    ```bash
    history|tail -n 10
    ```
      
    or to show all lines containing the word `ssh`

    ```bash
    history|grep ssh
    ```

  * **execute the last matching command**  
    If you want to run a command several times without scrolling through the history all the time you can use the `!` at the start of the line to execute the last line that starts with your search string, e.g.:

    ```
    !ssh
    ```

    will re-run the last invocation of ssh

  * **clear local history**  
    To clear the session history (not the one in `.bash_history`) call

    ```bash
    history -c
    ```

  * **read/write history**  
    If you have multiple sessions running and want to get the local history of one session to another one, you can use
    ```bash
    history -a
    ```

    to append the local history to .bash_history in the first terminal and

    ```bash
    history -r
    ```

    in the second terminal to read `.bash_history`

    Those parameters can also be combined (read man bash for detailed information)
