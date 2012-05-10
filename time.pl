#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  time.pl
#
#        USAGE:  ./time.pl 
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
#      CREATED:  25/05/08 10:55:59 VET
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use Time::HiRes qw( usleep);

my $microsegundos = 400_4480;
#usleep($microsegundos);
my $i = 1;
while ($i < 6) {
	print $i."\n";
	sleep(5);
	$i++;
}
