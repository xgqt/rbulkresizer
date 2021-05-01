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
 racket/format
 )

(provide
 percentage-scale
 resize-elements
 scale-to-element
 scale-to-longest-element
 )


;; Example usage:
;;   (percentage-scale 50 (bitmap/file (string->path "string-path")))


(define (percentage-scale percentage image)
  "Given a number PERCENTAGE scale IMAGE to it."
  (scale (/ percentage 100) image)
  )

(define (resize-elements width height image)
  "Return a IMAGE of given WIDTH and HEIGHT."
  (let*
      (
       [og-width  (image-width  image)]
       [og-height (image-height image)]
       [to-width  (/ width  og-width)]
       [to-height (/ height og-height)]
       )
    (scale/xy to-width to-height image)
    )
  )

(define (scale-to-element element size image)
  "Scale IMAGE to SIZE of given ELEMENT: width or height"
  (let*
      (
       [og-size (case element
                  ['width  (image-width image)]
                  ['height (image-height image)]
                  [else (error (string-append
                                "Unknown element: " (~v element) "\n"
                                "Requires: 'width or 'height"
                                ))]
                  )]
       [to-scale (/ size og-size)]
       )
    (scale to-scale image)
    )
  )

(define (scale-to-longest-element size image)
  "Take the longest element and scale image to SIZE based on it."
  (if (> (image-width image) (image-height image))
      (scale-to-element 'width size image)
      (scale-to-element 'height size image)
      )
  )
