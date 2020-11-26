human1=read.csv("human.csv",row.names=1)

str(human1)
dim(human1)
#The data contains sets of information on both HDI (Human Developlemt Index) and GII (Gender inequality Index). 
#Some variable names are explicit such as Rank and Country, , while the other columns are explained as: 

#- Expected.Edu is the espected education in years
#- GNI refers to Gross National Income per capita 
#- GNI.HDI.RANK refers to the substraction of HDI rank from GNI rank (i.e GNI minus HDI)
#- Mat.Mor Ratio refers to the number of deaths per 100 000 live births.
#- Birth.Rate refers to the adolescent births per 1000 women ages 15 - 19.
#- Parliment percentage refers to the percentage of parliment seats taken up by females
#- F2Edu & M2Edu refers to secondardy education of both female and male respectively. 
#- FLab & MLab refers the labour force of both female and male respectively.
#- EduRatio and LabRatio refers to the ratio of female over male for both education and labour respectively. 

# More information can be obtained from http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf and http://hdr.undp.org/en/content/table-5-gender-inequality-index-gii

library(stringr)
human1$GNI<-str_replace(human$GNI, pattern=",", replace ="")%>% as.numeric()

keep<-c("Country","EduRatio","LabRatio","Expected.Edu","Life.Expectancy","GNI","Mat.Mor.Ratio","Birth.Rate","Parliment.Percentage")

human1<- select(human1,one_of(keep))
str(human1) #Only 8 choosen variables were selected
comp1<-complete.cases(human1)
summary(comp1) #after filtering, we should only get 162 obs.

data.frame(human1[-1],comp=comp1)

human2<-filter(human1,comp1)
str(human2) #agrees with our summary(comp1)

tail(human2,10) #Last 7 entries are regions to be removed
last <- nrow(human2)-7
human3<-human2[1:last,]
rownames(human3) <-human3$Country

summary(human3)

human3<-select(human3,-Country)
str(human3) #agrees with what was provided on datacamp

write.csv(human3,file="human3.csv")
