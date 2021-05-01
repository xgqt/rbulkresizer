#!/usr/bin/env bash


# This file is part of rbulkresizer.

# rbulkresizer is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 3.

# rbulkresizer is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with rbulkresizer.  If not, see <https://www.gnu.org/licenses/>.

# Copyright (c) 2021, Maciej Barć <xgqt@riseup.net>
# Licensed under the GNU GPL v3 License
# SPDX-License-Identifier: GPL-3.0-only


export PATH
set -e
trap 'die' INT ERR


function bold() {
    echo "$(tput bold 2>/dev/null)${*}$(tput sgr0 2>/dev/null)"
}

function info() {
    bold "[ INFO  ] ${*}"
}

function die() {
    bold "[ ERROR ] Failure at line ${LINENO}"
    exit 1
}


info "Create executable"
make compile
make exe

info "Installation"
make install
make setup

info "Tests"
make check-deps
make test

info "Removal and cleanup"
make remove
make clean
