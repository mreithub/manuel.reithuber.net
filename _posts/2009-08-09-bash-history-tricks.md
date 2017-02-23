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
In addition to the possibility to view/edit your ~/.bash_history manually, I&#8217;ve collected some little tips for the bash history:

  * **Hide single commands from the bash history**
  
    If your command line begins with a space character, it won&#8217;t be logged.
  * **Log a command for later execution**
  
    If you&#8217;ve just typed a long command line and realized that there&#8217;s other stuff to do before executing it, jump to its beginning (with Pos1) and type &#8216;#&#8217;. The command will then be treated as comment and won&#8217;t be executed. As soon as you&#8217;ve finished running all the other instructions use the history to get back to your comment. Remove the &#8216;#&#8217; and execute it.
  * **disable .bash_history file**
  
    one simple way to disable the .bash_history file is to remove the write permission to it:</p> <p class="code">
      chmod -w ~/.bash_history
    </p>
    
    If you first edit your .bash_history file manually you can turn it into a permanent history list with all your favourite commands.</li> 
    
      * **use the reverse search**
  
        press Ctrl+R and then enter your search string. To edit the command (and exit the search mode) use tab or one of the position keys.
  
        The reverse-i-search always brings you the first match before the current history position
      * **full history processing**
  
        The _history_ command lists the whole saved bash command history.
  
        You could use it e.g. to show the last 10 commands:</p> <p class="code">
          history|tail -n 10
        </p>
        
        or to show all lines containing the word &#8220;ssh&#8221;
        
        <p class="code">
          history|grep ssh
        </p>
    
      * **execute the last matching command**
  
        If you want to run a command several times without scrolling through the history all the time you can use the &#8216;!&#8217; at the start of the line to execute the last line that starts with your search string, e.g.</p> <p class="code">
          !ssh
        </p>
        
        will re-run the last invocation of ssh</li> 
        
          * **clear local history**
  
            To clear the session history (not the one in .bash_history) call</p> <p class="code">
              history -c
            </p>
        
          * **read/write history**
  
            If you have multiple sessions running and want to get the local history of one session to another one, you can use</p> <p class="code">
              history -a
            </p>
            
            to append the local history to .bash_history in the first terminal and
            
            <p class="code">
              history -r
            </p>
            
            in the second terminal to read .bash_history
  
            Those parameters can also be combined (read man bash for detailed information)</li> </ul>