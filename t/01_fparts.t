# -*- mode: perl; coding: iso-8859-1-unix -*-
#
# Author:      Peter J. Acklam
# Time-stamp:  2006-09-24 19:09:22 +02:00
# E-mail:      pjacklam@cpan.org
# URL:         http://home.online.no/~pjacklam

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 01_fparts.t'

#########################

use strict;
use warnings;

#use Scalar::Util ();
#use overload ();

local $| = 1;

BEGIN {
    chdir 't' if -d 't';
    unshift @INC, '../lib';     # for running manually
}

use Math::BigFloat;
use Math::BigInt::Parts;

my @data
  =
  (

   [Math::BigFloat->new('+3.141592653589793e-12'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('-12')]],
   [Math::BigFloat->new('+3.141592653589793e-11'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('-11')]],
   [Math::BigFloat->new('+3.141592653589793e-10'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('-10')]],
   [Math::BigFloat->new('+3.141592653589793e-09'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('-9')]],
   [Math::BigFloat->new('+3.141592653589793e-08'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('-8')]],
   [Math::BigFloat->new('+3.141592653589793e-07'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('-7')]],
   [Math::BigFloat->new('+3.141592653589793e-06'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('-6')]],
   [Math::BigFloat->new('+3.141592653589793e-05'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('-5')]],
   [Math::BigFloat->new('+3.141592653589793e-04'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('-4')]],
   [Math::BigFloat->new('+3.141592653589793e-03'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('-3')]],
   [Math::BigFloat->new('+3.141592653589793e-02'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('-2')]],
   [Math::BigFloat->new('+3.141592653589793e-01'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('-1')]],
   [Math::BigFloat->new('+3.141592653589793e+00'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+0')]],
   [Math::BigFloat->new('+3.141592653589793e+01'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+1')]],
   [Math::BigFloat->new('+3.141592653589793e+02'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+2')]],
   [Math::BigFloat->new('+3.141592653589793e+03'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+3')]],
   [Math::BigFloat->new('+3.141592653589793e+04'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+4')]],
   [Math::BigFloat->new('+3.141592653589793e+05'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+5')]],
   [Math::BigFloat->new('+3.141592653589793e+06'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+6')]],
   [Math::BigFloat->new('+3.141592653589793e+07'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+7')]],
   [Math::BigFloat->new('+3.141592653589793e+08'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+8')]],
   [Math::BigFloat->new('+3.141592653589793e+09'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+9')]],
   [Math::BigFloat->new('+3.141592653589793e+10'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+10')]],
   [Math::BigFloat->new('+3.141592653589793e+11'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+11')]],
   [Math::BigFloat->new('+3.141592653589793e+12'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+12')]],
   [Math::BigFloat->new('+3.141592653589793e+13'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+13')]],
   [Math::BigFloat->new('+3.141592653589793e+14'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+14')]],
   [Math::BigFloat->new('+3.141592653589793e+15'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+15')]],
   [Math::BigFloat->new('+3.141592653589793e+16'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+16')]],
   [Math::BigFloat->new('+3.141592653589793e+17'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+17')]],
   [Math::BigFloat->new('+3.141592653589793e+18'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+18')]],
   [Math::BigFloat->new('+3.141592653589793e+19'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+19')]],
   [Math::BigFloat->new('+3.141592653589793e+20'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+20')]],

   [Math::BigFloat->new('-3.141592653589793e-12'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('-12')]],
   [Math::BigFloat->new('-3.141592653589793e-11'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('-11')]],
   [Math::BigFloat->new('-3.141592653589793e-10'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('-10')]],
   [Math::BigFloat->new('-3.141592653589793e-09'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('-9')]],
   [Math::BigFloat->new('-3.141592653589793e-08'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('-8')]],
   [Math::BigFloat->new('-3.141592653589793e-07'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('-7')]],
   [Math::BigFloat->new('-3.141592653589793e-06'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('-6')]],
   [Math::BigFloat->new('-3.141592653589793e-05'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('-5')]],
   [Math::BigFloat->new('-3.141592653589793e-04'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('-4')]],
   [Math::BigFloat->new('-3.141592653589793e-03'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('-3')]],
   [Math::BigFloat->new('-3.141592653589793e-02'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('-2')]],
   [Math::BigFloat->new('-3.141592653589793e-01'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('-1')]],
   [Math::BigFloat->new('-3.141592653589793e+00'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+0')]],
   [Math::BigFloat->new('-3.141592653589793e+01'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+1')]],
   [Math::BigFloat->new('-3.141592653589793e+02'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+2')]],
   [Math::BigFloat->new('-3.141592653589793e+03'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+3')]],
   [Math::BigFloat->new('-3.141592653589793e+04'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+4')]],
   [Math::BigFloat->new('-3.141592653589793e+05'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+5')]],
   [Math::BigFloat->new('-3.141592653589793e+06'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+6')]],
   [Math::BigFloat->new('-3.141592653589793e+07'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+7')]],
   [Math::BigFloat->new('-3.141592653589793e+08'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+8')]],
   [Math::BigFloat->new('-3.141592653589793e+09'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+9')]],
   [Math::BigFloat->new('-3.141592653589793e+10'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+10')]],
   [Math::BigFloat->new('-3.141592653589793e+11'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+11')]],
   [Math::BigFloat->new('-3.141592653589793e+12'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+12')]],
   [Math::BigFloat->new('-3.141592653589793e+13'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+13')]],
   [Math::BigFloat->new('-3.141592653589793e+14'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+14')]],
   [Math::BigFloat->new('-3.141592653589793e+15'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+15')]],
   [Math::BigFloat->new('-3.141592653589793e+16'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+16')]],
   [Math::BigFloat->new('-3.141592653589793e+17'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+17')]],
   [Math::BigFloat->new('-3.141592653589793e+18'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+18')]],
   [Math::BigFloat->new('-3.141592653589793e+19'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+19')]],
   [Math::BigFloat->new('-3.141592653589793e+20'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+20')]],

   [Math::BigInt->new('+3'),                     [Math::BigFloat->new('+3'),                 Math::BigInt->new('+0')]],
   [Math::BigInt->new('+31'),                    [Math::BigFloat->new('+3.1'),               Math::BigInt->new('+1')]],
   [Math::BigInt->new('+314'),                   [Math::BigFloat->new('+3.14'),              Math::BigInt->new('+2')]],
   [Math::BigInt->new('+3141'),                  [Math::BigFloat->new('+3.141'),             Math::BigInt->new('+3')]],
   [Math::BigInt->new('+31415'),                 [Math::BigFloat->new('+3.1415'),            Math::BigInt->new('+4')]],
   [Math::BigInt->new('+314159'),                [Math::BigFloat->new('+3.14159'),           Math::BigInt->new('+5')]],
   [Math::BigInt->new('+3141592'),               [Math::BigFloat->new('+3.141592'),          Math::BigInt->new('+6')]],
   [Math::BigInt->new('+31415926'),              [Math::BigFloat->new('+3.1415926'),         Math::BigInt->new('+7')]],
   [Math::BigInt->new('+314159265'),             [Math::BigFloat->new('+3.14159265'),        Math::BigInt->new('+8')]],
   [Math::BigInt->new('+3141592653'),            [Math::BigFloat->new('+3.141592653'),       Math::BigInt->new('+9')]],
   [Math::BigInt->new('+31415926535'),           [Math::BigFloat->new('+3.1415926535'),      Math::BigInt->new('+10')]],
   [Math::BigInt->new('+314159265358'),          [Math::BigFloat->new('+3.14159265358'),     Math::BigInt->new('+11')]],
   [Math::BigInt->new('+3141592653589'),         [Math::BigFloat->new('+3.141592653589'),    Math::BigInt->new('+12')]],
   [Math::BigInt->new('+31415926535897'),        [Math::BigFloat->new('+3.1415926535897'),   Math::BigInt->new('+13')]],
   [Math::BigInt->new('+314159265358979'),       [Math::BigFloat->new('+3.14159265358979'),  Math::BigInt->new('+14')]],
   [Math::BigInt->new('+3141592653589793'),      [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+15')]],
   [Math::BigInt->new('+31415926535897930'),     [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+16')]],
   [Math::BigInt->new('+314159265358979300'),    [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+17')]],
   [Math::BigInt->new('+3141592653589793000'),   [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+18')]],
   [Math::BigInt->new('+31415926535897930000'),  [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+19')]],
   [Math::BigInt->new('+314159265358979300000'), [Math::BigFloat->new('+3.141592653589793'), Math::BigInt->new('+20')]],

   [Math::BigInt->new('-3'),                     [Math::BigFloat->new('-3'),                 Math::BigInt->new('+0')]],
   [Math::BigInt->new('-31'),                    [Math::BigFloat->new('-3.1'),               Math::BigInt->new('+1')]],
   [Math::BigInt->new('-314'),                   [Math::BigFloat->new('-3.14'),              Math::BigInt->new('+2')]],
   [Math::BigInt->new('-3141'),                  [Math::BigFloat->new('-3.141'),             Math::BigInt->new('+3')]],
   [Math::BigInt->new('-31415'),                 [Math::BigFloat->new('-3.1415'),            Math::BigInt->new('+4')]],
   [Math::BigInt->new('-314159'),                [Math::BigFloat->new('-3.14159'),           Math::BigInt->new('+5')]],
   [Math::BigInt->new('-3141592'),               [Math::BigFloat->new('-3.141592'),          Math::BigInt->new('+6')]],
   [Math::BigInt->new('-31415926'),              [Math::BigFloat->new('-3.1415926'),         Math::BigInt->new('+7')]],
   [Math::BigInt->new('-314159265'),             [Math::BigFloat->new('-3.14159265'),        Math::BigInt->new('+8')]],
   [Math::BigInt->new('-3141592653'),            [Math::BigFloat->new('-3.141592653'),       Math::BigInt->new('+9')]],
   [Math::BigInt->new('-31415926535'),           [Math::BigFloat->new('-3.1415926535'),      Math::BigInt->new('+10')]],
   [Math::BigInt->new('-314159265358'),          [Math::BigFloat->new('-3.14159265358'),     Math::BigInt->new('+11')]],
   [Math::BigInt->new('-3141592653589'),         [Math::BigFloat->new('-3.141592653589'),    Math::BigInt->new('+12')]],
   [Math::BigInt->new('-31415926535897'),        [Math::BigFloat->new('-3.1415926535897'),   Math::BigInt->new('+13')]],
   [Math::BigInt->new('-314159265358979'),       [Math::BigFloat->new('-3.14159265358979'),  Math::BigInt->new('+14')]],
   [Math::BigInt->new('-3141592653589793'),      [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+15')]],
   [Math::BigInt->new('-31415926535897930'),     [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+16')]],
   [Math::BigInt->new('-314159265358979300'),    [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+17')]],
   [Math::BigInt->new('-3141592653589793000'),   [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+18')]],
   [Math::BigInt->new('-31415926535897930000'),  [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+19')]],
   [Math::BigInt->new('-314159265358979300000'), [Math::BigFloat->new('-3.141592653589793'), Math::BigInt->new('+20')]],

   [Math::BigFloat->new('+0.1'), [Math::BigFloat->new('+1'),   Math::BigInt->new('-1')]],
   [Math::BigFloat->new('+1'),   [Math::BigFloat->new('+1'),   Math::BigInt->new('+0')]],
   [Math::BigFloat->new('+10'),  [Math::BigFloat->new('+1'),   Math::BigInt->new('+1')]],

   [Math::BigFloat->new('-0.1'), [Math::BigFloat->new('-1'),   Math::BigInt->new('-1')]],
   [Math::BigFloat->new('-1'),   [Math::BigFloat->new('-1'),   Math::BigInt->new('+0')]],
   [Math::BigFloat->new('-10'),  [Math::BigFloat->new('-1'),   Math::BigInt->new('+1')]],

   [Math::BigFloat->new('+0'),   [Math::BigFloat->new('+0'),   Math::BigInt->new('+0')]],

   [Math::BigFloat->new('+inf'), [Math::BigFloat->new('+inf'), Math::BigInt->new('+inf')]],
   [Math::BigFloat->new('-inf'), [Math::BigFloat->new('-inf'), Math::BigInt->new('+inf')]],
   [Math::BigFloat->new('nan'),  [Math::BigFloat->new('nan'),  Math::BigInt->new('nan')]],

   [Math::BigInt->new('+inf'),   [Math::BigFloat->new('+inf'), Math::BigInt->new('+inf')]],
   [Math::BigInt->new('-inf'),   [Math::BigFloat->new('-inf'), Math::BigInt->new('+inf')]],
   [Math::BigInt->new('nan'),    [Math::BigInt->new('nan'),    Math::BigInt->new('nan')]],
  );

print "1..242\n";

my $testno = 0;

### List context ###

for (my $i = 0 ; $i <= $#data ; ++ $i) {
    ++ $testno;

    my $in                = $data[$i][0];
    my $out_expected_mant = $data[$i][1][0];
    my $out_expected_expo = $data[$i][1][1];

    #printf "%40s -> %20s %6s\n", $in, $out_expected_mant, $out_expected_expo;
    #next;

    #my $in_orig_val = $in->copy();
    #my $in_orig_adr = Scalar::Util::refaddr($in);
    #my $in_orig_adr = overload::StrVal($in);

    # Get the actual output argument.

    my @out_actual = $in->fparts();

    # First make sure that the input argument was unmodified.

    # xxx not implemented yet

    # Check the output.

    my $noutargs = @out_actual;
    if ($noutargs != 2) {
        print "not ok ", $testno, "\n";
        print "  input ...: $in\n";
        print "  error ...: got $noutargs arg(s), expected 2\n";
        next;
    }

    unless (defined $out_actual[0]) {
        print "not ok ", $testno, "\n";
        print "  input ...: $in\n";
        print "  error ...: first output arg is undefined\n";
        next;
    }

    if (ref($out_actual[0]) ne 'Math::BigFloat') {
        print "not ok ", $testno, "\n";
        print "  input ...: $in\n";
        print "  error ...: first output arg not a Math::BigFloat object\n";
        next;
    }

    unless ($out_expected_mant->is_nan() ?
            $out_actual[0] -> is_nan()   :
            $out_actual[0] == $out_expected_mant)
    {
        print "not ok ", $testno, "\n";
        print "  input ...............: $in\n";
        print "  output mantissa .....: $out_actual[0]\n";
        print "  expected mantissa ...: $out_expected_mant\n";
        next;
    }

    unless (defined $out_actual[1]) {
        print "not ok ", $testno, "\n";
        print "  input ...: $in\n";
        print "  error ...: second output arg is undefined\n";
        next;
    }

    if (ref($out_actual[1]) ne 'Math::BigInt') {
        print "not ok ", $testno, "\n";
        print "  input ...: $in\n";
        print "  error ...: second output argument is not Math::BigInt object\n";
        next;
    }

    unless ($out_expected_expo->is_nan() ?
            $out_actual[1] -> is_nan()   :
            $out_actual[1] == $out_expected_expo)
    {
        print "not ok ", $testno, "\n";
        print "  input ...............: $in\n";
        print "  output exponent .....: $out_actual[1]\n";
        print "  expected exponent ...: $out_expected_expo\n";
        next;
    }

    print "ok ", $testno, "\n";
}

### Scalar context ###

for (my $i = 0 ; $i <= $#data ; ++ $i) {
    ++ $testno;

    my $in                = $data[$i][0];
    my $out_expected_mant = $data[$i][1][0];

    #printf "%40s -> %20s\n", $in, $out_expected_mant;
    #die;

    # Get the actual output argument.

    my @out_actual;
    $out_actual[0] = $in->fparts();

    # Check the output.

    unless (defined $out_actual[0]) {
        print "not ok ", $testno, "\n";
        print "  input ...: $in\n";
        print "  error ...: first output arg is undefined\n";
        next;
    }

    if (ref($out_actual[0]) ne 'Math::BigFloat') {
        print "not ok ", $testno, "\n";
        print "  input ...: $in\n";
        print "  error ...: first output arg not a Math::BigFloat object\n";
        next;
    }

    unless ($out_expected_mant->is_nan() ?
            $out_actual[0] -> is_nan()   :
            $out_actual[0] == $out_expected_mant)
    {
        print "not ok ", $testno, "\n";
        print "  input ...............: $in\n";
        print "  output mantissa .....: $out_actual[0]\n";
        print "  expected mantissa ...: $out_expected_mant\n";
        next;
    }

    print "ok ", $testno, "\n";
}

__END__

# Emacs Local Variables:
# Emacs mode: perl
# Emacs coding: iso-8859-1-unix
# Emacs End:
