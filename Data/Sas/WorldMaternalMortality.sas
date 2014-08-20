data a;
***This data set was compiled using information from www dot cia dot gov and www dot who dot int;
***for DeShea and Toothaker's Introductory Statistics for the Health Sciences;
input Country $ 1-32 MaternalMortper100KBirths2010 LifeExpectancyAtBirth2011 Extreme $;
lines;
Chad								1100	51	FALSE
Somalia								1000	50	FALSE
Sierra Leone						890	47	FALSE
Central African Republic			890	48	FALSE
Burundi								800	53	FALSE
Guinea-Bissau						790	50	FALSE
Liberia								770	59	FALSE
Sudan								730	62	FALSE
Cameroon							690	53	FALSE
Nigeria								630	53	FALSE
Lesotho								620	50	TRUE
Guinea								610	55	FALSE
Niger								590	56	FALSE
Zimbabwe							570	54	FALSE
Mali								540	51	FALSE
Mauritania							510	59	FALSE
Mozambique							490	53	FALSE
Afghanistan							460	60	FALSE
Malawi								460	58	FALSE
Angola								450	51	FALSE
Zambia								440	55	FALSE
Senegal								370	61	FALSE
Kenya								360	60	FALSE
Benin								350	57	FALSE
Ethiopia							350	60	FALSE
Ghana								350	64	FALSE
Haiti								350	63	FALSE
Rwanda								340	60	FALSE
Swaziland							320	50	TRUE
Uganda								310	56	FALSE
Timor-Leste							300	64	FALSE
Burkina Faso						300	56	FALSE
Togo								300	56	FALSE
South Africa						300	58	TRUE
Guyana								280	63	FALSE
Comoros								280	62	FALSE
Pakistan							260	67	FALSE
Cambodia							250	65	FALSE
Bangladesh							240	70	FALSE
Equatorial Guinea					240	54	FALSE
Eritrea								240	61	FALSE
Madagascar							240	66	FALSE
Gabon								230	62	FALSE
Papua New Guinea					230	63	FALSE
Indonesia							220	69	FALSE
Djibouti							200	58	FALSE
India								200	65	FALSE
Namibia								200	65	TRUE
Yemen								200	64	FALSE
Belarus								190	71	FALSE
Bhutan								180	67	FALSE
Nepal								170	68	FALSE
Botswana							160	66	TRUE
Dominican Republic					150	73	FALSE
Suriname							130	72	FALSE
Guatemala							120	69	FALSE
Tonga								110	72	FALSE
Ecuador								110	76	FALSE
Jamaica								110	75	FALSE
Vanuatu								110	72	FALSE
Morocco								100	72	FALSE
Samoa								100	73	FALSE
Honduras							100	74	FALSE
Philippines							99	69	FALSE
Paraguay							99	75	FALSE
Algeria								97	73	FALSE
Nicaragua							95	73	FALSE
Solomon Islands						93	70	FALSE
Panama								92	77	FALSE
Colombia							92	78	FALSE
El Salvador							81	72	FALSE
Cape Verde							79	72	FALSE
Argentina							77	76	FALSE
Cuba								73	78	FALSE
Kyrgyzstan							71	69	FALSE
Sao Tome and Principe				70	63	FALSE
Turkmenistan						67	63	FALSE
Georgia								67	72	FALSE
Peru								67	77	FALSE
Egypt								66	73	FALSE
Tajikistan							65	68	FALSE
Iraq								63	69	FALSE
Jordan								63	74	FALSE
Mongolia							63	68	FALSE
Mauritius							60	74	FALSE
Maldives							60	77	FALSE
Libya								58	65	FALSE
Tunisia								56	76	FALSE
Brazil								56	74	FALSE
Belize								53	74	FALSE
Kazakhstan							51	67	FALSE
Barbados							51	78	FALSE
Mexico								50	75	FALSE
Saint Vincent and the Grenadines	48	74	FALSE
Thailand							48	74	FALSE
Trinidad and Tobago					46	71	FALSE
Azerbaijan							43	71	FALSE
Costa Rica							40	79	FALSE
China								37	76	FALSE
Sri Lanka							35	75	FALSE
Saint Lucia							35	75	FALSE
Latvia								34	74	FALSE
Oman								32	72	FALSE
Ukraine								32	71	FALSE
Armenia								30	71	FALSE
Uruguay								29	77	FALSE
Malaysia							29	74	FALSE
Uzbekistan							28	68	FALSE
Albania								27	74	FALSE
Romania								27	74	FALSE
Fiji								26	70	FALSE
Lebanon								25	74	FALSE
Chile								25	79	FALSE
Grenada								24	74	FALSE
Saudi Arabia						24	76	FALSE
Hungary								21	75	FALSE
Bahrain								20	79	FALSE
Turkey								20	76	FALSE
Luxembourg							20	82	FALSE
Croatia								17	77	FALSE
New Zealand							15	81	FALSE
Kuwait								14	80	FALSE
United Kingdom						12	80	FALSE
Slovenia							12	80	FALSE
United Arab Emirates				12	76	FALSE
Serbia								12	74	FALSE
Canada								12	82	FALSE
Denmark								12	79	FALSE
Bulgaria							11	74	FALSE
Cyprus								10	81	FALSE
Kiribati							9	67	FALSE
Bosnia and Herzegovina				8	76	FALSE
France								8	82	FALSE
Belgium								8	80	FALSE
Malta								8	80	FALSE
Switzerland							8	83	FALSE
Lithuania							8	74	FALSE
Montenegro							8	76	FALSE
Portugal							8	80	FALSE
Israel								7	82	FALSE
Germany								7	81	FALSE
Australia							7	82	FALSE
Qatar								7	82	FALSE
Norway								7	81	FALSE
Ireland								6	81	FALSE
Netherlands							6	81	FALSE
Slovakia							6	76	FALSE
Spain								6	82	FALSE
Japan								5	83	FALSE
Czech Republic						5	78	FALSE
Poland								5	76	FALSE
Iceland								5	82	FALSE
Finland								5	81	FALSE
Sweden								4	82	FALSE
Austria								4	81	FALSE
Italy								4	82	FALSE
Greece								3	81	FALSE
Singapore							3	82	FALSE
Estonia								2	76	FALSE
;
proc print;
run;
