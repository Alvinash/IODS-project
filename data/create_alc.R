library(dplyr)

student_math <- read.csv("student-mat.csv", sep=";",header=TRUE)
student_por <- read.csv("student-por.csv", sep=";",header=TRUE)
colnames(student_math)
colnames(student_por)
dim(student_math)
dim(student_por)
str(student_math)

join <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
#Creating a vector for inner_join

student_math_por <- inner_join(student_math,student_por, by = join, suffix = c(".math",".por"))
colnames(student_math_por)
dim(student_math_por)
str(student_math_por)

# create a new data frame with only the joined columns
alc <- select(student_math_por, one_of(join))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(student_math)[!colnames(student_math) %in% join]

notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'student math_por' with the same original name
  two_columns <- select(student_math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- select(two_columns,1)
  }
}

alc <- mutate(alc, alc_use = (Dalc + Walc)/2) 
alc <- mutate(alc, high_use = alc_use > 2)

glimpse(alc) #everything seems to be in order

write.csv(alc,file="alc.csv")
        