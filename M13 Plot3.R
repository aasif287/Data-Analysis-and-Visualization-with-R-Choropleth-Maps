#loads libraries
library(ggplot2)
library(maps)
library(mapdata)
#gathers data from usa and states and counties and puts into variable 
usa<-map_data("usa")
states<-map_data("state")
counties<-map_data("county")
#creates map of usa with states along with title
state_base<-ggplot(data=states,mapping=aes(x=long,y=lat,group=group))+coord_fixed(1.3)+geom_polygon(color="black",fill="gray")+ggtitle("Counties with High Life Expectancy (79 or above) in each State")
#adds county region on map but looks the same
p<-state_base+geom_polygon(data=counties,fill=NA, color="gray")+geom_polygon(color="black", fill=NA)

#reads file and collects column names and values 
life<- read.csv("lifeexp.csv")
colnames(life)<-c("State","LifeExp")
life$LifeExp<-as.numeric(as.character(life$LifeExp))
#merges dataset by names of states and makes lowercase
life$State<-tolower(life$State)
#renames data in dataset
names(counties)[names(counties)=="region"]<-"State"
#merges data set
life<-merge(counties,life, by="State")
#filters the data set
biglife<-subset(life, life$LifeExp >= 79)
#adds datapoints onto map with certain color and size 
biglives<-p+geom_point(inherit.aes = F, aes(x=long,y=lat),color="blue", size=0.5, data=biglife)
#displays map
biglives



