DATA example;
INPUT traffic lead;
DATALINES;
 8.1  227
 8.3  312
12.1  362
13.2  521
16.5  640
17.5  539
19.2  728
24.8  945
24.1  738
26.1  759
33.6 1263
22     .
;

PROC PRINT data=example; run;

/* Create a scatterplot of the (x,y) pairs
   to determine if a linear model is reasonable
*/
PROC SGPLOT DATA=example;
  SCATTER x=traffic y=lead;
  RUN;

/* Generate the fitted regression line and
   and diagnostic plots. 
   Calculate and print these values:
     P = predicted values (a.k.a fitted values, expected values)
     CLM = confidence limits for the mean (confidence intervals)
     CLI = confidence limits for individual values (prediction intervals)
 */
PROC REG DATA=example PLOTS=DIAGNOSTICS;
 MODEL lead=traffic / P CLM CLI;
 RUN;

QUIT;
