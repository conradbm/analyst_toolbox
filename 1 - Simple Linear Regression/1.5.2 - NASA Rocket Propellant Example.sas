********************************************
** STAT 705,    Spring 2014
** SAS Code:    Simple Linear Regression
** Author:      Nora Bello
** Adapted by:  Karen Keating
** Data Source: Montgomery, et.al., 2006
********************************************;
DATA nasa;
  INPUT Obs ShearStrength Age ;
  DATALINES;
1   2158.7   15.5
2   1678.15  23.75
3   2316      8	
4   2061.3   17	
5   2207.5    5.5	
6   1708.3   19	
7   1784.7   24	
8   2575      2.5	
9   2357.9    7.5	
10  2256.7   11	
11  2165.2   13	
12  2399.55   3.75
13  1779.8   25	
14  2336.75   9.75
15  1765.3   22	
16  2053.5   18	
17  2414.4    6	
18  2200.5   12.5
19  2654.2    2
20  1753.7   21.5
21    .      10 
;
run;

title 'NASA Data';
/* Always print the data to make sure it was read correctly */
PROC PRINT DATA=nasa; 
RUN;

/* Get some summary statistics on the variables */
PROC MEANS DATA=nasa N SUM MEAN STD MIN MAX;
  VAR ShearStrength Age;	
  RUN;

/* Scatterplot of the data */
PROC SGPLOT DATA=nasa;
 SCATTER X=Age Y=ShearStrength;
 RUN;

/* Fit a linear regression model and calculate
     P = predicted values
     CLM = confidence intervals for the mean
     CLB = confidence intervals for the regression coefficients
     CLI = prediction intervals for individual observations
*/
PROC REG DATA=nasa;
  MODEL ShearStrength = Age / P CLM CLB CLI alpha=0.05;	 
  RUN;
QUIT;  

