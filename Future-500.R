#inserting empty cells with NA and <NA> for factor
fin <- read.csv("Future-500.csv", na.strings = c("") )
fin[which(fin$Employees == 45),] 
head(fin,24)
#getting na subset(rows) 
fin[is.na(fin$Expenses),]
a <- c(1,24,543,NA,76,45,NA)
#all the rows that have empty value somewhere
fin[!complete.cases(fin),]
fin_backup <- fin
fin[is.na(fin$Industry),]
fin <- fin[!is.na(fin$Industry),]
fin
#reseting the dataframe index
rownames(fin) <- 1:nrow(fin)
#?
rownames(fin) <- NULL
fin
#Replacing Missing Data: Factual Analysis
fin[is.na(fin$State) & fin$City == "New York", "State"] <- "NY"
#check:
fin[c(11,377),]
fin[!complete.cases(fin),]
fin[is.na(fin$State) & fin$City == "San Francisco", "State"] <- "LA"