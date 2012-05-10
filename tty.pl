#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  tty.pl
#
#        USAGE:  ./tty.pl 
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
#      CREATED:  24/05/08 22:15:24 VET
#     REVISION:  ---
#===============================================================================

use warnings;

sysopen(TTYIN,"/dev/ttyACM0",O_NDELAY) or die "No puedo abrir el puerto";
open(TTYOUT,"+>TTYIN"  ) or die "No puedo escribir en el puerto"; 

my $ofh = select(TTYOUT); $| = 1; select($ofh);

print TTYOUT "AT+MODE=2\015";
my $respuesta = <TTYIN>; 
print $respuesta;


