#Matrix
x=matrix(nrow=4,ncol=2,data=c(1,2,3,4,5,6,7,8))#by default column wise
x

x[3,2]

#For row wise definition
x=matrix(nrow=4,ncol=2,data=c(1,2,3,4,5,6,7,8),byrow=TRUE)
x

#Properties of Matrix
dim(x)
nrow(x)
ncol(x)
mode(x)
attributes(x)

#Renaming rows and columns
rownames(x)=c("r1","r2","r3","r4")
colnames(x)=c("c1","c2")
x

#Assigning a specified number to all matrix 
x=matrix(nrow=4,ncol=2,data=2)
x

#Construction of Diagonal Matrix
d=diag(1,nrow=3,ncol=3)
d

#Transpose of MAtrix
x=matrix(nrow=4,ncol=2,data=1:8,byrow=TRUE)
x
xt=t(x)
xt

#Rows and Column sum
x
rowSums(x)
colSums(x)

#rowMeans colMeans
rowMeans(x)
colMeans(x)


#Access to rows,columns or submatrices
x=matrix(nrow=5,ncol = 3,byrow=T,data=1:15)
x

x[3,]
x[,2]
x[4:5,2:3]
x[c(1,4),c(1,3)]

#Addition of Matrix with constant
x=matrix(nrow=4,ncol=2,data=1:8,byrow=T)
x
x+5

#Subtraction
x-1

#Multiplication
x*2

#Division
x/2


#Addition and Subtraction of matrices
x=matrix(nrow=4,ncol=2,data=1:8,byrow=T)
y=matrix(nrow=4,ncol=2,data=11:18,byrow=T)
x
y

x+y
x-y

4*x-x

# ============================================
# MULTIPLICATION OF MATRICES
# ============================================

# Create matrix X
x = matrix(nrow=4, ncol=2, data=1:8, byrow=T)

# Create matrix Y
y = matrix(nrow=2, ncol=4, data=11:18, byrow=T)

# Display matrices
x
y

# Matrix multiplication
x %*% y

# Matrix multiplication in reverse order
y %*% x


# ============================================
# MULTIPLICATION OF X' AND X
# ============================================

# Create matrix X
x = matrix(nrow=4, ncol=2, data=1:8, byrow=T)

# Display X
x

# Transpose of X
t(x)

# X'X
t(x) %*% x

# XX'
x %*% t(x)


# ============================================
# CROSS PRODUCT OF A MATRIX
# ============================================

# Create matrix X
x = matrix(nrow=4, ncol=2, data=1:8, byrow=T)

# Display X
x

# Transpose of X
t(x)

# Cross product X'X
crossprod(x)


# ============================================
# ACCESS TO ROWS, COLUMNS AND SUBMATRICES
# ============================================

x = matrix(nrow=5, ncol=3, byrow=T, data=1:15)

# Display matrix
x

# Access first row
x[1, ]

# Access second row
x[2, ]

# Access first column
x[, 1]

# Access second column
x[, 2]

# Access element in first row and second column
x[1, 2]

# Access a submatrix
x[1:3, 1:2]


# ============================================
# DIAGONAL MATRIX
# ============================================

# Identity matrix of dimension 3
d = diag(1, nrow=3, ncol=3)

d

# Diagonal matrix with all diagonal elements equal to 5
d = diag(5, nrow=3, ncol=3)

d


# ============================================
# TRANSPOSE OF A MATRIX
# ============================================

x = matrix(nrow=4, ncol=2, data=1:8, byrow=T)

# Display X
x

# Transpose X
t(x)


# ============================================
# ADDITION AND SUBTRACTION OF MATRICES
# ============================================

x = matrix(nrow=4, ncol=2, data=1:8, byrow=T)

# Scalar multiplication
4 * x

# Matrix addition
x + x

# Matrix subtraction
x - x


# ============================================
# CONCATENATING MATRICES
# ============================================

x = matrix(nrow=3, ncol=2, data=1:6, byrow=T)

y = matrix(nrow=3, ncol=2, data=11:16, byrow=T)

# Display matrices
x
y

# Concatenate row-wise
rbind(x, y)

# Concatenate column-wise
cbind(x, y)


# ============================================
# INVERSE OF A MATRIX
# ============================================

y = matrix(
  nrow=2,
  ncol=2,
  byrow=T,
  data=c(84, 100, 100, 120)
)

# Display matrix
y

# Inverse of matrix
solve(y)


# ============================================
# EIGEN VALUES AND EIGEN VECTORS
# ============================================

y = matrix(
  nrow=2,
  ncol=2,
  byrow=T,
  data=c(84, 100, 100, 120)
)

# Display matrix
y

# Eigen values and eigen vectors
eigen(y)
