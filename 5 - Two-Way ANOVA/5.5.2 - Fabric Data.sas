options linesize=76 nodate;
data fabric;
input Level Salt $ Temperature;
datalines;
1 CaCO3      733
1 CaCO3      728
1 CaCO3      720
1 CaCl2      725
1 CaCl2      727
1 CaCl2      719
1 Untreated  812
1 Untreated  827
1 Untreated  876
2 CaCO3      786
2 CaCO3      771
2 CaCO3      779
2 CaCl2      756
2 CaCl2      781
2 CaCl2      814
2 Untreated  945
2 Untreated  881
2 Untreated  919
;

proc print data=fabric; run;

proc sort data=fabric;
 by Level Salt;
 run;

proc means data=fabric noprint;
 by Level Salt;
 var Temperature;
 output out=means mean=mean;
 run;

proc print data=means; run;

proc sgplot data=means;
 series x=Salt y=mean / group=Level markers;
 run;

title 'Interaction Model: Fabric Data';
proc glm data=fabric;
 class level salt;
 model temperature = level | salt /ss3;
 lsmeans Level Salt Level*Salt / stderr cl pdiff;
 contrast 'ContrastName' level 2 -2 level*salt 1 1 0 -1 -1 0; 
 run;

quit;
