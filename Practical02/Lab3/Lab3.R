# ============================================
# Practical 2 - Lab 3
# Control Flow for Data Cleaning
# ============================================

# --------------------------------------------
# 1. Import Dataset
# --------------------------------------------

column_names <- c(
  "age", "sex", "cp", "trestbps", "chol",
  "fbs", "restecg", "thalach", "exang",
  "oldpeak", "slope", "ca", "thal", "target"
)

heart_data <- read.csv(
  "processed.cleveland.data",
  header = FALSE,
  na.strings = "?"
)

names(heart_data) <- column_names

head(heart_data)
str(heart_data)

cat("Rows:", nrow(heart_data), "\n")
cat("Columns:", ncol(heart_data), "\n")


# --------------------------------------------
# 2. Introduce Invalid BP Values
# --------------------------------------------

heart_data_cleaning <- heart_data

heart_data_cleaning$trestbps[c(5, 15, 25)] <- -120
heart_data_cleaning$trestbps[c(35, 45, 55)] <- NA
heart_data_cleaning$trestbps[c(65, 75, 85)] <- 350

cat(
  "Negative BP values:",
  sum(heart_data_cleaning$trestbps < 0, na.rm = TRUE),
  "\n"
)

cat(
  "Missing BP values:",
  sum(is.na(heart_data_cleaning$trestbps)),
  "\n"
)

cat(
  "BP values greater than 300:",
  sum(heart_data_cleaning$trestbps > 300, na.rm = TRUE),
  "\n"
)


# --------------------------------------------
# 3. BP Cleaning Function
# --------------------------------------------

clean_bp <- function(bp, median_bp)
{
  if(is.na(bp))
  {
    return(median_bp)
  }
  else if(bp < 0)
  {
    return(median_bp)
  }
  else if(bp > 300)
  {
    return(median_bp)
  }
  else
  {
    return(bp)
  }
}

median_bp <- median(
  heart_data_cleaning$trestbps,
  na.rm = TRUE
)

cat("Median BP:", median_bp, "\n")


# Test function

cat("NA test:", clean_bp(NA, median_bp), "\n")
cat("Negative test:", clean_bp(-120, median_bp), "\n")
cat("Extreme test:", clean_bp(350, median_bp), "\n")
cat("Valid test:", clean_bp(145, median_bp), "\n")


# --------------------------------------------
# 4. Loop-Based Cleaning
# --------------------------------------------

heart_data_loop <- heart_data_cleaning

loop_time <- system.time({
  
  for(i in 1:nrow(heart_data_loop))
  {
    heart_data_loop$trestbps[i] <-
      clean_bp(
        heart_data_loop$trestbps[i],
        median_bp
      )
  }
  
})

cat(
  "Negative BP after loop cleaning:",
  sum(heart_data_loop$trestbps < 0, na.rm = TRUE),
  "\n"
)

cat(
  "Missing BP after loop cleaning:",
  sum(is.na(heart_data_loop$trestbps)),
  "\n"
)

cat(
  "BP values > 300 after loop cleaning:",
  sum(heart_data_loop$trestbps > 300, na.rm = TRUE),
  "\n"
)


# --------------------------------------------
# 5. Vectorized Cleaning
# --------------------------------------------

heart_data_vectorized <- heart_data_cleaning

vectorized_time <- system.time({
  
  invalid_bp <- is.na(heart_data_vectorized$trestbps) |
    heart_data_vectorized$trestbps < 0 |
    heart_data_vectorized$trestbps > 300
  
  heart_data_vectorized$trestbps[invalid_bp] <- median_bp
  
})

cat(
  "Negative BP after vectorized cleaning:",
  sum(heart_data_vectorized$trestbps < 0, na.rm = TRUE),
  "\n"
)

cat(
  "Missing BP after vectorized cleaning:",
  sum(is.na(heart_data_vectorized$trestbps)),
  "\n"
)

cat(
  "BP values > 300 after vectorized cleaning:",
  sum(heart_data_vectorized$trestbps > 300, na.rm = TRUE),
  "\n"
)


# --------------------------------------------
# 6. Performance Comparison
# --------------------------------------------

cat("\nLoop Execution Time:\n")
print(loop_time)

cat("\nVectorized Execution Time:\n")
print(vectorized_time)


# --------------------------------------------
# 7. Error Handling using tryCatch()
# --------------------------------------------

safe_calculation <- function(expression)
{
  tryCatch(
    {
      result <- expression
      
      if(length(result) == 0 ||
         all(is.na(result)) ||
         any(!is.finite(result)))
      {
        stop(
          "Calculation resulted in NA, Inf, -Inf, or empty value."
        )
      }
      
      return(result)
    },
    
    error = function(e)
    {
      cat("Error:", e$message, "\n")
      return(NA)
    }
  )
}


# Mean BP

mean_bp <- safe_calculation(
  mean(
    heart_data_vectorized$trestbps,
    na.rm = TRUE
  )
)

cat("Mean BP:", mean_bp, "\n")


# Cholesterol / BP

chol_ratio <- safe_calculation(
  heart_data_vectorized$chol /
    heart_data_vectorized$trestbps
)

cat("First 10 Cholesterol/BP ratios:\n")
print(head(chol_ratio, 10))


# Invalid calculations

safe_calculation(200 / 0)
safe_calculation(0 / 0)


# --------------------------------------------
# 8. Final Validation
# --------------------------------------------

cat("\n===== Final BP Validation =====\n")

cat(
  "Missing BP values:",
  sum(is.na(heart_data_vectorized$trestbps)),
  "\n"
)

cat(
  "Minimum BP:",
  min(heart_data_vectorized$trestbps, na.rm = TRUE),
  "\n"
)

cat(
  "Maximum BP:",
  max(heart_data_vectorized$trestbps, na.rm = TRUE),
  "\n"
)

cat(
  "Mean BP:",
  mean(heart_data_vectorized$trestbps, na.rm = TRUE),
  "\n"
)

cat(
  "Median BP:",
  median(heart_data_vectorized$trestbps, na.rm = TRUE),
  "\n"
)

cat(
  "Negative BP values:",
  sum(heart_data_vectorized$trestbps < 0, na.rm = TRUE),
  "\n"
)

cat(
  "BP values > 250:",
  sum(heart_data_vectorized$trestbps > 250, na.rm = TRUE),
  "\n"
)


# --------------------------------------------
# 9. Export Cleaned Dataset
# --------------------------------------------

write.csv(
  heart_data_vectorized,
  "cleaned_heart_data.csv",
  row.names = FALSE
)

cat("Cleaned dataset exported successfully.\n")