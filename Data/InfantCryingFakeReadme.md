Information about the Infant Crying *Fake* Data
================
## *Introductory Statistics for the Health Sciences*, by Lise DeShea and Larry E. Toothaker

### Background
The purpose of this document is to provide background on the *fake* data set on soothing methods and duration of infant crying.  The data were computer-generated for Chapter 12.

The fake data were created to illustrate the computation of the one-way ANOVA *F* test and the concept of total variability being divided into between-groups and within-groups variability.  The scenario builds upon a scenario used in Chapter 11 in connection with the independent-samples *t* test.  The scenario describes babies receiving the usual maternal soothing after an injection and babies who are breast-feeding when they receive the shot, then encouraged to continue breast-feeding.  In Chapter 12, a third group was added to the scenario:  an imagined group of babies who were bottle-fed with breast milk when they received the shot.  

The scenario describes three groups:

 * `Group 1`:  Babies who received the shot while breast-feeding, then who were encouraged to resume breast-feeding after the shot;
 * `Group 2`:  Babies who received the shot while bottle-feeding with breast milk, then who were encouraged to resume bottle-feeding after the shot; and
 * `Group 3`:  Babies who received the usual maternal soothing after the shot.

### Dataset Variables
 1. `GroupID`:  A numeric variable to distinguish among the three groups.
 2. `Group`:  Name of the group (breast, bottle, control).
 3. `CryingDuration`:  The generated (fake) data representing the number of seconds that each baby cried after the injection.

Note about missing values:

 * missing values in the CSV are coded as `NA`.
 * missing values in the SAS dataset are coded as `.` (*i.e.*, a period).
 * missing values in the SPSS dataset are coded as `.` (*i.e.*, a period).
