###############################################
####    project possible stats analysis    ####
###############################################

# 1. Descriptives
#summary()
install.packages("psych")
library(psych)
#describe.by()  --> describe df or column

#to compare across different subject areas that have 
#we standardize
#zscore = xi - mean/sd
#mean()
#sd()


# 2. T-test
#when comparing the mean of two groups --> t test
#t test with unequal varience Welch's t-test
#the true independent two sample t-test, you have to specify that the variences are equal
#matched / paired t-tests: measure the same subject for two times (e.g. USC pre-/post- COVID)

#t.test(dv ~ iv, dataset = )     #Welch's t-test
#t.test(dv ~ iv, dataset = ,var.equal = Y)       #independent t-test
?t.test()
#t.test(dv ~ iv, dataset = ,var.equal = Y, paired = T)    #paired / matched t-test
#data types require that dv be continuous numerial and iv be categorical

# 3. Analysis of varience - ANOVA
#Analysis with more than two groups that you want to compare
aov(dv ~ iv + cov, dataset = )   #controls for multiple comparisons among 3 grouos or more of data
#dv is continuous and numerical, and IV is also categorical but with at least 3 categories
#ANOVA tells that there is a general significance somewhere between the groups, but not specify which two groups
#then run a post hoc analysis to examine where the exact statistics significance is 
?TukeyHSD()

# 4. Correlations -- two variables that are both numerical and has linear correlations
#cor()
#cor.test()
#corr.test()
#are used to examine relationships
#-1 to +1
# p value hasto be less than significance level
# for correlations, dv and iv must be numerical

# 5. Regression
# used when you have a question that is more causal in nature
# lm(dv ~ iv, dataset = )   #simple linear regression model
#dv is continuous, primary IV is continuous, but you can also have other categorical variables
# lm(dv ~ iv + iv2 + iv3, dataset = )   #multiple linear regression

sleepdf = sleep
describe.by(sleepdf)
model1 = t.test(sleepdf$extra ~ sleepdf$group, dataset = sleepdf)
model1
model2 = t.test(sleepdf$extra ~ sleepdf$group, dataset = sleepdf, paired = T)



npkdf = npk
model3 = aov(npkdf$yield ~ npkdf$block, dataset = npkdf)
summary(model3)


install.packages('ggplot2')
library(ggplot2)
dmd = diamonds
cor(dmd$carat, dmd$price)
model4 = lm(dmd$price ~ dmd$carat)
summary(model4)

model5 = lm(dmd$price ~ dmd$carat + dmd$clarity + dmd$cut + dmd$color)
summary(model5)