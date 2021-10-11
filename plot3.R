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

## This code create a png file named plot3.png.
png(filename="plot3.png",width=480,height=480,units="px")
## This code allows to plot three piecewise curves (where each piece is a line),
## in one plot as layers. These curves correspond to the energy submetering for
## three distinct areas in a household: the kitchen, the laundry room, and 
## the water-heater and air-conditioning.
with(df,plot(Date_Time,Sub_metering_1,type="l",col="black",xlab="",
                                           ylab="Energy sub metering"))
with(df,lines(Date_Time,Sub_metering_2,col="red"))
with(df,lines(Date_Time,Sub_metering_3,col="blue"))
## The code lty is necessary, otherwise the line color will not appear in the 
## legend.
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=c(1,1,1))
## This code closes the file device. If this code is not executed, it is 
## impossible to visualize the png file.
dev.off()