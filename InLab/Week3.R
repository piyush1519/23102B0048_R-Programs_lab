#Addition of data vectors
c(2,3,5,7) + c(-2,-3,-5,8)


#R as a calculator
 #Power Operator
 2^3
 2**3 

 #Power Operator with scalar 
 c(2,3,5,6)^2
 #Power Operator with vector
 c(2,3,5,7)^c(2,3)
 c(1,2,3,5,7)^c(2,3,4)

 #Integer Division with scalar
#%/% Operator
 2%/%2
 5%/%2
 c(2,3,5,7)%/%2 
#with vector
 c(2,3,5)%/%c(2,3)
 
 #Modulo Division - %% Operator
 2%%2
 3%%2 
 #With scalars
 c(2,3,5,7) %% 2
 #With vector 
 c(2,3,5,7) %% c(2,3)

 
#Built in Functions
 #Maximum
 max(1.2,3.4,-7.8)
 #Minimum
 min(1.2,3.4,-7.8)
 #Arithmetic Mean
 mean(2,3,4)
 #Absolute 
 abs(-4)
 #Square root
 sqrt(c(9,4,16,36))
 #Sum
 sum(c(1,2,3,4))
 #Product
 prod(c(1,2,3,4))
 #round
 round(1.25)
 #log
 log(10)
 log(c(10,100,1000)) 
 #log10
 log10(10)
 log10(100) 
 #Assignment
 x1=c(1,2,4,5)
 x1

 x2=x1^2 
 x2 
 