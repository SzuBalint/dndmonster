library(readxl)
library(tidyverse)
library(magrittr)
library(data.table)

#Set working directory
setwd("C:/Users/Ildiko/OneDrive/Projekt/Data science/dndmonster")

#Importing files
Stats <- read_xlsx("AbilityScores.xlsx",sheet = 1, col_names = TRUE)
Abi <- read_xlsx("AbilityScores.xlsx",sheet = 2, col_names = TRUE)
Saving <- read_xlsx("AbilityScores.xlsx",sheet = 4, col_names = TRUE)

Saving$CHA_mod <- Saving$CHA_mod %>% as.numeric()

#Suming each line of modifiers skrtskrt
Saving$sum_mod <- rowSums( Saving[,8:13] )

Monsters <- cbind(Abi, Saving %>% select(8:ncol(Saving)),Stats %>% select(8:ncol(Stats)))
#remove(Stats,Abi,Saving)

Monsters <- Monsters[order(Monsters$CR),]
