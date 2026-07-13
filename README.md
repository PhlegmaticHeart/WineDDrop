# Wine/Lutris canvas container

This project is a personal take on containerizing wine, winetricks and lutris;
The aim of the project is to deliver a plug and play container, empowering you with
a ready to start environment, a canvas to let you use wine and lutris without having to install their dependancies or
having to mess up with different versions, thanks to docker compatibility layer.

**Another wine-based container?**

Granted that there are many similar other projects, i decided to create this one because i feel that other projects are:

- unnecessarily bloated

- unnecessarily fancy

- unnecessarily bare

This container is that one thing that you spin, just works and let you know everything that its happening.
No long configuration scripts, no bloat ( like zenity ).

If you have to fine tune it or add more libraries and packages, its meant to be your canvas. 

Actually, all offered scripts do NOT act outside containerized environment, stay safe.
Note: X11, Xauthority and pulse tmp folders are shared with the container as they are necessary for video and audio forwarding.


I hope that you'll find it as a good starting point to play on linux/mac.


**Usage**

1 ) After cloning/downloading the repo, you have just to execute ./build.sh to start building the container.

2 ) use ./run.sh [ARGUMENT] for everything else, from starting the container, to stopping it, to removing it etc... 
Notes: 
To see the full supported arguments list of run.sh, execute it without arguments.
The run.sh script automatically mount your personal user's home folder inside the container as [USER NAME]_home, feel free to put your prefixes there.

3 ) Thats it, really, if you want to add an alias to the container, use the provided aliases.txt.
If you need to execute a precise command at first container run, you can edit entrypoint.sh.
If you want to change or review users' passwords, you can manage them inside passwd.txt. 

Note: I have included all main libraries to let the majority of games to work, including vulkan, opengl and gtk support, the build process might require a while to finish.

For a streamlined usage, you can put your aliases inside the file "aliases.txt" ( for example your lutris executables, using the template also included inside the same file ).

**Sound**

Actually sound rely on PulseAudio and, if not supported it has also Alsa.
Sound, even if not fine-tuned for you pc, should work out-of-the-box without having to touch anything.

**Video**

The container rely on X11 session forwarding of the executor user.
Its already forwarded, just start a GUI app inside the container and you should see it on your screen.


