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
 (only-in racket/gui/base message-box)
 2htdp/image
 racket/format
 "resize-functions.rkt"
 "resize-helpers.rkt"
 )

(provide
 resize
 )


(define (error-box msg)
  "Display a error message box and throw a error."
  (message-box "ERROR" msg)
  (error msg)
  )


(define (resize
         #:percentage [percentage #f]
         #:width      [width      #f]
         #:height     [height     #f]
         #:longest    [longest    #f]
         #:selection  [selection  #f]
         image-path-list
         )

  ;; SELECTION guard to throw error early
  (case selection
    ['percentage (when (<0? percentage)
                   (error-box
                    (~a "Wrong parameter percentage: " percentage)))
                 ]
    ['dimensions (when (or (<0? width) (<0? height))
                   (error-box
                    (~a "Wrong parameters width & height: " width height)))
                 ]
    ['width      (when (<0? width)
                   (error-box
                    (~a "Wrong parameter width: " width)))
                 ]
    ['height     (when (<0? height)
                   (error-box
                    (~a "Wrong parameter height: " height)))
                 ]
    ['longest    (when (<0? longest)
                   (error-box
                    (~a "Wrong parameter longest: " longest)))
                 ]
    [else        (error-box
                  "[ERROR] Wrong selection")
                 ]
    )

  (map
   (lambda (og-path)
     (let*
         (
          [og-image (bitmap/file og-path)]
          [to-image (case selection
                      ['percentage
                       (percentage-scale percentage og-image)]
                      ['dimensions
                       (resize-elements width height og-image)]
                      ['width
                       (scale-to-element 'width width og-image)]
                      ['height
                       (scale-to-element 'height height og-image)]
                      ['longest
                       (scale-to-longest-element longest og-image)]
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
