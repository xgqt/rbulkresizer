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


PACKAGE-NAME		:= $(shell basename $(abspath .))
PACKAGE-EXE			:= $(PACKAGE-NAME).exe
PACKAGE-DIST		:= $(PACKAGE-NAME)_distribution
PACKAGE-DIST-TAR	:= $(PACKAGE-DIST).tar.gz
PACKAGE-ZIP			:= $(PACKAGE-NAME).zip

RACKET				:= racket
RACO				:= raco

ENTRYPOINT			:= $(PACKAGE-NAME)/main.rkt
COMPILE-FLAGS		:= -v
RUN-FLAGS			:=
EXE-FLAGS			:= -v -o $(PACKAGE-EXE)
DO-DOCS				:= --no-docs
INSTALL-FLAGS		:= --auto $(DO-DOCS)
DEPS-FLAGS			:= --check-pkg-deps --unused-pkg-deps


all:	install setup test

compile:
	$(RACO) make $(COMPILE-FLAGS) $(ENTRYPOINT)

run:
	$(RACKET) $(RUN-FLAGS) $(ENTRYPOINT)

install:
	$(RACO) pkg install $(INSTALL-FLAGS) --name $(PACKAGE-NAME)


# Distribution

exe:	compile
	$(RACO) exe $(EXE-FLAGS) $(ENTRYPOINT)

dist:	exe
	mkdir -p $(PACKAGE-DIST)
	$(RACO) distribute $(PACKAGE-DIST) $(PACKAGE-EXE)
	tar cfz $(PACKAGE-DIST-TAR) $(PACKAGE-DIST)

pkg:
	$(RACO) pkg create --source $(PWD)


# Removal

distclean:
	if [ -d $(PACKAGE-DIST) ] ; then rm -r $(PACKAGE-DIST) ; fi
	if [ -f $(PACKAGE-DIST-TAR) ] ; then rm $(PACKAGE-DIST-TAR) ; fi
	if [ -f $(PACKAGE-ZIP) ] ; then rm $(PACKAGE-ZIP)* ; fi

clean:	distclean
	find . -depth -type d -name 'compiled' -exec rm -r {} \;
	if [ -f $(PACKAGE-EXE) ] ; then rm $(PACKAGE-EXE) ; fi

remove:
	$(RACO) pkg remove $(DO-DOCS) $(PACKAGE-NAME)

purge:	remove clean

reinstall:	remove install


# Tests

# This builds docs
setup:
	$(RACO) setup --tidy --avoid-main $(DEPS-FLAGS) --pkgs $(PACKAGE-NAME)

check-deps:
	$(RACO) setup $(DO-DOCS) $(DEPS-FLAGS) $(PACKAGE-NAME)

test:
	$(RACO) test --package $(PACKAGE-NAME)


# Everything

everything-test:	clean compile install setup check-deps test remove clean

everything-dist:	clean pkg compile dist
