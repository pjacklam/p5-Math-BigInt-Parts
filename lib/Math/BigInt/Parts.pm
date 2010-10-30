# -*- mode: perl; coding: iso-8859-1-unix; -*-
#
# Author:      Peter J. Acklam
# Time-stamp:  2006-09-24 23:06:01 +02:00
# E-mail:      pjacklam@online.no
# URL:         http://home.online.no/~pjacklam

package Math::BigInt;

use 5.008;

use strict;                     # restrict unsafe constructs
use warnings;                   # control optional warnings

use vars qw($VERSION @ISA);

use Carp;
use Math::BigFloat;

$VERSION = '0.01';
@ISA = qw();

=head1 NAME

Math::BigInt::Parts - split a Math::BigInt into mantissa and exponent

=head1 SYNOPSIS

  use Math::BigInt::Parts;

  $h = Math::BigFloat->new('6.6260693e-34');   # Planck's constant

  # a non-zero, finite mantissa $mant always satisfies 1 <= $mant < 10

  ($mant, $expo) = $h->fparts();    # $mant = 6.6260693, $expo = -34

  # a non-zero, finite mantissa $mant always satisfies 1 <= $mant < 1000
  # and the exponent $expo is always a multiple of 3

  ($mant, $expo) = $h->eparts();    # $mant = 662.60693, $expo = -36

  # compare this with the standard parts method, which returns both
  # the mantissa and exponent as integers

  ($mant, $expo) = $h->parts();     # $mant = 66260693, $expo = -41

=head1 DESCRIPTION

This module implements the Math::BigInt methods C<fparts> and C<eparts> which
are variants of the standard Math::BigInt C<parts> method.  C<fparts> and
C<eparts> return the mantissa and exponent with the values that are common for
floating point numbers in standard notation and in engineering notation,
respectively.

=head1 METHODS

=head2 Behaviour common for both methods

The following applies to both methods, and assumes the methods are called using

  ($mant, $expo) = $x->fparts ();     # or eparts()
  $mant = $x->fparts ();              # or eparts()

=over 4

=item Output versus input

For a zero value operand $x, both the mantissa $mant and the exponent $expo is
zero.  For plus/minus infinity, the mantissa is infinity with the appropriate
sign and the exponent is plus infinity.  For NaN, both the mantissa and the
exponent is NaN.  For a non-zero, finite $x, see the appropriate method below.

Regardless of the operand $x and the method, the returned mantissa $mant and
the exponent $expo give the value of $x with

  $x = $mant * 10 ** $expo;

=item Context

In list context the mantissa and exponent is returned.  In scalar context the
mantissa is returned.  In void context a warning is given, since there is no
point in using any of the methods in this case.

=item Classes

The mantissa is always a Math::BigFloat object, and the exponent is always a
Math::BigInt object.

=back

=head2 Behaviour specific for each method

=over 4

=item fparts

For a non-zero, finite $x the mantissa $mant always satisfies 1 E<lt>= $mant
E<lt> 10 and the exponent is an integer.

=cut

sub fparts {
    my $self    = shift;
    my $selfref = ref $self;
    my $class   = $selfref || $self;
    my $name    = 'fparts';

    croak "$name() is an instance/object method, not a class method"
      unless $selfref;

    carp "Useless use of $name in void context"
      unless defined wantarray;

    # Check number of arguments.

    #croak "$name(): Not enough input arguments" if @_ < 0;
    croak "$name(): Too many input arguments"   if @_ > 0;

    # Not-a-number.

    if ($self->is_nan()) {
        my $mant = Math::BigFloat->bnan();
        return $mant unless wantarray;                  # scalar context
        my $expo = Math::BigInt->bnan();
        return ($mant, $expo);                          # list context
    }

    # Infinity.
    #
    # Work around Math::BigInt inconsistency.  The sign() method returns '-'
    # and '+' for negative and non-negative numbers, but '-inf' and '+inf' for
    # negative and positive infinity.  Why not '-' and '+' for +/- inf too?

    if ($self->is_inf()) {
        my $signstr = $self < 0 ? '-' : '+';
        my $mant = Math::BigFloat->binf($signstr);
        return $mant unless wantarray;                  # scalar context
        my $expo = Math::BigInt->binf('+');
        return ($mant, $expo);                          # list context
    }

    # Finite number.
    #
    # Get the mantissa and exponent.  The documentation says that one should
    # not assume that the mantissa is an integer.  The code below works also if
    # the mantissa is a Math::BigFloat non-integer.

    my ($mant, $expo) = $self->parts();
    $expo = $expo->bzero() unless $mant->bcmp(0);
    my ($ndig, $fraclen) = $mant->length();
    my $k = $ndig - $fraclen - 1;
    my $c = Math::BigFloat->bpow(10, -$k);
    my $fmant = Math::BigFloat->new($mant)->copy()->bmul($c);

    # Scalar context.  Return the mantissa only.

    return $fmant unless wantarray;

    # List context.

    my $fexpo = $expo->copy()->badd($k);
    return ($fmant, $fexpo);
}

=pod

=item eparts

For a non-zero, finite $x the mantissa $mant always satisfies 1 E<lt>= $mant
E<lt> 1000 and the exponent is an integer which is a multiple of 3.

=cut

sub eparts {
    my $self    = shift;
    my $selfref = ref $self;
    my $class   = $selfref || $self;
    my $name    = 'eparts';

    croak "$name() is an instance/object method, not a class method"
      unless $selfref;

    carp "Useless use of $name in void context"
      unless defined wantarray;

    # Check number of arguments.

    #croak "$name(): Not enough input arguments" if @_ < 0;
    croak "$name(): Too many input arguments"   if @_ > 0;

    # Not-a-number and Infinity.

    if ($self->is_nan() || $self->is_inf()) {
        return $self->fparts();
    }

    # Finite number.

    my ($fmant, $fexpo) = $self->fparts();

    my $c = $fexpo->copy()->bmod(3);
    my $eexpo = $fexpo - $c;

    #my $emant = $fmant * 10 ** $c;
    my $emant = Math::BigFloat->new(10)->bpow($c)->bmul($fmant);

    # Scalar context.  Return the mantissa only.

    return $emant unless wantarray;

    # List context.

    return ($emant, $eexpo);
}

=pod

=back

=head1 BUGS

None known.

=head1 SEE ALSO

The documentation for Math::BigInt and Math::BigFloat.

=head1 AUTHOR

Peter J. Acklam E<lt>pjacklam@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2006 by Peter J. Acklam.

This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut

1;

# Emacs Local Variables:
# Emacs mode: perl
# Emacs coding: iso-8859-1-unix
# Emacs fill-column: 79
# Emacs End:
