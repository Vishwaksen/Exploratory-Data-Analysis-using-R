# R Script to fetch twitter data related to upcoming Presidential Elections for USA.
# The fetched data is formatted as JSON objects.
# R Script for Importing JSON objects.

#  Author : Vishwaksen Mane 

# Install and Activate Packages
#install.packages("rjson")

# Load the required libraries
library(rjson)

# Set the current working directory here
setwd("C:/R Demo Projects")

# Fetch the JSON files containing the twitter data crawled for 7 days into a dataframe.
Day1 <- fromJSON(paste(readLines('Day1_Json_Tweets.json'), collapse=""))
Day2 <- fromJSON(paste(readLines('Day2_Json_Tweets.json'), collapse=""))
Day3 <- fromJSON(paste(readLines('Day3_Json_Tweets.json'), collapse=""))
Day4 <- fromJSON(paste(readLines('Day4_Json_Tweets.json'), collapse=""))
Day5 <- fromJSON(paste(readLines('Day5_Json_Tweets.json'), collapse=""))
Day6 <- fromJSON(paste(readLines('Day6_Json_Tweets.json'), collapse=""))
Day7 <- fromJSON(paste(readLines('Day7_Json_Tweets.json'), collapse=""))


# Write the dataframes collected for 7 days of crawled tweets into CSV files
write.csv(Day1,file="Day1.csv")
write.csv(Day2,file="Day2.csv")
write.csv(Day3,file="Day3.csv")
write.csv(Day4,file="Day4.csv")
write.csv(Day5,file="Day5.csv")
write.csv(Day6,file="Day6.csv")
write.csv(Day7,file="Day7.csv")

#Plotting graphs to analyse data 
#Barplot to analyse which user the most in the sample collected for Day2
counts=table(Day2$screenName)
barplot(counts)

#Barplot to analyse users who tweeted twice or more in data sample for Day2 
cc=subset(counts,counts>1)
barplot(cc,las=2,cex.names = 0.3)