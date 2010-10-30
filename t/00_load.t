# -*- mode: perl; coding: iso-8859-1-unix -*-
#
# Author:      Peter J. Acklam
# Time-stamp:  2006-09-24 15:49:31 +02:00
# E-mail:      pjacklam@cpan.org
# URL:         http://home.online.no/~pjacklam

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 00_load.t'

#########################

use strict;
use warnings;

local $| = 1;

BEGIN {
    chdir 't' if -d 't';
    unshift @INC, '../lib';             # for running manually
}

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

my $loaded;
BEGIN { print "1..1\n"; }
END   { print "not ok 1 # module load\n" unless $loaded; }
use Math::BigInt::Parts;
$loaded = 1;
print "ok 1 # module load\n";

######################### End of black magic.
