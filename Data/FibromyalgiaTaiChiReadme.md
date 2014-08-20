Information about the Fibromyalgia-Tai Chi data set
================
## *Introductory Statistics for the Health Sciences*, by Lise DeShea and Larry E. Toothaker

### Background
The purpose of this document is to provide background on the data set on fibromyalgia and tai chi.  The data came from the following study:
 * Wang, C., Schmid, C. H., Rones, R., Kalish, R., Yinh, J., Goldenberg, D. L., Lee, Y., & McAlindon, T. (2010).  [A randomized trial of tai chi for fibromyalgia](http://www.ncbi.nlm.nih.gov/pubmed/20818876).  *The New England Journal of Medicine, 363*, 743-754.  doi:10.1056/NEJMoa0912611 

These researchers, who graciously agreed to share their data, randomly assigned people with fibromyalgia to one of two groups.  The control group received wellness education and engaged in stretching exercises, and the treatment group engaged in tai chi sessions.  The two groups met for an hour twice weekly for 12 weeks.  

The participants were measured three times:  at baseline, at the end of the 12-week intervention period, and 24 weeks after the intervention ended.  Not every participant was measured at every occasion, so there are some missing data.  

**Important note about this data set**:  The researchers conducted an intention-to-treat analysis, which is reflected in the data set.  Intention-to-treat is a general term for many approaches to dealing with missing data.  The analysis attempts to avoid the bias that can be introduced in a study when participants may differentially drop out of one group.  Instead of losing all of the data for that participant, data analysts may attempt to extrapolate from the existing data.  One such approach is to take the last known score on a variable and replace the subsequent missing data on that variable with the last known value.  Wang et al. (2010) followed this approach.  Therefore, while the data set appears to have no missing values, in fact some participants did drop out.  The data set includes the last known values for the missing data.  For example, the participant with Subject ID = 20 was a member of the control group who had a PSQI score = 13 at baseline (Time 1).  This participant was not measured at Time 2 or Time 3), so the researchers used this PSQI score = 13 at Times 2 and 3.  The same is true for the person’s FIQ score and SF-36 scores.  We have included a variable to flag each participant for whom the last known values were substituted for missing values.

The data set contains four numeric variables that were measured on the three occasions.  These variables contain the abbreviations FIQ, PSQI, SF36MCS, and SF36PCS:

 * The Fibromyalgia Impact Questionnaire (FIQ) “assesses physical function, common symptoms, and general well-being in patients with fibromyalgia.  Scores range from 0 to 100, with higher scores indicating more severe symptoms” (p. 749, Wang et al. [2010]).  Not all items on the FIQ are rated on the same scale, so according to the original FIQ instructions, the scoring requires some items to be multiplied by either 3.33 or 1.43 before they are summed with the other items.  Therefore, the FIQ scores are not whole numbers.  The scoring method also allows an FIQ score to be produced for participants who do not answer all 10 questions on the instrument.  
 * The Pittsburgh Sleep Quality Index (PSQI) includes questions about problems related to sleep.  Scores range from 0 to 21, with higher scores corresponding to more problems with sleeping and worse sleep quality.  
 * The 36-Item Short-Form Health Survey’s mental component score (SF36MCS) is a measure of mental quality of life, with scores ranging from 0 to 100.  Higher scores correspond to better mental quality of life.  The study used the Medical Outcomes Study’s scoring method for the SF-36 MCS.
 * The SF-36’s physical component score (SF36PCS) is a measure of physical quality of life, with scores ranging from 9 to 100.  Higher scores correspond to better physical quality of life.  The study used the Medical Outcomes Study’s scoring method for the SF-36 PCS.


### Dataset Variables
 1. `SubjectID`: A unique number assigned to each participant.
 2. `Group`:  An indicator for the participant’s assignment to a group, where the possible values are `Control` and `Treatment`.
 3.	`FiqT1`:  Total score on the Fibromyalgia Impact Questionnaire (FIQ) at baseline.  Higher numbers mean greater (negative) impact of fibromyalgia on the participant’s daily activities and experience of pain, fatigue and mood.
 4. `FiqT2`:  Total FIQ score at the end of the 12-week intervention (Time 2).
 5. `FiqT3`:  Total FIQ score 24 weeks after the study began (Time 3).
 6. `PsqiT1`:  The Pittsburgh Sleep Quality Index score at Time 1 (baseline).  Higher numbers mean more sleep disturbances in the last month.
 7. `PsqiT2`:  PSQI Time 2 score (described above).
 8. `PsqiT3`:  PSQI Time 3 score (described above).
 9. `SF36McsT1`:  SF-36 Mental Component Score, Time 1 (described above).
 10. `SF36McsT2`:  SF-36 MCS, Time 2 (described above).
 11. `SF36McsT3`:  SF-36 MCS, Time 3 (described above).
 12. `SF36PcsT1`:  SF-36 Physical Component Score, Time 1 (described above).
 13. `SF36PcsT2`:  SF-36 PCS, Time 2 (described above).
 14. `SF36PcsT3`:  SF-36 PCS, Time 3 (described above).
 15. `Flag`:  An indicator of whether a participant had missing data and had their last known values used on subsequent occasions in the data set (as described above).  FALSE means the participant had complete data, and TRUE indicates the participant had missing data that were replaced with the last known values.


Note: missing values in the CSV are coded as `NA`.
