## Summarized Human Activity Data Set

The data set described in this code book is a summarized version 
of the dataset from the work [1].

### Study Design and Summary Choices

The data taken from the original research include the values of some 
physical parameters measured with a smartphone. They were associated to 
six types of human activity. 30 volunteers took part in the experiment.

In the work presented in this code book, the training and testing data sets 
from the original source were merged, then only the variables describing 
means and standard deviations were extracted. The merged data set is stored
in *merged_dataset.csv*.

The average of the selected variables was computed grouped by the type of 
activity and subject (volunteer) id. The summarized data set is contained 
in the *summary_dataset.csv* file.

### Variables

Its variables are the summarized (average by activity type and subject) 
versions of some variables from the original study (see __Study design__).

The list of the 68 columns follows.
__NOTE__: all the continuous variables are __normalized__ to [-1, 1], as they come from the original
authors. For their raw values, see the original dataset.

- *activitylabel*: the observed human activity (LAYING, SITTING, STANDING, WALKING,
WALKING_DOWNSTAIRS, WALKING_UPSTAIRS)
- *subjectid*: the identifier of the volunteer corresponding (1 to 30)
- Tri-axial acceleration means and standard deviations,
units: standard gravity units 'g'
  - *tBodyAccmeanX*
  - *tBodyAccmeanY*
  - *tBodyAccmeanZ*
  - *tBodyAccstdX*
  - *tBodyAccstdY*
  - *tBodyAccstdZ*
- Tri-axial gravity acceleration means and standard deviations,
units: standard gravity units 'g'
  - *tGravityAccmeanX*
  - *tGravityAccmeanY*
  - *tGravityAccmeanZ*
  - *tGravityAccstdX*
  - *tGravityAccstdY*
  - *tGravityAccstdZ*
- Tri-axial body jerk means and standard deviations,
units: standard gravity unit 'g' per second
  - *tBodyAccJerkmeanX*
  - *tBodyAccJerkmeanY*
  - *tBodyAccJerkmeanZ*
  - *tBodyAccJerkstdX*
  - *tBodyAccJerkstdY*
  - *tBodyAccJerkstdZ*
- Tri-axial body angular velocity means and standard deviations,
units: radians per second
  - *tBodyGyromeanX*
  - *tBodyGyromeanY*
  - *tBodyGyromeanZ*
  - *tBodyGyrostdX*
  - *tBodyGyrostdY*
  - *tBodyGyrostdZ*
- Tri-axial body angular jerk means and standard deviations,
units: radians per second^3
  - *tBodyGyroJerkmeanX*
  - *tBodyGyroJerkmeanY*
  - *tBodyGyroJerkmeanZ*
  - *tBodyGyroJerkstdX*
  - *tBodyGyroJerkstdY*
  - *tBodyGyroJerkstdZ*
- Means and standard deviations of the magnitudes 
of the aforementioned 3-dimensional signals (Euclidean norm): 
  - *tBodyAccMagmean*, units: g
  - *tBodyAccMagstd*, units: g
  - *tGravityAccMagmean*, units: g
  - *tGravityAccMagstd*, units: g
  - *tBodyAccJerkMagmean*, units: g/s
  - *tBodyAccJerkMagstd*, units: g/s
  - *tBodyGyroMagmean*, units: rad/s
  - *tBodyGyroMagstd*, units: rad/s
  - *tBodyGyroJerkMagmean*, units: rad/s^3
  - *tBodyGyroJerkMagstd*, units: rad/s^3
- Tri-axial acceleration means and standard deviations (frequency domain),
units: standard gravity units 'g'
  - *fBodyAccmeanX*
  - *fBodyAccmeanY*
  - *fBodyAccmeanZ*
  - *fBodyAccstdX*
  - *fBodyAccstdY*
  - *fBodyAccstdZ*
- Tri-axial body jerk means and standard deviations (frequency domain),
units: standard gravity unit 'g' per second
  - *fBodyAccJerkmeanX*
  - *fBodyAccJerkmeanY*
  - *fBodyAccJerkmeanZ*
  - *fBodyAccJerkstdX*
  - *fBodyAccJerkstdY*
  - *fBodyAccJerkstdZ*
- Tri-axial body angular velocity means and standard deviations (frequency domain),
units: radians per second
  - *fBodyGyromeanX*
  - *fBodyGyromeanY*
  - *fBodyGyromeanZ*
  - *fBodyGyrostdX*
  - *fBodyGyrostdY*
  - *fBodyGyrostdZ*
- Means and standard deviations of the magnitudes
of the aforementioned 3-dimensional signals in the frequency domain (Euclidean norm):
  - *fBodyAccMagmean*, units: g
  - *fBodyAccMagstd*, units: g
  - *fBodyBodyAccJerkMagmean*, units: g/s
  - *fBodyBodyAccJerkMagstd*, units: g/s
  - *fBodyBodyGyroMagmean*, units: rad/s
  - *fBodyBodyGyroMagstd*, units: rad/s
  - *fBodyBodyGyroJerkMagmean*, units: rad/s^3
  - *fBodyBodyGyroJerkMagstd*, units: rad/s^3

__References__

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012  
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
