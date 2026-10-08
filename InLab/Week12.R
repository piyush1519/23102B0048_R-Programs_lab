############################################################
# R PROGRAMMING - NPTEL WEEK 12
# LECTURE 50, 51, 52 and 53
# Complete executable code
############################################################
 
 
############################################################
# LECTURE 50
# SUBDIVIDED BAR PLOT AND PIE DIAGRAM
############################################################
 
cat("========== LECTURE 50 ==========\n")
 
 
# ----------------------------------------------------------
# 1. SUBDIVIDED / COMPONENT BAR DIAGRAM
# ----------------------------------------------------------
 
cust = matrix(
  nrow = 4,
  ncol = 3,
  data = c(
    2, 20, 30,
    26, 53, 40,
    42, 15, 25,
    30, 75, 100
  ),
  byrow = TRUE
)
 
print(cust)
 
# Basic subdivided bar plot
barplot(cust)
 
 
# Bar plot with labels and colours
barplot(
  cust,
  names.arg = c("Shop 1", "Shop 2", "Shop 3"),
  xlab = "Shops",
  ylab = "Days",
  col = c("red", "green", "orange", "brown")
)
 
 
# ----------------------------------------------------------
# 2. PIE DIAGRAM
# ----------------------------------------------------------
 
# Gender data
gender = c(1, 2, 1, 2, 1, 1, 1, 2, 1, 1)
 
print(gender)
 
# Direct pie chart
pie(gender)
 
# Pie chart using frequency table
pie(table(gender))
 
 
# ----------------------------------------------------------
# 3. FOOD DELIVERY PIE CHART
# ----------------------------------------------------------
 
direction = c(
  1,1,2,1,2,3,2,2,3,3,3,1,2,3,2,2,3,1,1,3,3,1,2,
  1,3,3,3,2,2,2,2,1,2,2,1,1,1,3,2,2,1,2,3,2,2,1,
  2,3,3,2,1,2,2,3,1,1,2,1,2,3,2,3,2,2,3,1,2,3,3,3,
  2,1,1,1,2,1,1,2,1,2,3,3,1,2,3,3,2,1,2,3,2,1,3,
  2,2,2,2,3,2,2
)
 
print(table(direction))
 
# Basic pie chart
pie(table(direction))
 
# Pie chart with colours and title
pie(
  table(direction),
  col = c("red", "green", "blue"),
  main = "Directions of food delivery"
)
 
 
# ----------------------------------------------------------
# 4. COMBINING GRAPHICS
# ----------------------------------------------------------
 
# Two plots side-by-side
par(mfrow = c(1, 2))
 
barplot(table(direction))
pie(table(direction))
 
 
# Two plots one below another
par(mfrow = c(2, 1))
 
barplot(table(direction))
pie(table(direction))
 
 
# Reset plotting area
par(mfrow = c(1, 1))
 
 
 
############################################################
# LECTURE 51
# HISTOGRAM
############################################################
 
cat("========== LECTURE 51 ==========\n")
 
 
# ----------------------------------------------------------
# 5. HISTOGRAM
# ----------------------------------------------------------
 
height = c(
  166,125,130,142,147,159,159,147,165,156,149,164,137,166,135,142,
  133,136,127,143,165,121,142,148,158,146,154,157,124,125,158,159,
  164,143,154,152,141,164,131,152,152,161,143,143,139,131,125,145,
  140,163
)
 
print(height)
 
 
# Basic histogram
hist(height)
 
 
# Histogram showing relative frequencies
hist(height, freq = FALSE)
 
 
# Histogram with title, colour and axis labels
hist(
  height,
  main = "Heights of persons",
  col = "green",
  xlab = "Heights",
  ylab = "Number of Persons"
)
 
 
# Histogram with density = 2
hist(
  height,
  main = "Heights of persons",
  col = "red",
  xlab = "Heights",
  ylab = "Number of Persons",
  density = 2
)
 
 
# Histogram with density = 8
hist(
  height,
  main = "Heights of persons",
  col = "red",
  xlab = "Heights",
  ylab = "Number of Persons",
  density = 8
)
 
 
# Histogram with angle
hist(
  height,
  main = "Heights of persons",
  col = "red",
  xlab = "Heights",
  ylab = "Number of Persons",
  density = 8,
  angle = 100
)
 
 
 
############################################################
# LECTURE 52
# BIVARIATE AND 3D SCATTER PLOTS
############################################################
 
cat("========== LECTURE 52 ==========\n")
 
 
# ----------------------------------------------------------
# 6. BIVARIATE SCATTER PLOT
# ----------------------------------------------------------
 
marks = c(
  337,316,327,340,374,330,352,353,370,380,
  384,398,413,428,430,438,439,479,460,450
)
 
hours = c(
  23,25,26,27,30,26,29,32,33,34,
  35,38,39,42,43,44,45,46,44,41
)
 
 
# Basic scatter plot
plot(hours, marks)
 
 
# Points
plot(hours, marks, type = "p")
 
 
# Lines
plot(hours, marks, type = "l")
 
 
# Both lines and points
plot(hours, marks, type = "b")
 
 
# Both overplotted
plot(hours, marks, type = "o")
 
 
# Histogram-like vertical lines
plot(hours, marks, type = "h")
 
 
# Stair steps
plot(hours, marks, type = "s")
 
 
# Scatter plot with labels and title
plot(
  hours,
  marks,
  xlab = "Number of weekly hours",
  ylab = "Marks obtained",
  main = "Marks obtained versus Number of hours per week"
)
 
 
 
# ----------------------------------------------------------
# 7. MATRIX SCATTER PLOT
# ----------------------------------------------------------
 
pairs(cbind(hours, marks))
 
 
# Matrix scatter plot with labels and colour
pairs(
  cbind(hours, marks),
  labels = c("Study hours", "Marks obtained"),
  col = "red"
)
 
 
 
# ----------------------------------------------------------
# 8. SCATTER PLOT WITH SMOOTH CURVE
# ----------------------------------------------------------
 
scatter.smooth(hours, marks)
 
 
# Scatter plot with smooth curve and additional options
scatter.smooth(
  hours,
  marks,
  lpars = list(
    col = "red",
    lwd = 3,
    lty = 3
  )
)
 
 
 
# ----------------------------------------------------------
# 9. THREE DIMENSIONAL SCATTER PLOT
# ----------------------------------------------------------
 
# Install package
install.packages("scatterplot3d")
 
# Load package
library(scatterplot3d)
 
 
# Data
height3d = c(100, 125, 145, 160, 170)
weight3d = c(30, 35, 50, 65, 70)
age3d = c(10, 15, 20, 30, 35)
 
 
# Basic 3D scatter plot
scatterplot3d(
  height3d,
  weight3d,
  age3d
)
 
 
# Change direction
scatterplot3d(
  height3d,
  weight3d,
  age3d,
  angle = 120
)
 
 
# Change colour
scatterplot3d(
  height3d,
  weight3d,
  age3d,
  color = "red"
)
 
 
 
# ----------------------------------------------------------
# 10. PERSPECTIVE PLOT
# ----------------------------------------------------------
 
x = seq(-10, 10, length = 30)
y = x
 
 
f = function(x, y) {
  r = sqrt(x^2 + y^2)
  10 * sin(r) / r
}
 
 
z = outer(x, y, f)
 
# Replace NA values
z[is.na(z)] = 1
 
 
# Basic perspective plot
persp(
  x,
  y,
  z,
  theta = 30,
  phi = 30,
  expand = 0.5,
  col = "lightblue"
)
 
 
# Detailed perspective plot
persp(
  x,
  y,
  z,
  theta = 30,
  phi = 30,
  expand = 0.5,
  col = "lightblue",
  ltheta = 120,
  shade = 0.75,
  ticktype = "detailed",
  xlab = "X",
  ylab = "Y",
  zlab = "Sinc(r)"
)
 
 
 
# ----------------------------------------------------------
# 11. OTHER GRAPHICS FUNCTIONS
# ----------------------------------------------------------
 
# Contour plot
contour(x, y, z)
 
# Image plot
image(x, y, z)
 
# Perspective plot
persp(x, y, z)
 
 
 
############################################################
# LECTURE 53
# SOME EXAMPLES OF R PROGRAMMING
############################################################
 
cat("========== LECTURE 53 ==========\n")
 
 
# ----------------------------------------------------------
# EXAMPLE 1
# ----------------------------------------------------------
 
# Remove all existing data
rm(list = ls())
 
 
# Define input vectors
x = c(10, 20, 30)
y = c(1, 2, 3)
 
 
# Define function
example1 = function(x, y)
{
 
  # Number of observations
  n = length(x)
 
  # Initialize variables
  x1 = 0
  y1 = 0
  z1 = 0
 
  # Loop
  for(i in 1:n)
  {
    x1[i] = x[i]^2
    y1[i] = y[i]^2
    z1[i] = (x[i] / y[i])^2
  }
 
  # Sum of squared quantities
  sum_square_x = sum(x1)
  sum_square_y = sum(y1)
  sum_square_z = sum(z1)
 
  # Compute g and h
  g = sum_square_x / sum_square_y
  h = sum_square_z
 
  # Output
  cat(
    "The value of g and h are",
    g,
    "and",
    h,
    "respectively",
    "\n"
  )
}
 
 
# Call function
example1(x, y)
 
 
# Another input
x = c(67, 87, 26, 85, 6, 45)
y = c(54, 64, 22, 94, 20, 88)
 
example1(x, y)
 
 
 
# ----------------------------------------------------------
# EXAMPLE 1 - ALTERNATIVE APPROACH
# ----------------------------------------------------------
 
x = c(10, 20, 30)
y = c(1, 2, 3)
 
g = sum(x^2) / sum(y^2)
h = sum(x / y)^2
 
cat("g =", g, "\n")
cat("h =", h, "\n")
 
 
 
############################################################
# EXAMPLE 2
############################################################
 
# Function g(x,y)
g = function(x, y)
{
  (x + log(y)) / y
}
 
 
# Function f(x,y)
f = function(x, y)
{
  (
    ((g(x, y))^2) /
    (5 + (g(x, y))^3)
  ) *
  (exp(g(x, y)))^(2/3)
}
 
 
# Test values
x = 10
y = 20
 
print(f(x, y))
 
 
# Another test
x = 1896
y = 23454
 
print(f(x, y))
 
 
 
############################################################
# EXAMPLE 3
############################################################
 
# Function f(x)
f = function(x)
{
 
  if(x > 0)
  {
    exp(
      (x + log(1 + x^3)) /
      x^2
    )
  }
 
  else if(x == 0)
  {
    10
  }
 
  else
  {
    (2 + x^3) / x
  }
}
 
 
# Test the function
print(f(123))
print(f(-123))
print(f(0))
print(f(8))
print(f(-4))
 
 
# ----------------------------------------------------------
# Plot f(x) from -1 to 5 with increment 0.2
# ----------------------------------------------------------
 
h = function()
{
 
  # Generate x values
  x = seq(-1, 5, by = 0.2)
 
  # Initialize y
  y = 0
 
  # Calculate f(x)
  for(i in 1:length(x))
  {
    y[i] = f(x[i])
  }
 
  # Plot
  plot(
    x,
    y,
    type = "l"
  )
}
 
 
# Call plotting function
h()
 
 
 
############################################################
# END OF NPTEL WEEK 12
############################################################
 
cat("\n====================================\n")
cat("ALL WEEK 12 CODE EXECUTED\n")
cat("====================================\n")
 
