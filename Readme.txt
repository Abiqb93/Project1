#How Project Works?

1. Reads the train data from subject_train.txt, X_train.txt, y_train.txt into seperate variables
1. Reads the test data from subject_test.txt, X_test.txt, y_test.txt into seperate variables
1. Merges all the columns (train and test cases) and all the rows (train and test cases) in to a single variable
1. Assigns the column names to variable, by reading them from the file named "features.txt"
1. Extracts the data for mean and standard deviation and stores it into another single variable
1. Reads the activity names from file and factorize the existing activity variable with those names
1. Makes the names more descriptive by replacing a few symbols and adapting a specific format for all the variables
1. Groups the data based on subject and activities. For this the dplyr package is employed. 