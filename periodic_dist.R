# Returns distance matrix ("dist" class) for data points, where some values belong to periodic/cyclical attributes.
# E.g. 23:59 is only one minute away from 00:00, not 23 hours and 59 minutes.

periodic_dist <- function(dat, 
                          ranges = NULL,
                          diag = T, upper = T) {
  # Check arguments
  if (sum(class(dat) %in% c("data.frame", "tbl_df", "tbl")) < 1) {
    stop("\nArgument 'dat' should be a tibble or dataframe.")
  } else {
    # This shouldn't happen, but if I can make the mistake someone else might.
    if (sum(class(dat[[1]]) %in% c("data.frame", "tbl_df", "tbl")) > 0) {
      stop("\nIt appears you supplied a tibble containing a dataframe or tibble.\n",
           "Did you use tibble() instead of as_tibble()? Try nameOfYourData[[1]].")
    }
  }
  if (is.null(ranges)) {
    warning("\nArgument 'ranges' not provided.\n",
        "All columns treated as periodic and set column ranges to lowest and highest values.")
    ranges <- list()
    for (col in dat) {
      # Append vector to list
      ranges <- c(ranges, list(range(col)))
    }
  } else {
    if (class(ranges) != "list") {
      stop(paste("\nProvide argument 'ranges' as a list of vectors and values describing each column.", 
                 "If a column is periodic provide a min and max vector, like c(1, 12) for month, or a single range value (computed by min - max), like 2*pi for angle.", 
                 "If a column is not periodic, provide NA.",
                 "Example: list(c(0,1), c(1,12), 2*pi, NA)", 
                 sep = "\n"))
    }
  }
  
  # Initialize distance matrix
  distances <- dist(rep(0, nrow(dat)), diag = diag, upper = upper)
  
  for (i in 1:length(dat)) {
    col_dist <- dist(dat[i], diag = diag, upper = upper)
    
    if (sum(is.na(ranges[[i]])) < 1) {
      # Replace values greater than half the possible distance 
      # with the remaining distance
      range_val <- ranges[[i]]
      if (length(range_val) > 1) {
        range_val <- range_val[2] - range_val[1]
      }
      too_high <- which(col_dist > range_val/2)
      col_dist[too_high] <- 
        abs(range_val - col_dist[too_high])
    }
    # cat("col_dist", col_dist)
    # Increment distance^2
    distances <- distances + col_dist^2
    # cat("\n", distances)
  }
  # Complete distance formula by taking square root
  return(sqrt(distances))
}