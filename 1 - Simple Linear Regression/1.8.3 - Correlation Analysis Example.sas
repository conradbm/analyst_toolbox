options ls=78 nodate nonumber;

data example;
 input one two;
 title 'Two Judges';
 datalines;
 2 3
 6 5
 3 4
 4 8
 8 10
 ;

proc corr data=example;
run;
title 'Spearman Correlation';
proc corr data=example spearman;
run;



data panels;
 input judge project rating @@;
 project_jittered = project + (judge -3)/10;  
    * to jitter the points, so they don't overlap on the graph;
 datalines;
 1 1 5.0  1 2 4.0  1 3 4.4  1 4 5.0  1 5 5.2  1 6 6.2
 2 1 3.2  2 2 3.6  2 3 4.2  2 4 6.0  2 5 6.4  2 6 8.0
 3 1 4.0  3 2 5.6  3 3 5.8  3 4 6.2  3 5 6.8  3 6 7.4
 4 1 5.4  4 2 5.4  4 3 5.8  4 4 6.2  4 5 7.0  4 6 7.4
 5 1 3.8  5 2 5.8  5 3 6.4  5 4 6.0  5 5 7.2  5 6 7.6
 ; 

proc sgplot data=panels;
 scatter x=project_jittered y=rating /group=judge;
 run;
 

proc sgplot data=panels;
 series x=project_jittered y=rating /group=judge;
 run;

data pairwise;
input project judge1 judge2 judge3 judge4 judge5;
datalines;
1 5.0 3.2 4.0 5.4 3.8
2 4.0 3.6 5.6 5.4 5.8
3 4.4 4.2 5.8 5.8 6.4
4 5.0 6.0 6.2 6.2 6.0
5 5.2 6.4 6.8 7.0 7.2
6 6.2 8.0 7.4 7.4 7.6
;

proc corr data=pairwise pearson spearman;
 var judge1 -- judge5;
 run;

quit;