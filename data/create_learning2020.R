#Khng You cheng, 051120,data wrangling file for linear regression#

# read the data from web into memory (Check under environment)
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

summary(lrn14) #Provides summary of data, inclding all the headers, min, max and quartile values#
str(lrn14) #describes the structure of the values for each header e.g. int, str##

# access the dplyr library for wrangling
library(dplyr)

# create column 'attitude' by scaling the column "Attitude" (changing it to avg likert scale)
lrn14$Attitude <- lrn14$Attitude/10

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging all the questions
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging all the questions
surface_columns <- select(lrn14, one_of(surface_questions)) 
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging all the questions
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

keep_columns <- c("gender","Age","Attitude","deep","stra","surf","Points")

learning2014 <- select(lrn14,one_of(keep_columns))

colnames(learning2014)[2]<-"age"
colnames(learning2014)[3]<-"attitude"
colnames(learning2014)[7]<-"points"

learning2014 <- filter(learning2014,points>0)

#to set working director, go under "SESSION->set working directory -> choose directory"
write.csv(learning2014,file = "learning2014.csv") #first agu = object, 2nd = name of file
read.csv("learning2014.csv",row.names = 1) #remove the numbers from excel itself



