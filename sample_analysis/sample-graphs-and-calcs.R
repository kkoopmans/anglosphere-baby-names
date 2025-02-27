library(tidyverse)
summary_df <- read.csv("C:/Users/kathe/Documents/Name Project/metrics-and-summary.csv")
lachlan <- summary_df %>%
  filter(name == "Lachlan" & sex == "M" & year > 1996)

ggplot(lachlan,aes(x=year, y=countryness,fill = max_country)) + geom_bar(stat = "identity")
ggplot(lachlan,aes(x=year, y=total_num_babies_w_name)) + geom_bar(stat = "identity")

average_countryness <- lachlan %>% 
  filter(max_country == "Australia") %>% 
  summarise(mean=mean(countryness))

matilda <- summary_df %>%
  filter(name == "Matilda" & sex == "F" & year > 1996)
ggplot(matilda,aes(x=year, y=countryness,fill = max_country)) + geom_bar(stat = "identity")

hamish <- summary_df %>%
  filter(name == "Hamish" & sex == "M" & year > 1996)
ggplot(hamish,aes(x=year, y=countryness,fill = max_country)) + geom_bar(stat = "identity")

gordon <- summary_df %>%
  filter(name == "Gordon" & sex == "M")
ggplot(gordon,aes(x=year, y=countryness,fill = max_country)) + geom_bar(stat = "identity")

terry <- summary_df %>%
  filter(name == "Terry" & sex == "M" & year > 1996)
ggplot(terry,aes(x=year, y=countryness,fill = max_country)) + geom_bar(stat = "identity")



jim <- summary_df %>%
  filter(name == "Jim" & sex == "M" & year > 1973)
ggplot(jim,aes(x=year, y=countryness,fill = max_country)) + geom_bar(stat = "identity")

james <- summary_df %>%
  filter(name == "James" & sex == "M" & year > 1973)
ggplot(james,aes(x=year, y=countryness,fill = max_country)) + geom_bar(stat = "identity")

