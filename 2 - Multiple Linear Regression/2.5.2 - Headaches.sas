data headaches;
input Subject Drug $ Severity Time;
datalines;           
1  acetaminophen        2 15.4
2  acetaminophen        3  8.4
3  acetaminophen        6 20.7
4  acetaminophen       10 17.7
5  acetaminophen        3 12.6
6  acetaminophen        5 10.9
7  acetaminophen        3 14.5
8  acetaminophen        7 21.5
9  acetaminophen        5 15.9
10 acetaminophen        2  4.7
11 acetaminophen        4 17.0
12 acetaminophen        5 21.3
13 acetaminophen        9 19.0
14 acetaminophen        4 16.1
15 acetaminophen        7 19.5
16 acetaminophen       10 21.2
17 acetaminophen        7 24.8
18 acetaminophen        7 22.1
19 acetaminophen        3 16.1
20 acetaminophen       10 24.0
21 acetaminophen        9 27.2
22 acetaminophen        6 14.8
23 acetaminophen        1 18.8
24 acetaminophen        5 20.9
25 acetaminophen        7 25.9
26     ibuprofen        3 15.5
27     ibuprofen        3  9.0
28     ibuprofen        9 33.1
29     ibuprofen        2 19.0
30     ibuprofen        1  6.5
31     ibuprofen        2 16.9
32     ibuprofen        7 29.9
33     ibuprofen        7 26.5
34     ibuprofen        8 26.7
35     ibuprofen        5  8.8
36     ibuprofen        6 23.0
37     ibuprofen        2 18.4
38     ibuprofen        5 25.1
39     ibuprofen       10 30.4
40     ibuprofen        6 34.4
41     ibuprofen        9 32.4
42     ibuprofen        3 20.8
43     ibuprofen        2 10.1
44     ibuprofen        4 26.8
45     ibuprofen        3 11.7
46     ibuprofen        5 16.6
47     ibuprofen        7 18.9
48     ibuprofen        2 12.9
49     ibuprofen        6 28.5
50     ibuprofen        3 16.8
;

/*make sure the data is read correctly */
proc print data=headaches;run; 

title 'Additive Model';
proc glm data = headaches plots=all;
 class Drug;
 model Time = Drug Severity / solution;
 run;

title 'Interaction Model';
proc glm data = headaches plots=all;
 class Drug;
 model Time = Drug Severity Drug*Severity / solution;
 run;
