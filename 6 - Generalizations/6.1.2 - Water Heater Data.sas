data heaters;
input Eff Cap $ Flo $ Exp $;
datalines;
41.6 120 high 6
41.3 120 high 6
39.9 120 high 4 
39.7 120 high 4 
51.9 120 low  6
52.4 120 low  6
43.0 120 low  4
44.9 120 low  4
39.2  80 high 6
38.4  80 high 6
37.5  80 high 4 
35.0  80 high 4 
50.2  80 low  6
51.3  80 low  6
41.3  80 low  4 
43.5  80 low  4 
;

proc glm data=heaters;
class Cap Flo Exp;
model Eff = Cap Flo Exp Cap*Flo Cap*Exp Flo*Exp Cap*Flo*Exp / ss3;
lsmeans Cap Flo Exp Cap*Flo Cap*Exp Flo*Exp Cap*Flo*Exp / stderr pdiff;
run;

 /* the model and lsmeans statements can be 
    abbreviated and achieve the same results
 */
proc glm data=heaters;
 class Cap Flo Exp;
 model Eff = Cap | Flo | Exp / ss3;
 lsmeans Cap | Flo | Exp / stderr pdiff;
 run;
 

 
 
quit;
