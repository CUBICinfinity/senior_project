#####
# Setup

# Installing Keras in R is not always as easy as it's supposed to be.
# I followed much of this guide in getting it to work for myself:
# http://rstudio-pubs-static.s3.amazonaws.com/415380_56d75ae905a7418ca07f0040e0cbd70e.html

# To save time, avoid issues by updating these packages first:
install.packages(c("ps", "Rcpp", "digest", "processx", "devtools"))

# Install TensorFlow
devtools::install_github("rstudio/tensorflow")
tensorflow::install_tensorflow() # Use gpu=TRUE if using GPU

# Verify installation
library(tensorflow)
tensorflow::tf_config()

# Install Keras
devtools::install_github("rstudio/keras")
# If you update other packages when prompted and one of them fails, 
# perform `install.packages('package_name')` separately, 
# then run `devtools::install_github("rstudio/keras")` again.

# Let it install miniconda.


#####
library(keras)
library(tidyverse)
library(caret)

# Fake data
y <- seq(0, 30*pi, pi/7.1)
df <- data.frame(x1 = sin(y), 
                 x2 = sin(y + (pi/4)), 
                 y = (y + rnorm(length(y), 0, pi/30)) %% (2*pi))

# What it looks like
df %>% 
  ggplot(aes(x = y, y = x1)) +
  geom_point(color = 'red', alpha = 0.5) +
  geom_point(aes(y = x2), color = 'blue', alpha = 0.5) +
  labs(y = 'x1 in red, x2 in blue')

# Add trigonometric transformation to target value
df <- df %>% 
  mutate(cos_y = cos(y), 
         sin_y = sin(y))

# Train-test split
train_rows <- sample(1:nrow(df), nrow(df)*0.8, replace = F)
train <- df[train_rows, ]
test <- df[-train_rows, ]

#####
# Build model

inputs <- layer_input(shape = c(2))
outputs <- inputs %>% 
  layer_dense(8, activation = 'elu') %>% 
  layer_dense(4, activation = 'elu') %>% 
  layer_dense(2, activation = 'linear')

model <- keras_model(inputs = inputs, outputs = outputs)
model %>% compile(
  optimizer = 'adam',
  loss = 'mean_absolute_error',
  metrics = c('mean_squared_error'))

model %>% fit(
  as.matrix(train[1:2]), 
  as.matrix(train[4:5]), 
  validation_data = list(
    as.matrix(test[1:2]), as.matrix(test[4:5])), 
  epochs = 2000,
  callbacks = list(
    callback_early_stopping(
      monitor = 'val_loss',
      mode = 'min',
      patience = 150)))

# Test model
y_pred <- as.data.frame(model %>% predict(as.matrix(test[1:2])))
print("MLP results:")
print(paste("MAE for cos(y) and sin(y) =", mean(abs(as.matrix(test[4:5] - y_pred)))))

real_y_pred = atan2(y_pred[,2], y_pred[,1]) %% (2*pi)
errors <- abs(test$y - real_y_pred)
# Correct for predictions near 2pi
errors <- if_else(errors > pi, abs(errors - 2*pi), errors)
print(paste("MAE for y =", mean(errors)))

# Compare to a very simple model
knn_model <- knnreg(train[1:2], as.matrix(train[4:5]), k = 2)
knn_pred <- predict(knn_model, as.data.frame(test[1:2]))

print("\nKNN results:")
print("MAE for cos(y) and sin(y) =", mean(abs(test$y - knn_pred)))
real_knn_pred = atan2(knn_pred[,2], knn_pred[,1]) %% (2*pi)
errors <- abs(test$y - real_knn_pred)
# Correct for predictions near 2pi
errors <- if_else(errors > pi, abs(errors - 2*pi), errors)
print("MAE for y =", mean(errors))
