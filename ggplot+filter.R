######    DSO545 Homework2    #####

###  Case 01: Tips
install.packages('dplyr')
library(dplyr)
install.packages("ggplot2")
library(ggplot2)

tipsdf = read.csv(file.choose())
str(tipsdf)

#1. Write R code to find out how many females are there in the dataset?
df1 = filter(tipsdf, sex == 'F')
count(df1)

#2. Write R code to find out how many non-smoker females are there in the dataset?
df2 = filter(tipsdf, sex == 'F', smoker == 'No')
count(df2)

#3. Create a copy of the following bar chart that shows the number of males and females in the data. 
   #Use colors (pink = smokers, lightblue= non-smokers) to show the distribution of smokers 
   #and non-smokers among each gender. Count of Smokers/Non−smokers for Each Gender.
ggplot(tipsdf, aes(x = sex, fill = smoker)) +
  geom_bar() +
  scale_fill_manual(values = c('lightblue', 'pink'))

#4. Add a new variable called “tipCategory” to the dataset. 
  #The value of “tipCategory” is “Low” if the tip <= 2.5, otherwise, it is “High”.
  #Create a copy of the following bar chart that shows the distribution of low and high tips.
df4 = tipsdf %>%
  mutate(tipsCategory = if_else(tipsdf$tip <= 2.5, 'Low', 'High'))

#OR
df4b = tipsdf %>%
  mutate(tipsCategory = case_when(
    tipsdf$tip <= 2.5 ~ 'Low',
    tipsdf$tip >= 2.5 ~ 'High'
  ))

ggplot(df4, aes(x = tipsCategory)) + geom_bar()


###  Case 02: Which countries host the Syrian refugees?

rfg = read.csv(file.choose())
str(rfg)

#5. Write R code to find out how many Asian countries host Syrian refugees?
df5 = filter(rfg, continent == 'Asia')
count(df5)

#6. Write R code to find out how many Asian and European countries host Syrian refugees?
df6 = filter(rfg, continent %in% c('Asia', 'Europe'))
count(df6)

#7. Write R code to find the total number of Syrian refugees hosted in North America?
df7 = rfg %>%
  filter(continent == 'North America') %>%
  summarise(sum(refugees))

#8. Create a dot plot, showing the top 20 countries hosting the highest number of Syrian refugees.
top10 = rfg[order(rfg$refugees), ][1:10, ]
ggplot(top10, aes(x = reorder(Country, -refugees), y = refugees)) + 
  geom_point() +
  xlab('Country') +
  ylab('Num of Refugees')

