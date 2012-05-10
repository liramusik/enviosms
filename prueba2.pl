#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  prueba2.pl
#
#        USAGE:  ./prueba2.pl 
#
#  DESCRIPTION:  i
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Walter Vargas (Wv), <walter@waltervargas.org>
#      COMPANY:  Covetel
#      VERSION:  1.0
#      CREATED:  28/05/08 04:10:46 VET
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

my $numArgs = $#ARGV + 1;
print "$numArgs command-line arguments.\n";

foreach my $argnum (0 .. $#ARGV) {
   print "@ARGV[$argnum]\n";
   }

