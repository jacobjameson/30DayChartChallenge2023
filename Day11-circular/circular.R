# ------------------------------------------------------------------------
# DAY 11 #30DayChartChallenge
# AUTHOR: Jacob Jameson
# THEME: "Circular"
# ------------------------------------------------------------------------

# load packages ----------------------------------------------------------
rm(list = ls())

libs <- c("tidyverse", 'png', 'patchwork', 'grid',
          "ggtext", "showtext", 'ggpubr', 'tidygraph', 'ggraph')

installed_libs <- libs %in% rownames (installed.packages ())

if (any (installed_libs == F)) {
  install.packages (libs[!installed_libs])
}

invisible(lapply (libs, library, character.only = T))

font_add_google("Courgette")
showtext_auto()


# load dataset ------------------------------------------------------------


#hierarchical clustering on the iris dataset based 
#on the Euclidean distance between the first four columns 
#(i.e., attributes) of the dataset (i.e., sepal length, 
#sepal width, petal length, and petal width).

iris.clust <- hclust(dist(iris[, 1:4]))

# theme --------------------------------------------------------------------

theme_set(theme_minimal(base_family = "Courgette"))

theme_update(
  axis.title = element_blank(),
  axis.text = element_blank(),
  axis.text.x = element_blank(),
  axis.text.y = element_blank(),
  axis.ticks = element_blank(),
  axis.ticks.length.x = unit(1.3, "lines"),
  axis.ticks.length.y = unit(.1, "lines"),
  panel.grid = element_blank(),
  legend.position = 'left',
  plot.background = element_rect(fill = "#E7E5EE", color = NA), 
  legend.text = element_text(size = 16),
  plot.title = element_text(
    color = "#524A67", 
    size = 50, 
    face = "bold",
    hjust = 0.5,
  ),
  plot.subtitle = element_text(
    color = "black", 
    size = 22,
    lineheight = 1.35,
    margin = margin(t = 15)
  ),
  plot.title.position = "plot",
  plot.caption.position = "plot",
  plot.caption = element_text(
    color = "#524A67", 
    size = 14,
    lineheight = 1.2, 
    hjust = 0.5,
    margin = margin(b = 30) 
  ))


# plot --------------------------------------------------------------------


ggraph(iris.clust, layout = 'dendrogram', circular = TRUE) + 
  geom_edge_link(color='#9FAC7C', width=3) + 
  geom_node_point(aes(filter = leaf),size=6, color='#996699') +
  labs(caption= str_wrap("Hierarchical clustering of the iris dataset
                         based on four attributes: sepal length, 
                         sepal width, petal length, and petal width. 
                         The dataset contains measurements of 150 iris 
                         flowers, with 50 samples from each of three
                         species: setosa, versicolor, and virginica. 
                         Clustering is a technique used to group data 
                         points based on similarity, with similar data 
                         points being placed in the same cluster.
                         In this case, the dendrogram shows how the 
                         iris flowers are grouped based on their attributes. 
                         | #30DayChartChallenge Circular | @JacobCJameson", 190),
       title="\nHierarchical Clustering of Iris Dataset \nBased on Flower Characteristics",
       fill="") 

