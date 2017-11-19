How to check if set A is subset of set B (R and SAS)

Venn type problems are best solved with R or IML?
Think outside the datastep.

INPUT
=====

  SD1.HAV1ST total obs=4
  Obs    A

   1     1
   2     2
   3     3
   4     4


  SD1.HAV2nd total obs=4
  Obs    B

   1     1
   2     2
   3     3
   4     4
   5     5


WORKING CODE
============

    R
      all(A %in% B);

    SAS

      select a as m from sd1.hav1st
      except
      select b as m from sd1.hav2nd

      %put %sysfunc(ifc(&sqlobs=0,TRUE,FALSE));

OUTPUT
======
      R
      [1] TRUE

      SAS
      All of A is in B   TRUE

see
https://stackoverflow.com/questions/37656853/how-to-check-if-set-a-is-subset-of-set-b-in-r

Akun profile
https://stackoverflow.com/users/3732271/akrun

*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;

options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.hav1st(keep=a) sd1.hav2nd(keep=b);
  do a= 1,2,3,4;
    output sd1.hav1st;
  end;
  do b= 2, 5, 3, 4, 1;
    output sd1.hav2nd;
  end;
run;quit;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __  ___
/ __|/ _ \| | | | | __| |/ _ \| '_ \/ __|
\__ \ (_) | | |_| | |_| | (_) | | | \__ \
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/

;

* R;

%utl_submit_r64('
library(haven);
library(SASxport);
library(Hmisc);
a<-t(read_sas("d:/sd1/hav1st.sas7bdat"));
b<-t(read_sas("d:/sd1/hav2nd.sas7bdat"));
a;
b;
all(a %in% b);
all(b %in% a);
');

* SAS;

proc sql;

 select
   a as mat
 from
   sd1.hav1st

 except

 select
   b as mat
 from
   sd1.hav2nd
;quit;

%put All of A is in B   %sysfunc(ifc(&sqlobs=0,TRUE,FALSE));



