## Summary

This project was completed as the final project for the Practical Machine Learning Class offered by faculty at Johns Hopkins and hosted by Coursera. This project uses accelerometer data (http://groupware.les.inf.puc-rio.br/har) from six participants to try to determine how well they are performing barbell lifts. Four separate accelerometers (mounted to the belt, forearm, arm and dumbell of each participant) collect data as each participant peforms the exercise correctly (classified as A) and incorrectly in four different ways (classified as B-E). This labeled training data is used to fit a model that can predict the quality of future exercises. Based on the accuracy of the validation set (20% of the available data) described below, the expected out of sample error is <1%. Default values for cross-validation within the random forest package are used.

## Methods

All models for this project were developed in R using the random forest method of the caret package. The bulk of this analysis is performed in finalProjectMain.R with calls to plotAccuraciesTime.R and plotConfusion.R for generating plots. The random forest method was chosen due to its high accuracy and ability to handle a large number of features. A random forest is created for each individual, as well as for the entire group. Before training any models, 20% of the data is set aside for a validation set. Varying portions (20%, 40%...100%) of the remaining data are then used to train random forests.

In addition to separating the data into training and validation sets, columns with missing values are also removed from the data, leaving 52 numerical features with which to train. The final models each use 500 trees and have expoted summaries that can be viewed at https://github.com/bryanpeele/PracticalMachineLearning_FinalProject/tree/master/models. The accuracy on the validation set, and the training time, are examined as more data from the training set is used for the model. Finally, using the the entirety of the training data (80% of the full dataset) is used and confusion matrices are plotted for each user. An overall accuracy of 99% is achieved for the validation set.

## Validation Accuracy vs. Training Data Fraction

As shown at https://github.com/bryanpeele/PracticalMachineLearning_FinalProject/blob/master/figures/ValidationAccuracy.png, the accuracy on the validation set increases as more of the training data is sued to fit the model. However, even with only 20% of the data the cummulative model achieves 96.6% accuracy. Using all of the available data, this accuracy increases to 99.2%

This 2.6% increase in accuracy comes at the cost of significantly more computing time (259 minutes rather than 31 minutes). It should be noted that these times only serve as rough estimates. All analysis was performed on the same desktop computer (Processor: AMD FX-4100 Quad-Core 3.60 GHz, RAM: 8GB, OS: Windows 10), but other work was performed on the computer intermittently throughout the process. The time taken to train each model is shown at https://github.com/bryanpeele/PracticalMachineLearning_FinalProject/blob/master/figures/ModelFitTime.png.

## Final Results
Confusion matrices are shown at https://github.com/bryanpeele/PracticalMachineLearning_FinalProject/blob/master/figures/IndividualConfusionMatrix.png using random forest models fit to each individual user. On the vertical axis the actual classes from the labelled validation data are shown. On the horizontal axis, the correspondind frequency of predicted classes is shown.

The figure at https://github.com/bryanpeele/PracticalMachineLearning_FinalProject/blob/master/figures/all%20users%20combinedConfusionMatrix.png shows the confusion matrix for the cummulative model trained collectively on all users at once. For all classes, the validation accuracy is greater than 98%.
