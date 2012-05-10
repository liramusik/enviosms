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
my $passwd 		= "142x2947"; 

my $mydsn = "DBI:mysql:database=$database;host=$hostname;port=$port";
my $mydbh = DBI->connect($mydsn, $user, $passwd);


my $dbh = DBI->connect("DBI:CSV:");
    $dbh->{'csv_tables'}->{'tachira'} = {
        'eol' => "\n",
        'sep_char' => ",",
        'quote_char' => "\"",
        'escape_char' => undef,
        'file' => '/home/elsanto/tachira.csv',
        'col_names' => ["estado", "municipio", "parroquia", "nacionalidad", "cedula",
                        "nombres", "apellidos","telefono"]
    };
    my $sth = $dbh->prepare("SELECT * FROM tachira");
	$sth->execute();
	while (my $row = $sth->fetchrow_hashref) {
		my $estado 		= $row->{'estado'}; 
		my $municipio 	= $row->{'municipio'}; 
		my $parroquia 	= $row->{'parroquia'}; 
		my $nacionalidad 	= $row->{'nacionalidad'}; 
		my $cedula 		= $row->{'cedula'}; 
		my $nombres 	= $row->{'nombres'}; 
		my $apellidos 	= $row->{'apellidos'}; 
		my $telefono 	= $row->{'telefono'}; 

		my $sql = "INSERT INTO tachira VALUES(\"$estado\",\"$municipio\",\"$parroquia\",\"$nacionalidad\",$cedula,\"$nombres\",\"$apellidos\",\"$telefono\")";
		print "$sql\n";

		$mydbh->do($sql);
    }


