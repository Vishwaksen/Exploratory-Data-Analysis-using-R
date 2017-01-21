# R SCript to perform EDA on Monthly Data(Manhattan, Queens, StateIslands, Brooklyn, Bronx)

#  Author : Vishwaksen Mane 

#install.packages("gdata")
require(gdata)

# Set the current working directory here
setwd("C:/R Demo Projects/dds_datasets/dds_datasets/dds_ch2_rollingsales")

# Path for Perl interpreter so as to read excel files using read.xls
perl <- ("C:/Strawberry/perl/bin/perl5.22.1.exe")

# Combining data across files for EDA on monthly data.
bk1 <- read.xls("rollingsales_queens.xls",pattern="BOROUGH",perl=perl)
bk2 <- read.xls("rollingsales_manhattan.xls",pattern="BOROUGH",perl=perl)
bk3 <- read.xls("rollingsales_brooklyn.xls",pattern="BOROUGH",perl=perl)
bk4 <- read.xls("rollingsales_statenisland.xls",pattern="BOROUGH",perl=perl)
bk5 <- read.xls("rollingsales_bronx.xls",pattern="BOROUGH",perl=perl)
data1=rbind(data1,bk1)
data2=rbind(bk2,data1)
data3=rbind(bk3,data2)
data4=rbind(bk4,data3)
bk=rbind(bk5,data4)

head(bk)
summary(bk)
bk$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","",bk$SALE.PRICE))
names(bk) <- tolower(names(bk))

# Cleaning and Formatting the data with Regular Expressions
bk$gross.sqft <- as.numeric(gsub("[^[:digit:]]","",bk$gross.square.feet))
bk$land.sqft <- as.numeric(gsub("[^[:digit:]]","",bk$land.square.feet))

bk$sale.date <- as.Date(bk$sale.date)
bk$year.built <- as.numeric(as.character(bk$year.built))

# Exploring more about the Data
attach(bk)
hist(sale.price.n)
hist(sale.price.n[sale.price.n>0])
hist(gross.sqft[sale.price.n==0])
detach(bk)

# Actual Sales
bk.sale <- bk[bk$sale.price.n!=0,]

plot(bk.sale$gross.sqft,bk.sale$sale.price.n)
plot(log(bk.sale$gross.sqft),log(bk.sale$sale.price.n))

# Analysing 1,2,3 boroughs
bk.homes <- bk.sale[which(grepl("FAMILY",bk.sale$building.class.category)),]
plot(log(bk.homes$gross.sqft),log(bk.homes$sale.price.n))

bk.homes[which(bk.homes$sale.price.n<100000),][order(bk.homes[which(bk.homes$sale.price.n<100000),]$sale.price.n),]

# Removing Outliers which did not reflect actual sales
bk.homes$outliers <- (log(bk.homes$sale.price.n) <=5) + 0
bk.homes <- bk.homes[which(bk.homes$outliers==0),]

plot(log(bk.homes$gross.sqft),log(bk.homes$sale.price.n))