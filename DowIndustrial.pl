#!/usr/bin/perl

#Dillon Dall
#dillon.dall@und.edu
#1107601
#program 5
#This perl script is used to

use LWP::Simple;
use strict;

my ( $webpage, $currentPage, $currentsection, $info, $selection, $name );

#Ip address and Host Name
$currentPage = "http://money.cnn.com/data/markets/dow/";

$webpage = get $currentPage;

if ( $webpage =~ /<span stream="last_599362" streamFormat="ToHundredth" streamFeed="SunGard">(.*?)<\/span>/g ) {
    print "Dow Avg: $1\n";
}
if ( $webpage =~ /<span stream="change_599362" streamFeed="SunGard"><span class="posData">(.*?)<\/span>/g ) {
    print "Dow Change: $1\n";
}
