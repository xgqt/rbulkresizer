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


#lang racket/base

(require
 (prefix-in image:: 2htdp/image)
 racket/format
 racket/gui
 )


(define program-name "R Bulk ResizeR")


;;; Main frame

(define frame
  (new frame%
       [label program-name]
       [height 600]
       [width  500]
       )
  )


;;; Menu bar

(define menu-bar
  (new menu-bar%
     [parent frame]
     )
  )

(define menu-file
 (new menu%
     [parent menu-bar]
     [label "&File"]
     ))

(define menu-help
  (new menu%
     [parent menu-bar]
     [label "&Help"]
     )
  )


;;; File picker

(define button-pick-file
 (new button%
     [parent frame]
     [label "Pick file"]
     [min-height 100]
     [stretchable-height #f]
     [stretchable-width #t]
     )
  )


;;; Radio box

(define radio-box
  (new radio-box%
     [parent frame]
     [label "Pick resize method"]
     [choices '(
                "Percentage"
                "Dimensions"
                "Width"
                "Height"
                )
              ]
     )
  )


;;; Preview

(define group-box-panel
  (new group-box-panel%
     [parent frame]
     [label "Preview"]
     )
  )


;;; Finishing buttons

(define button-ok
 (new button%
     [parent frame]
     [label "OK"]
     [stretchable-height #f]
     [stretchable-width #f]
     )
  )

(define button-exit
 (new button%
     [parent frame]
     [label "Exit"]
     [stretchable-height #f]
     [stretchable-width #f]
     [callback (lambda (x y) (exit))]
     )
  )


(send frame show #t)
