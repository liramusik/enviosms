#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  serial.pl
#
#        USAGE:  ./serial.pl 
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
#      CREATED:  26/05/08 22:45:53 VET
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
require Device::SerialPort;
import 	Device::SerialPort;

my $PortObj = new Device::SerialPort("/dev/ttyACM1")  || die "Can’t open : $!\n";"";

$PortObj->baudrate(115200);
$PortObj->parity("none");
$PortObj->databits(8);
$PortObj->stopbits(1); 

$PortObj->debug(1);
my $r = $PortObj->write(qq{AT+MODE=2}."\r"); 
print &answer();
$PortObj->write(qq{AT+CMGF=1}."\r"); 
print &answer();
$PortObj->write(qq{AT+CMGS="04247131418"}."\r"); 
$PortObj->write(qq{SOY EL COMANDANTE ARIAS CARDENAS NECESITO TU VOTO PARA HACER DEL TACHIRA LA FUERZA DE VENEZUELA}.chr(26)); 
print &answer();
print &answer();
sleep(10);
print &answer();

print $PortObj->input;

sub answer(){
	my $STALL_DEFAULT=10; # how many seconds to wait for new input
	my $timeout=$STALL_DEFAULT;
	$PortObj->read_char_time(0);     # don’t wait for each character
	$PortObj->read_const_time(100); # 1 second per unfulfilled "read" call
	my $chars=0;
	my $buffer="";
	while ($timeout>0){
	   my ($count,$saw)=$PortObj->read(255); # will read _up to_ 255 chars
	   if ($count > 0) {
			   $chars+=$count;
			   $buffer.=$saw;
	   }
	   else {
			   $timeout--;
	   }
	}
	return $buffer;
}
