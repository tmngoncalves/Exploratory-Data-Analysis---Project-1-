## The following code loads the data into a data frame and substitutes all "?" 
## by NA.
data <- read.table("household_power_consumption.txt",sep=";", 
                   stringsAsFactors = FALSE,na.strings=c("?"))
## With the following code, it is possible to see the first row of the data 
## frame consists of the names of the variables. So the first row was used to
## name the variables and then the first row of the data frame was removed.
head(data)
names(data) <- data[1,]
names(data)
dim(data)
dataf <- data[2:2075260,]
## The following code removes the rows with NA's.
dataNAfree <- dataf[complete.cases(dataf),]
## With this code, a new variable is created: Date-Time. This new variable is 
## necessary to create the plots: it is the variable associated to the x axis. 
## Furthermore, the data for this new variable are transformed into the type
## Date/Time, in order to allow plotting. Finally, the data is filtered in order 
## to keep only two dates: 1st and 2nd of february 2007.
df <- dataNAfree %>% mutate(Date_Time=paste(Date, Time, sep = " ")) %>% 
        mutate(Date_Time=strptime(Date_Time,format="%d/%m/%Y %H:%M:%S")) %>% 
        filter(Date == "1/2/2007" | Date == "2/2/2007")
## All the data that is not related to date and time, are transformed to the 
## numeric type. This is necessary in order to be able to plot.
df[,c(3:9)] <- sapply(df[,c(3:9)],as.numeric)

## This code create a png file named plot2.png.
png(filename="plot2.png",width=480,height=480,units="px")
## This code generates a plot of the change of global active power through time.
## Note that the type "l" allows to plot a line (piecewise curve, where each 
## piece is a line).
with(df,plot(Date_Time,Global_active_power,type="l",xlab="",
             ylab="Global Active Power (kilowatts)"))
## This code closes the file device. If this code is not executed, it is 
## impossible to visualize the png file.
dev.off()