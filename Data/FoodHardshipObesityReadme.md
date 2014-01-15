Information about the Food Hardship and Obesity Rates, 2011
================
## *Introductory Statistics for the Health Sciences*, by Lise DeShea and Larry E. Toothaker

### Background
The purpose of this document is to provide background on the data set on food hardship and obesity.  The data came from two sources:
 * Food Research and Action Center. (2012, February).  [Food hardship in America 2011: Data for the nation, states, 100 MSAs, and every congressional district.](http://frac.org/pdf/food_hardship_2011_report.pdf)  Washington, D.C.  
 * Centers for Disease Control and Prevention. (2012, August 13).  [Adult obesity facts.](http://www.cdc.gov/obesity/data/adult.html) 

To measure food hardship, the Food Research and Action Center's polling organization (Gallup) in 2011 conducted surveys of large representative samples from every state, the District of Columbia and U.S. territories.  The survey included both landline and cell phones.  Respondents were asked, “Have there been times in the past 12 months when you did not have enough money to buy food that you or your family needed?”  Those who answered “yes” were counted as experiencing food hardship, and percentages of respondents answering yes were reported for the 50 states plus D.C.

The prevalence of obesity is the proportion or percentage of a population identified as obese.  The Centers for Disease Control and Prevention (CDC) manages the Behavioral Risk Factor Surveillance System (BRFSS), which is conducted at the state level and provides data to help agencies address behavioral risks that affect the health of Americans.  Representative samples in 2011 were obtained, and the obesity rates were the percentage of respondents in that state whose self-reported weight and height resulted in a body mass index (BMI) of 30 or higher.  BMI was defined as weight (in kilograms) divided by the person's squared height (in meters).  The survey included both landline and cell phones.  Among the exclusion criteria were pregnant women and people whose height, weight or BMI were extreme (e.g., respondents who said they were shorter than 3 feet tall).

### Dataset Variables
 1. **StateName**: Names of the states.  Includes the 50 states and D.C.
 2. **State**:  Abbreviations for state names.
 3. **FoodHardshipRate**:  Percentage of respondents to the FRAC/Gallup representatives surveys in 2011 who said yes when asked:  “Have there been times in the past 12 months when you did not have enough money to buy food that you or your family needed?”
 4. **ObesityRate**:  Percentage of respondents to the 2011 BRFSS survey whose self-reported height and weight resulted in a BMI of 30 or higher. 
 5. **Location**: Indicates if the state is commonly thought as of a Southern State or not.  The possible values are `Southern` and `Other`.

Note: missing values in the CSV are coded as `NA`.
