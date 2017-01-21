# R Script to fetch twitter data related to upcoming Presidential Elections for USA.
# The fetched data is formatted as JSON objects. 
# R Script for Data Mining

#  Author : Vishwaksen Mane 

# Install and Activate Packages
#install.packages("twitteR", "rjson")

# Load the required libraries
library(twitteR)
library(jsonlite)


# Set the current working directory here
setwd("C:/R Demo Projects")


# Declare Twitter API Credentials
api_key <- "W8xGZm5KNPeiY5PEah20iikXn" # From dev.twitter.com
api_secret <- "x89ZpS2eOLserlZMUP2MsFyWShUwdwcdK3sXkB3SK4ZjZVOU8p" # From dev.twitter.com
token <- "3556700356-W24SgujrNl12689UqCHcGL6qjX8IGJnaQZvuYOM" # From dev.twitter.com
token_secret <- "HVoNs0RS9ChuumJotrU9PjGxSXgoYr3G2x5T6tQ7Hxagu"  # From dev.twitter.com


# Establish a connection to Twitter through your credentials
setup_twitter_oauth(api_key, api_secret, token, token_secret)


# Crawl Twitter data for 7 days
day1 <- searchTwitter("Donald Trump", n=800, lang="en", since="2016-02-22",until = "2016-02-23", retryOnRateLimit = 790)
day2 <- searchTwitter("Hillary Clinton", n=800, lang="en", since="2016-02-23",until = "2016-02-24", retryOnRateLimit = 790)
day3 <- searchTwitter("Jeb Bush", n=800, lang="en", since="2016-02-24",until = "2016-02-25", retryOnRateLimit = 790)
day4 <- searchTwitter("Republican OR Democratic", n=800, lang="en", since="2016-02-25",until = "2016-02-26", retryOnRateLimit = 790)
day5 <- searchTwitter("Donald Trump", n=800, lang="en", since="2016-02-26",until = "2016-02-27", retryOnRateLimit = 790)
day6 <- searchTwitter("Republican OR Democratic", n=800, lang="en", since="2016-02-27",until = "2016-02-28", retryOnRateLimit = 790)
day7 <- searchTwitter("Hillary Clinton", n=800, lang="en", since="2016-02-28",until = "2016-02-29", retryOnRateLimit = 790)


# Transform the crawled tweets list into a data frame for all 7 days.
day1.df <- twListToDF(day1)
day2.df <- twListToDF(day2)
day3.df <- twListToDF(day3)
day4.df <- twListToDF(day4)
day5.df <- twListToDF(day5)
day6.df <- twListToDF(day6)
day7.df <- twListToDF(day7)

# Convert the dataframe of collected tweets into JSON format
day1_Json <- toJSON(day1.df, .na="")
day2_Json <- toJSON(day2.df, .na="")
day3_Json <- toJSON(day3.df, .na="")
day4_Json <- toJSON(day4.df, .na="")
day5_Json <- toJSON(day5.df, .na="")
day6_Json <- toJSON(day6.df, .na="")
day7_Json <- toJSON(day7.df, .na="")


# Writing the fetched JSON formatted tweets of 7 days into a JSON File.
write(day1_Json, file = "Day1_Json_Tweets.json")
write(day2_Json, file = "Day2_Json_Tweets.json")
write(day3_Json, file = "Day3_Json_Tweets.json")
write(day4_Json, file = "Day4_Json_Tweets.json")
write(day5_Json, file = "Day5_Json_Tweets.json")
write(day6_Json, file = "Day6_Json_Tweets.json")
write(day7_Json, file = "Day7_Json_Tweets.json")