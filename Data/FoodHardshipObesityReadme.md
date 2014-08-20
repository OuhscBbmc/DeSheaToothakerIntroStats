Information about the Food Hardship and Obesity Rates
================
## *Introductory Statistics for the Health Sciences*, by Lise DeShea and Larry E. Toothaker

### Background
The purpose of this document is to provide background on the data set on food hardship and obesity.  The data came from two sources:

 * Centers for Disease Control and Prevention. (2012, August 13).  *Adult obesity facts.*  Retrieved from http://www.cdc.gov/obesity/data/adult.html.
 * Food Research and Action Center. (2012, February).  *Food hardship in America 2011: Data for the nation, states, 100 MSAs, and every congressional district.*  Washington, D.C.  Retrieved from http://frac.org/pdf/food_hardship_2011_report.pdf.

The textbook authors combined the data to illustrate correlation.  Note:  The rates are expressed as proportions, not percentages, in the SAS and .csv files.  The SPSS files contain two additional variables representing the rates as percentages as well.


### Dataset Variables
 1. `StateName`:  State names.
 2. `State`:  State abbreviations.
 3. `FoodHardshipRate`:  Proportion of adults who said they lacked money to buy food for their families or themselves on at least one day in the previous 12 months, 2011.
 4. `ObesityRate`:  Proportion of adults surveyed by the Behavioral Risk Factor Surveillance System (BRFSS) who had a body mass index of 30 or higher, based on the participants’ self-reported height and weight, 2011.
 5. `Location`:  Indicator of whether the state is in the South or Other location in the United States, based on U.S. census’ designations.
 6. `FHPercent` (only in SPSS file):  The food hardship rates expressed as percentages.
 7. `ObesityPercent` (only in SPSS file):  The obesity rates expressed as percentages.

Note: missing values in the CSV are coded as `NA`.
