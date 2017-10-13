# CSci 260 Perl Program 5
## Due 10/21/17
## Objective
- Work with regular expressions
- Work with accessing HTML source code
## Assignment
Using LWP::Simple and regular expressions, find and display the following information
to the screen. Make sure all output has appropriate labels and is clearly readable. Do
not display any “extra” information, such as HTML code. For the two parts that request
user input, don’t worry about error checking unless it is specifically addressed in the
request.
## Specifics
1. The site https://en.wikipedia.org/wiki/List_of_cities_in_North_Dakota lists the cities in
North Dakota by population. Ask for a position and then display the city in that position
and its estimated 2015 population
2. The IP number of your machine and host name of the machine.
The information can be found at https://www.iplocation.net/find-ip-address
3. The faculty in the CS department and their research interests. Indent the research
interests of each faculty member. The output for each faculty member could look
something like:
```
Tom Stokke
  Computer Science Education
  Robotics
  Android Programming
```
The information can be found at
http://engineering.und.edu/computer-science/faculty-staff.cfm
4. Number of tweets from the official UND Twitter account.
The information can be found at https://twitter.com/UofNorthDakota
5. Today’s Dow Jones Industrial Average and today’s numeric change (not percent).
The information can be found at http://money.cnn.com/data/markets/dow/
6. The current temperature in Grand Forks. The information can be found at
https://weather.com/weather/tenday/l/USND0146:1:US
7. Ask the user for a team name. The team name will not have to be an exact match.
Display every NFL football team that matches the entered text (city OR team name).
The match does not have to be case-specific. Display the team name, their wins, losses
and ties. Display an error message if the entered text does not match any team names.
Don’t loop, just ask a single question and display the output.
The information can be found at http://www.nfl.com/standings
## Requirements
- use strict
- Complete comment section that includes your name, id number, email address,
program number and a brief description of the program.
## Questions?
Ask. Sooner rather than later.
