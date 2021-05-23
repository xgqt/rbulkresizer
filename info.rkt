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


#lang info


(define pkg-authors '(Maciej Barć))
(define pkg-desc "Graphical bulk picture resize tool.")
(define version "1.3.1")

(define collection 'multi)
(define scribblings '(("scribblings/rbulkresizer.scrbl" ())))

(define deps
  '(
    "base"
    "gui-lib"
    "htdp-lib"
    "net-lib"
    )
  )
(define build-deps
  '(
    "racket-doc"
    "rackunit-lib"
    "scribble-lib"
    )
  )
