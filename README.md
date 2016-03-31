# i3_config
This was just a place to keep my config files, but now it's that, and a cool makefile to quickly swap configes around.

#### The structure
So the idea is that a simple makefile can be used to do all the configuration compilation, and long as the folder structure is there to support it. Most parts the config are made from the config.d folder, and the theme is in the theme folder (whoa! right?).
Inside the config.d folder is a bunch of files split up into their contents functionality. Anything at the root of config.d is applied to all configurations. Inside of config.d is also laptop.d, and desktop.d. Which contain settings specific to my laptop or desktop config.
 The theme folder has one layer of folders to hold themes, and the root of the theme folder has the current theme stored in it. The last theme you set is copied over to the theme folder, and the originals are all kept in their folders. 
You can try to read that explenation, or just look at the folders, and makefile, and it'll make sense.

####Usage
to use say your laptop config, and the light theme type
`make laptop theme=light`

if you want you can change just the config.
`make laptop`

or re-apply the same config, with a different theme.
`make laptop theme=light;make laptop theme=dark;`

#### Ideas / Todo
* give the workspaces names again.

#####You're free to use, modify, and distriibute this as you please. Or whatever.
