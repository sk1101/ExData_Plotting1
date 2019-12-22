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
gd<-strptime(g,"%d/%m/%Y %T")
png(filename = "plot2.png")
plot(gd,as.numeric(as.character(glo$Global_active_power)),type="l",ylab = "Global Active Power(kilowatts)",xlab = "")
dev.off()