#!/usr/bin/perl

#Dillon Dall
#dillon.dall@und.edu
#1107601
#program 5
#This perl script is used to

use LWP::Simple;
use strict;
use utf8;

my ( $webpage, $currentPage, $currentsection, $info, $selection, $name );

#Ip address and Host Name
$currentPage = "http://engineering.und.edu/computer-science/faculty-staff.cfm";

$webpage = get $currentPage;
$webpage =~ /Faculty and Staff(.*)Adjunct Faculty/gs;    #only look for the current staff members, not "Adjunct Faculty" or "staff"
$currentsection = $1;
while ( $currentsection =~ /(?<!<!--)<div class="col three">(.*?)<\/ul>/gs ) {    #Separate out into the section for each person not including those which are commented out (eg kerlin) who no longer work here
    $selection = $1;                                                              #The (?<!<!--) is a look behind. makes sure the selected one isn't html commented out
    $selection =~ /<h3>(.*?)<\/h3>/sg;                                            #get the name in the <h3> section
    $name = "$1\n";
    $info = "";
    while ( $selection =~ /<li>(.*?)<\/li>/sg ) {                                 #get the list of special interests in the list section
        $info = $info . "\t$1\n";
    }
    print $name, $info;

}
