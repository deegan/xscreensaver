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

```
"VideoScreenSaver"  videoscreensaver                                        \n\
```

And place the videoscreensaver file in like /usr/local/bin. Next up is saving
the configuration file to your $HOME/.config/ directory. This file now contains
any settings I've added to the original version. The comments should be self
explanatory but here's a brief overview.

Setting this variable to 1 will make the script use the URL setting in
$my_server to fetch videos for you screensaver.
```
export use_my_videos="0"
export my_server="http://my.server/vidz"
```

Settings this variable to 1 will make the script use the list of YouTube videos
either from $youtube_list, or $youtube_file. Leaving one of those blank will
ignore it.

```
export use_youtube_videos="1"
export youtube_list="http//my.server/vidz/youtube-playlist"
export youtube_file="/tmp/youtube-playlist"
```

# Getting videos.
So here are just some tips and tricks do get the files onto your server. Either
you can create a playlist on YouTube and use youtube-dl do get all the videos
from the list, or just create a new file on the server and add all the urls for
the videos you wish to use as your screensaver, and then run this little thing.

```bash
for video in `cat youtube-list`; do youtube-dl -f 22 $video; done
```

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

```
root   /opt/ytdl;
location / {
    index  index.html index.htm;
}
location /vidz {
        autoindex on;
}
```

# Tweaks?
So I save all my files in /vidz, you are free to change this, but you will need to edit the
script yourself to fix it. I could have named it somethings else. Just change
the "my_server" variable to be host/path.

# YouTube playlist
So this functionality is very basic, it solely depends on YOU having a file containing all the URLs
for the videos you wish to highlight in your screensaver. You can easliy obtain these using youtube-dl
like so.

```bash
youtube-dl -o "http://www.youtube.com/watch?v=%(id)s" --get-filename "https://www.youtube.com/watch?list=PLdSUTU0oamrzINhr7CW-Fw41b__K-3DjB" > /tmp/urls
```
Also it's not feasible to have this in the script itself, because as you will surely notice it takes a
pretty long time to generate this list of YouTube URLs. If you wish to host this file some place else other
than on your computer, you should upload it as is and define the "youtube_list" variable instead of the "youtube_list".

# Original source.
So this is a clone and edited version of
https://github.com/graysky2/xscreensaver-aerial fine work.
