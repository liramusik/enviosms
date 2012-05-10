#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  prueba.pl
#
#        USAGE:  ./prueba.pl 
#
#  DESCRIPTION:  
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Walter Vargas (Wv), <walter@waltervargas.org>
#      COMPANY:  Covetel
#      VERSION:  1.0
#      CREATED:  23/05/08 00:01:13 VET
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;


my ($tty) = shift;
my ($municipio) = shift;
my ($tipo) = shift;
my ($mensaje) = shift;

if ( defined($tty) and  defined($municipio) and  defined($tipo) and  defined($mensaje) ){

} else {
	print "no entro";
}


