#  Author : Vishwaksen Mane 

library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  
  # Application title
  titlePanel("Stream Processing for USA Presidential Elections 2016!"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      # sliderInput("bins",
      #            "Number of bins:",
      #           min = 1,
      #          max = 50,
      #         value = 30)
      #,
      fluidRow( column(3,
                       h3("WordCloud Checkbox"),
                       checkboxInput("checkbox", label = "WordCloud", value = TRUE)))),
                
    # Show a plot of the generated distribution
    mainPanel(
      img (src="http://ropercenter.cornell.edu/wp/wp-content/uploads/2014/11/2016-Election.gif",height=200,width=200),
      img (src="https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcR2FszHID5u8c0L9gafGVvbxjEfrIFs6EuUPpIx8nghTkbCmpBI", height=225,width=475),
      plotOutput("plot")
      #plotOutput("distPlot"), #Here I will show the bars graph
      #sidebarPanel(
      #  plotOutput("positive_wordcloud") #Cloud for positive words
      #),
      #sidebarPanel(
      #  plotOutput("negative_wordcloud") #Cloud for negative words
      #),
      #sidebarPanel(
      #  plotOutput("neutral_wordcloud") #Cloud for neutral words
      #)
    )
  ))