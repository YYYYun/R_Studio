install.packages('dplyr')
library(dplyr)
install.packages('hflights')
library(hflights)
install.packages("ggplot2")
library(ggplot2)
#1. What order of operations should we use to find the average value of the ArrDelay (arrival delay)
   #variable for all American Airline flights in the hflights tbl
flights = hflights

##########################################################
####    Manipulating Variables (Select and Mutate)    ####
##########################################################

#2. Return a copy of hflights that contains the four columns related to delay 
   #(ActualElapsedTime, AirTime, ArrDelay, DepDelay).
df2 = select(flights, ActualElapsedTime, AirTime, ArrDelay, DepDelay)
df2
#we use select() on columns

#3. Return a copy of hflights containing the columns Origin up to Cancelled.
df3 = select(flights, Origin:Cancelled)

#4. Find the most concise way to select: columns Year up to and including DayOfWeek, columns ArrDelay
   #up to and including Diverted.
df4 = select(flights, c(Year:DayOfWeek, ArrDelay:Diverted))

#5. dplyr comes with a set of helper functions that can help you select variables. 
   #These functions find groups of variables to select, based on their names. 
   #dplyr provides 6 helper functions, each of which only works when used inside select().
df5 = select(flights, ends_with('Delay'))
df5

#########################################################################
#####    Use select and a helper function to return a tbl copy of   #####
#####       hflights that contains just ArrDelay and DepDelay.      #####
#########################################################################

#6. Use a combination of helper functions and variable names to return 
   #the UniqueCarrier, FlightNum, TailNum, Cancelled, and CancellationCode columns of hflights.
df6 = select(flights, starts_with('Cancel'), UniqueCarrier, ends_with('Num'))

#7. Which variables in hflight do you think count as a plane’s “ground time”? 
   #Use mutate() to add these variables together and save them as GroundTime.
df7 = mutate(flights, GroundTime = TaxiIn + TaxiOut)
?mutate
# we use mutate() to create, modify and delete columns in a dataframe

#############################################################
####    Manipulating Observations (Filter and Arrange)   ####
#############################################################

#8. Return a copy of all flights that traveled 3000 miles or more.
df8 = filter(flights, Distance >= 3000)

#9. Return a copy of all flights flown by one of American(AA), Alaska (AS), or JetBlue (B6) airlines.
df9 = filter(flights, UniqueCarrier %in% c('AA','AS','B6'))
n_distinct(rownames(df9$UniqueCarrier))
?n_distinct
#OR
df9b = filter(flights, UniqueCarrier == 'AA' | UniqueCarrier == 'AS' | UniqueCarrier == 'B6')

#10. Return a copy of all flights where taxi-ing took longer than flying.
df10 = filter(flights, (TaxiIn + TaxiOut) > AirTime)

#11. Return a copy of all cancelled weekend flights
df11 = filter(flights, DayOfWeek %in% c(6,7), Cancelled == 1)

#12. Arrange according to carrier and decreasing departure delays.
df12 = arrange(flights, UniqueCarrier, desc(DepDelay))
?group_by
?arrange

#13. Arrange flights by total delay (normal order).
df13 = arrange(flights, (ArrDelay + DepDelay))

#14. Filter out flights leaving to DFW before 8am and arrange according to decreasing AirTime
df14 = filter(arrange(flights, desc(AirTime)), Dest == 'DFW', DepTime < 800) 

#OR
df14b = arrange(filter(flights, Dest == 'DFW', DepTime < 800), desc(AirTime))

#OR
df14c = 
  flights %>%      #pipe operator allows you to get whatever is before
  filter(Dest == 'DFW', DepTime < 800) %>%
  arrange(desc(AirTime)) 

#########################################################
######     Manipulating Groups of Observation      ######
######           (summarize and group_by)          ######
#########################################################

#15. Determine the shortest and longest distance flown and save statistics to min_dist and max_dist resp.
df15 = 
  flights %>%
  summarise(min_dist = min(Distance), max_dist = max(Distance))

#16. Determine the longest distance for diverted flights, save statistic to max_div.
df16 = 
  flights %>%
  filter(Diverted == 1) %>%
  summarise(max_div = max(Distance))

##########   aggregate functions   ##########
#17. dplyr provides several helpful aggregate functions of its own, in addition to the ones that are 
    #already defined in R. These include:
   # • first(x) - The first element of vector x.
   # • last(x) - The last element of vector x.
   # • nth(x, n) - The nth element of vector x.
   # • n() - The number of rows in the data.frame or group of observations that summarise() describes.
   # • n_distinct(x) - The number of unique values in vector x.

#Create a table with the following variables (and variable names): 
    #the total number of observations in hflights (n_obs), 
    #the total number of carriers that appear in hflights (n_carrier), 
    #the total number of destinations that appear in hflights (n_dest), 
    #and the destination of the flight that appears in the 100th row of hflights (dest100).

df17 = flights %>%
  summarise(n_obs = n(),
            n_carrier = n_distinct(flights$UniqueCarrier),
            n_dest = n_distinct(Dest),
            dest100 = nth(Dest, 100)
            )

#18. Use Piping: (1) Take the hflights data set and then, 
#(2) Add a variable named diff that is the result of subtracting TaxiIn from TaxiOut, 
#and then (3) pick all of the rows whose diff value does not equal NA, 
#and then (4) summarise the data set with a value named avg that is the mean diff value.
df18 = flights %>%
  mutate(diff = TaxiOut - TaxiIn) %>%
  filter(!is.na(diff)) %>%   #do not include if there is a missing value
  summarise(avg = mean(diff))

#missing data, na.rm this means remove missing data
# flights$diff.na.rm = True
#you also have another option is na.omit
#is.na more so asking if there's any missing value

#19. Use Piping: Define a data set named d that contains just the Dest, UniqueCarrier, Distance, 
#and ActualElapsedTime columns of hflights as well an additional variable: RealTime 
#which is equal the actual elapsed time plus 100 minute.
d = flights %>%
  select(Dest, UniqueCarrier, Distance,ActualElapsedTime)  %>%
  mutate(RealTime = ActualElapsedTime + 100)

#20. For each destination, find the number of flights, the mean distance travelled, 
#and the mean arrival delay and investigate visually if there is any relationship between distance travelled 
#and arrival delays. You can get rid of the outliers if any.
df20 = flights %>%
  group_by(Dest) %>%
  filter(!is.na(ArrDelay)) %>%     #a method to remove missing data from ArrDelay
  summarise(numflt = n(),
            meandis = mean(Distance),
            meandelay = mean(ArrDelay),
            )  
#  ggplot(aes(meandis, meandelay)) + geom_point()



