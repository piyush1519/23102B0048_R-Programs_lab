# ============================================
# Practical 2 - Lab 4
# Advanced Missing Data Handling
# ============================================

# --------------------------------------------
# 1. Import Adult Dataset
# --------------------------------------------

column_names <- c(
  "age",
  "workclass",
  "fnlwgt",
  "education",
  "education_num",
  "marital_status",
  "occupation",
  "relationship",
  "race",
  "sex",
  "capital_gain",
  "capital_loss",
  "hours_per_week",
  "native_country",
  "income"
)

adult_data <- read.csv(
  "adult.data",
  header = FALSE,
  na.strings = "?",
  strip.white = TRUE
)

names(adult_data) <- column_names

head(adult_data)
str(adult_data)
cat("Rows:", nrow(adult_data), "\n")
cat("Columns:", ncol(adult_data), "\n")

cat(
  "Total Missing Values:",
  sum(is.na(adult_data)),
  "\n"
)

cat("Missing workclass:", sum(is.na(adult_data$workclass)), "\n")

cat("Missing occupation:", sum(is.na(adult_data$occupation)), "\n")

cat("Missing native_country:", sum(is.na(adult_data$native_country)), "\n")

# ============================================
# Task 1: Missing Data Types
# ============================================

# NA example
temperature <- c(28, 30, NA, 32)

cat("Temperature vector:\n")
print(temperature)

cat("Is third value NA?",
    is.na(temperature[3]),
    "\n")

# NULL example
missing_object <- NULL

cat("Is object NULL?",
    is.null(missing_object),
    "\n")

# NaN example
undefined_value <- 0 / 0

print(undefined_value)

cat("Is value NaN?",
    is.nan(undefined_value),
    "\n")

# Blank string example
blank_value <- ""

cat("Is value blank?",
    blank_value == "",
    "\n")

# ============================================
# Task 2: Introduce Missing and Invalid Values
# ============================================

adult_cleaning <- adult_data
adult_cleaning$age[c(100, 200, 300)] <- NA
adult_cleaning$hours_per_week[c(400, 500)] <- NaN
adult_cleaning$workclass[c(600, 700, 800)] <- ""
adult_cleaning$occupation[c(900, 1000)] <- ""
adult_cleaning$age[c(1100, 1200)] <- 999

cat(
  "NA values in age:",
  sum(is.na(adult_cleaning$age)),
  "\n"
)

cat(
  "NaN values in hours_per_week:",
  sum(is.nan(adult_cleaning$hours_per_week)),
  "\n"
)

cat(
  "Blank workclass values:",
  sum(adult_cleaning$workclass == "", na.rm = TRUE),
  "\n"
)

cat(
  "Blank occupation values:",
  sum(adult_cleaning$occupation == "", na.rm = TRUE),
  "\n"
)

cat(
  "Impossible age values:",
  sum(adult_cleaning$age == 999, na.rm = TRUE),
  "\n"
)

# ============================================
# Task 3: Variable-wise Missing Value Summary
# ============================================

missing_summary <- data.frame(
  Variable = names(adult_cleaning),
  Missing_Values = sapply(adult_cleaning, function(x) sum(is.na(x))),
  Missing_Percentage = round(
    sapply(adult_cleaning, function(x) mean(is.na(x)) * 100),
    2
  )
)

print(missing_summary)

missing_summary

# ============================================
# Task 3: Missing Value Summary using naniar
# ============================================

library(naniar)

naniar_summary <- miss_var_summary(adult_cleaning)

print(naniar_summary)

#write.csv(
 # naniar_summary,
  #"missing_summary.csv",
  #row.names = FALSE
#)

# ============================================
# Task 4: Data Cleaning
# ============================================

# Replace impossible age values with NA
adult_cleaning$age[adult_cleaning$age == 999] <- NA

cat(
  "Age values equal to 999 after cleaning:",
  sum(adult_cleaning$age == 999, na.rm = TRUE),
  "\n"
)

# Replace blank categorical values
# Handle missing categorical values

adult_cleaning$workclass[
  is.na(adult_cleaning$workclass)
] <- "Unknown"

adult_cleaning$occupation[
  is.na(adult_cleaning$occupation)
] <- "Unknown"

adult_cleaning$native_country[
  is.na(adult_cleaning$native_country)
] <- "Unknown"

cat(
  "Missing workclass:",
  sum(is.na(adult_cleaning$workclass)),
  "\n"
)

cat(
  "Missing occupation:",
  sum(is.na(adult_cleaning$occupation)),
  "\n"
)

cat(
  "Missing native_country:",
  sum(is.na(adult_cleaning$native_country)),
  "\n"
)

# ============================================
# Task 5: Custom Median Imputation Function
# ============================================

median_impute <- function(x)
{
  median_value <- median(x, na.rm = TRUE)
  
  x[is.na(x) | is.nan(x)] <- median_value
  
  return(x)
}

adult_cleaning$age <- median_impute(
  adult_cleaning$age
)

adult_cleaning$hours_per_week <- median_impute(
  adult_cleaning$hours_per_week
)

cat(
  "Missing age:",
  sum(is.na(adult_cleaning$age)),
  "\n"
)

cat(
  "NaN age:",
  sum(is.nan(adult_cleaning$age)),
  "\n"
)

cat(
  "Missing hours_per_week:",
  sum(is.na(adult_cleaning$hours_per_week)),
  "\n"
)

cat(
  "NaN hours_per_week:",
  sum(is.nan(adult_cleaning$hours_per_week)),
  "\n"
)

# ============================================
# Task 6: Complete Cases Comparison
# ============================================

adult_before <- adult_data

# Introduce the same invalid/missing values
adult_before$age[c(100, 200, 300)] <- NA

adult_before$hours_per_week[c(400, 500)] <- NaN

adult_before$workclass[c(600, 700, 800)] <- ""

adult_before$occupation[c(900, 1000)] <- ""

adult_before$age[c(1100, 1200)] <- 999

complete_before <- sum(complete.cases(adult_before))

incomplete_before <- sum(!complete.cases(adult_before))

cat("Complete cases BEFORE cleaning:", complete_before, "\n")
cat("Incomplete cases BEFORE cleaning:", incomplete_before, "\n")

adult_after <- adult_before

# Impossible age
adult_after$age[
  adult_after$age == 999
] <- NA

# Blank categorical values
adult_after$workclass[
  adult_after$workclass == ""
] <- "Unknown"

adult_after$occupation[
  adult_after$occupation == ""
] <- "Unknown"

# Existing categorical NA values
adult_after$workclass[
  is.na(adult_after$workclass)
] <- "Unknown"

adult_after$occupation[
  is.na(adult_after$occupation)
] <- "Unknown"

adult_after$native_country[
  is.na(adult_after$native_country)
] <- "Unknown"

# Numeric median imputation
adult_after$age <- median_impute(adult_after$age)

adult_after$hours_per_week <- median_impute(
  adult_after$hours_per_week
)

complete_after <- sum(complete.cases(adult_after))

incomplete_after <- sum(!complete.cases(adult_after))

cat("Complete cases AFTER cleaning:", complete_after, "\n")
cat("Incomplete cases AFTER cleaning:", incomplete_after, "\n")

# ============================================
# Task 7: Before/After Missing Value Summary
# ============================================

missing_before <- sum(is.na(adult_before))

missing_after <- sum(is.na(adult_after))

cat("Total missing values BEFORE cleaning:",
    missing_before, "\n")

cat("Total missing values AFTER cleaning:",
    missing_after, "\n")

cat(
  "Missing percentage BEFORE cleaning:",
  round(
    missing_before / (nrow(adult_before) * ncol(adult_before)) * 100,
    2
  ),
  "%\n"
)

cat(
  "Missing percentage AFTER cleaning:",
  round(
    missing_after / (nrow(adult_after) * ncol(adult_after)) * 100,
    2
  ),
  "%\n"
)

# ============================================
# Task 8: Missingness Visualization
# ============================================

library(naniar)

# Before cleaning
vis_miss(adult_before)

png(
  filename = file.path(getwd(), "missingness_before.png"),
  width = 1600,
  height = 1000,
  res = 150
)

print(naniar::vis_miss(adult_before))

dev.off()
png(
  filename = file.path(getwd(), "missingness_after.png"),
  width = 1600,
  height = 1000,
  res = 150
)

print(naniar::vis_miss(adult_after))

dev.off()


# ============================================
# Final Validation
# ============================================

cat("Final Missing Values:",
    sum(is.na(adult_after)), "\n")

cat("Final Rows:",
    nrow(adult_after), "\n")

cat("Final Columns:",
    ncol(adult_after), "\n")

str(adult_after)

write.csv(
  adult_after,
  "cleaned_adult_data.csv",
  row.names = FALSE
)

cat("Cleaned dataset exported successfully.\n")