Datasets and their Documentation
================
## for *Introductory Statistics for the Health Sciences*, by Lise DeShea and Larry E. Toothaker

Hi, and welcome to the folder containing the book's datasets.  These files are provided so that students and teachers can recreate all analyses and graphs found in our book.  For each dataset, there are four files:

 1. **A comma separated values (.csv) file**, which is located in this directory.  The dataset can be viewed in GitHub, or used in the book's R code.  For example of reading a csv into R, see [this code snippet](https://github.com/OuhscBbmc/DeSheaToothakerIntroStats/blob/master/chapter-03/chapter-03.R#L25-L27) near the top of the Chapter 2 file.
 
 2. **A 'readme' file**, which is located in this directory.  It documents the dataset's (1) source, (2) interesting or important details, (3) the variable names and definitions, and (4) coding scheme for any missing observations.
 
 3. **An SPSS file**, which is located in the `spss/` subdirectory.  The file is most naturally readable in the SPSS program.
 
 4. **A SAS file**, which is located in the `sas/` subdirectory.  Unlike the csv and SPSS files, this isn't strictly a dataset, but a file that should be executed in SAS.  It creates an in-memory dataset that can be used for analyses.  Alternatively, the csv files can be read into SAS with `proc import`.

One of the book's goals is to narrow the gap between the (a) statistical concepts and the (b) pragmatic steps taken for an analysis.  Please share any comments you have (or possible errors you see) with [Lise DeShea](http://nursing.ouhsc.edu/AboutTheCollege/Research/MeetourResearchTeam.aspx).
