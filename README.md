# i3_config

### Greetings
Welcome to my home, or at least the home of the thing I use to configure my home.

This is possibly the most overly complex structure just to concatenate a few files. It makes changes and multi machine setups much easier though. Most importantly is allows themes to be configured seperately from the overall system configuration.

## Contents
### Makefile
The make file is used to concatenate selected setting and theme files into one config. It also moves the relevant theme files to their proper location. Follwed by reloading i3 to display the results.

The syntax is as follows
    make *pc_type* [theme=*$theme*]

For example:
    make desktop theme=margaret

would add all the files in settings.d, settings.d/desktop.d, and theme/margaret to the config file. Then it would restart i3 so you can see errors or your purty new theme.

---

### Folder Structure

The most important part of this repository is the structure of the files. The make file that puts it together relies on things being in their expected location.

#### settings.d
In this folder you'll find configuration files for different parts of the i3 config, but no aestetic related things. There is also a laptop.d and desktop.d. They contain files with similar names to settings.d, but are added specifically when the desktop or laptop make directive is used.

#### theme
This folder contains the different theme folders along with the files for the last theme that was used. When a theme is selected with make the contents of that theme is first moved out to the theme directory. This way if changes are made to the settings.d files you only need to run make laptop/desktop (instead of *make laptop theme=margaret*). This is because if no theme is specified the make file just concatenates the files in the root of the theme folder.

#### scripts
I'm gonna blow your mind here, but this folder contains some scripts I use. I know. Very complex. I might write a readme just for this folder later.

---

## Plans

I'd like to completely redo things so that components are even more modular. For example the workspace names are currently built into the global configuration. It would be nice to move those over to the theme folders instead.


The redo would most likely include a way to not explicitly name the primary part of the make directive in the Makefile. Right now we have a laptop, and desktop section, which specifies the folder used after the global files are added. Though the system works for my current setup fairly well, it would not adjust well to having say, a desktop and 2 different laptops. I found myself in that position, and frequently had to manually change things for the second laptop. Thankfully the first one died so... solved that problem didn't we?


Summary: More modular = more better.

## Pretty Pictures
![this is the a2 theme btw](http://i.imgur.com/nuKaTbQ.jpg)

#### You're free to use, modify, and distribute this as you please. Or whatever.
