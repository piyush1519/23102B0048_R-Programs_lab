# PBLE 6 – Statistical Analysis of Palmer Penguins

## Aim

To perform statistical analysis on the Palmer Penguins dataset using R, including descriptive statistics, hypothesis testing, ANOVA, non-parametric testing, post-hoc analysis, and data visualization.

## Dataset

**Dataset:** Palmer Penguins Dataset

**R Package:** `palmerpenguins`

The dataset contains measurements of penguins belonging to three species:

- Adelie
- Chinstrap
- Gentoo

Important variables used:

- `species`
- `sex`
- `body_mass_g`
- `flipper_length_mm`

## Software and Libraries Required

### Software

- R
- RStudio

### R Packages

    install.packages("palmerpenguins")
    install.packages("moments")
    install.packages("car")
    install.packages("ggplot2")

Load the libraries:

    library(palmerpenguins)
    library(moments)
    library(car)
    library(ggplot2)

# Practical Tasks

## Task 1 – Descriptive Statistics of Body Mass

Calculate descriptive statistics for `body_mass_g`:

- Mean
- Median
- Minimum
- Maximum
- Variance
- Standard Deviation
- Q1
- Q3
- IQR
- Skewness
- Kurtosis

Calculate the same statistics separately for each penguin species.

### Required Output

The output should contain:

- Overall body-mass descriptive statistics
- Species-wise descriptive statistics for Adelie, Chinstrap, and Gentoo

### Visualizations

Generate:

- Histogram of penguin body mass
- Body mass by species boxplot
- Density plot of penguin body mass

---

## Task 2 – Male vs Female Body Mass

Compare the body mass of male and female penguins.

### Statistical Analysis

Perform:

- Mean body-mass comparison
- Shapiro-Wilk normality test
- QQ plots
- Independent two-sample Welch's t-test
- 95% confidence interval
- Cohen's d effect size

### Required Output

The output should contain:

- Mean body mass of males
- Mean body mass of females
- Shapiro-Wilk test results
- Welch's t-test result
- t-statistic
- Degrees of freedom
- p-value
- 95% confidence interval
- Cohen's d

### Interpretation

The analysis should determine whether there is a statistically significant difference between male and female penguin body mass.

---

## Task 3 – One-Way ANOVA for Body Mass

Perform one-way ANOVA using:

    body_mass_g ~ species

### Statistical Analysis

Perform:

- Species-wise QQ plots
- Shapiro-Wilk normality tests
- Levene's test for equality of variances
- One-way ANOVA
- Tukey HSD post-hoc test

### Required Output

The output should contain:

- ANOVA degrees of freedom
- Sum of squares
- Mean squares
- F-statistic
- p-value
- Tukey HSD pairwise comparisons
- Adjusted p-values

### Interpretation

Determine whether body mass differs significantly among the three penguin species and identify which species pairs differ significantly.

---

## Task 4 – Kruskal-Wallis Test

When ANOVA assumptions are substantially violated, perform the Kruskal-Wallis test using:

    body_mass_g ~ species

### Required Output

The output should contain:

- Chi-squared statistic
- Degrees of freedom
- p-value

### Interpretation

Determine whether there is a statistically significant difference in body mass among penguin species using the non-parametric test.

---

## Task 5 – Two-Way ANOVA

Perform two-way ANOVA using:

    body_mass_g ~ species * sex

### Factors Tested

- Species
- Sex
- Species × Sex interaction

### Required Output

The ANOVA table should contain:

- Degrees of freedom
- Sum of squares
- Mean squares
- F-statistics
- p-values

### Interpretation

Determine:

- Whether species significantly affects body mass
- Whether sex significantly affects body mass
- Whether the effect of sex varies across species

---

## Task 6 – Flipper Length Analysis

Perform statistical analysis on:

    flipper_length_mm

### Descriptive Statistics

Calculate species-wise:

- Mean
- Median
- Minimum
- Maximum
- Standard deviation

### One-Way ANOVA

Perform:

    flipper_length_mm ~ species

### Tukey HSD

Perform Tukey HSD when the ANOVA is significant.

### Required Output

The output should contain:

- Species-wise flipper-length descriptive statistics
- ANOVA table
- F-statistic
- p-value
- Tukey HSD pairwise comparisons
- Adjusted p-values

### Interpretation

Determine whether flipper length differs significantly among the three penguin species.

---

# Task 7 – Visualizations

The following visualizations are required:

1. Histogram of Penguin Body Mass
2. Body Mass by Penguin Species Boxplot
3. Body Mass by Sex Boxplot
4. Density Plot of Penguin Body Mass
5. QQ-Plot of Male Penguin Body Mass
6. QQ-Plot of Female Penguin Body Mass
7. Flipper Length by Penguin Species Boxplot
8. Body Mass by Species with Significant Differences

---

# Key Results

## Body Mass

### Overall Statistics

| Statistic | Value |
|---|---:|
| Mean | 4201.754 g |
| Median | 4050 g |
| Minimum | 2700 g |
| Maximum | 6300 g |
| Variance | 643131.1 |
| Standard Deviation | 801.955 g |
| Q1 | 3550 g |
| Q3 | 4750 g |
| IQR | 1200 g |
| Skewness | 0.468 |
| Kurtosis | 2.274 |

### Species-wise Mean Body Mass

| Species | Mean Body Mass (g) |
|---|---:|
| Adelie | 3700.662 |
| Chinstrap | 3733.088 |
| Gentoo | 5076.016 |

---

## Male vs Female Body Mass

| Group | Mean Body Mass (g) |
|---|---:|
| Male | 4545.685 |
| Female | 3862.273 |

### Welch's t-test

- t = **8.5545**
- df = **323.9**
- p-value = **4.794 × 10⁻¹⁶**
- 95% CI = **526.245 to 840.578 g**
- Cohen's d = **0.936**

### Result

Male penguins have a significantly higher mean body mass than female penguins.

---

## One-Way ANOVA – Body Mass

- F(2, 339) = **343.6**
- p-value < **2 × 10⁻¹⁶**

### Tukey HSD

| Comparison | Result |
|---|---|
| Chinstrap vs Adelie | Not significant |
| Gentoo vs Adelie | Significant |
| Gentoo vs Chinstrap | Significant |

### Result

Penguin species has a significant effect on body mass. Gentoo penguins are significantly heavier than both Adelie and Chinstrap penguins.

---

## Kruskal-Wallis Test

- Chi-squared = **217.6**
- df = **2**
- p-value < **2.2 × 10⁻¹⁶**

### Result

There is a statistically significant difference in body mass among the three penguin species.

---

## Two-Way ANOVA – Body Mass

| Factor | F-value | p-value |
|---|---:|---:|
| Species | 758.358 | < 2 × 10⁻¹⁶ |
| Sex | 387.460 | < 2 × 10⁻¹⁶ |
| Species × Sex | 8.757 | 0.000197 |

### Result

Species, sex, and the species × sex interaction all have statistically significant effects on body mass.

---

## Flipper Length

### Species-wise Mean Flipper Length

| Species | Mean Flipper Length (mm) |
|---|---:|
| Adelie | 189.954 |
| Chinstrap | 195.824 |
| Gentoo | 217.187 |

### One-Way ANOVA

- F(2, 339) = **594.8**
- p-value < **2 × 10⁻¹⁶**

### Tukey HSD

| Comparison | Mean Difference (mm) | Result |
|---|---:|---|
| Chinstrap − Adelie | 5.870 | Significant |
| Gentoo − Adelie | 27.233 | Significant |
| Gentoo − Chinstrap | 21.363 | Significant |

### Result

Flipper length differs significantly among all three penguin species.

The mean flipper length follows:

**Gentoo > Chinstrap > Adelie**

---

# Output Files

All generated visualizations are stored in the `outputs/` directory.

- `body_mass_density.png`
- `body_mass_sex_boxplot.png`
- `body_mass_species_boxplot.png`
- `body_mass_species_significance.png`
- `flipper_length_species_boxplot.png`
- `histogram_body_mass.png`
- `qq_female_body_mass.png`
- `qq_male_body_mass.png`

---

# Project Structure

    PBLE_6/
    ├── PBLE_6.R
    ├── README.md
    └── outputs/
        ├── body_mass_density.png
        ├── body_mass_sex_boxplot.png
        ├── body_mass_species_boxplot.png
        ├── body_mass_species_significance.png
        ├── flipper_length_species_boxplot.png
        ├── histogram_body_mass.png
        ├── qq_female_body_mass.png
        └── qq_male_body_mass.png

---

# Conclusion

The Palmer Penguins dataset was analyzed using descriptive statistics, hypothesis testing, ANOVA, Kruskal-Wallis testing, Tukey HSD post-hoc analysis, and data visualization.

The analysis showed significant differences in body mass among penguin species. Male penguins also had significantly higher body mass than female penguins. The two-way ANOVA showed significant effects of species, sex, and their interaction.

Flipper length also differed significantly among all three species, with Gentoo penguins having the longest average flippers, followed by Chinstrap and Adelie.
