data a;
input StorkPairCount BirthRate Extreme $;
lines;
100	  83	FALSE
300   87	FALSE
1	  118	FALSE
5000  117	FALSE
9	  59	FALSE
140	  774	FALSE
3300  901	FALSE
2500  106	FALSE
4	  188	FALSE
5000  124	FALSE
5	  551	FALSE
30000 610	TRUE
1500  120	FALSE
5000  367	FALSE
8000  439	FALSE
150	  82	FALSE
25000 1576	TRUE
;
proc print;
run;