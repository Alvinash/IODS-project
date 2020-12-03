library(dplyr)
library(tidyr)

BPRS<-read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt",sep='',header=T)
RATS<-read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt",sep="",header=T)

#BPRS data wrangling
summary(BPRS)
str(BPRS)
#This dataset describes a clinical trial of 40 men randonmly assigned to two treatments, as well as the brief psychiatric
#rating scale (BRPS) measured before treatment and at a weekly intervals for a total of 8 weeks. 
#18 levels of symptoms are measured such as hostility, suspiciousness, hallucinations and grandiosity 
#- each are rated against a scale from 1 (not present) to 7 (extremely severe). 
#The sum of scale (I presumed) is then used to evaluate patients suspected of having schizophrenia

#Converting categorical to factor for treatment and subject
BPRS$treatment<-factor(BPRS$treatment)
BPRS$subject<-factor(BPRS$subject)
str(BPRS)

# Convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(BPRSL$weeks,5,5)))

# Comparison between long and wide form
glimpse(BPRS)%>%dim()
glimpse(BPRSL)%>%dim()

#Main difference is the dimensions: 40obs of 11 variables vs 360obs of 5 variables. 
#In the wide form, each week 0 to 8 are the variable names. In the wide form, the week numbers now becomes observations.
#This reduces the number of variables and allow better plotting of data with inclusion of week numbers. This can capture the data of the BRPS per patient
#for each different week. i.e. patient 1 from treatment 1 in week 0 has a BRPS score of 42.

#RATS data wrangling
summary(RATS)
str(RATS)
#This dataset describes an in vivo test of 16 rats from 3 different diet groups. Their weight were measured a few times with intervals at day 1, 8, 15
#22, 29, 36, 43, 44, 50, 57 and 64. 

#Converting categorical to factor for treatment and subject
RATS$ID<-factor(RATS$ID)
RATS$Group<-factor(RATS$Group)
str(RATS)

# Convert to long form
RATSL <-  RATS %>% gather(key = WD, value = Weight, -ID, -Group)
RATSL

# Extract the day nutime()
RATSL <-  RATSL %>% mutate(Time = as.integer(substr(WD,3,4)))

# Comparison between long and wide form
glimpse(RATS)%>%dim()
glimpse(RATSL)%>%dim()
#Similar to the BRPSL dataset, the dim has changed from 16 obs of 13 variables to 176 obs of 5 variables. The 
#weight at each individual timepoint per animal is captured in as observation. This again allow better plotting throughout the different time interval. 

write.csv(RATSL,file="RATSL.csv")
write.csv(BPRSL,file="BPRSL.csv")
