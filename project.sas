/*project*/

/*proc import data in*/
proc import out=a
 datafile="I:\project\azalea.csv"
 dbms=csv;
run;

/*get the dummy variable for rooted*/
data a1;
 set a;
 if rooted='y' then root=1; else root=0;
run;

/*only keep concentration cultivar and root variable*/
data a2;
 set a1;
 keep conc cultivar root;
run;

/*keep "yes" in root variable*/
data a3;
 set a2;
 if root='0' then delete;
run;

/*frequency table*/
proc freq data=a2;
 table root*cultivar/nopercent nocol;
run;

proc freq data=a2;
 table root*conc/nopercent nocol;
run;


/*histogram for conc vs root*/
proc univariate Noprint data=a3;
 histogram conc;
 class root;
run;

/*redo the data-concentration*/
data aa;
  input Concentration Rooted;
  cards;
2500 59
3750 60
5000 58
6250 65
7500 61
8750 66
10000 80
;
run;

/*linear regression*/
proc reg data = aa;
 model rooted = concentration/clb;
run;
quit;




