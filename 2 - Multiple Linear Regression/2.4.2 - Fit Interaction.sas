data fake;
input x1 x2 y @@;  * '@@' allows us to put more than one record on a line;
x1sq = x1**2;       * square of x1;
x2sq = x2**2;       * square of x2;
interact = x1*x2;  * interaction;
datalines;
1.8 3.8 219.3   1.4 7.4 204.3   8.9 6.5 113.5   1.8 5.6 206.7   1.9 2.7 214.4
4.3 8.2 149.6   3.6 3.0 204.5   4.3 6.1 179.0   4.6 3.9 201.9   8.3 2.2 188.5
1.7 5.0 213.7   3.3 3.7 210.5   9.2 6.0 125.3   1.3 7.0 202.6   6.2 5.2 174.3
3.4 1.9 211.4   9.0 8.4  81.2   9.0 4.0 166.2   8.7 3.8 175.1   5.4 5.7 177.6
8.0 3.8 172.1   2.5 2.5 212.2   8.0 3.8 170.1   3.6 9.3 147.0   2.6 9.5 158.1
7.2 4.1 176.3   1.7 9.6 177.1   4.0 1.5 207.4   4.4 3.2 200.5   8.9 6.9 106.9
9.8 8.6  53.2   3.7 3.1 205.2   2.3 3.2 214.5   9.3 6.6 111.4   4.4 1.6 214.1
6.2 7.0 147.7   9.9 5.4 131.5   3.7 6.2 190.9   9.5 9.6  30.6   2.9 2.0 215.5
7.0 4.2 179.7   1.1 5.7 217.9   6.0 5.7 158.7   6.2 6.1 161.2   7.4 3.8 176.6
8.6 8.6  74.5   3.9 5.5 187.1   8.0 2.4 190.0   8.7 6.2 127.8   8.1 5.1 152.7
;
run;

proc reg data=fake plots=residuals;
 'main effects': model y = x1 x2;
 run;

 title 'With interaction and squares';
 proc reg data=fake;
 model y= x1 x2 x1sq x2sq interact;
 run;

 title 'Fake Data: Full Model';
 proc reg data=fake;
 'Full': model y= x1 x2 x1sq x2sq;
 'Reduced': model y = x2 x2sq;
 run;

quit;
