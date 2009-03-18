SWFMP3
======

SWFMP3, the MP3 player that Does Much Less™


Compilation
-----------
SWFMP3 has been created using fluby, so compilation is pretty straightforward:

    $ cd SWFMP3
    $ rake

There are some additional rake tasks available:

rake release  # Build a release version of SWFMP3 (with trace() disabled)
rake test     # Test the SWF file in your default browser


Customization
-------------
The look of the player is determined by the crappy PNG files in the 'assets' folder.


Features
--------
* Plays MP3 files :P
* Easily customizable (for really broad definitions of the word 'easy', that is)
* The width of the player is set automatically, so you can use whatever size you want. However, vertical height is defined by the background image (bg.png)


Usage
-----
Just stick it to your HTML using SWFObject, and set the MP3 file to play with:

    so.addVariable("mp3_file","ouh_yeah_baby.mp3");


--- 
Created: Thu Apr 03 19:09:50 +0200 2008