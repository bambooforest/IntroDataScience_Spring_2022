#H1: Both species have similar trend
#H0: Different species have different trend

#Load the packages
#install.packages("tseries")
library(tidyverse)
library(tseries)

#Set the working directory and load the dataset

setwd("/home/marco/Desktop/Neuchatel_PhD/Lectures_Material/Time_Series/Datasets")

data <- read.csv("Species_Individuals_center_Italy.csv")

str(data)

#Explore the dataset and filter if necessary

data <- data %>%
 mutate (Date = paste(Year, Month, '1', sep = '-'))

data$Date <- as.Date(data$Date, format = '%Y-%m-%d')

data$Individuals <- as.numeric(data$Individuals)

str(data)

data0 <- filter(data, Species == "Sus scrofa")

is.ts(data0)

data0

data0.ts <- ts(data0$Individuals, start = c(2020,10),frequency = 12)

is.ts(data0.ts)

print(data0.ts)

str(data0.ts)

start(data0.ts)

end(data0.ts)

frequency(data0.ts)

deltat(data0.ts)

#Plot as a time-series (plot + acf), which visualization is better?
#Axis control
xmin<-min(data0$Date,na.rm=T);xmax<-max(data0$Date,na.rm=T) #ESTABLISH X-VALUES (MIN & MAX)
ymin<-min(data0$Individuals,na.rm=T);ymax<-max(data0$Individuals,na.rm=T) #ESTABLISH Y-VALUES (MIN & MAX)
xseq<-seq.Date(xmin,xmax,by='1 month') #CREATE DATE SEQUENCE THAT INCREASES BY MONTH FROM DATE MINIMUM TO MAXIMUM
yseq<-round(seq(0,ymax,by=10),0) # CREATE SEQUENCE FROM 0-350 BY 50
#Plot
plot(Individuals~Date,data=data0,type='b',ylim=c(0,ymax),axes=F,xlab='',ylab='', main = "Individuals presence");box() #PLOT LEVEL AS A FUNCTION OF DATE, REMOVE AXES FOR FUTURE CUSTOMIZATION 
axis.Date(side=1,at=xseq,format='%Y-%m',labels=T,las=3) #ADD X-AXIS LABELS WITH "YEAR-MONTH" FORMAT
axis(side=2,at=yseq,las=2) #ADD Y-AXIS LABELS
mtext('Date',side=1,line=5) #X-AXIS LABEL
mtext('Individuals',side=2,line=4) #Y-AXIS LABEL

#Remove NAs
mean(data0.ts, na.rm = TRUE)
data0.ts[8] <- mean(data0.ts, na.rm = TRUE)

#Plot without NAs
par (mfrow=c(2,1), mar=c(4,4,4,4))

plot(data0.ts, type = "b",xlab = "Date", ylab = "N individuals", main = "Boar individals", axes = T);box()
#axis(2);
#axis.Date(1,xlim=xseq, at=xseq, format='%Y-%m', labels=T)
acf(data0.ts, main = "acf boar spotted")

#Which model is more suitable?

data0_AR <- arima(data0.ts, order = c(1,0,0))
print(data0_AR)
ts.plot(data0.ts, xlab = "Date", ylab = "Individuals", main = "AR Individuals boar", type = "b")
AR_fitted0 <- data0.ts - residuals(data0_AR)
points(AR_fitted0, type = "l", col = 2, lty = 2)

data0_MA <- arima(data0.ts, order = c(0,0,1))
print(data0_MA)
ts.plot(data0.ts, xlab = "Date", ylab = "Individuals", main = "MA Individuals boar", type = "b")
MA_fitted0 <- data0.ts - residuals((data0_MA))
points(MA_fitted0, type = "l", col = 2, lty = 2)
#Which model is better?

cor(AR_fitted0, MA_fitted0)

#Autoregression
AIC(data0_AR) #better
BIC(data0_AR)

#Moving Average
AIC(data0_MA) #better
BIC(data0_MA)

###--------------------------------------------------------Capreolus
#Explore the dataset and filter if necessary

data1 <- filter(data, Species == "Capreolus capreolus")

is.ts(data1)

data1 <- data1 %>%
  mutate (Date = paste(Year, Month, '1', sep = '-'))

data1$Date <- as.Date(data1$Date, format = '%Y-%m-%d')

data1

data1$Individuals <- as.numeric(data1$Individuals)

data1.ts <- ts(data1$Individuals, start = c(2020, 10), end = c(2021, 09), frequency = 12)

is.ts(data1.ts)

print(data1.ts)

str(data1.ts)

start(data1.ts)

end(data1.ts)

frequency(data1.ts)

deltat(data1.ts)

#Plot as a time-series (plot + acf), which visualization is better?
#Axis control
xmin<-min(data1$Date,na.rm=T);xmax<-max(data1$Date,na.rm=T) #ESTABLISH X-VALUES (MIN & MAX)
ymin<-min(data1$Individuals,na.rm=T);ymax<-max(data1$Individuals,na.rm=T) #ESTABLISH Y-VALUES (MIN & MAX)
xseq<-seq.Date(xmin,xmax,by='1 month') #CREATE DATE SEQUENCE THAT INCREASES BY MONTH FROM DATE MINIMUM TO MAXIMUM
yseq<-round(seq(0,ymax,by=10),0) # CREATE SEQUENCE FROM 0-350 BY 50
#Plot
plot(Individuals~Date,data=data1,type='b',ylim=c(0,ymax),axes=F,xlab='',ylab='', main = "Individuals presence");box() #PLOT LEVEL AS A FUNCTION OF DATE, REMOVE AXES FOR FUTURE CUSTOMIZATION 
axis.Date(side=1,at=xseq,format='%Y-%m',labels=T,las=3) #ADD X-AXIS LABELS WITH "YEAR-MONTH" FORMAT
axis(side=2,at=yseq,las=2) #ADD Y-AXIS LABELS
mtext('Date',side=1,line=5) #X-AXIS LABEL
mtext('Individuals',side=2,line=4) #Y-AXIS LABEL

#Remove NAs
#mean(data1.ts, na.rm = TRUE)
#data1.ts[8] <- mean(data.ts, na.rm = TRUE)

#Plot without NAs
par (mfrow=c(2,1), mar=c(4,4,4,4))

plot(data1.ts, type = "b",xlab = "Date", ylab = "N individuals", main = "Roe deer individals", axes = T);box()
#axis(2);
#axis.Date(1,xlim=xseq, at=xseq, format='%Y-%m', labels=T)
acf(data1.ts, main = "acf roe deer spotted")

#Which model is more suitable?

data1_AR <- arima(data1.ts, order = c(1,0,0))
print(data1_AR)
ts.plot(data1.ts, xlab = "Date", ylab = "Individuals", main = "AR Individuals roe deer", type = "b")
AR_fitted1 <- data1.ts - residuals(data1_AR)
points(AR_fitted1, type = "l", col = 2, lty = 2)

data1_MA <- arima(data1.ts, order = c(0,0,1))
print(data1_MA)
ts.plot(data1.ts, xlab = "Date", ylab = "Individuals", main = "MA Individuals roe deer", type = "b")
MA_fitted1 <- data1.ts - residuals((data1_MA))
points(MA_fitted1, type = "l", col = 2, lty = 2)

#Which model is better?

cor(AR_fitted1, MA_fitted1)

#Autoregression
AIC(data1_AR)
BIC(data1_AR)

#Moving Average
AIC(data1_MA)
BIC(data1_MA)

#Final plot

par (mfrow=c(2,1), mar=c(4,4,4,4))

ts.plot(data0.ts, xlab = "Date", ylab = "Individuals", main = "AR Individuals boar", type = "b")
AR_fitted0 <- data0.ts - residuals(data0_AR)
points(AR_fitted0, type = "l", col = 2, lty = 2)

ts.plot(data1.ts, xlab = "Date", ylab = "Individuals", main = "AR Individuals roe deer", type = "b")
AR_fitted1 <- data1.ts - residuals(data1_AR)
points(AR_fitted1, type = "l", col = 2, lty = 2)

