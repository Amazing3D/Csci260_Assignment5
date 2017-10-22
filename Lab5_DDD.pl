#!/usr/bin/perl

#Dillon Dall
#dillon.dall@und.edu
#1107601
#program 5
#This perl script is used to gather data from a variety of websites.

use LWP::Simple;
use strict;

my ( $webpage, $currentPage, $currentsection, $info, $selection, $name, $testvar );

#North Dakota wikipedia selection########################################################################################
print "North Dakota wikipedia section\n";
print "North Dakota wikipedia selection\nSelect an ranking: ";

$currentPage = "https://en.wikipedia.org/wiki/List_of_cities_in_North_Dakota";
$webpage     = get $currentPage;

$webpage =~ /<table class="wikitable sortable">(.*?)<\/table>/su; #get just the table containing all of the data we want about the cities
$currentsection = $1;
while ( !$selection ) {
    chomp( $selection = <STDIN> );                                #get the user input which represents the ranking of the city based off size
}

while ( $currentsection =~ /<\/span>$selection(\-\(T\))?<\/td>.*?North Dakota">(.*?)<\/a><\/td>.*?">(.*?)<\/td>/gs ) { #using the input ranking find the row containing that citys info. There can be ties so (\-\(T\))? looks to see fi the tie symbol is there "-(T)" but doesn't require it
    if ($1) {
        print "$selection-Tie : $2 : $3\n";
    }
    else {
        print "$selection : $2 : $3\n";
    }
    $testvar = 1;
}
if ( !$testvar && $selection > 1 ) {                                                                                   # If there is a tie the next one is missing so output the two tied values
    $selection--;
    while ( $currentsection =~ /<\/span>$selection(\-\(T\))?<\/td>.*?North Dakota">(.*?)<\/a><\/td>.*?">(.*?)<\/td>/gs ) {
        if ($1) {
            print "$selection-Tie : $2 : $3\n";
        }
        else {
            print "$selection : $2 : $3\n";
        }
    }
}

#Ip address and Host Name###############################################################################################
print "Ip Address Section\n";
print "Ip address and Host Name\n";
$currentPage = "https://www.iplocation.net/find-ip-address";

$webpage = get $currentPage;

$webpage =~ /<table class="iptable">(.*?)<\/table>/s; # Get the table section which is at the bottom of the page. This section contains all the info we want
$currentsection = $1;

$currentsection =~ /((\d{1,3}\.){3}\d{1,3})/;         #look for an ip ((1-3 digits with periods after) x 3 ) + (1-3 digits without a period after) ex: ??d.??d.??d.??d
print "Your IP is: $1\n";

$currentsection =~ /<th>Host Name<\/th><td>(.*)<\/td>/; #look in the hostname table row for the hostname info
print "Your Host Name is: $1\n";

#UND CS staff section################################################################################################
print "\nUND CS staff section\n";
$currentPage = "http://engineering.und.edu/computer-science/faculty-staff.cfm";

$webpage = get $currentPage;
$webpage =~ /Faculty and Staff(.*)Adjunct Faculty/gs;   #only look for the current staff members, not "Adjunct Faculty" or "staff"
$currentsection = $1;
#while ( $currentsection =~ /(?<!<!--)<div class="col three">(.*?)<\/ul>/gs ) { #Separate out into the section for each person not including those which are commented out (eg kerlin) who no longer work here
while ( $currentsection =~ /<div class="col three">(.*?)<\/ul>/gs ) {
    $selection = $1;                                    #The (?<!<!--) is a look behind. makes sure the selected one isn't html commented out

    $selection =~ /<h3>(.*?)<\/h3>/sg;                  #get the name in the <h3> section
    $name = "\n$1\n";
    $info = "";
    while ( $selection =~ /<li>(.*?)<\/li>/sg ) {       #get the list of special interests in the list section
        $info = $info . "\t$1\n";
    }
    print $name, $info;

}

#number of tweets section############################################################################################
print "\nUND number of tweets section\n";

$currentPage = "https://twitter.com/UofNorthDakota";
$webpage     = get $currentPage;

$webpage =~ /span class="ProfileNav-value"  data-count=(.*?) data/;
print "Number of tweets from the UND twitter: $1\n";

#Dow Jones Industrial Average Section##############################################################################
print "\nDow Jones Industrial Average Section\n";

$currentPage = "http://money.cnn.com/data/markets/dow/";
$webpage     = get $currentPage;

if ( $webpage =~ /<span stream="last_599362" streamFormat="ToHundredth" streamFeed="SunGard">(.*?)<\/span>/g ) {
    print "Dow Avg: $1\n";
}
if ( $webpage =~ /<span stream="change_599362" streamFeed="SunGard"><span class="posData">(.*?)<\/span>/g ) {
    print "Dow Change: $1\n";
}

#Current Grand Forks Temperature Section###########################################################################
print "\nCurrent Grand Forks Temperature Section\n";

$currentPage = "https://weather.com/weather/tenday/l/USND0146:1:US";
$webpage     = get $currentPage;

$webpage =~ /"temperature":(.*?),/s;
print "Current Temp: $1\n";

#NFL team record Section###########################################################################################
print "\nNFL team record Section\n";
$currentPage = "http://www.nfl.com/standings";

$webpage = get $currentPage;

$webpage =~ /summarizes the NFL standings(.*?)tfoot/s; # get the table where the team data is located
$currentsection = $1;

print "Enter a team city or name: ";

chomp( $name = <STDIN> );

$testvar = 0;

# while ( $currentsection =~ /<a href="\/teams\/profile\?team=\w\w\w">\n\t{6}(.{0,30})$name(.*?)<\/a>(.*?)<\/tr>/sgi ) {    # Testing other regex expressions
while ( $currentsection =~ /<a href="\/teams\/profile\?team=\w\w\w">\n\t{6}(.{0,30})$name(.*?)<\/a>(.*?)<\/tr>/sgi ) { #find the table row where the matching team(s) info is.
    $testvar = $3;
    $info    = $1 . $name . $2;                                                                                        #get all parts of the name of the team

    $info =~ s/\r?\n\s*|\r\s*//gs;                                                                                     #remove the newline and all the spaces before what was the </a>

    $info =~ s/\b(\w)(\w*)/\U$1\L$2/g;                                                                                 #capitalize the first letter of each word
    print "$info";

    $testvar =~ /<\/td>.*?<td>(.*?)<\/td>.*?<td>(.*?)<\/td>.*?<td>(.*?)<\/td>.*?<td class/s;                           #get the Wins Losses and Ties for the team

    print "\n\tWins:   $1\n\tLosses: $2\n\tTies:   $3\n";
}

if ( !$testvar ) {
    print "No team found";
}
