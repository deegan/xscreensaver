# xscreensaver
Use mpv to play movies as a screensaver. This script asumes you will host your
own repository of videos to play, so you will need to replace the URL with your
own, more on that later. This version also allows you to host just one single
file and have that play on all monitors, but can easily be adjusted. 

# Requirements
* mpv - https://mpv.io
* xscreensaver - https://www.jwz.org/xscreensaver/

Optional if you do want to download your own videos from youtube you will also
install youtube-dl, and my prefered way of doing that is using pip (python)
but you can also use brew.

For the option to show up in Xscreensaver, you need to add this to your
~/.xscreensaver file.

"VideoScreenSaver"  videoscreensaver                                        \n\

And place the videoscreensaver file in like /usr/local/bin

# Getting videos.
So here are just some tips and tricks do get the files onto your server. Either
you can create a playlist on YouTube and use youtube-dl do get all the videos
from the list, or just create a new file on the server and add all the urls for
the videos you wish to use as your screensaver, and then run this little thing.

for video in `cat youtube-list`; do youtube-dl -f 22 $video; done

And then you will need to rename all the files to remove any spaces and odd
characters. Disclaimer: you might have to do more sed stuff than what I do if
your videos have lots of wierd characters in them that break shell-scripts.
Also the downloaded videos are 99% of the time in mp4 format, adjust
accordingly. I will for ease-of-use sake also have the rename.sh file in this
repo.

# Hosting it, how?
So the one-liner in the script that get the video list relies on direcotry
indexes being turned on, so you will need to fix that. Since this is the only
thing I host on the server I have for this, I simply run nginx and have this in
the default nginx.conf http {  } bracket. Also the root is /opt/ytdl, add a
index-file there, and create a vidz/ directory and put all your sanitized and
renamed youtube videos there.

root   /opt/ytdl;
location / {
    index  index.html index.htm;
}
location /vidz {
        autoindex on;
}

# Tweaks?
So I save all my files in /vidz, you are free to change this, but you will need to edit the
script yourself to fix it. I could have named it somethings else. Just change
the "my_server" variable to be host/path.

# todo
Considering adding configuration to play videos straight from a YouTube
playlist.

# Original source.
So this is a clone and edited version of
https://github.com/graysky2/xscreensaver-aerial fine work.
