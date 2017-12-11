options ls=80;
/*  We will use @@ on the input statement to tell 
    SAS to continue reading data on the same line  */
data caffeine;
input dose taps @@;  
datalines;
  0 242   0 245   0 244   0 248   0 247
  0 248   0 242   0 244   0 246   0 242
100 248 100 246 100 245 100 247 100 248 
100 250 100 247 100 246 100 243 100 244
200 246 200 248 200 250 200 252 200 248 
200 250 200 246 200 248 200 245 200 250
;

proc print data=caffeine; run;

title 'GLM';
proc glm data=caffeine plots=diagnostics;
  class dose (ref='0');  
  model taps = dose / solution ;
  lsmeans dose / stderr cl;
  means dose / hovtest=bf; /* Brown-Forsythe test */
  run;

quit;



