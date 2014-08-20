Information about the Exercise During Pregnancy data set
================
## *Introductory Statistics for the Health Sciences*, by Lise DeShea and Larry E. Toothaker

### Background
The purpose of this document is to provide background on the data set on exercise during pregnancy.  The data came from the following study:
 * Price, B. B., Amini, S. B., & Kappeler, K. (2012).  [Exercise in pregnancy:  Effect on fitness and obstetric outcomes – a randomized trial.](http://www.ncbi.nlm.nih.gov/pubmed/22843114)  *Medicine & Science in Sports & Exercise, 44, 2263-2269*.  doi:10.1249/MSS.0b013e318267ad67

These researchers, who graciously agreed to share their data, randomly assigned sedentary pregnant women to one of two groups.  The control group remained sedentary, and the treatment group engaged in moderate aerobic exercise regularly through the 36th week of gestation.  The data set contains some variables that were measured on five occasions in time.  

The two main numeric variables that were measured repeatedly contain the words lifts and watts.  The lifts variables are the number of times that the participant could lift a 7-kilogram (about 15.4-pound) medicine ball from the floor to their waist in 1 minute.  The watts variables are measures of the power in watts produced during a timed walk.  “Each participant was asked to walk or run 3.2 km (2 miles) as fast as possible within her comfort zone at a steady pace … [P]ower … was calculated based on the following equation:  power = (weight x distance) / time” (p. 2265, Price, Amini, & Kappeler, 2012).

The five occasions in time were:  12-14 weeks of pregnancy (Time 1); 18-20 weeks (Time 2); 24-26 weeks (Time 3); 30-32 weeks (Time 4); and 6-8 weeks post-delivery (Time 5).  Not every participant was measured at every occasion, so there are some missing data.

### Dataset Variables
 1. `SubjectID`: A unique number assigned to each participant.
 2. `Group`:  An indicator for the participant's assignment to a group. Values can be `Active` or `Control`.
 3. `T1Lifts`:  At Time 1 (baseline:  12-14 weeks gestation), the number of times that the participant could lift a 7-kg medicine ball from the floor to waist height in 1 min.
 4. `T2Lifts`:  Like T1Lifts, but measured at Time 2 (18-20 weeks gestation).
 5. `T3Lifts`:  Like T1Lifts, but measured at Time 3 (24-26 weeks gestation).
 6. `T4Lifts`:  Like T1Lifts, but measured at Time 4 (30-32 weeks gestation).
 7. `T5Lifts`:  Like T1Lifts, but measured at Time 5 (6-8 weeks after delivery).
 8. `T1Watts`:  At Time 1, a measure of power in watts produced during a 3.2-km walk or run.  Power was calculated by multiplying the participant's weight and the distance covered, divided by time.  
 9. `T2Watts`, `T3Watts`, `T4Watts`, `T5Watts`:  Like T1Watts, but measured at Times 2, 3, 4 and 5.
 10. `DeliveryMethod`:  An indicator of delivery method. Values can be `Vaginal` or `Cesarean`.
 11. `CesareanHistory`:  An indicator of whether the delivery was vaginal (a value of `0`), or this was the first time that the participant had a cesarean (a value of `1`), or the was at least the mother's second cesarean (a value of `2`).
 12. `BabyWeightInG`:  Baby's birth weight in grams.
 13. `RecoveryDays`:  Number of days postpartum that the mother returned to being able to perform 3 of 5 listed household tasks (“changing sheets and making beds; sweeping, mopping, vacuuming, or other cleaning; washing and folding clothes; shopping for groceries and putting groceries away; preparing, cooking, and serving meals”).

Note: missing values in the CSV are coded as `NA`.
