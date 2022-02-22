###########################
##       Variable        ##
###########################
2+3

print("Hello!")    #print() is a function

#1. create a variable called x that holds a value of 10
x <- 10     #another option: x = 10, spaces is optional
x

#2. update of the variable x created in the previous question by adding 2 to the original value.
#notice that if you do not assign it, it will not be in your global environment.
y = x+2
y

#3. update the value of the variable x to have a value of 20. 
#can we still access the original value of x?
x = 20

#4. create a variable y that holds a value of 5. perform the following operations: x+y, x-y, x squared, and find the square root of x, and x%%2
x = 20
y = 5
x+y
x-y
x^2
sqrt(x)     #it's a function
x%%2        #the modulus tells you the remainder after division

###########################
##       Vectors         ##
###########################

#5. use the function c() to create a vertor or an array
#save your results in an object called grades
#the c in the c() functions stands for concatenate
grades = c(100, 90, 85, 95)

#6. create a vector called classes that contains the following: DSO510, DSO545, DSO552, and GSBA545
classes = c('DSO510', 'DSO545', 'DSO552', 'GSBA545')
#when we have numbers and characters, the characters overrides, and the object is a string but not int/floats

#7. use the function class() to identify the data types of the R objects you created previsously (grades and classes)
class(grades)
str(grades)

#8. add five bonus points to the grades for all classes
grades = c(100, 90, 85, 95)
grades + 5

#9. create a new vector x that holds the following: 5, 10, "15", 20.
x = c('5', '10', '15', '20')
#you cannot have multiple types of data 

#10 what is the value of the second grade in the grades vector? what is the value of the 4th?
grades[2]
grades[4]

#12. Write one line of code to return the 2nd and 4th element.
grades[c(2,4)]                    #working with a vectir
#when trying to access more than 1 element use the c()
#you work with both rows and columns --> [ROWS, COLUMNS]

#13. Return all grades except the third one.
grades[-3]
#or
grades[c(1,2,4)]

#14. Update the second grade to 97
grades[3] = 97
print(grades[3])

###########################
##       DataFrame       ##
###########################

#15. Create a data frame that has the grades and course names in one object called student.
studentdf = data.frame(grades, classes)
#can use the any of the following to create a dataframe: cbind(), data.frame(), 
studentdf

#16. Create a new vector lettergrade that contains the following four letters: B, A+, A-, A+.
lettergrades = c('B','A+','A-','A+')
str(studentdf)
str(lettergrades)

#17. Use the cbind() function in R to add the letter grade column to the studentdata dataframe.
#cbind() --> combine by columns; rbind() --> by rows
newstudentdf = cbind(studentdf, lettergrades)

#18. Use the colnames() function to return all column names of the student dataframe.
colnames(newstudentdf)

#19. Update the colnames to: “Class”, “Grade”, “Lettergrade”.
colnames(newstudentdf) = c('Class', 'Grade', 'Lettergrade')
colnames(newstudentdf)

#20. List the grade for the third observation.
newstudentdf[3, ]        #this means get the 3rd row observation with all the columns

#21. List all information associated with the second observation.
newstudentdf[2, ] 

#22. List all the letter grades in the studentdata dataframe.
newstudentdf$Lettergrade          # $ is for accessing columns
#or
newstudentdf[ ,3]

#23. List all classes with their information except for the DSO510 class.
newstudentdf[2:4, ]      # : grab in sequence the consecutive numbers
newstudentdf[-1, ]       #drop the first row

1:100      #give me a list from 1 through 100, it will by default go up by 1s
seq(2,100,by=2)     #the official seq() function, start at 2, go up to 100 in sequence of 2

#24. Show all information in the studentdata dataframe except for the grade.
newstudentdf[ ,-1]

#25. Retrieve the class and grade information for all classes except for GSBA545.
newstudentdf[-4, ]

###############################################
###   Reading External Data Sets into R     ###
###############################################

#26. Use the length() function to find the length of the classes vector.
length(classes)
#str() --> more comprehensive, gives you whether its a df, data types, levels
#length() --> specifically the length
#class() --> specifically the data type
#dim() --> gives you the obs and variables

#27. How many observations are there in the studentdata dataframe? How many columns?
ncol(newstudentdf)
nrow(newstudentdf)

#28. Use the function seq() to create a vector of numbers from 1 to 10.
seq(1,10)      #seq(from=1, to=10)

#29. Create a vector of numbers from 1 to 10 with increments of 2.
seq(1,10,2)    #seq(from=1, to=10, by=2)

#30. Create a vector of numbers that goes backward from 100 to 0 with decrements of 20.
backwards = seq(100,0,-20)
print(backwards)

#31. Create a vector that repeats “Hi” 10 times.
rep('Hi', 10)

###############################################
###         Conditional Subsetting          ###
###############################################

#32. Return the second and third column in the studentdata dataframe.
newstudentdf[ ,2:3]
newstudentdf[-1]

#33. In order to load up the data, we can use the read.csv() command. This command
#takes a string, which is the name of the file. And here we’re going to save it to a
#variable called statedata. statedata is going to save all of our data into a data frame.
#When I run this code, I can see that states info appears in my environment.
getwd()      #where is my R file pointing at
#setwd()     #this function would allow me to change my working directory
read.csv()
file.choose()
stateData = read.csv(file.choose())

#34. It’s a long dataframe. We can inspect the first few observation in the dataset using the head() function.
head(stateData)        #by default gives you the first six rows of every column
head(stateData, 20)

#35. How many observations are there in the dataset you just read in?
nrow(stateData)
dim(stateData)

#36. Return the first 10 observations.
head(stateData, 10)
stateData[1:10, ]

#37. Return the state name, state area, and population for the first 10 observations.
stateData[1:10, c(1,3,5)]

#38. Use the sum() function to find the total population of all the states?
sum(stateData$population)

#39. Return all information on states located in only the Northeast. 
#Those states would be states like Connecticut and they have a state region of 1 (region == 1).
a == 3      #comprarator used often to filter, you can also use dplyr
ne_data = stateData[stateData$region == 1, ]        #we need a comma and space to grab all the columns, and stateData$region represents 9 the rows
ne_data

#40. How many states are in region 1?
nrow(ne_data)

#41. How many states are in region 2?
region2 = stateData[stateData$region == 2, ] 
nrow(region2)

#42. How many states are in region 3?
region3 = stateData[stateData$region == 3, ] 
nrow(region3)

#43. How many states are in region 4?
region4 = stateData[stateData$region == 4, ] 
nrow(region4)

#44. What is the minimum value of the income variable?
min(stateData$income)

#45. What is the maximum value of the income variable?
max(stateData$income)
summary(stateData)

