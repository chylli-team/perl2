#!/bin/bash
set -e

echo "Building perl version $VERSION"
rm -rf bin lib man
wget http://www.cpan.org/src/5.0/perl-$VERSION.tar.gz
rm -rf perl-$VERSION
tar xzvf perl-$VERSION.tar.gz
cd perl-$VERSION

#We defined `-Dusesitecustomize` and removed `-Dusethreads`. Most of other parameters are copied from `perl -V | grep config_args`
./Configure -Dusesitecustomize -Dinc_version_list=none -Duselargefiles -Dccflags="-DDEBIAN -D_FORTIFY_SOURCE=2 -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security" -Dldflags=" -Wl,-z,relro" -Dlddlflags="-shared -Wl,-z,relro" -Dcccdlflags="-fPIC" -Duse64bitint -Dman1dir=none -Dman3dir=none -Dpager=/usr/bin/sensible-pager -Uafs -Ud_csh -Ud_ualarm -Uusesfio -Uusenm -Uuseithreads -Uusemultiplicity -Ui_libutil -DDEBUGGING=-g -Doptimize=-O2 -Duseshrplib -des
make && make test && make install

