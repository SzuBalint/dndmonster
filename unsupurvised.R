library(data.table)
library(ggplot2)
data <- fread("data/sales_data_for_clustering.csv")

pca_output <- prcomp(data[,c(4,5)], scale = TRUE)
# Mivel csak ez a ket valtozo numerikus, legalabbis ertelmezhetoen

pca_output$center
pca_output$scale

pca_output$rotation

head(pca_output$x)
vars_trans <- apply(pca_output$x, 2, var)
vars_trans/sum(vars_trans)
# Tehat az elso component 50.6 %-ot, mig a masodik 49.4 %-ot magyaraz

biplot(pca_output, scale = 0)
# Mivel a nyilak nem annyira parhuzamosak erdemes lehet mind a ketto numerikus valtozot hasznalni

# K-means

km_output <- kmeans(data[,c(4,5)], centers = 2, nstart = 20)
km_output
km_output$cluster
# Futatok egy k-means clustert aztan abrazolom

ggplot(data, aes(x = quantity, y = price)) + geom_point(colour = (km_output$cluster + 1))


ks <- 1:10
tot_within_ss <- sapply(ks, function(k) {
  km_output <- kmeans(data[,c(4,5)], k, nstart = 20)
  km_output$tot.withinss
})
tot_within_ss

plot(
  x = ks,
  y = tot_within_ss,
  type = "b",
)
# A plot alapjan en 3 centert latok a legertelmesebbnek, ott van a legnagyobb "konyok" talan

km_output <- kmeans(data[,c(4,5)], centers = 3, nstart = 20)
ggplot(data, aes(x = quantity, y = price)) + geom_point(colour = (km_output$cluster + 1))

# Levagom az adat veget hogy szebb legyen a plot
data <- data[quantity < 25]
km_output <- kmeans(data[,c(4,5)], centers = 3, nstart = 20)
ggplot(data, aes(x = quantity, y = price)) + geom_point(colour = (km_output$cluster + 1))
