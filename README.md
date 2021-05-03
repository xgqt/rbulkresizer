# R Bulk ResizeR

<p align="center">
    <a href="https://gitlab.com/xgqt/rbulkresizer/pipelines">
        <img src="https://gitlab.com/xgqt/rbulkresizer/badges/master/pipeline.svg">
    </a>
    <a href="https://github.com/xgqt/rbulkresizer/actions/workflows/ci.yml">
        <img src="https://github.com/xgqt/rbulkresizer/actions/workflows/ci.yml/badge.svg">
    </a>
    <a href="https://gitlab.com/xgqt/rbulkresizer/commits/master.atom">
        <img src="https://img.shields.io/badge/feed-atom-orange.svg">
    </a>
    <a href="./LICENSE">
        <img src="https://img.shields.io/badge/license-GPLv3-blue.svg">
    </a>
</p>

Graphical bulk picture resize tool written in Racket.


# About

This app is meant to be a alternative to https://bulkresizephotos.com
A member of my family was using that service to resize their photos
so I thought I would write a libre replacement.


# Bugs

Report bugs to [the upstream on GitLab](https://gitlab.com/xgqt/rbulkresizer).

- few TODOs and FIXMEs here and there
- can only create PNG images


# Compilation

**WARNING!!!** This process is still experimental.
Better to just install [Racket](https://racket-lang.org/download/), especially if you are on GNU+Linux.

By using scripts from this repository the binaries can be found
in [bin](./bin) directory.


## Linux

Execute `make exe`.


## Windows

Run the [exe.ps1](./exe.ps1) script.


# License

SPDX-License-Identifier: GPL-3.0-only

## Unless otherwise stated contents here are under the GNU GPL v3 license

This file is part of rbulkresizer.

rbulkresizer is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3.

rbulkresizer is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with rbulkresizer.  If not, see <https://www.gnu.org/licenses/>.

Copyright (c) 2021, Maciej Barć <xgqt@riseup.net>
Licensed under the GNU GPL v3 License
