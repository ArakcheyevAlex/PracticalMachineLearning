library(caret)

set.seed(9988)

train_path <- "pml-training.csv"
test_path <- "pml-testing.csv"

f_train <- read.csv(train_path, na.strings = c("NA", ""))
f_test <- read.csv(test_path, na.strings = c("NA", ""))

inTrain <- createDataPartition(y = f_train$classe, p = 0.75, list = FALSE)
p_train <- f_train[inTrain, ]
p_test <- f_train[-inTrain, ]
dim(p_train)
dim(p_test)

nzv <- nearZeroVar(p_train)
p_train <- p_train[, -nzv]
p_test <- p_test[, -nzv]

NA_mark <- sapply(p_train, function(x) mean(is.na(x))) > 0.95
p_train <- p_train[, NA_mark == FALSE]
p_test <- p_test[, NA_mark == FALSE]

p_train <- p_train[, -(1:5)]
p_test <- p_test[, -(1:5)]

fitControl <- trainControl(method = "cv", number = 3, verboseIter = FALSE)
modRF1 <- train(classe ~ ., data = p_train, method = "rf", trControl = fitControl)
modRF1$finalModel

modRF1$xlevels

predictions <- predict(modRF1, p_test)
confusionMatrix(p_test$classe, predictions)

## real test
nzv <- nearZeroVar(training)
f_train <- f_train[, -nzv]
f_test <- f_test[, -nzv]
dim(f_train)
dim(f_test)

NA_mark <- sapply(f_train, function(x) mean(is.na(x))) > 0.95
f_train <- f_train[, NA_mark == FALSE]
f_test <- f_test[, NA_mark == FALSE]
f_train <- f_train[, -(1:5)]
f_test <- f_test[, -(1:5)]

modRF2 <- train(classe ~ ., data = f_train, method = "rf", trControl = fitControl)
modRF2$finalModel
predictions <- predict(modRF2, f_test)

predictions
