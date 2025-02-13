install.packages("ozbabynames")
library("ozbabynames")
View(ozbabynames)
write.csv(ozbabynames,file='/Users/kathe/Documents/Work and Education/GDAC/csvs/name project/australia/australia_names.csv',row.names = FALSE)
