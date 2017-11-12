fin <- read.csv("Future-500.csv", na.strings = c("") )
fin[which(fin$Employees == 45),] 
head(fin,24)
fin[is.na(fin$Expenses),]
a <- c(1,24,543,NA,76,45,NA)
is.na(fin)
