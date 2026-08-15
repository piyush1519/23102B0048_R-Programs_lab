# Practical 2 – Data Cleaning and Missing Data Handling

## Objective

To perform data cleaning and advanced missing data handling in R using real-world datasets.

## Lab 3 – Heart Disease Data Cleaning

### Dataset

Cleveland Heart Disease Dataset

### Tasks Performed

- Imported and inspected the dataset.
- Examined the structure and dimensions of the data.
- Identified invalid and missing blood pressure values.
- Detected negative, missing, and extreme blood pressure values.
- Calculated the median blood pressure.
- Replaced invalid and missing blood pressure values using the median.
- Performed vectorized data cleaning.
- Performed final validation of the cleaned data.

### Final Validation

| Metric | Result |
|---|---:|
| Missing BP values | 0 |
| Negative BP values | 0 |
| Minimum BP | 94 |
| Maximum BP | 200 |
| Mean BP | 131.6832 |
| Median BP | 130 |

### Files

- `Lab3/Lab3.R` – R implementation
- `Lab3/processed.cleveland.data` – Original dataset
- `Lab3/cleaned_heart_data.csv` – Cleaned dataset

## Lab 4 – Advanced Missing Data Handling

### Dataset

UCI Adult Income Dataset

### Tasks Performed

- Imported and inspected the Adult dataset.
- Assigned column names to the dataset.
- Demonstrated `NA`, `NULL`, `NaN`, and blank strings.
- Introduced missing and invalid values for testing.
- Generated variable-wise missing-value summaries.
- Used the `naniar` package for missing-value analysis.
- Detected and corrected impossible age values (`999`).
- Replaced blank categorical values with `"Unknown"`.
- Handled missing categorical values.
- Created a custom median-imputation function.
- Replaced missing and `NaN` numeric values using median imputation.
- Compared complete cases before and after cleaning.
- Visualized missingness before and after cleaning.
- Exported the cleaned dataset.

### Missing Data Results

| Metric | Before Cleaning | After Cleaning |
|---|---:|---:|
| Total Missing Values | 4267 | 0 |
| Missing Percentage | 0.87% | 0% |
| Complete Cases | 30158 | 32561 |
| Incomplete Cases | 2403 | 0 |

### Files

- `Lab4/Lab4.R` – R implementation
- `Lab4/adult.data` – Original dataset
- `Lab4/cleaned_adult_data.csv` – Cleaned dataset
- `Lab4/missing_summary.csv` – Missing-value summary
- `Lab4/missingness_before.png` – Missingness before cleaning
- `Lab4/missingness_after.png` – Missingness after cleaning

## Tools Used

- R
- RStudio
- `naniar`
- Git
- GitHub

## Key Concepts

- Data inspection
- Missing-value detection
- `NA`, `NULL`, `NaN`, and blank values
- Invalid-value detection
- Median imputation
- Categorical missing-value handling
- `complete.cases()`
- Missingness visualization
- Data validation
- CSV export
