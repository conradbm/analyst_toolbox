options ls=78 ps=45 nodate nonumber;
data phstudy;
 input time ph @@;  * '@@' tells SAS to keep reading data on this line;
 datalines;
 1 7.02 1 6.93 2 6.42 2 6.51 4 6.07 4 5.98 6 5.59 6 5.80 8 5.51 8 5.36
 ;

 proc gplot data=phstudy;
  plot ph*time;
  run;

title1 'pH regressed on time';
 proc reg data=phstudy;
  model ph=time /p r;
  output out=newph predicted=pred residual=resid;
  run;
 proc gplot data=newph;
  plot ph * time    
       pred * time / overlay;
  plot resid * time;  
  run;


data transform;
 set phstudy;  * this reads in all the data from the 'phstudy' data set;
 logtime = log(time);  * log transform X and save it as a new variable;
 run;

 title1 'pH regressed on log(time)';
 proc reg data=transform;
  model ph=logtime /p r;
  output out=newph2 predicted=pred residual=resid;
  run;
 proc gplot data=newph2;
  plot ph * logtime    
       pred * logtime / overlay;
  plot resid * logtime;  
  run;

/* graph the results using time instead of logtime */
title 'Back-Transformed "Time"';
proc gplot data=newph2;
  plot ph *time
       pred * time / overlay;
  plot resid *time;
  run;

