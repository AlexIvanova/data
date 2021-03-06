/*  EXAMPLES 10.4.2, 10.5.1, 10.5.2, and 10.6.2  */
options ls=76;
FILENAME CHEM 'My Documents/RencherBook/ftpsite/multivariate_analysis/T10_1_CHEM.dat';
DATA CHEM;
  INFILE CHEM;
  INPUT NUM Y1 Y2 Y3 X1 X2 X3;
  X1X2 = X1*X2;   X1SQ = X1*X1;
  X1X3 = X1*X3;   X2SQ = X2*X2;
  X2X3 = X2*X3;   X3SQ = X3*X3;run;


PROC REG SIMPLE;
  MODEL Y1 Y2 Y3 = X1 X2 X3;
  OVERALL:  MTEST /PRINT;
RUN;

  TITLE 'EXAMPLES 10.4.2, 10.5.1, and 10.5.2';
PROC REG;
  MODEL Y1 Y2 Y3 = X1 X2 X3 X1X2 X1X3 X2X3 X1SQ X2SQ X3SQ;
  OVERALL9:  MTEST/print canprint;
  Partial6:   MTEST X1X2,X1X3,X2X3,X1SQ,X2SQ,X3SQ/print canprint;
  Partial3:   MTEST X1X2,X1X3,X2X3/print canprint;
run;

  TITLE 'EXAMPLE 10.6.2';

DATA CHEM2;
  INPUT  X1 X2 X3;
  X1X2 = X1*X2;   X1SQ = X1*X1;
  X1X3 = X1*X3;   X2SQ = X2*X2;
  X2X3 = X2*X3;   X3SQ = X3*X3;
  DATALINES; 
160 25 5
;
RUN;

DATA CHEM2;
  SET CHEM CHEM2;
RUN;
options ls=120 formdlim="#";

PROC REG SIMPLE;
  MODEL Y1 Y2 Y3 = X1 X2 X3 /  CLI CLM;
  OVERALL:  MTEST /PRINT;
RUN;
