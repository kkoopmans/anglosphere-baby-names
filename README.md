# Anglosphere Baby Names

This repo contains an aggregated dataset containing baby name data for 8 English-speaking regions: Australia, Canada, England and Wales (goruped together), Ireland, Northern Ireland, New Zealand, Scotland and the USA. It can be used to compare the popularity of names in the anglosphere over time, and I have used it to determine the "Country-ness" of each particular name, or, how much more popular it is in its most popular country as compared to all the other countries.

## all-names-long.csv

A compilation of most available baby name data:

Australia (1935-2023)
Canada (1991-2023)
England and Wales (1996-2023)
Ireland (1964-2023)
Northern Ireland (1997-2023)
New Zealand (1935-2023)
Scotland (1974-2023)
USA (1910-2023)

## metrics-and-summary.csv

Summary statistics for the name data, including averages, country where the name is most popular, and "countryness" - a measure of how much more popular the name is in the country where it is most popular than it is in the rest of the world. (Think, Saoirse in Ireland or Lachlan in Australia)

## summary-1997-2023.csv

For the 27 year period that all 8 regions have data (1997-2023 inclusive), this table summarizes the names for the entire span, and calculates the country-ness. Countryness is computed as "proportion of babies of this gender with this name in the max country over the 27 year period"/"proportion of babies of this gender with this name in the other 7 countries over the 27 year period". A country can only be considered the "max_country" if it used the name in at least 5 different years over the 27 year period, and only names which were used in at least 2 different countries were included in this dataset.

## Limitations and Notes:

Each data set came with its own limitations. 

Most countries do not report the names of babies where fewer than 3 were born with that name. The USA uses a minimum of 5. Unique names were available in Scotland and Australia data - For privacy and to align with the other countries, I excluded names with a frequency <3.

The Australian data has notable holes, including that the data is reported by state and not all states report all names. Many only report the top 50 or 100. See [ozbabynames](https://github.com/robjhyndman/ozbabynames) for more details on the specific limitations of the Australian data. Similarly, Canada's data prior to 1991 was recorded by individual provinces. Recently, Statistics Canada released the "Baby Names Observatory" which published compiled data for the whole country from 1991-2023.

Also:
* The USA does not preserve hyphens in given names, while all other countries do. It also cuts off the length of names at 15 letters.
* Only New Zealand and Ireland preserve accented letters in their datasets. All other countries would, for example, report the name "Zoë" or "Zoé" as Zoe. My data set does not change these.
* Most countries do not preserve the capitalization of the given names, so "Mackenzie" and "MacKenzie" would be reported as the same name. For simplicity, I adjusted all names so that only the initial letter was capitalised, so Mary-Jane and MARY-JANE were changed to Mary-jane. In countries that did preserve capitalization, I combined the entries so they would match the style of the other countries.

## The countryness Metric

The countryness metric is a measure of relative popularity of the name. It is the number of times more popular the name is in the country where it is most popular than it is anywhere else in the anglosphere. ie. suppose you take a random kid born in 2003 named Kyle. Kyle was most popular in Scotland in 2003, and it is 4.15x more likely that the Kyle you chose was Scottish than any of the other 7 regions, therefore the "countryness" score is 4.15.

$\text{countryness of a name} = \frac{\text{proportion of babies with that name in the country in which it is most common}}{\text{proportion of babies with that name in the rest of the anglosphere}}$

## Sample Usage

Explore the data in this (Tableau dashboard)[https://public.tableau.com/app/profile/katherine.koopmans/viz/CountrynessofAnglosphereBabyNames/TopNames] (see all 3 tabs).

```{r}
install.packages("tidyverse")
library(tidyverse)
summary_df <- read.csv("metrics-and-summary.csv")
lachlan <- summary_df %>%
  filter(name == "Lachlan" & sex == "M" & year > 1996)

ggplot(lachlan,aes(x=year, y=countryness,fill = max_country)) + geom_bar(stat = "identity")+ggtitle("Countryness of Lachlan")
ggplot(lachlan,aes(x=year, y=total_num_babies_w_name)) + geom_bar(stat = "identity") + ggtitle("General popularity of the name Lachlan")

print("Average Countryness of the name Lachlan, 1997-2017:")
average_countryness <- lachlan %>% 
  filter(max_country == "Australia") %>% 
  summarise(mean=mean(countryness))
print(average_countryness)
```

## Data Sources:

#### Australia:

Hyndma
n R, O'Hara-Wild M, Roberts J, Tierney N (2024). _ozbabynames: Australian
  Popular Baby Names_. R package version 0.1.0,
  <https://CRAN.R-project.org/package=ozbabynames>.

Australian Bureau of Statistics (2025). Births, Australia, Births registered – 1935 to 2023(a) - Table. https://www.abs.gov.au/statistics/people/population/births-australia/latest-release.

#### Canada:

Statistics Canada. Table 17-10-0147-01  First names at birth by sex at birth, selected indicators (Number). https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1710014701. Accessed Feb 11, 2025

Statistics Canada. Table 13-10-0415-01  Live births, by month. https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1310041501. Accessed Feb 11, 2025

See Also:
Statistics Canada. Baby Name Observatory. https://www150.statcan.gc.ca/n1/pub/71-607-x/71-607-x2023021-eng.htm

#### England and Wales:

Office for National Statistics (ONS). Baby names for boys in England and Wales. https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/livebirths/datasets/babynamesenglandandwalesbabynamesstatisticsboys

Office for National Statistics (ONS). Baby names for girls in England and Wales. https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/livebirths/datasets/babynamesenglandandwalesbabynamesstatisticsgirls

Office for National Statistics (ONS). Information on birth statistics, Table 1. https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/livebirths/datasets/birthsummarytables

Office for National Statistics (ONS), released 28 October 2024, ONS website, statistical bulletin, Births in England and Wales: 2023 https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/livebirths/bulletins/birthsummarytablesenglandandwales/2023

#### Ireland:

Central Statistics Office. Total Births, Deaths and Marriages Registered Numbers and Rates (VSQ04). https://data.cso.ie/table/VSQ04

Central Statistics Office. Boys Names in Ireland with 3 or More Occurrences (VSA50). https://data.cso.ie/table/VSA50

Central Statistics Office. Girls Names in Ireland with 3 or More Occurrences (VSA60). https://data.cso.ie/table/VSA60

#### Northern Ireland:

Northern Ireland Statistics and Research Agency (2024). Registrar General Annual Report 2023 Births. https://www.nisra.gov.uk/publications/registrar-general-annual-report-2023-births

Northern Ireland Statistics and Research Agency (2024). Baby Names 2023, Full Names List, 1997-2023 Tables. https://www.nisra.gov.uk/publications/baby-names-2023

#### New Zealand:

Stats NZ (2025). Baby name counts over time (data). https://catalogue.data.govt.nz/dataset/01ee87cd-ecf8-44a1-ad33-b376a689e597/resource/0b0b326c-d720-480f-8f86-bf2d221c7d3f/download/baby-names-2025-01-06.csv

Stats NZ Infoshare. Live births (by sex), stillbirths (Maori and total population) (Annual-Dec). https://infoshare.stats.govt.nz/SelectVariables.aspx?pxID=b8c1a042-cea5-4fd7-888b-8735b0f6bf20

#### Scotland:

National Records of Scotland (2024). Babies' First Names 2023, Full List 1974-2023. https://www.nrscotland.gov.uk/publications/babies-first-names-2023/

National Records of Scotland (2024). Births Time Series Data, Table BT.01. https://www.nrscotland.gov.uk/publications/births-time-series-data/

#### USA:

Social Security Administration. Popular Baby Names. https://www.ssa.gov/OACT/babynames/limits.html

National Centre for Health Statistics (Centre for Disease Control). Natality Trends in the United States, 1909–2018. https://www.cdc.gov/nchs/data-visualization/natality-trends/index.htm

National Centre for Health Statistics (Centre for Disease Control). National Vital Statistics System, Birth Data. https://www.cdc.gov/nchs/nvss/births.htm