Information about the Breastfeeding and Sleep **Fake** Data
================
## *Introductory Statistics for the Health Sciences*, by Lise DeShea and Larry E. Toothaker

### Background
The purpose of this document is to provide background on the *fake* data set on baby-feeding and maternal sleep.  The data were computer-generated for Chapter 12.

The fake data were created to illustrate the concepts of between-groups and within-groups variability and were used in the discussion of the one-way ANOVA *F* test.  The scenario describes three groups of mothers:

 * Group 1:  Mothers who breast-feed exclusively;
 * Group 2:  Mothers who bottle-feed exclusively; and
 * Group 3:  Mothers who use both feeding methods.

Three variations of the scenario were given in Chapter 12:

 * Scenario 12-A:  All three groups have the same mean and standard deviation.
 * Scenario 12-B:  All three groups have the same standard deviation, but one group has a higher mean than the two other groups.
 * Scenario 12-C:  One of the groups has a mean that differs from the two other groups’ means, and all of the groups have the same standard deviation, but now the standard deviation is larger than the standard deviation in the two other scenarios.


### Dataset Variables
 1. `ScenarioID`: A numeric variable to distinguish among the three scenarios.
 2. `Scenario`: Names of the three scenarios.
 3. `FeedingID`: The group numbers (1 = breast, 2 = bottle, 3 = both).
 4. `Feeding`: Names of the three groups.
 5. `Deviates`: A number used to generate the data; this variable can be ignored.
 6. `GroupMean`: The means for each group within each scenario.
 7. `ScenarioSD`: The standard deviations for each group within each scenario.
 8. `Sleep`: The generated (fake) data representing each mother’s number of minutes of sleep in a 24-hour period.

Note about missing values:

 * missing values in the CSV are coded as `NA`.
 * missing values in the SAS dataset are coded as `.` (*i.e.*, a period).
 * missing values in the SPSS dataset are coded as `.` (*i.e.*, a period).
