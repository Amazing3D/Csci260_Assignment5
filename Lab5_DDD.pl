#!/usr/bin/perl

#Dillon Dall
#dillon.dall@und.edu
#1107601
#program 5
#This perl script is used to

use LWP::Simple;
use strict;
use utf8;

my ( $webpage, $currentPage, $currentsection, $info, $selection );

#Ip address and Host Name
print "\nIp address and Host Name\n";
$currentPage = "https://www.iplocation.net/find-ip-address";

$webpage = get $currentPage;

$webpage =~ /<table class="iptable">(.*?)<\/table>/s;
$currentsection = $1;

$currentsection =~ /((\d{1,3}\.){3}\d{1,3})/;
print "Your IP is: $1\n";

$currentsection =~ /<th>Host Name<\/th><td>(.*)<\/td>/;
print "Your Host Name is: $1\n";

print "\n\n";

#North Dakota wikipedia selection
print "North Dakota wikipedia selection\nSelect an ranking: ";
$currentPage = "https://en.wikipedia.org/wiki/List_of_cities_in_North_Dakota";
$webpage     = get $currentPage;

$webpage =~ /<table class="wikitable sortable">(.*?)<\/table>/su;
$currentsection = $1;
chomp( $selection = <STDIN> );
while ( $currentsection =~ /<\/span>$selection(\-\(T\))?<\/td>.*?North Dakota">(.*?)<\/a><\/td>.*?">(.*?)<\/td>/gs ) {
    if ($1) {
        print "$selection-Tie : $2 : $3\n";
    }
    else {
        print "$selection : $2 : $3\n";
    }
}
