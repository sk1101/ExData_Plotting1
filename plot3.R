setwd("C:\\Users\\Shrishti\\Downloads\\exdata_data_household_power_consumption")
cofile<-file("household_power_consumption.txt",open = "r")
dat<-c()
## Reading the col names:
colnamess<-readLines(cofile,1)
colnamesf<-strsplit(colnamess,split = ";")
while(TRUE){
  l<-readLines(cofile,1)
  if(grepl("^(3/2/2007)",l)){
    break
  }
  else if(grepl("^(1/2/2007|2/2/2007)",l)){
    dat<-c(dat,l)
  }
}
close(cofile)

#Making the data frame (tidy data):
datf<-strsplit(dat,split=";")
ldf<-c()
glo<-data.frame(matrix(ncol = 9,nrow=0),stringsAsFactors = FALSE)
colnames(glo)<-colnamesf[[1]]
for(i in seq_along(datf))
{
  tgf<-data.frame(matrix(ncol=9,nrow = 0),stringsAsFactors = FALSE)
  tgf<-rbind(tgf,datf[[i]])
  colnames(tgf)<-colnamesf[[1]]
  glo<-rbind(glo,tgf)
}

#Plotting the data:
g<-mapply(paste,as.character(glo$Date),as.character(glo$Time))
glo$gd<-strptime(g,"%d/%m/%Y %T")
png(filename = "plot3.png")
with(glo,plot(gd,as.numeric(as.character(Sub_metering_1)),col="black",type = "l",ylab = "Energy sub metering",xlab = ""))
with(glo,points(gd,as.numeric(as.character(Sub_metering_2)),col="red",type = "l"))
with(glo,points(gd,as.numeric(as.character(Sub_metering_3)),col="blue",type = "l"))
legend("topright",col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ),lwd=1)
dev.off()