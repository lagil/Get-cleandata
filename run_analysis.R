##Projecto getting and cleaning data.

##Definicion de Variables de ambiente para trabajo.
pathtrain <- "./data/UCI HAR Dataset/train"
pathtest <- "./data/UCI HAR Dataset/test"
rootpath <- getwd()

##Configura ambiente de trabajo para lectura de testdata
setwd(pathtest)

##Lectura de test data
test_df <- read.table("X_test.txt", head = FALSE)
test_dfy <- read.table("y_test.txt", head = FALSE)
test_dfsubject <- read.table("subject_test.txt", head = FALSE)

##Regreso a ambiente inicial
setwd(rootpath)

##Configura ambiente de trabajo para lectura de traindata
setwd(pathtrain)

##Lectura de train data
train_df <- read.table("X_train.txt", header = FALSE)
train_dfy <- read.table("y_train.txt", header = FALSE)
train_dfsubject <- read.table("subject_train.txt", header = FALSE)


##test_data <- mutate(test_dfy, NV1 = test_dfsubject$V1)
##test_df1 <- mutate(test_df, NVtest1 = test_data$V1, NVtest2 = test_data$NV1)

setwd(rootpath)

## Lectura de informacion general para el dataset saliente
activitylabesl_df <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE)
features_df <- read.table("./data/UCI HAR Dataset/features.txt", header = FALSE)

##pregunta 1
##Merges the training and the test sets to create one data set

dssub <- rbind(train_dfsubject, test_dfsubject)
dsacti <- rbind(train_dfy, test_dfy)
dsfeatur <- rbind(train_df, test_df)


names(dssub) <- c("subject")
names(dsacti) <- c("activityid")
names(dsfeatur) <- features_df$V2

datatempo <- cbind(dssub, dsacti)
one_data_set <- cbind(datatempo, dsfeatur)

##pregunta 2
##Extracts only the measurements on the mean and standard deviation for
##each measurement

##Busca subset que diga mean() y std()
extract_features <- grepl("mean\\(\\)|std\\(\\)", names(one_data_set))
extracts_only <- one_data_set[,extract_features]

##pregunta 3
##Uses descriptive activity names to name the activities in the data set

one_data_set[,2] <- activitylabesl_df[one_data_set[,2],2]

##pregunta 4
##Appropriately labels the data set with descriptive variable names.



##pregunta 5
##From the data set in step 4, creates a second, independent tidy data set
##with the average of each variable for each activity and each subject.

independent_tds <- ddply(one_data_set, c("subject","activityid"), mean)
write.table(independent_tds,file="./data/newtidy.txt", row.names = FALSE)

