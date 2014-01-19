Information about the Fibromyalgia-Tai Chi data set
================
## *Introductory Statistics for the Health Sciences*, by Lise DeShea and Larry E. Toothaker

### Background
The purpose of this document is to provide background on the data set on fibromyalgia and tai chi.  The data came from the following study:
 * Wang, C., Schmid, C. H., Rones, R., Kalish, R., Yinh, J., Goldenberg, D. L., Lee, Y., & McAlindon, T. (2010).  [A randomized trial of tai chi for fibromyalgia](http://www.ncbi.nlm.nih.gov/pubmed/20818876).  *The New England Journal of Medicine, 363*, 743-754.  doi:10.1056/NEJMoa0912611 

These researchers randomly assigned patients with fibromyalgia to either a 12-week tai chi class that met twice a week for one hour per session or a control group meeting for the same amount of time for wellness education related to fibromyalgia and stretching exercises.  Participants were measured before the intervention began (baseline), at the end of 12 weeks, and 24 weeks after the study began (followup).

One of the main measures used in the study was the Fibromyalgia Impact Questionnaire (FIQ), which produced scores “ranging from 0 to 100, with higher scores meaning more severe symptoms” of fibromyalgia.  Many scales, such as the FIQ, ask participants to rate statements on a scale from 0 to 3, or 0 to 7, or 0 to 10, with anchors defining two or more of the numbers on the scale.  For example, a statement might say, “How bad has your pain been?”  The participant may be asked to give a rating from 0 = “no pain” to 10 = “very severe pain.”  The FIQ includes questions that sometimes do not apply to all participants; specifically, some questions ask about days missed from work.  If a participant was unemployed and could answer only some of the questions, the participant’s average response to those items was included in the total FIQ score.  Therefore, the data set contains FIQ scores that have decimal places (e.g., participant #1’s FIQ score at Time 1 was 59.5927).  Similar adjustments were performed on the mental and physical components of the Short Form Health Survey (SF-36, described below).

### An important note about this data set
The researchers employed an intention-to-treat approach to data analysis.  Among the many intention-to-treat approaches, one way is to use the participant’s last known score.  For example, Participant #57 was measured at Time 1 (baseline) and again at Time 2 (end of the 12-week intervention), but no score was available at Time 3 (24 weeks after the study began).  When analyzing longitudinal data, we often use statistical programs that will ignore all of the data for a participant if even one occasion of measurement was missed.  In order to keep the participant’s available data in the study, these researchers took Participant #57’s scores at Time 2 and recorded those same scores as the Time 3 scores.  Notice that there is an “x” at the end of Participant #57’s row of data. The “x” flags this participant as one of the cases for whom this intention-to-treat approach was used.  Your instructor may wish to have you change the Time 3 score to a missing value and reanalyze the data to see the effect on the results.  (Other participants had data only at Time 1, so both Time 2 and Time 3 scores were recorded as the same as the Time 1 scores.)

### Dataset Variables
 1. **SubjectID**: A unique number assigned to each participant.
 2. **Group**:  An indicator for the participant’s assignment to a group, where the possible values are `Control` and `Treatment`.
 3.	**FiqT1**:  Total score on the Fibromyalgia Impact Questionnaire (FIQ) at baseline.  Higher numbers mean greater (negative) impact of fibromyalgia on the participant’s daily activities and experience of pain, fatigue and mood.
 4. **FiqT2**:  Total FIQ score at the end of the 12-week intervention (Time 2).
 5. **FiqT3**:  Total FIQ score 24 weeks after the study began (Time 3).
 6. **PsqiT1**:  The Pittsburgh Sleep Quality Index score at Time 1 (baseline).  Higher numbers mean more sleep disturbances in the last month.
 
 **TODO**: need explanations for the rest of the variables.

Note: missing values in the CSV are coded as `NA`.
