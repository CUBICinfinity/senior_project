# Computing distances between points

# Set points
n_points <- 12
min_val <- -1
max_val <- 1
val_range <- max_val - min_val

points <- data.frame(X1= runif(n_points, min_val, max_val), 
                     X2= runif(n_points, min_val, max_val), 
                     X3= runif(n_points, min_val, max_val), 
                     X4= runif(n_points, min_val, max_val), 
                     X5= runif(n_points, min_val, max_val), 
                     X6= runif(n_points, min_val, max_val))

#~~~~
# Typical Distance matrix
dist(points, diag = T, upper = T)

#~~~~
# If variables are cyclical

## Initialize distance matrix
distances <- dist(rep(0, n_points), diag = T, upper = T)

for (column in points){
  col_dist <- dist(column, diag = T, upper = T)
  
  ## Replace values greater than half the possible distance 
  ## with the remaining distance
  col_dist[which(col_dist > val_range/2)] <- 
    abs(val_range - col_dist[which(col_dist > val_range/2)])
  
  ## Increment distance^2
  distances <- distances + col_dist^2
}

## Complete distance formula by taking square root
(distances <- sqrt(distances))

#~~~~
# If only some variables are cyclical

# Is column cyclical?
cyclical <- c(F, T, T, F, F, F)

## Initialize distance matrix
distances <- dist(rep(0, n_points), diag = T, upper = T)

i <- 1
for (column in points){
  col_dist <- dist(column, diag = T, upper = T)
  
  if (cyclical[i]) {
    ## Replace values greater than half the possible distance 
    ## with the remaining distance
    col_dist[which(col_dist > val_range/2)] <- 
      abs(val_range - col_dist[which(col_dist > val_range/2)])
  }
  
  ## Increment distance^2
  distances <- distances + col_dist^2
  
  i <- i + 1
}
## Complete distance formula by taking square root
(distances <- sqrt(distances))
