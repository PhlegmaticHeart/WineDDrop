This project is a personal take on containerizing wine, winetricks and lutris;
The aim of the project is to deliver a plug and play experience, in the sense that you'll be empowered with
a ready to start environment, a canvas to let you use wine and lutris without having to install their dependancies or
having to mess up with different versions, thanks to docker compatibility layer.

I decided to create this project, granted that there are many similar others, because i feel other projects are:

- unnecessarily bloated

or

- unnecessarily fancy

or

- unnecessarily bare

This container is that one thing that you spin, just works and let you know everything that its happening.
No long configuration scripts, no bloat ( like zenity ), if you have to fine tune it or add more libraries and packages, its your canvas. 


Actually, all offered scripts do NOT act outside containerized environment, stay safe.
( except for X11, Xauthority and pulse tmp folders, necessary for video and audio forwarding ).


I hope that you'll find it a good starting point to play on linux/mac.


**Usage**

1 ) After cloning/downloading the repo, you have just to execute ./build.sh to start building the container.

2 ) use ./run.sh [ARGUMENT] for everything else, from starting the container, to stopping it, to removing it etc...

3 ) Thats it, really, if you want to add an alias to the container's bashrc or execute a precise command you can edit entrypoint.sh, if you want to change or review users' passwords, you can manage them inside passwd.txt. 

Note: I have included all main libraries to let the majority of games to work, including vulkan, opengl and gtk support, the build process might require a while to finish.

**Sound**

Actually sound rely on PulseAudio, but it can already work even only with Alsa.

**Video**

The container rely on X11 session forwarding of the executor user.

WIP...


