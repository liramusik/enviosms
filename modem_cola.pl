#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  modem.pl
#
#        USAGE:  ./modem.pl 
#
#  DESCRIPTION:  
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Walter Vargas (Wv), <walter@covetel.com.ve>
#      COMPANY:  COOPERATIVA VENEZOLANA DE TECNOLOGIAS LIBRES. 
#      VERSION:  1.0
#      CREATED:  24/05/08 23:27:45 VET
#     REVISION:  ---
#===============================================================================
use strict;
use Device::Modem;
use Time::HiRes qw( usleep);
use Device::Gsm::Pdu;
use DBI;

# Preparo la conexion a mysql 
my $database    = "cne"; 
my $hostname    = "localhost"; 
my $port        = "3306"; 
my $user        = "psuv"; 
my $passwd      = "otIjSod4"; 

my $mydsn       = "DBI:mysql:database=$database;host=$hostname;port=$port";
my $mydbh       = DBI->connect($mydsn, $user, $passwd);

my $tty         = shift;

my $modem 		= ''; 

my $sql 		= "SELECT m.mensaje, c.numero, c.id_cola FROM msj_cola c INNER JOIN mensajes m ON m.id_mensaje = c.id_mensaje LIMIT 1"; 
#my $sql 		= "SELECT m.mensaje, c.numero, c.id_cola FROM msj_cola c INNER JOIN mensajes m ON m.id_mensaje = c.id_mensaje WHERE c.cedula = 16612574 LIMIT 1"; 

if ($modem = new Device::Modem(port => $tty)){
    if( $modem->connect(baudrate => 115200) ) { 
		$modem->verbose(1);
		$modem->echo(1);
		$modem->atsend('AT+MODE=2'.Device::Modem::CR);
		$modem->atsend('AT+CMGF=1'.Device::Modem::CR);
		print "Conecto\n";
		my $i = 1;
		while ($i > 0) {
			my ($play) = $mydbh->selectrow_array("SELECT value from control WHERE param = \"envio\" ");
			if ($play != 1){
				print "Envio Detenido por el administrador";
				$i--;
			}
			my ($mensaje,$numero,$id_cola) = $mydbh->selectrow_array($sql);
			print $mensaje;
			if ($id_cola > 0) {
				print $numero."\n";
				$mydbh->do("DELETE FROM msj_cola WHERE id_cola = $id_cola");
				if ($i >= 1){
					&enviar($numero,$mensaje);
				}
			} else {
				print "Se termino La cola \n";
				$i--;
			}
		}
    } else {
        print "sorry, no connection with serial port!\n";
    }   
}

sub enviar(){
    my ($numero,$msg) = @_; 
	$modem->atsend( "AT+CMGS=\"$numero\"" . Device::Modem::CR );
	print $modem->answer();
	$modem->atsend("$msg" . Device::Modem::CTRL_Z);
	print "Enviando $tty \n";
	sleep(8);
	print $modem->answer();
}

sub leer( ) {
	my ($patron) = @_;
	my $i = 1;
	my $answ = '';
	while ($i > 0){
	print "WHILE\n";
		if ($answ = $modem->answer()){
			print $answ."\n";
			if ($answ eq $patron){
				$i--;	
			}
			else {
				print "Nanani";
			}
		}
	}
	return $answ;
}
