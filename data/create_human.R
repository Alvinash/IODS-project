hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#exploring hd data
dim(hd)
# 195 obs out of 8 variables
str(hd)
summary(hd)
# exploring gii data
dim(gii)
# 195 obs out of 10 variables
str(gii)
summary(gii)

#changing names of both data sets
colnames(hd)
colnames(hd)[3]<-"HDI"
colnames(hd)[4]<-"Life Expectancy"
colnames(hd)[7]<-"GNI per capita"
colnames(hd)[8]<-"GNI-HDI Rank"
colnames(hd)

colnames(gii)
colnames(gii)[3]<-"GII"
colnames(gii)[4]<-"Mat Mor Ratio"
colnames(gii)[5]<-"Birth Rate"
colnames(gii)[6]<-"Parliment Percentage"
colnames(gii)[7]<-"F2Edu"
colnames(gii)[8]<-"M2Edu"
colnames(gii)[9]<-"FLab"
colnames(gii)[10]<-"MLab"
colnames(gii)

#mutating 2 new variables with gender ratios for both education and labor force.
gii<-mutate(gii,EduRatio=(F2Edu/M2Edu))%>%mutate(LabRatio=(FLab/MLab))
glimpse(gii)

#Joining the 2 data set via countries
human<-dplyr::inner_join(hd,gii,by=colnames(gii[2]))
dim(human)
#got 195 obs out of 19 variables, correct. 