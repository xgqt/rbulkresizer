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

;; Directory Local Variables
;; For more information see (info "(emacs) Directory Variables")


(
 (nil
  . (
     (projectile-project-type            . make)
     (projectile-project-compilation-cmd . "make clean compile")
     (projectile-project-install-cmd     . "make install")
     (projectile-project-test-cmd        . "make test-local")
     )
  )
 (find-file
  . (
     (indent-tabs-mode . nil)
     (require-final-newline . t)
     (show-trailing-whitespace . t)
     (tab-width . 4)
     )
  )
 (makefile-mode
  . (
     (indent-tabs-mode . t)
     )
  )
 (yaml-mode
  . (
     (tab-width . 2)
     )
  )
 )
