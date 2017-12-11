options ls=100 ps=61;
data fat;
  input triceps thigh midarm bodyfat;
  cards;
  19.5  43.1  29.1  11.9
  24.7  49.8  28.2  22.8
  30.7  51.9  37.0  18.7
  29.8  54.3  31.1  20.1
  19.1  42.2  30.9  12.9
  25.6  53.9  23.7  21.7
  31.4  58.5  27.6  27.1
  27.9  52.1  30.6  25.4
  22.1  49.9  23.2  21.3
  25.5  53.5  24.8  19.3
  31.1  56.6  30.0  25.4
  30.4  56.7  28.3  27.2
  18.7  46.5  23.0  11.7
  19.7  44.2  28.6  17.8
  14.6  42.7  21.3  12.8
  29.5  54.4  30.1  23.9
  27.7  55.3  25.7  22.6
  30.2  58.6  24.6  25.4
  22.7  48.2  27.1  14.8
  25.2  51.0  27.5  21.1
  20.0  50.0  20.0    .		
;
/* the last data line is for estimations/predictions 
   for covariate combinations of interest */
run;

ods graphics on;
title 'Correlation Analysis';
                
proc corr data=fat plots=matrix;
  var triceps midarm bodyfat;
run;

title 'Regression analysis of bodyfat on
 skinfold thickness and midarm circumference';
proc reg data=fat;
  model bodyfat = triceps midarm / 
    clb	  /*CI on beta*/
  	covb /* Var-cov matrix on beta */
	p clm cli /* Fitted values, CI and PI */;
  plot residual.*predicted.;  *Residual plot;
run;

/* include thigh as a predictor */
title 'With Thigh as a Predictor';
proc reg data=fat;
model bodyfat = triceps midarm thigh / vif;
plot residual.*predicted.;
run;

title ' ';
proc corr data=fat;
  var triceps midarm thigh bodyfat;
run;

/* run many models and compare them */
proc reg data=fat;
 model bodyfat = midarm;               * Model 1;
 model bodyfat = thigh;                * Model 2;
 model bodyfat = triceps;              * Model 3;
 model bodyfat = midarm triceps / vif; * Model 4;
 model bodyfat = midarm thigh / vif;   * Model 5;
 run;
ods graphics off;