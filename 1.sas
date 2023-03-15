
proc reg data=ninds;
model ninety_1 = los;
run;
libname p 'C:\Users\18750\OneDrive\Desktop\Study\Biostat200B\Project';

data p.ninds; set p.originalninds;run;

data p.ninds_1;set p.ninds;
keep hour24 bgender nihssb brace age treatcd los ninety seventen bhyper int3mles;
run;

proc contents data=p.ninds;
run;
data ninds; set p.ninds_1;
ninety = ninety+1;
int3mles=int3mles+1;
run;
data ninds;set p.ninds_1;
if ninety=43 then delete;
if hour24=42 then delete;
if seventen=42 then delete;
if los>90 then delete;
ninety_1 = log(ninety);
int3mles_1 = log(int3mles);
if cmiss(of _all_) then delete;
if bgender = 1 then gender=1; else gender=0;
if treatcd =1 then treat=1;else treat=0;
if bhyper =0 then hyper=0;else hyper=1;
if brace=1 then black=1; else black=0;
if brace=3 then hispanic=1; else hispanic=0;
if brace=4 then asian=1; else asian=0;
if brace=5 then other=1; else other=0;
run;

proc univariate data=ninds;



proc sgscatter data=ninds;
plot ninety*int3mles_1;
run;
proc reg data=ninds;
model ninety_1=int3mles_1;
run;
proc transreg data=ninds;
model identity(ninety) = identity(int3mles);
run;

proc loess data=ninds;
model ninety_1=int3mles_1;
run;

proc corr data=ninds;
var ninety_1 hour24 int3mles_1 gender nihssb black hispanic asian other age treat los hyper seventen;
run;

data ninds;set ninds;
nihssb_ninety = nihssb*ninety;
int3_nihssb = int3mles*nihssb;
int3_ninety = int3mles*ninety;
age_hyper = age*hyper;
run;


proc reg data=ninds;
model ninety_1 = seventen;
run;



proc reg data=ninds;
model ninety_1=hour24 int3mles_1 gender nihssb black hispanic asian other age treat los hyper seventen/selection=cp aic bic;
run;
 
proc means data=ninds;
var ninety;
run;


proc reg data=ninds;
model ninety_1 = hour24 int3mles_1 gender black age los hyper seventen;
run;


proc sgscatter data=ninds;
matrix ninety_1 hour24 int3mles_1 gender nihssb black hispanic asian other age treat los hyper seventen;
run;

proc reg data=ninds;
model ninety_1 = hour24 int3mles_1 gender nihssb black hispanic asian other age treat los hyper seventen/VIF;
run;


proc reg data=ninds;
model ninety_1 = hour24 int3mles_1 gender black age treat los hyper seventen/VIF;
run;

proc reg data=ninds;
model ninety_1=hour24 int3mles_1 black age los hyper seventen; run;
