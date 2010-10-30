# -*- mode: perl; coding: us-ascii-unix -*-
#
# Author:      Peter John Acklam
# Time-stamp:  2010-03-17 21:28:29 +01:00
# E-mail:      pjacklam@online.no
# URL:         http://home.online.no/~pjacklam

use 5.006;              # required version of Perl
use strict;             # restrict unsafe constructs
use warnings;           # control optional warnings

use ExtUtils::MakeMaker;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

WriteMakefile
  (
   (MM->can('signature_target') ? (SIGN => 1) : ()),
   NAME             => 'Math::BigInt::Parts',
   AUTHOR           => 'Peter John Acklam <pjacklam@online.no>',
   VERSION_FROM     => 'lib/Math/BigInt/Parts.pm',
   ABSTRACT_FROM    => 'lib/Math/BigInt/Parts.pm',
   PL_FILES         => {},
   PREREQ_PM        => {
                        #'Scalar::Util' => 0.0,
                       },
   dist             => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
   clean            => { FILES => 'Math-BigInt-Parts-*' },
  );
