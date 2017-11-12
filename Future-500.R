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
fin[c(82,265),]
fin[!complete.cases(fin),]
fin[fin$City == "San Francisco", "State"] <- "CA"
fin[!complete.cases(fin),]
#replacing missing data 
fin[!complete.cases(fin),]
#more accurate because doesn't count outliars
med_empl_retail <- median(fin[fin$Industry=="Retail","Employees"], na.rm = TRUE)
med_empl_retail
#mean(fin[,"Employees"], na.rm = TRUE)
fin[is.na(fin$Employees) & fin$Industry == "Retail", "Employees"] <- med_empl_retail
fin[3,]
med_empl_finserv <- median(fin[fin$Industry=="Financial Services","Employees"], na.rm = TRUE)
med_empl_finserv
fin[is.na(fin$Employees) & fin$Industry == "Financial Services", "Employees"] <- med_empl_finserv
#check
fin[330,]
fin[!complete.cases(fin),]
