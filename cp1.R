library(caret)

set.seed(9988)

train_path <- "pml-training.csv"
test_path <- "pml-testing.csv"

training <- read.csv(train_path, na.strings = c("NA", ""))
testing <- read.csv(test_path, na.strings = c("NA", ""))

inTrain <- createDataPartition(y = training$classe, p = 0.6, list = FALSE)
training_data <- training[inTrain, ]
testing_data <- training[-inTrain, ]
dim(training_data)
dim(testing_data)

nzv <- nearZeroVar(training_data, saveMetrics = TRUE)

training_data <- training_data[, -nzv]
testing_data <- testing_data[, -nzv]




