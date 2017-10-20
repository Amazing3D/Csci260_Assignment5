#!/usr/bin/perl

#Dillon Dall
#dillon.dall@und.edu
#1107601
#program 5
#This perl script is used to

use LWP::Simple;
use strict;
use utf8;

my ( $webpage, $currentPage, $currentsection, $info, $selection, $name, $testvar );

#Ip address and Host Name
$currentPage = "http://www.nfl.com/standings";

$webpage = get $currentPage;

$webpage =~ /summarizes the NFL standings(.*?)tfoot/s;
$currentsection = $1;

print "\nEnter a team city or name: ";
chomp( $name = <STDIN> );

# while ( $currentsection =~ /<a href="\/teams\/profile\?team=\w\w\w">\n\t{6}(.{0,30})$name(.*?)<\/a>(.*?)<\/tr>/sgi ) {    #find the table row where the team is.
while ( $currentsection =~ /<a href="\/teams\/profile\?team=\w\w\w">\n\t{6}(.{0,30})$name(.*?)<\/a>(.*?)<\/tr>/sgi ) { #find the table row where the team is.
    $testvar = $3;
    $info    = $1 . $name . $2;                                                                                        #get all parts of the name of the team

    $info =~ s/\r?\n\s*|\r\s*//gs;                                                                                     #remove the newline and all the spaces before what was the </a>

    $info =~ s/\b(\w)(\w*)/\U$1\L$2/g;                                                                                 #capitalize the first letter of each word
    print "$info";

    $testvar =~ /<\/td>.*?<td>(.*?)<\/td>.*?<td>(.*?)<\/td>.*?<td>(.*?)<\/td>.*?<td class/s;

    print "\n\tWins:   $1\n\tLosses: $2\n\tTies:   $3\n";
}
