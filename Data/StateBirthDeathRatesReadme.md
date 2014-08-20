Information about the State Birth and Death Rates Data
================
## *Introductory Statistics for the Health Sciences*, by Lise DeShea and Larry E. Toothaker

### Background
The purpose of this document is to provide background on the data set on state birth and death rates.  The data came from the following sources:

 * Centers for Disease Control and Prevention.  (2013, April 26).  Birth data.  National Vital Statistics System.  Retrieved from http://www.cdc.gov/nchs/births.htm 
 * Centers for Disease Control and Prevention.  (2013, April 26).  Mortality tables.  National Vital Statistics System.  Retrieved from http://www.cdc.gov/nchs/nvss/mortality_tables.htm 

The birth rates are the number of live births per 1,000 people in the state.  The death rates are the number of deaths per 100,000 people, with the rates adjusted for age.  

The data set also includes many other variables with data obtained from the CDC; those variables have not been described in the DeShea and Toothaker textbook, but they are provided for use by instructors.  The CDC manages the Behavioral Risk Factor Surveillance System (BRFSS), which involves representative samples and is conducted at the state level and provides data to help agencies address behavioral risks that affect the health of Americans.  


### Dataset Variables
 1. `StateName`: The 50 United States and the District of Columbia.
 2. `State`:  Abbreviations for state names.
 3. `AdultAsthmaPrev`:  Percentage of adults surveyed in the 2010 BRFSS survey who responded affirmatively to a question about whether they had ever been told by a health care professional that they had asthma.
 4. `Diabetes2010`:  Percentage of adults surveyed in the 2010 BRFSS survey who responded affirmatively to a question about whether they had ever been told by a health care professional that they had diabetes.
 5. `BirthCount`:  Number of births, 2010.
 6. `PopulationCount`:  Estimated total population of the state, 2010.
 7. `BirthRate2010`:  Number of births per 1,000 population; the crude birth rate.
 8. `DeathCount2011`:  Number of deaths, 2011.
 9. `DeathRateCrude2011`:  Number of deaths per 100,000 population in 2011; the crude death rate.
 10. `DeathRateAgeAdjusted201`1:  The death rate per 100,000 population in 2011, after adjusting for the age of the population.
 11. `DeathCount2010`:  Number of deaths, 2010.
 12. `DeathRateCrude2010`:  Number of deaths per 100,000 population in 2010; the crude death rate.
 13. `DeathRateAgeAdjusted2010`:  The death rate per 100,000 population in 2010, after adjusting for the age of the population.

Note: missing values in the CSV are coded as `NA`.
