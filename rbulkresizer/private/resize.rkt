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
 2htdp/image
 "resize-functions.rkt"
 )

(provide
 resize
 )


(define (resize percentage width height longest selection image-path-list)
  (map
   (lambda (og-path)
     (let*
         (
          [og-image (bitmap/file og-path)]
          [to-image (case selection
                      ;; Percentage
                      [(0) (percentage-scale percentage og-image)]
                      ;; Dimensions
                      [(1) (resize-elements width height og-image)]
                      ;; Width
                      [(2) (scale-to-element 'width width og-image)]
                      ;; Height
                      [(3) (scale-to-element 'height height og-image)]
                      ;; Longest side
                      [(4) (scale-to-longest-element longest og-image)]
                      ;; Other
                      [else (error "[ ERROR ] No support for this method")]
                      )
                    ]
          [to-path (path-replace-extension og-path #"_resized.png")]
          )
       (displayln (string-append
                   "[ INFO  ] Resizing: "
                   (path->string og-path) " -> " (path->string to-path)
                   ))
       (save-image to-image to-path)
       )
     )
   image-path-list
   )
  )
