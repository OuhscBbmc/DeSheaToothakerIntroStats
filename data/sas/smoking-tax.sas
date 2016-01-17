data a;
***This data set was compiled using information from www dot cdc dot gov and Orzechowski and Walker (2011);
***for DeShea and Toothaker's Introductory Statistics for the Health Sciences;
***The context and details of the dataset are described in https://github.com/OuhscBbmc/DeSheaToothakerIntroStats/blob/master/data/smoking-taxReadme.md;

input StateName $ 1-18 State $ AdultCigaretteUse YouthCigaretteUse TaxCentsPerPack Location $;
lines;
Alabama				AL	0.225	0.208	42.5	South
Alaska				AK	0.206	0.157	200	Other
Arizona				AZ	0.161	0.197	200	Other
Arkansas			AR	0.215	0.203	115	South
California			CA	0.129	.		87	Other
Colorado			CO	0.171	0.177	84	Other
Connecticut			CT	0.154	0.178	300	Other
Delaware			DE	0.183	0.19	160	South
DistrictofColumbia	DC	0.153	.		250	Other
Florida				FL	0.171	0.161	133.9	South
Georgia				GA	0.177	0.169	37	South
Hawaii				HI	0.154	0.152	260	Other
Idaho				ID	0.163	0.145	57	Other
Illinois			IL	0.186	0.181	98	Other
Indiana				IN	0.231	0.235	99.5	Other
Iowa				IA	0.172	.		136	Other
Kansas				KS	0.178	0.169	79	Other
Kentucky			KY	0.256	0.261	60	South
Louisiana			LA	0.221	0.176	36	South
Maine				ME	0.173	0.181	200	Other
Maryland			MD	0.152	0.119	200	South
Massachusetts		MA	0.15	0.16	251	Other
Michigan			MI	0.196	0.188	200	Other
Minnesota			MN	0.168	.		156	Other
Mississippi			MS	0.233	0.196	68	South
Missouri			MO	0.231	0.189	17	Other
Montana				MT	0.168	0.187	170	Other
Nebraska			NE	0.167	.		64	Other
Nevada				NV	0.22	0.17	80	Other
NewHampshire		NH	0.158	0.208	178	Other
NewJersey			NJ	0.158	0.17	270	Other
NewMexico			NM	0.179	0.24	91	Other
NewYork				NY	0.18	0.148	275	Other
NorthCarolina		NC	0.203	0.177	45	South
NorthDakota			ND	0.186	0.224	44	Other
Ohio				OH	0.203	.		125	Other
Oklahoma			OK	0.255	0.226	103	South
Oregon				OR	0.179	.		118	Other
Pennsylvania		PA	0.202	0.184	160	Other
RhodeIsland			RI	0.151	0.133	346	Other
SouthCarolina		SC	0.204	0.205	7	South
SouthDakota			SD	0.175	0.232	153	Other
Tennessee			TN	0.22	0.209	62	South
Texas				TX	0.179	0.212	141	South
Utah				UT	0.098	0.085	69.5	Other
Vermont				VT	0.171	0.176	224	Other
Virginia			VA	0.19	.		30	South
Washington			WA	0.149	.		302.5	Other
WestVirginia		WV	0.256	0.218	55	South
Wisconsin			WI	0.188	0.169	252	Other
Wyoming				WY	0.199	0.221	60	Other
;
proc print;
run;
