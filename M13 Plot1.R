#loads libraries
library(ggplot2)
library(maps)
library(mapdata)
#gathers data from usa and states and puts into variable 
usa<-map_data("usa")
states<-map_data("state")
#creates map of usa with states 
state_base <- ggplot(data=states,mapping=aes(x=long,y=lat,group=group))+coord_fixed(1.3)+geom_polygon(color="black",fill="gray")
#reads file and collects column names and values 
miles<- read.csv("milesdrive.csv")
colnames(miles)<-c("State","VMT")
miles$VMT<-as.numeric(as.character(miles$VMT))
#renames data in dataset
names(states)[names(states)=="region"]<-"State"
#merges dataset by names of states
miles$State<-tolower(miles$State)
stco<-merge(states,miles, by="State")
#creates cholopleth map based on values in the dataset
eb1<-state_base+geom_polygon(data=stco,aes(fill=VMT),color="white") +geom_polygon(color="black",fill=NA)+coord_fixed(1.3)+theme_bw()+ggtitle("The Amount of Miles Driven in Each State")
#assign color gradeint to map based on values
eb2<-eb1+scale_fill_gradient(low="lightgreen", high="darkgreen")
#displays map
eb2
