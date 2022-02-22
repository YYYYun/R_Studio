##################################################
#########    Week 3: Intro to ggplot2   ##########
##################################################

### styles: color, size

##################################################
############      Scatterplots       #############
##################################################

#1. Load the ggplot2 package into R.
install.packages("ggplot2")
library(ggplot2)

#2. Use the mpg dataset that comes with the ggplot2 package, and create a scatterplot that 
#shows the relationship between the engine displacement displ and the highway miles per gallon variable hwy.
mpg = mpg
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()          #for scatterplot

#3. Use color to distinguish between different types (class) of cars in the previous plot.
ggplot(mpg, aes(displ, hwy, color = class)) + 
  geom_point()

#or
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color = class))
#all the variables have to be inside the aes(), such as displ, hwy, class

#4. In the previous plot, we assigned a categorical variable to the color aesthetics. In this exercise, 
#try to add the color aesthetics to the geom_point() line of code. Explain what happened.
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(color = "green")

#5. Use the size aesthetic to show the different types of cars (class) instead of the color aesthetic.
ggplot(mpg, aes(displ, hwy, size = class)) + 
  geom_point()

#or
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(size = class))

##################################################
##############      Facets      ##################
##################################################

#6. Use the function facet_wrap() to show the relationship between 
#displ and hwy for each of the car types (class) in a separate graph.
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~class, nrow = 2)
  

##################################################
##########         Bar Graphs         ############
##################################################

diamonds
rihanna = diamonds
#check out the structure: to get an idea of whether it's already a dataframe

#7. Use the str() function to explore the diamonds dataset that comes with ggplot2 package.
str(rihanna)

#8. Create a barchart that shows the count distribution for each of the cut levels of the diamonds.
#geom_bar() are graphing an x and its count VS. geom_col() x and the y
hist(mpg$displ)      #histogram is for continuous variables, and the y is frequency
ggplot(mpg, aes(x = displ)) + geom_bar()      #geom_bar() is for categorical data(not continuous), the y bar is count
ggplot(mpg, aes(x = displ)) + geom_histogram()
ggplot(rihanna, aes(x = cut)) + geom_bar()

#9. Check what happens if you try to create a count bar chart for the variable carat.
ggplot(rihanna, aes(carat)) + geom_bar()
#carat is numaric therefore not suitable for bar chart

#10. Load the gcookbook package to R.
install.packages('gcookbook')
library(gcookbook)
BOD
?BOD

#11. Investigate the contents of the BOD dataset that comes with gcookbook R package.
str(BOD)
O2 = BOD

#12. Create a bar chart that shows you the biochemical oxygen demand for each time in an evaluation of water quality.
ggplot(O2, aes(x = Time, y = demand)) + geom_col()

#13. How can you improve the previous graph?
ggplot(O2, aes(factor(Time),demand)) + geom_col()
#don't want to change the original dataset
?factor

#or
O2$Time = as.factor(O2$Time)   #Changing the data type within the dataframe
ggplot(O2, aes(x = Time, y = demamd)) + geom_col()

#14. Change the width of each bar in the previous graph into 0.5.
ggplot(O2, aes(Time, demand)) + 
  geom_col(width = 0.5)

#15. Change the color of the bars in the previous graph into lightblue.
ggplot(O2, aes(Time, demand)) +
  geom_col(fill = 'lightblue', color = 'orange') +
  ylab('Demand')

###################################################
#######    Adding Labels to a Bar Graph     #######
###################################################

#To do so, we will add a new layer to our plot using geom_text().
#16. For the BOD barchart created before, add the oxygen demand value on the bars for each of the Times.

ggplot(O2, aes(Time, demand)) +
  geom_col(fill = 'lightblue', color = 'orange') +
  ylab('Demand') +
  geom_text(aes(label = demand), vjust = -1)
#demand is a variable, it has to be put in aes()
#vjust is a functiuon that allows you to place the labels where yu want as well adjust
#represents vertical justification or horizontal justtification

###################################################
#######       Horizontal Bar Charts         #######
###################################################

#17. Create a horizontal barchart version of the BOD barchart using the coord_flip() function.
ggplot(O2, aes(Time, demand)) +
  geom_col(fill = 'lightblue', color = 'orange') +
  ylab('Demand') +
  geom_text(aes(label = demand), hjust = 1) +
  coord_flip()

###################################################
#######       Grouping Bars Together        #######
###################################################

#18. Create a bargraph that shows how each cut level in the diamonds dataset is 
    #distributed among the different clarity levels for the diamonds.
ggplot(rihanna, aes(x = cut, fill = clarity)) + 
  geom_bar(position = 'dodge')
#good for comparing side by side VS. stacked bar

###################################################
#######    Using Colors in a Bar Graph      #######
###################################################

#19. Exlpore the uspopchange dataset that comes with the gcookbook R package 
    #and create a barchart that shows the % change in population for the top 10 states. 
    #The bars should be colored based on the region of each state (default colors).
uspopchange
?uspopchange
ppl = uspopchange
str(ppl)

sorted_ppl = ppl[order(-ppl$Change), ]         #decesding order '-'
#indexing and incorporating order function since you want the top10 change percentage
top10 = sorted_ppl[1:10, ]

ggplot(top10, aes(x = Abb, y = Change, fill = Region)) + 
  geom_col()

#20. Use the scale_fill_manual() function to update the colors of the previous chart as follows: 
    #South (pink), and West (lightblue).
ggplot(top10, aes(x = Abb, y = Change, fill = Region)) + 
  geom_col() +
  scale_fill_manual(values = c('pink', 'lightblue'))

?scale_fill_manual

#21. Reorder the bars in the previous barchart to decreasing order.
ggplot(top10, aes(x = reorder(Abb, -Change), y = Change, fill = Region)) + 
  geom_col() 
#reorder(Abb, -Change) means: reorder Abb(States) by the volume of change descending;
#and the whole reorder() --> the x in the graph
?reorder

###################################################
#####    Cleveland Dot Plot or Dot Plots      #####
###################################################

#22. Explore the tophitters2001 dataset that comes in the gcookbook R package.
tobb = tophitters2001

#23. Create a dotplot that shows the name as well as the average batting score for the top 10 players.
top10bb = tobb[order(-tobb$avg), ][1:10, ]
ggplot(top10bb, aes(x = reorder(name, -avg), y = avg)) + 
  geom_point()
