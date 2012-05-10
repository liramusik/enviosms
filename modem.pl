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
use DBI;
use Device::Gsm::Pdu;

# Preparo la conexion a mysql 
my $database 	= "PSUV"; 
my $hostname 	= "localhost"; 
my $port 		= "3306"; 
my $user 		= "root"; 
my $passwd 		= "UpAnVovking0"; 

my $mydsn 		= "DBI:mysql:database=$database;host=$hostname;port=$port";
my $mydbh 		= DBI->connect($mydsn, $user, $passwd);

my $tty 		= shift;
my $municipio 	= shift;
my $tipo 		= shift;
my $mensaje 	= shift;
my $codigo 		= shift;


my ($sql,$modem) = '';

if ($tipo eq 'm') {
		$sql = "SELECT telefono FROM tachira WHERE id_municipio = $municipio AND telefono like \"$codigo%\""; 
		print $sql;
} elsif ($tipo eq 'c') {
		$sql = "SELECT telefono FROM tachira WHERE cedula = 16409503"; 
		print $sql;
} 
	
if ($modem = new Device::Modem(log => 'File', port => $tty)){
	if( $modem->connect(baudrate => 115200) ) {
		my $sth = $mydbh->prepare($sql);
		$sth->execute();
		while(my $r = $sth->fetchrow_hashref()){ 
			my $telefono = $r->{'telefono'};   
			&enviar($telefono,&get_mensaje($mensaje),$mensaje,$municipio);
			sleep(6);
		}
	} else {
		print "sorry, no connection with serial port!\n";
	}
}

sub enviar(){
	my ($numero,$msg,$id_msj,$municipio) = @_; 
	$modem->echo(1);  
	$modem->verbose(1); 
	$modem->attention();
	$modem->send_init_string();
	$modem->atsend('AT+MODE=2'.Device::Modem::CR);
	print $modem->answer()."\n";
	$modem->atsend('AT+CMGF=1'.Device::Modem::CR);
	print $modem->answer()."\n";
	$modem->atsend("AT+CMGS=\"$numero\"".Device::Modem::CR);
	print $modem->answer()."\n";
	$modem->atsend("$msg");
	$modem->atsend(Device::Modem::CTRL_Z);
	$modem->atsend(Device::Modem::CTRL_Z);
	print $modem->parse_answer()."\n";
	my $sql = "INSERT INTO msj_enviados VALUES($id_msj,$numero,NOW(),NULL,$municipio)";
	$mydbh->do($sql);
}

sub get_mensaje(){
	my($id) = @_;
	my $sql = "SELECT mensaje FROM mensajes WHERE id_mensaje = $id";
	my $sth = $mydbh->prepare($sql);
	$sth->execute();
	my $r = $sth->fetchrow_hashref();
	return $r->{'mensaje'};
}
