Information about the World Maternal Mortality Data
================
## *Introductory Statistics for the Health Sciences*, by Lise DeShea and Larry E. Toothaker

### Background
The purpose of this document is to provide background on the data set on maternal mortality and life expectancy at birth.  The data came from the following sources:

 * World Factbook (2013).  Maternal mortality rates per 100,000 births in 2010.  Washington, D.C.:  Central Intelligence Agency.  Retrieved from:  https://www.cia.gov/library/publications/the-world-factbook/
 * World Health Organization (2013).  Life expectancy tables.  Global Health Observatory.  Retrieved from http://www.who.int/gho/mortality_burden_disease/life_tables/en/ 

The World Factbook defines the maternal mortality rate as “the annual number of female deaths per 100,000 live births from any cause related to or aggravated by pregnancy or its management (excluding accidental or incidental causes).”  The data set contains the number of maternal deaths per 100,000 births in 2010.  The World Health Organization estimated the average life expectancy for people born in 2011.  DeShea & Toothaker combined the data for an example in Chapter 5. 

### Dataset Variables
 1. `Country`: The name of each country in the data set (N = 159 countries).
 2. `MaternalMortper100KBirths2010`:  The number of maternal deaths per 100,000 births in 2010.
 3. `LifeExpectancyAtBirth2011`:  The estimated average lifespan for people born in 2011.
 4. `Extreme`:  An indicator used in creating some graphs.  This variable may be ignored.

Note about missing values:

 * missing values in the CSV are coded as `NA`.
 * missing values in the SAS dataset are coded as `.` (*i.e.*, a period).
 * missing values in the SPSS dataset are coded as `.` (*i.e.*, a period).
