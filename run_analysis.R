rm(list = ls())
library(dplyr)
#..........................................................................................#
# Reading the train data
data_train_sub <- read.table("train\\subject_train.txt")
data_train_X <- read.table("train\\X_train.txt")
data_train_Y <- read.table("train\\y_train.txt")
#..........................................................................................#

#..........................................................................................#
#Reading the test data
data_test_sub <- read.table("test\\subject_test.txt")
data_test_X <- read.table("test\\X_test.txt")
data_test_Y <- read.table("test\\y_test.txt")
#..........................................................................................#

#..........................................................................................#
#Merge two data sets to a single one
data1 <- cbind(data_train_sub, data_train_X, data_train_Y)       #Binding train data into columns
data2 <- cbind(data_test_sub, data_test_X, data_test_Y)          #Binding test data into columns
data_merged <- rbind(data1, data2)                               #Merging all the data
#..........................................................................................#

#..........................................................................................#
#Assigning variable names from the text file names "features"
feature_names <- read.table("features.txt", as.is = TRUE)
colnames(data_merged) <- c("subject",feature_names[,2], "activity")
#..........................................................................................#

#..........................................................................................#
#Extracting Data for mean, standard deviation and rest of the two columns that we appended earlier
Ext_Data <- data_merged[grepl("mean|std|subject|activity", colnames(data_merged))]

#..........................................................................................#

#..........................................................................................#
#Reading activity names
act_names <- read.table("activity_labels.txt", as.is = TRUE)
Ext_Data$activity <- factor(Ext_Data$activity, levels = c(1,2,3,4,5,6), labels = act_names[,2])

#..........................................................................................#

#..........................................................................................#
#Assigning Descriptive Names
var_names <- gsub("-", "", colnames(Ext_Data))
var_names <- gsub("\\(\\)", "", var_names)
var_names <- gsub("^f", "Frequency",var_names)
var_names <- gsub("^t", "Time",var_names)
var_names <- gsub("[Bb]ody", "Body",var_names)
var_names <- gsub("[Aa]cc", "Accelerometer",var_names)
var_names <- gsub("[Mm]ean", "Mean",var_names)
var_names <- gsub("[Ss]td", "StandardDeviation",var_names)
var_names <- gsub("[Mm]ax", "LargestValue",var_names)
var_names <- gsub("[Mm]in", "SmallestValue",var_names)
var_names <- gsub("[Mm]ad", "MedianAbsoluteDeviation",var_names)
var_names <- gsub("[Ss]ma", "SignalMagnitudeArea",var_names)
var_names <- gsub("[Ee]nergy", "EnergyMeasure",var_names)
var_names <- gsub("[Ii]qr", "InterquartileRange",var_names)
var_names <- gsub("[Ee]ntropy", "SignalEntropy",var_names)
var_names <- gsub("[Aa]rCoeff", "AutoregressionCoefficients",var_names)
var_names <- gsub("[Cc]orrelation", "CorrelationCoefficients",var_names)
var_names <- gsub("[In]Inds", "Index",var_names)
var_names <- gsub("[Ff]req", "Frequency",var_names)
var_names <- gsub("[Ss]kewness", "SkewnessOfFrequency",var_names)
var_names <- gsub("[Kk]urtosis", "KutosisOfFrequency",var_names)
var_names <- gsub("[Bb]ands", "EnergyBands",var_names)
var_names <- gsub("[Bb]ody[Bb]ody", "Body",var_names)
colnames(Ext_Data) <- var_names

#..........................................................................................#

#..........................................................................................#
#Now as we need to group the data by activity and by subject
tidy_data <- Ext_Data %>% group_by(subject, activity) %>% summarise_all(funs(mean))
write.table(tidy_data,"Tidy Data.txt")
