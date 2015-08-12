Shattings
=========

> SHAred + SeTTINGS = *Shattings*

## License ##

This colleciton of works is Copyright (C) 2012 Robert Quattlebaum. The
individual files contained in this collection may or may not be
covered by this license. Such files are clearly marked.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## About ##

Shattings is a collection of scripts and settings which improve my own
productivity at the terminal. YMMV.

It is a work in progress. Not guaranteed to be useful for anyone
except me.

## Quick Install ##

If you have `curl` installed, type:

    bash -c "$(curl -L https://raw.github.com/darconeous/shattings/master/quick_start.sh)"

If you don't have`curl`, but have `wget`, type:

    bash -c "$(wget -O /dev/stdout https://raw.github.com/darconeous/shattings/master/quick_start.sh)"

---

Another good complement to shattings on MacOS X is
[Homebrew](http://brew.sh).

    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

Below are the homebrew packages that I always tend to install:

	brew install c-kermit
	brew install nmap
	brew install xmlstarlet
	brew install tmux
	brew install dos2unix
	brew install wget
	brew install wine

For general software development:

	brew install pkg-config
	brew install boost
	brew install abnfgen
	brew install node
	brew install docker
	brew install qemu

For secure element stuff:

	brew install mfcuk
	brew install mfoc
	brew install nfcutils
	brew install yubico-piv-tool
	brew install ykpers
	brew install ykclient
	brew install gpshell
	brew install globalplatform
	brew install libfreefare

For CoAP stuff:

	brew tap darconeous/embedded
	brew install smcp

For embedded development:

	brew tap darconeous/embedded
	brew install arm-2008q3-gcc
	brew install avr-gcc
	brew install avr-gdb
	brew install avrdude         # For general-purpose AVR programming.
	brew install dfu-programmer  # For programming AVR USB chips.
	brew install avarice         # For using GDB.
	brew install darconeous/embedded/sdcc # SDCC with special fixes
	brew install cc-tool         # For using the CC-Debugger
	brew install srecord
	brew install open-ocd

---

[MouseTerm](https://bitheap.org/mouseterm/) is also useful for
enabling mouse support in vim.
