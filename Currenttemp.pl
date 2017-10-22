#!/usr/bin/perl

#Dillon Dall
#dillon.dall@und.edu
#1107601
#program 5
#This perl script is used to

use LWP::Simple;
use strict;
use utf8;

my ( $webpage, $currentPage, $currentsection, $info, $selection, $name, $day );

#Ip address and Host Name
$currentPage = "https://weather.com/weather/tenday/l/USND0146:1:US";

$webpage = get $currentPage;
$webpage =~ /"temperature":(.*?),(.*)/s;
print "\nCurrent Temp: $1\n";
