#!/usr/bin/perl

#Dillon Dall
#dillon.dall@und.edu
#1107601
#program 5
#This perl script is used to

use LWP::Simple;
use strict;

my ( $webpage, $currentPage, $currentsection, $info );

$currentPage = "https://www.iplocation.net/find-ip-address";

$webpage = get $currentPage;

$webpage =~ /<table class="iptable">(.*?)<\/table>/s;
$currentsection = $1;

#print $1;
