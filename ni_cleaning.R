ni_data <- read.csv("/Users/kathe/Documents/Work and Education/GDAC/csvs/name project/uk/northern_ireland.csv")

library(tidyverse)

clean_ni_data <- data.frame(year=integer(),
                            sex=character(),
                            name=character(),
                            frequency=integer())
curr_year <- 1997L
for (tableno in seq(1,54,by = 2)) {
  minitable <- select(ni_data,all_of(tableno),all_of(tableno+1))
  for (row in 1:nrow(ni_data)) {
    nm = ni_data[row,1]
    freq = ni_data[row,2]
    if (!is.null(nm) & freq != ".." & !is.na(nm) & !is.na(freq) & nm != "") {
      clean_ni_data[nrow(clean_ni_data)+1,] <- c(year = curr_year, sex = "M", name = nm, frequency = as.integer(str_replace_all(freq,",","")))
    }
  }
  curr_year <- curr_year + 1
}

ni_data_f <- read.csv("/Users/kathe/Documents/Work and Education/GDAC/csvs/name project/uk/northern_ireland_f.csv")

curr_year <- 1997L
for (tableno in seq(1,54,by = 2)) {
  minitable <- select(ni_data_f,all_of(tableno),all_of(tableno+1))
  for (row in 1:nrow(ni_data_f)) {
    nm = ni_data_f[row,1]
    freq = ni_data_f[row,2]
    if (!is.null(nm) & freq != ".." & !is.na(nm) & !is.na(freq) & nm != "") {
      clean_ni_data[nrow(clean_ni_data)+1,] <- c(year = curr_year, sex = "F", name = nm, frequency = as.integer(str_replace_all(freq,",","")))
    }
  }
  curr_year <- curr_year + 1
}

write.csv(clean_ni_data,"/Users/kathe/Documents/Work and Education/GDAC/csvs/name project/uk/ni_clean.csv")
  