#zsh#

My zsh(1) startup files.  I finally bowed to reality and did a real scrub
with the rules in mind.

##Invocating a Shell Means...##

Basically, we're talking about the shell you or your software works in and
the options it's started with.  The invocation options determine if the shell 
is started as a login shell and whether or not it's an interactive shell.
Further, a new shell can be instantiated by forking a child process or by
using the exec(1) command to completely replace the shell you've exec'd from.


Invocation options are distinct from other options like '--verbose' or '--c'.


##Shell Types##

###Login Shells (and Logging Out)###

A login shell is started when you present your username and password (or some
other form of authentication, like public key).  It's distinction is that it's
the *first* shell invoked and that it's invoked only once per user (or 
connection- think SSH). All other shells are forked or exec'd from this one
for the duration and until the user logs out.  

So, what does "logging out" mean?  It means you're through using the computer
that you're logged in to (and any other connections your original connection
may have created, say with SSH). Practically speaking, you're telling the
computer to release all of the resources allocated to you so that they can be
available to other users.  Ideally, these resources will either be deleted or
protected against unauthorized viewing/use by other users. To be absolutely
sure (secure), clean up after yourself!  Zsh(1) runs the shell script from the
.zlogout file.  The .zlogout is typcially in $HOME though it's  technically
in the directory refered to by $ZDOTDIR, if you've set that variable.

If you were connecting to Big Iron over a terminal back in the ol'
days, this would have been a physical terminal like a Lear Seigler ADM3a that
you usually shared with a bunch of other people like your college buddies.  In
this case, you want to clear out anything on the screen and maybe confirm any
sensitive info is cleaned up off disk, etc.


###Interactive and Non-Interactive Shells###

An interactive shell is really just one that expects to handle all the extra
work necessary to control a terminal.  A simple example is when you assign a
terminal type to your TERM variable (e.g., xterm, xterm-256color).  Once set,
this tells the computer all about the codes needed to control terminal 
behavior.  Basic terminal ops include seemingly simple things like positioning
the cursor, erasing a line or a screen, and presenting characters on the
screen using attributes like color and/or highlighting.

A non-interactive shell may be instantied temporarily by application software
to create the environment needed to execute another program, like a source file
linter, or network utility.  These shells are ephemeral and not assigned a 
terminal since they're typcially communicating through returen codes, pipes,
or even file artifacts.  Maybe you've used rsync(1) to backup your files to a
remote server over a secure connection.  This is a very good example of a 
non-interactive shell that's running in "batch" mode on another machine.  Even
more common are programs that run as 'daemons', which by definition are 
detached from the terminal (and even the user's own process space!).


###How zsh(1) Startup Files are used:###

To start with, the zsh(1) shell defines two groups of startup files: system
and user.  The user's personal startup files are located in the user's home
directory by default and they're named .zshenv, zprofile, zshrc, zlogin, and
.zlogout. The zsh(1) shell is hard-coded to look for files in /etc. These files
are all named the same as user files, without the '.'.  Usually the OS creates
only one such file by default: /etc/zshenv.  This file typcially sets the PATH
environment variable and exits.  Immediately after that, zsh(1) executes the
user's $HOME/.zshenv startup file.  And so it goes, /etc/zshrc before 
$HOME/,zshrc, /etc/zprofile and then $HOME/.zprofile, and so on.

One significant note here: /etc/zshenv is special because it's the ONLY startup
file executed when the shell is invoked in a "fast startup mode", i.e.,
'zsh -f'.  The user's startup files (incl. ,zshenv) are never executed.

With that all out of the way, the actual execution order for zsh's startup
files under all of these conditions is:

|   Shell Invoke     || Startup Order      |           Notes               |
| Login | Interactive |                    |                               |
  :---: | :---------: | ------------------- | ----------------------------- |
   YES  |   YES       |                     |                               |
        |             | $HOME/.zshenv       | Reminder: /etc/zshenv first!  |
        |             | $HOME/.zshrc        |                               |
        |             | $HOME/.zprofile     |                               |
        |             | $HOME/.zlogin       | $HOME/.zlogout on "log-out"   |
   YES  |   NO        | $HOME/.zshenv       |                               |
        |             |                     |                               |
   NO   |   YES       | $HOME/.zshenv       | "zsh -i"                      |
        |             | $HOME/.zshrc        |                               |
   NO   |   NO        | /etc/zshenv         | "zsh -f"                      |

