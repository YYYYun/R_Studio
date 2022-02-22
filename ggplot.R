file.choose()
mystery = read.csv(file.choose())

#1. Find the means of the data
mean(mystery$x1)
lapply(mystery, mean)

#2. Find the standard deviation of the data
sd(mystery$x1)
lapply(mystery, FUN = sd)     #replicates sd for all columns in th mystery dataframe and simplifies it
lapply(mystery, hist)         #so it works on graphics as well such as hist

#3. Find correlations
#4. Perform Linear Models
cor(mystery$x1,mystery$y1)     #good to see that it is linear
plot(mystery$x1,mystery$y1)    #the plot justified the correlations

cor(mystery$x2,mystery$y2)
plot(mystery$x2,mystery$y2)
#correlation require a linear relationship between x and y
cor(mystery$x3,mystery$y3)
plot(mystery$x3,mystery$y3)

cor(mystery$x4,mystery$y4)
plot(mystery$x4,mystery$y4)

#linear models
#correalation does not equal causation
#cor is for correlation and lm is for linear model

model1 = lm(y1 ~ x1, mystery)
summary(model1)

#5. Plot with ggplot2
install.packages("ggplot2")
library(ggplot2)

ggplot(mystery, aes(x = x1, y = y1)) 
  + geom_point()
  + ggtitle("correlation between Being on Campus and Going to Class")
  + xlab("Being on Campus")
  + ylab("Going to Class")



