#!/usr/bin/env racket


;; This file is part of rbulkresizer.

;; rbulkresizer is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, version 3.

;; rbulkresizer is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with rbulkresizer.  If not, see <https://www.gnu.org/licenses/>.

;; Copyright (c) 2021, Maciej Barć <xgqt@riseup.net>
;; Licensed under the GNU GPL v3 License
;; SPDX-License-Identifier: GPL-3.0-only


#lang scribble/manual

@require[@for-label[rbulkresizer
                    racket/base]]


@title{R Bulk ResizeR}

@author[@author+email["Maciej Barć"
                      "xgqt@riseup.net"]]


@section{About}

R Bulk ResizeR, also called rbulkresizer is a graphical
bulk picture resize tool.


@section{rbulkresizer executable}

On commandline the @exec{rbulkresizer} launcher executable takes any number
of arguments and interprets them as pictures to append to initial list
of pictures to rezise.

For example:
@commandline{rbulkresizer ~/Pictures/Screenshots/*.png ~/Downloads/test.jpg}


@section{Requiring the rbulkresizer module}

@defmodule[rbulkresizer]

Requiring the module is unnecessary, it is reccomended to run
@exec{rbulkresizer} via it's launcher instead.
