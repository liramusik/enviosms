#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  migrar.pl
#
#        USAGE:  ./migrar.pl 
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
#      CREATED:  25/05/08 15:46:54 VET
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use DBI; 

# Preparo la conexion a mysql 
my $database 	= "PSUV"; 
my $hostname 	= "localhost"; 
my $port 		= "3306"; 
my $user 		= "root"; 
my $passwd 		= "UpAnVovking0"; 

my $mydsn = "DBI:mysql:database=$database;host=$hostname;port=$port";
my $mydbh = DBI->connect($mydsn, $user, $passwd);


my $sth = $mydbh->prepare("SELECT cedula FROM tachira");
$sth->execute();
my $i = 1; 
while (my $row = $sth->fetchrow_hashref) {
	my $cedula 		= $row->{'cedula'}; 
	my $sql = "UPDATE tachira SET id_tachira = $i WHERE cedula = $cedula";
	print "$sql\n";
	$i++;
	$mydbh->do($sql);
}


