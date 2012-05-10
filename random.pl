#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  random.pl
#
#        USAGE:  ./random.pl 
#
#  DESCRIPTION: Genera numeros aleatorios  
#
#      OPTIONS:  rango
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Walter Vargas (Wv), <walter@waltervargas.org>
#      COMPANY:  Covetel
#      VERSION:  1.0
#      CREATED:  21/05/08 17:33:32 VET
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

my $rango = shift; 
if($rango){
	print int(rand($rango))."\n";
} else {
	print "Debe especificar un rango numerico \n";
}

