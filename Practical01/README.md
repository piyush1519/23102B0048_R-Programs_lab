# Practical 1 - Air Quality Data Cleaning Using R

## Objective

To perform data cleaning and preprocessing on the Beijing Multi-Site Air Quality dataset using R. The practical focuses on identifying, analyzing, and handling missing values while implementing reusable functions and error handling.

## Dataset

**Beijing Multi-Site Air Quality Dataset**

File Used:

- PRSA_Data_Aotizhongxin_20130301-20170228.csv

## Concepts Covered

- Importing CSV files
- Data inspection
- Handling NA, NULL and NaN
- User-defined functions
- Missing value analysis
- Median imputation
- Mode imputation
- Looping through variables
- Error handling using tryCatch()
- Data visualization
- Exporting cleaned datasets

## Tasks Performed

- Imported and inspected the dataset
- Demonstrated NA, NULL and NaN
- Created a `missing_summary()` function
- Identified invalid numerical values
- Replaced missing numerical values using median
- Replaced missing categorical values using mode
- Implemented error handling using `tryCatch()`
- Generated a comparison table
- Created a bar chart for missing values
- Exported the cleaned dataset as CSV

## Folder Structure

```
Practical01/
│
├── Practical01.R
├── Practical01.Rproj
├── cleaned_air_quality_data.csv
├── PRSA_Data_Aotizhongxin_20130301-20170228.csv
└── README.md
```
## Output Visualization

![Missing Values Graph](images/missing-values-graph.png)
## Output

- Cleaned Air Quality Dataset
- Comparison Table
- Missing Value Visualization
- Exported CSV File

## Technologies Used

- R
- RStudio

## Author

**Sarthak Chaudhari**

Semester 7 – R Programming Practical
