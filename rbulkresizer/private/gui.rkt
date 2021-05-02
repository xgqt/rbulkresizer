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
 racket/gui
 "gui-helpers.rkt"
 "program-name.rkt"
 "resize.rkt"
 )

(provide
 app-start
 )


;;; Images to resize

;; Initial value - empty list
(define images-to-resize '())

;; Show the contents of IMAGES-TO-RESIZE on the canvas and console
(define (display-images-to-resize)
  "On console and canvas write the paths of files from IMAGES-TO-RESIZE."

  (displayln (string-append "[ INFO  ] Images: " (~v images-to-resize)))

  (send text insert
        (string-append
         "\n" "Files: "
         (~a (map (lambda (path) (string-append (path->string path) "\n"))
                  images-to-resize))
         )
        )
  (send editor-canvas set-editor text)
  )

(define (add-images-to-resize)
  (let*
      ([new-images (get-file-list "Pick images to resize")])
    (cond
      [(list? new-images)
       (set! images-to-resize (append images-to-resize new-images))]
      [else (message-box "No files" "You haven't picked any files")]
      )
    )
  (display-images-to-resize)
  )

(define (clean-images-to-resize)
  (set! images-to-resize '())
  (display-images-to-resize)
  )

(define (resize-start)
  (resize
   (string->number (send field-percentage get-value))
   (string->number (send field-width      get-value))
   (string->number (send field-height     get-value))
   (string->number (send field-longest    get-value))
   (send radio-box get-selection)
   images-to-resize
   )
  )


;;; Main frame

(define frame
  (new frame%
       [label program-titlebar]
       [height 600]
       [width  600]
       )
  )

(define (app-close)
  "`app-close' is the soft exit and `app-exit' from 'gui-helpers.rkt' is hard"
  (displayln "[WARNING] Closing the application")
  (displayln "[ INFO  ] Bye...")
  (send frame show #f)
  )


;;; Menu bar

(define menu-bar
  (new menu-bar%
     [parent frame]
     )
  )

;; File menu
(define menu-file
 (new menu%
     [parent menu-bar]
     [label "&File"]
     )
  )

(define menu-file-add
 (new menu-item%
     [parent menu-file]
     [label "&Add"]
     [help-string "Add new files"]
     [callback (lambda _ (add-images-to-resize))]
     )
  )

(define menu-file-resize
 (new menu-item%
     [parent menu-file]
     [label "&Resize"]
     [help-string "Resize picked files"]
     [callback (lambda _ (resize-start))]
     )
  )

(define menu-file-clean
 (new menu-item%
     [parent menu-file]
     [label "&Clean"]
     [help-string "Clean the list of selected files"]
     [callback (lambda _ (clean-images-to-resize))]
     )
  )

(define menu-file-close
 (new menu-item%
     [parent menu-file]
     [label "&Close"]
     [help-string "Close the application"]
     [callback (lambda _ (app-close))]
     )
  )

(define menu-file-exit
 (new menu-item%
     [parent menu-file]
     [label "&Exit"]
     [help-string "Exit the application"]
     [callback (lambda _ (app-exit))]
     )
  )

;; Help menu
(define menu-help
  (new menu%
     [parent menu-bar]
     [label "&Help"]
     )
  )

(define menu-help-about
  (new menu-item%
     [parent menu-help]
     [label "&About"]
     [help-string "Show information about the application"]
     [callback (lambda _ (message-box program-name program-license))]
     )
  )

(define menu-help-repository
  (new menu-item%
     [parent menu-help]
     [label "&Repository"]
     [help-string "Open the repository URL"]
     [callback (lambda _ (repo-open))]
     )
  )

(define menu-help-repository-issues
  (new menu-item%
     [parent menu-help]
     [label "&Report a bug"]
     [help-string "Report a bug in GitLab issues"]
     [callback (lambda _ (repo-open-issues))]
     )
  )


;;; File picker

(define button-pick-file
 (new button%
     [parent frame]
     [label "Pick files"]
     [min-height 60]
     [stretchable-height #f]
     [stretchable-width #t]
     [callback (lambda _ (add-images-to-resize))]
     )
  )


;;; Radio box

(define radio-box
  (new radio-box%
       [parent frame]
       [label "Resize method"]
       [choices '(
                  "Percentage - scale whole image by given percentage"  ; 0
                  "Dimensions - resize to target width and height"      ; 1
                  "Width      - scale to crate target width"            ; 2
                  "Height     - scale to crate target height"           ; 3
                  "Longest side - scale to target width or height based on the longest side"  ; 4
                  )
                ]
       )
  )


;;; Parameters

;; NOTICE: input values are strings

(define field-percentage
  (new text-field%
       [parent frame]
       [label "Percentage"]
       [init-value "100"]
       )
  )

(define field-width
  (new text-field%
       [parent frame]
       [label "Width"]
       [init-value "500"]
       )
  )

(define field-height
  (new text-field%
       [parent frame]
       [label "Height"]
       [init-value "500"]
       )
  )

(define field-longest
  (new text-field%
       [parent frame]
       [label "Longest"]
       [init-value "500"]
       )
  )


;;; Preview

;; TODO: make this non-editable (replace editor-canvas)

(define group-box-panel
  (new group-box-panel%
       [parent frame]
       [label "Files"]
       [min-height 100]
       )
  )

(define editor-canvas
  (new editor-canvas%
       [parent group-box-panel]
       [style '(hide-hscroll hide-vscroll)]
       )
  )

(define text
  (new text%)
  )


;;; Finishing buttons

(define horizontal-panel
  (new horizontal-panel%
       [parent frame]
       [alignment '(center center)]
       [stretchable-width #f]
       [stretchable-height #f]
       )
  )

;; Confirm & start the resize action.
(define button-ok
 (new button%
     [parent horizontal-panel]
     [label "OK"]
     [stretchable-height #f]
     [stretchable-width #f]
     [callback
      (lambda _ (resize-start))
      ]
     )
  )

;; Clean the IMAGES-TO-RESIZE list.
(define button-clean
 (new button%
     [parent horizontal-panel]
     [label "Clean"]
     [stretchable-height #f]
     [stretchable-width #f]
     [callback (lambda _ (clean-images-to-resize))]
     )
  )

;; Close the application ("soft" exit).
(define button-close
 (new button%
     [parent horizontal-panel]
     [label "Close"]
     [stretchable-height #f]
     [stretchable-width #f]
     [callback (lambda _ (app-close))]
     )
  )

;; Exit the application ("hard" exit).
(define button-exit
 (new button%
     [parent horizontal-panel]
     [label "Exit"]
     [stretchable-height #f]
     [stretchable-width #f]
     [callback (lambda _ (app-exit))]
     )
  )


(define (app-start
         #:start-with-files [start-with-files '()]
         )
  "Start the application"
  (displayln "[ INFO  ] Starting...")

  ;; Add optional arguments
  (set! images-to-resize (append images-to-resize start-with-files))

  ;; Show the main window frame
  (send frame show #t)

  ;; Display of images
  (display-images-to-resize)
  )
