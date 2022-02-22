############ Homework 1 #############

#1. Create a vector that contains numbers (5, 10, 15, 20, 25,…,125). Save it in a variable called vectorfives.
vectorfives = seq(5,125,5)
print(vectorfives)

#2. How many elements there are in vectorfives?
length(vectorfives)

#3. What is the value of the 12th element in vectorfives?
vectorfives[12]

#4. Compute the average, median, and standard deviation for all elements in vectorfives.
mean(vectorfives)
median(vectorfives)
sd(vectorfives)

#5. Create the following dataframe and save it in a variable called ‘membershipPackages’.
id = seq(90,100)
qtyBronzePackagesSold = seq(500,5500,500)
qtyMembership = c(5,5,5,5,5,5,6,7,8,9,10)
qtyGoldPackagesSold = seq(50000,0,-5000)

membershipPackages = data.frame(id, qtyBronzePackagesSold, qtyMembership, qtyGoldPackagesSold)
print(membershipPackages)

#6. What is the total for the Bronze Packages sold (qtyBronzePackagesSold)?
sum(membershipPackages$qtyBronzePackagesSold)

#7. How many qtyMemberships did account id93 have? Provide the correct indexing code.
membershipPackages[membershipPackages$id == 93, 3]

#8. Report all the information about the ids 92-96.
membershipPackages[3:8, ]

#9. Report all the Gold and Bronze Packages with their ids except for ids 95 and 99 
    #and do not include the qtyMembership column.
membershipPackages[c(-6,-10) ,c(1,2,4)]

#10. Add a new column to the membershipPackages dataframe that gives you the total Gold packages sold, 
    #and Bronze Packages sold. Name the column ‘totalPackagesSold’ and combine it into the dataframe.
total = membershipPackages$qtyBronzePackagesSold + membershipPackages$qtyGoldPackagesSold
membershipPackages$totalPackagesSold = total
#membershipPackages = cbind(membershipPackages, total)
print(membershipPackages)