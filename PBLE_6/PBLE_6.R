library(palmerpenguins)
library(moments)
library(car)
library(ggplot2)

data(penguins)

penguins

str(penguins)

dim(penguins)

summary(penguins)

colSums(is.na(penguins))

body_mass <- penguins$body_mass_g

mean(body_mass, na.rm = TRUE)

median(body_mass, na.rm = TRUE)

min(body_mass, na.rm = TRUE)

max(body_mass, na.rm = TRUE)

var(body_mass, na.rm = TRUE)

sd(body_mass, na.rm = TRUE)

quantile(body_mass, 0.25, na.rm = TRUE)

quantile(body_mass, 0.75, na.rm = TRUE)

IQR(body_mass, na.rm = TRUE)

skewness(body_mass, na.rm = TRUE)

kurtosis(body_mass, na.rm = TRUE)


species_stats <- aggregate(
  body_mass_g ~ species,
  data = penguins,
  FUN = function(x) {
    c(
      Mean = mean(x, na.rm = TRUE),
      Median = median(x, na.rm = TRUE),
      Minimum = min(x, na.rm = TRUE),
      Maximum = max(x, na.rm = TRUE),
      Variance = var(x, na.rm = TRUE),
      SD = sd(x, na.rm = TRUE),
      Q1 = quantile(x, 0.25, na.rm = TRUE),
      Q3 = quantile(x, 0.75, na.rm = TRUE),
      IQR = IQR(x, na.rm = TRUE),
      Skewness = skewness(x, na.rm = TRUE),
      Kurtosis = kurtosis(x, na.rm = TRUE)
    )
  }
)

species_stats


if (!dir.exists("outputs")) {
  dir.create("outputs")
}


png(
  "outputs/histogram_body_mass.png",
  width = 1200,
  height = 800
)

hist(
  penguins$body_mass_g,
  main = "Histogram of Penguin Body Mass",
  xlab = "Body Mass (g)",
  ylab = "Frequency"
)

dev.off()


png(
  "outputs/body_mass_species_boxplot.png",
  width = 1200,
  height = 800
)

boxplot(
  body_mass_g ~ species,
  data = penguins,
  main = "Body Mass by Penguin Species",
  xlab = "Species",
  ylab = "Body Mass (g)"
)

dev.off()


male_mass <- penguins$body_mass_g[penguins$sex == "male"]
female_mass <- penguins$body_mass_g[penguins$sex == "female"]

male_mass <- na.omit(male_mass)
female_mass <- na.omit(female_mass)

mean(male_mass)
mean(female_mass)


shapiro.test(male_mass)

shapiro.test(female_mass)


png(
  "outputs/qq_male_body_mass.png",
  width = 1200,
  height = 800
)

qqnorm(
  male_mass,
  main = "QQ-Plot of Male Penguin Body Mass"
)

qqline(male_mass)

dev.off()


png(
  "outputs/qq_female_body_mass.png",
  width = 1200,
  height = 800
)

qqnorm(
  female_mass,
  main = "QQ-Plot of Female Penguin Body Mass"
)

qqline(female_mass)

dev.off()


t_test_result <- t.test(
  male_mass,
  female_mass,
  var.equal = FALSE,
  conf.level = 0.95
)

t_test_result

pooled_sd <- sqrt(
  ((length(male_mass) - 1) * var(male_mass) +
     (length(female_mass) - 1) * var(female_mass)) /
    (length(male_mass) + length(female_mass) - 2)
)

cohens_d <- (mean(male_mass) - mean(female_mass)) / pooled_sd

cohens_d


par(mfrow = c(1, 3))

qqnorm(
  penguins$body_mass_g[penguins$species == "Adelie"],
  main = "Adelie"
)
qqline(penguins$body_mass_g[penguins$species == "Adelie"])

qqnorm(
  penguins$body_mass_g[penguins$species == "Chinstrap"],
  main = "Chinstrap"
)
qqline(penguins$body_mass_g[penguins$species == "Chinstrap"])

qqnorm(
  penguins$body_mass_g[penguins$species == "Gentoo"],
  main = "Gentoo"
)
qqline(penguins$body_mass_g[penguins$species == "Gentoo"])

par(mfrow = c(1, 1))

adelie_mass <- na.omit(
  penguins$body_mass_g[penguins$species == "Adelie"]
)

chinstrap_mass <- na.omit(
  penguins$body_mass_g[penguins$species == "Chinstrap"]
)

gentoo_mass <- na.omit(
  penguins$body_mass_g[penguins$species == "Gentoo"]
)

shapiro.test(adelie_mass)

shapiro.test(chinstrap_mass)

shapiro.test(gentoo_mass)

leveneTest(
  body_mass_g ~ species,
  data = penguins
)

anova_model <- aov(
  body_mass_g ~ species,
  data = penguins
)

summary(anova_model)

tukey_result <- TukeyHSD(anova_model)

tukey_result

kruskal_result <- kruskal.test(
  body_mass_g ~ species,
  data = penguins
)

kruskal_result


two_way_model <- aov(
  body_mass_g ~ species * sex,
  data = penguins
)

summary(two_way_model)

flipper_stats <- aggregate(
  flipper_length_mm ~ species,
  data = penguins,
  FUN = function(x) {
    c(
      Mean = mean(x, na.rm = TRUE),
      Median = median(x, na.rm = TRUE),
      Minimum = min(x, na.rm = TRUE),
      Maximum = max(x, na.rm = TRUE),
      SD = sd(x, na.rm = TRUE)
    )
  }
)

flipper_stats

flipper_anova <- aov(
  flipper_length_mm ~ species,
  data = penguins
)

summary(flipper_anova)

tukey_flipper <- TukeyHSD(flipper_anova)

tukey_flipper

if (!dir.exists("outputs")) {
  dir.create("outputs")
}

png(
  "outputs/body_mass_sex_boxplot.png",
  width = 1200,
  height = 800
)

boxplot(
  body_mass_g ~ sex,
  data = penguins,
  main = "Body Mass by Sex",
  xlab = "Sex",
  ylab = "Body Mass (g)"
)

dev.off()


png(
  "outputs/flipper_length_species_boxplot.png",
  width = 1200,
  height = 800
)

boxplot(
  flipper_length_mm ~ species,
  data = penguins,
  main = "Flipper Length by Penguin Species",
  xlab = "Species",
  ylab = "Flipper Length (mm)"
)

dev.off()


png(
  "outputs/body_mass_species_significance.png",
  width = 1200,
  height = 800
)

boxplot(
  body_mass_g ~ species,
  data = penguins,
  main = "Body Mass by Penguin Species",
  xlab = "Species",
  ylab = "Body Mass (g)",
  ylim = c(2500, 7000)
)

segments(1, 5800, 1, 5900, lwd = 2)
segments(1, 5900, 2, 5900, lwd = 2)
segments(2, 5900, 2, 5800, lwd = 2)
text(1.5, 6000, "ns")

segments(1, 6400, 1, 6500, lwd = 2)
segments(1, 6500, 3, 6500, lwd = 2)
segments(3, 6500, 3, 6400, lwd = 2)
text(2, 6600, "***")

segments(2, 6100, 2, 6200, lwd = 2)
segments(2, 6200, 3, 6200, lwd = 2)
segments(3, 6200, 3, 6100, lwd = 2)
text(2.5, 6300, "***")

png(
  "outputs/body_mass_density.png",
  width = 1200,
  height = 800
)

plot(
  density(na.omit(penguins$body_mass_g)),
  main = "Density Plot of Penguin Body Mass",
  xlab = "Body Mass (g)",
  ylab = "Density"
)

dev.off()
