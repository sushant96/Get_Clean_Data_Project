# Read the files placed under directory "/Users/tcs/ds/UCI HAR Dataset" on my machine

xtest = read.table('/Users/tcs/ds/UCI HAR Dataset/test/X_test.txt', header = FALSE)
# dim(xtest) is 2947 561

xtrain = read.table('/Users/tcs/ds/UCI HAR Dataset/train/X_train.txt', header = FALSE)
# dim(xtest) is 7352 561

ytest = read.table('/Users/tcs/ds/UCI HAR Dataset/test/Y_test.txt', header = FALSE)
# dim(ytest) is 2947 1

ytrain = read.table('/Users/tcs/ds/UCI HAR Dataset/train/Y_train.txt', header = FALSE)
# dim(ytrain) is 7352 1

feature = read.table('/Users/tcs/ds/UCI HAR Dataset/features.txt', header = FALSE)
#dim(feature) is 561 2

sub_test = read.table('/Users/tcs/ds/UCI HAR Dataset/test/subject_test.txt', header = FALSE)
#dim(sub_test) is 2947 1

sub_train = read.table('/Users/tcs/ds/UCI HAR Dataset/train/subject_train.txt', header = FALSE)
#dim(sub_train) is 7352 1

activity = read.table('/Users/tcs/ds/UCI HAR Dataset/activity_labels.txt', header = FALSE)
#dim(activity) is 6 2


# Combine the file based on dim values
xx <- rbind(xtest,xtrain)
yy <- rbind(ytest,ytrain)
sub <- rbind(sub_test,sub_train)
#dim(sub) is 10299 1

# Create data frame that merges the test and train data 
xxyy <- data.frame(xx,sub,yy)
#dim(xxyy) is 10299 563

# Read column headers from features and add two columns as "Subject" and "Activity"
features <- as.character(feature[,2])
colnames(xxyy) <- c(features,"Subject","Activity")

# data_set is the output for Step 1 as given in the project
data_set <- xxyy
#dim(data_set) is 10299 563

# Load dplyr and create mean_sd as the output for Step 2 as given in the project
# Considering all column which ends with "mean()" and "std()" anywhere in the string
library(dplyr)
mean_sd <- select(data_set,ends_with("mean()"),ends_with("std()"),contains("Subject"),contains("Activity"))
#dim(mean_sd) is 10299 20

# Load dplyr and create mean_sd_act as the output for Step 3 as given in the project
library(plyr)

#Replace activity numbers with details using mapvalues function 
act = mapvalues(mean_sd$Activity,c(1,2,3,4,5,6),c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))

mean_sd_act <- select(mean_sd,-contains("Activity")) %>% mutate( "Activity" = act)

# Labels the data set with descriptive variable name for Step 4 as given in the project

names(mean_sd_act) <- gsub("tBody", "TimeBody", names(mean_sd_act))
names(mean_sd_act) <- gsub("tGravity", "TimeGravity", names(mean_sd_act))
names(mean_sd_act) <- gsub("fBody", "FrequencyBody", names(mean_sd_act))
names(mean_sd_act) <- gsub("-mean", "Mean", names(mean_sd_act))
names(mean_sd_act) <- gsub("-std", "Std", names(mean_sd_act))

# Create independent tidy data set cdata for Step 5 as given in the project
  
cdata <- ddply(mean_sd_act,.(Subject,Activity),numcolwise(mean))
