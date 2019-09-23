library(readxl)
library(tidyverse)
library(magrittr)

setwd("C:/Users/Ildiko/OneDrive/Projekt/Data science")

Stats <- read_xlsx("AbilityScores.xlsx",sheet = 1, col_names = TRUE)
Abi <- read_xlsx("AbilityScores.xlsx",sheet = 2, col_names = TRUE)
Saving <- read_xlsx("AbilityScores.xlsx",sheet = 4, col_names = TRUE)

Monsters <- cbind(Abi, Saving %>% select(8:ncol(Saving)),Stats %>% select(8:ncol(Stats)))
remove(Stats,Abi,Saving)

