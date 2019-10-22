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

## Steps by example

    $ git clone git@github.com:alpha-rudy/gpx-overlay.git
    $ cd gpx-overlay/
    $ cp /path/to/src/Markchoo.osm /path/to/src/Happyman.osm .
    $ make
    $ ls *.map *.map.zip
    Happyman.map  Happyman.map.zip  Markchoo.map  Marchoo.map.zip

## BSD License

    Copyright (c) 2019, Rudy Chung
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:
        * Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
        * Redistributions in binary form must reproduce the above copyright
        notice, this list of conditions and the following disclaimer in the
        documentation and/or other materials provided with the distribution.
        * Neither the name of the <organization> nor the
        names of its contributors may be used to endorse or promote products
        derived from this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL RUDY CHUNG BE LIABLE FOR ANY
    DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
    ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
