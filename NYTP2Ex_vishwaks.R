# R Script to perform EDA on New York Times Monthly Data

#  Author : Vishwaksen Mane 

#Constructing a dataframe to accomodate NYT's monthly data.
urlpart1="http://stat.columbia.edu/~rachel/datasets/nyt"
urlpart2=".csv"
data1=read.csv(url("http://stat.columbia.edu/~rachel/datasets/nyt1.csv")) #put day1 data first
for(i in 2:31){
  wholeurl=paste(paste(urlpart1,i,sep=""),urlpart2,sep="") #construct the url for different days urlpart1+i+urlpart2
  subdataframe=read.csv(url(wholeurl))
  data1=rbind(data1,subdataframe) 
}

head(data1)

#Categorizing the data
#Creating variable age_group that classifies users into following age groups
#Age Group Classification: "<18","18-24", "25-34", "35-44", "45-54", "55-64", and "65+"
data1$age_group <-cut(data1$Age,c(-Inf,0,18,24,34,44,54,64,Inf))

#Summarizing the data
summary(data1)

#Use summaryBy function from "doBy" library to compute summary statistics
#install.packages("doBy")
library("doBy")

siterange <- function(x){c(length(x), min(x), mean(x), max(x))}
#Use summaryBy to calculate groupwise summary statistics.
summaryBy(Age~age_group, data =data1, FUN=siterange)

#Only signed in users should have ages and gender.
summaryBy(Gender+Signed_In+Impressions+Clicks~age_group, data =data1)

#install.packages("ggplot2")
library(ggplot2)
ggplot(data1, aes(x=Impressions, fill=age_group)) + geom_histogram(binwidth=1)
ggplot(data1, aes(x=age_group, y=Impressions, fill=age_group)) + geom_boxplot()

#Creating Click thru rate for clicks with impressions
data1$hasimps <-cut(data1$Impressions,c(-Inf,0,Inf))
summaryBy(Clicks~hasimps, data =data1, FUN=siterange)
ggplot(subset(data1, Impressions>0), aes(x=Clicks/Impressions,
                                         colour=age_group)) + geom_density()
ggplot(subset(data1, Clicks>0), aes(x=Clicks/Impressions,
                                    colour=age_group)) + geom_density()
ggplot(subset(data1, Clicks>0), aes(x=age_group, y=Clicks,
                                    fill=age_group)) + geom_boxplot()
ggplot(subset(data1, Clicks>0), aes(x=Clicks, colour=age_group)) + geom_density()

#Categorizing the User's based on their click behavior into variable scode.
data1$scode[data1$Impressions==0] <- "NoImps"
data1$scode[data1$Impressions >0] <- "Imps"
data1$scode[data1$Clicks >0] <- "Clicks"

#Transform the column into factor
data1$scode <- factor(data1$scode)
head(data1)

#Analyse the levels
clen <- function(x){c(length(x))}
etable<-summaryBy(Impressions~scode+Gender+age_group,
                  data = data1, FUN=clen)
