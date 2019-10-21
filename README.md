# GPX Overlay Utility

This is a small utility to ease the conversion GPX Overlay from the .osm to the .map format.

## Installation

Before to use this utility (script) you need to install:

    1. osmconvert
    2. python3
    3. java
    4. 7z

For example, at Ubuntu, you could:

    $ sudo apt-get install osmctools python3 default-jdk p7zip-full

## Steps

    $ git clone git@github.com:alpha-rudy/gpx-overlay.git
    $ cd gpx-overlay/
    $ cp /path/to/src/Markchoo.osm /path/to/src/Happyman.osm
    $ make
    $ ls *.map *.map.zip
    Happyman.map  Happyman.map.zip  Markchoo.map  Marchoo.map.zip
