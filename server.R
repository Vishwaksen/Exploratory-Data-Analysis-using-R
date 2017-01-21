#  Author : Vishwaksen Mane 

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  # R Fetch twitter data related to upcoming Presidential Elections for USA.
  # Declare Twitter API Credentials
  api_key <- "W8xGZm5KNPeiY5PEah20iikXn" # From dev.twitter.com
  api_secret <- "x89ZpS2eOLserlZMUP2MsFyWShUwdwcdK3sXkB3SK4ZjZVOU8p" # From dev.twitter.com
  token <- "3556700356-W24SgujrNl12689UqCHcGL6qjX8IGJnaQZvuYOM" # From dev.twitter.com
  token_secret <- "HVoNs0RS9ChuumJotrU9PjGxSXgoYr3G2x5T6tQ7Hxagu"  # From dev.twitter.com
  
  
  # Establish a connection to Twitter through your credentials
  setup_twitter_oauth(api_key, api_secret, token, token_secret)
  
  
  # Crawl Twitter data for 7 days
  day1 <- searchTwitter("Donald Trump", n=800, lang="en", since="2016-02-25",until = "2016-02-26", retryOnRateLimit = 790)
  day2 <- searchTwitter("Hillary Clinton", n=800, lang="en", since="2016-02-26",until = "2016-02-27", retryOnRateLimit = 790)
  day3 <- searchTwitter("Bernie Sanders", n=800, lang="en", since="2016-02-27",until = "2016-02-28", retryOnRateLimit = 790)
  day4 <- searchTwitter("Ted Cruz", n=800, lang="en", since="2016-02-28",until = "2016-02-29", retryOnRateLimit = 790)
  day5 <- searchTwitter("Donald Trump", n=800, lang="en", since="2016-02-29",until = "2016-03-01", retryOnRateLimit = 790)
  day6 <- searchTwitter("Republican OR Democratic", n=800, lang="en", since="2016-03-01",until = "2016-03-02", retryOnRateLimit = 790)
  day7 <- searchTwitter("Hillary Clinton", n=800, lang="en", since="2016-03-02",until = "2016-03-05", retryOnRateLimit = 790)
  
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
  
  # Convert the dataframe of collected tweets into CSV files to gather sample data.
  write.csv(day1.df, file = "Day1.csv")
  write.csv(day2.df, file = "Day2.csv")
  write.csv(day3.df, file = "Day3.csv")
  write.csv(day4.df, file = "Day4.csv")
  write.csv(day5.df, file = "Day5.csv")
  write.csv(day6.df, file = "Day6.csv")
  write.csv(day7.df, file = "Day7.csv")
  
  # Removing invalid ASCII characters from the dataframe.
  data1 <- sapply(day1.df$text, function(row) iconv(row, "latin1", "ASCII", sub=""))
  data2 <- sapply(day2.df$text, function(row) iconv(row, "latin1", "ASCII", sub=""))
  data3 <- sapply(day3.df$text, function(row) iconv(row, "latin1", "ASCII", sub=""))
  data4 <- sapply(day4.df$text, function(row) iconv(row, "latin1", "ASCII", sub=""))
  data5 <- sapply(day5.df$text, function(row) iconv(row, "latin1", "ASCII", sub=""))
  data6 <- sapply(day6.df$text, function(row) iconv(row, "latin1", "ASCII", sub=""))
  data7 <- sapply(day7.df$text, function(row) iconv(row, "latin1", "ASCII", sub=""))
  
  mydat <- rbind(day1.df,day2.df,day3.df,day4.df,day5.df,day6.df,day7.df)
  final_data <- rbind(data1,data2,data3,data4,data5,data6,data7)
  # Creating a WordCloud
  # Create corpus
  corpus=Corpus(VectorSource(final_data))
  
  # Convert to lower-case
  corpus=tm_map(corpus,tolower)
  
  # Remove stopwords
  corpus=tm_map(corpus,function(x) removeWords(x,stopwords()))
  
  # convert corpus to a Plain Text Document
  corpus=tm_map(corpus,PlainTextDocument)
  
  
  #  mydata <- rbind(mydata1,mydata2,mydata3,mydata4,mydata5,mydata6,mydata7)
  
  # terms <- reactive({
  # Change when the "update" button is pressed...
  #  input$update
  # ...but not for anything else
  # isolate({
  #  withProgress({
  #   setProgress(message = "Processing Results...") 
  #  })
  #})
  #})
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically
  #     re-executed when inputs change
  #  2) Its output type is a plot
  
  output$plot <- renderPlot({
    #   x    <- faithful[, 2]  # Old Faithful Geyser data
    #  bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    # hist(x, breaks = bins, col = 'darkgray', border = 'white')
    col=brewer.pal(8,"Dark2")
    wordcloud(corpus, min.freq=9, scale=c(3,0.5),rot.per = 0.25,
              random.color=T, max.word=150, random.order=F,colors=col)
  })
  
})
