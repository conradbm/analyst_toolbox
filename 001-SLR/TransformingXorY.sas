options ls=78 ps=60 nodate nonumber;
data corrosion;
 input napo4 corrode @@;
 datalines;
  2.5 7.68     5.03 6.95     7.6 6.3     11.6 5.75    13 5.01    19.6 1.43
 26.2 0.93    33.0  0.72    40   0.68    50   0.65    55 0.56
 ;

 title 'Corrosion Data';
 proc gplot data=corrosion;
 plot corrode * napo4;
 run;

* create a new data set that contains the transformed variables;
 data transform;
  set corrosion;
  log_napo4 = log(napo4);
  log_corrode = log(corrode);
  inv_napo4 = 1/napo4;
  inv_corrode = 1/corrode;
  run;

* run a bunch of models;
  proc reg data=transform;
  model corrode = napo4;         * Model 1: original variables;
  output out=new predicted=pred residual=resid;
  model log_corrode = napo4;     * Model 2: log Y;
  model inv_corrode = napo4;     * Model 3: 1/Y;
  model corrode = inv_napo4;     * Model 4: 1/X;
  model corrode = log_napo4;     * Model 5: log X;
  model log_corrode = log_napo4; * Model 6: log Y and log X;
  model inv_corrode = inv_napo4; * Model 7: 1/Y and 1/X;
  run;


  /* Take a closer look at Model 3  */
  proc reg data=transform;
  model inv_corrode = napo4 / p clm;
  output out=model3 predicted=inv_pred residual=resid u95m=uclm  l95m=lclm;
  run;

  proc gplot data=model3;
   plot resid*napo4;
   plot inv_pred * napo4
        inv_corrode * napo4 / overlay;
   run;


/* The predicted values (Y hat) and the confidence limits from Model 3
   are really estimating 1/Y.  We reverse-transform these estimates to
   put them back on the original scale.   */

data orig_scale;
 set model3;
 corrode_hat = 1/inv_pred;      * reciprocal of predicted values;
 upper_hat = 1/uclm;            * reciprocal of upper confidence limit;
 lower_hat = 1/lclm;            * reciprocal of lower confidence limit;
 diff = corrode - corrode_hat;  * 'true' residuals;
 diffsq = diff**2;

proc print data=orig_scale;
 var napo4 corrode inv_corrode inv_pred corrode_hat lower_hat upper_hat diff diffsq;
 run;

proc gplot data=orig_scale;
 plot corrode * napo4
      corrode_hat * napo4 /overlay;
 run;