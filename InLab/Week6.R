for (i in 1:5) {
  print(i^2)
}

numbers <- c(2, 4, 6, 7)

for (i in numbers) {
  print(i^2)
}

x <- c(2, 4, 6, 8, 10, 12)

count <- 0

for (xval in x) {
  if (xval / 2 > 3) {
    count <- count + 1
  }
}

print(count)

child <- c("child1","child2","child3")
sweet <- c("sweet1","sweet2","sweet3")

for(x in child){
for(y in sweet){
print(paste(x,y))  
  }
}

drink <- c("coffee","lemonade","tea","juice")
for(x in drink){
  if(x=="tea") {
    break
  }
  print(x)
}

for(x in drink){
  if(x=="lemonade") {
    next
  }
  print(x)
}

i <- 1 
while (i<10){
  print(i^2)
  i <- i+2
}


number <- 22
sum <- 0
while(number <= 25){
  sum <- sum + number
  number <- number + 1
}

print(sum)


i<- 1
repeat{
  print(i^2)
  i<-i+2
  if (i>10){
    break
  }
}


i<- 1
repeat {
  i<-i+1
  if(i<10) next
  print(i^2)
  if(i>=13) break
}


abc<- function(x) {
  x^2
}

abc(3)
abc(6)
abc(9)


abc <- function(x, y) {
  x^2 + y^2
}

abc(3, 4)
abc(10, 10)
abc(-2, -3)


abc <- function() {
  for (i in 1:3) {
    print(i^3)
  }
}

abc()


calculate_power <- function(x, power = 2) {
  x^power
}

calculate_power(5)


calculate_power(5,3)


seq(from=2,to=4)
seq(from=4,to=2)

seq(from =10,to=20,by=2)
seq(from=20,to=10,by=-2)
seq(from=3,to=-2,by=-0.5)

seq(from=10,length=10)
seq(to=10,length=10)


seq(from=10,length=10,by=0.1)

