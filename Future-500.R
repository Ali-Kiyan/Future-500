#inserting empty cells with NA and <NA> for factor
fin <- read.csv("Future-500.csv", na.strings = c("") )
fin[which(fin$Employees == 45),] 
head(fin,24)
str(fin)
summary(fin)
#$sub and $gsub
fin$Expenses <- gsub(" Dollars","",fin$Expenses)
fin$Expenses <- gsub(",","",fin$Expenses)
fin$Revenue <- gsub("\\$","",fin$Revenue)
fin$Revenue <- gsub(",","",fin$Revenue)
fin$Growth <- gsub("%","",fin$Growth)
fin$Expenses <- as.numeric(fin$Expenses)
fin$Revenue <- as.numeric(fin$Revenue)
fin$Growth <- as.numeric(fin$Growth)
#getting na subset(rows) 
fin[is.na(fin$Expenses),]
#all the rows that have empty value somewhere
fin[!complete.cases(fin),]
fin_backup <- fin
fin[is.na(fin$Industry),]
fin <- fin[!is.na(fin$Industry),]
fin
#reseting the dataframe index
rownames(fin) <- 1:nrow(fin)
#resent the dataframe index (the row names)
rownames(fin) <- NULL
fin
#Replacing Missing Data: Factual Analysis
fin[is.na(fin$State) & fin$City == "New York", "State"] <- "NY"
#check:
fin[c(82,265),]
fin[!complete.cases(fin),]
fin[fin$City == "San Francisco", "State"] <- "CA"
fin[!complete.cases(fin),]
#replacing missing data Median Imputation
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
#replacing missing data Median Imputation 2
med_growth_constr <- median(fin[fin$Industry=="Construction","Growth"], na.rm = TRUE)
med_growth_constr
fin[is.na(fin$Growth)& fin$Industry == "Construction",]
fin[is.na(fin$Growth)& fin$Industry == "Construction","Growth"] <- med_growth_constr
fin[8,]
med_rev_const <- median(fin[fin$Industry=="Construction","Revenue"], na.rm = TRUE)
med_rev_const
fin[is.na(fin$Revenue) & fin$Industry == "Construction","Revenue"] <- med_rev_const
#just calc profit where it cannot be drived from other attributes
med_exp_constr <- median(fin[fin$Industry=="Construction","Expenses"], na.rm=TRUE)
med_exp_constr
fin[is.na(fin$Expenses) & fin$Industry=="Construction" & is.na(fin$Profit),"Expenses"] <- med_exp_constr
# Revenue - expense = Profit
# Expenses = Revenue - Profit
fin[is.na(fin$Profit),"Profit"] <- fin[is.na(fin$Profit), "Revenue"] - fin[is.na(fin$Profit), "Expenses"]
fin[c(8,32),]
fin[is.na(fin$Expenses),"Expenses"] <- fin[is.na(fin$Expenses),"Revenue"] - fin[is.na(fin$Expenses),"Profit"]
fin[15,]
library(ggplot2)
#A scatterplot classified by industry showing revenue, expenses, profit
p <- ggplot(data=fin)
p + geom_point(aes(x=Revenue, y=Expenses, colour=Industry, size=Profit))
#A scatterplot that include industry trends for the expenses
d <- ggplot(data=fin, aes(x=Revenue, y=Expenses, colour=Industry))
#14 warning 
d + geom_point() +
  geom_smooth(fill=NA, size=1.2)
#BoxPlot 
f <- ggplot(data=fin, aes(x=Industry, y=Growth, colour=Industry))
f + geom_boxplot(size=1) 
#extra 
f + geom_jitter() + 
  geom_boxplot(size=1, alpha=0.5, outlier.color = NA) 
 