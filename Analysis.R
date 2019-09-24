library(readxl)
library(tidyverse)
library(magrittr)
library(data.table)
library(ggplot2)

#Importing files
Stats <- read_xlsx("AbilityScores.xlsx",sheet = 1, col_names = TRUE, na= "N/A")
Abi <- read_xlsx("AbilityScores.xlsx",sheet = 2, col_names = TRUE, na= "N/A")
Saving <- read_xlsx("AbilityScores.xlsx",sheet = 4, col_names = TRUE, na= "N/A")

Saving$CHA_mod <- Saving$CHA_mod %>% as.numeric()

#Suming each line of modifiers, as a way to signal the total ability of a monster
Saving$sum_mod <- rowSums( Saving[,8:13] )

Monsters <- cbind(Abi, Saving %>% select(8:ncol(Saving)),Stats %>% select(8:ncol(Stats)))
#remove(Stats,Abi,Saving)

#As some of the imported values are not numeric and are hard to deal with, I replace them with normal values
Monsters$CR <- replace(Monsters$CR, Monsters$CR == 43102, 1/2)
Monsters$CR <- replace(Monsters$CR, Monsters$CR == 43104, 1/4)
Monsters$CR <- replace(Monsters$CR, Monsters$CR == 43108, 1/8)

Monsters$CR <- replace(Monsters$CR, Monsters$CR == "1/2", 1/2)
Monsters$CR <- replace(Monsters$CR, Monsters$CR == "1/4", 1/4)
Monsters$CR <- replace(Monsters$CR, Monsters$CR == "1/8", 1/8)

#Then order the whole thing
Monsters$CR <- as.numeric(Monsters$CR)
Monsters <- Monsters[order(Monsters$CR),]
Monsters$CR <- as.factor(Monsters$CR)

#Finally I drop that one last NA as I can't really use it in the future
deleteNA <- function(data, desiredCols) {
  completeVec <- complete.cases(data[, desiredCols])
  return(data[completeVec, ])
}

Monsters <- deleteNA(Monsters,c("CR"))

#And now for the visual part
ggplot(Monsters, aes(x=CR, y=sum_mod, colour=CR)) +
  geom_point() +
  ggtitle("Sum of abilityscores and challange rates of monsters")
