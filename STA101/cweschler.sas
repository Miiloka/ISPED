PROC IMPORT OUT= WORK.ad 
            DATAFILE= "C:\Users\jeric\OneDrive\Programmation\Github\ISPE
D\STA101\cweschler.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
