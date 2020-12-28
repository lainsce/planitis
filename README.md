# ![icon](data/icon.png) Planitis

## Build up your planet's buildings and grow yourself a ecumenopolis of native aliens

[![Get it on AppCenter](https://appcenter.elementary.io/badge.svg)](https://appcenter.elementary.io/com.github.lainsce.planitis)

[![Build Status](https://travis-ci.org/lainsce/planitis.svg?branch=master)](https://travis-ci.org/lainsce/planitis)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)

![Screenshot](data/shot.png)

## Donations

Would you like to support the development of this app to new heights? Then:

[Be my backer on Patreon](https://www.patreon.com/lainsce)

## Dependencies

Please make sure you have these dependencies first before building.

```bash
granite
gtk+-3.0
libjson-glib
libgee-0.8
meson
```

## Building

Simply clone this repo, then:

```bash
meson build && cd build
meson configure -Dprefix=/usr
sudo ninja install
```
