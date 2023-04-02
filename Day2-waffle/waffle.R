# ------------------------------------------------------------------------
# DAY 2 #30DayChartChallenge
# AUTHOR: Jacob Jameson
# THEME: "Waffle"
# ------------------------------------------------------------------------

# load packages ----------------------------------------------------------
rm(list = ls())

libs <- c("tidyverse", 'png', 'patchwork', 'grid',
          "ggtext", "showtext", 'ggpubr')

installed_libs <- libs %in% rownames (installed.packages ())

if (any (installed_libs == F)) {
  install.packages (libs[!installed_libs])
}

invisible(lapply (libs, library, character.only = T))

font_add_google("Pacifico")
showtext_auto()

# load dataset ------------------------------------------------------------

# Data comes from Marth Stewart's easy waffles recipe
# https://www.marthastewart.com/338522/waffles


### Ingredients
# 1 cup all-purpose flour, spooned and leveled
# 2 tablespoons sugar
# 1 teaspoon baking powder
# ¼ teaspoon salt
# 1 cup milk
# 2 large eggs
# 4 tablespoons (½ stick) unsalted butter, melted

## convert ingredients to grams --------------------------------------------

waffle <- data.frame(grams = c(120, 25, 4, 2, 240, 112, 57),
                     ingredient = c('Flour ', 'Sugar ', 'Baking\nPowder', 
                                    'Salt ', 'Milk ', 'Eggs  ', 'Butter'),
                     colors <- c("#AB8100", "#BDAA70", "#D3C5AA", 
                                 "#60432D", "#BD9B30", "#7E6955", "#f1b39d")
) 
                      

background <- png::readPNG("data/waffle.png")
w <- matrix(rgb(background[,,1],background[,,2],
                background[,,3], background[,,4] * 0.2),
            nrow=dim(background)[1]) 


# theme --------------------------------------------------------------------

theme_set(theme_minimal(base_family = "Pacifico"))

theme_update(
  axis.title = element_blank(),
  axis.text = element_blank(),
  axis.text.x = element_blank(),
  axis.text.y = element_blank(),
  axis.ticks = element_blank(),
  axis.ticks.length.x = unit(1.3, "lines"),
  axis.ticks.length.y = unit(.1, "lines"),
  panel.grid = element_blank(),
  plot.background = element_rect(fill = "#FDFD96", color = NA), 
  legend.text = element_text(size = 16),
  legend.position = "top",
  plot.title = element_text(
    color = "#60432D", 
    size = 56, 
    face = "bold",
    hjust = 0.5
  ),
  plot.subtitle = element_text(
    color = "#60432D", 
    size = 30,
    lineheight = 1.35,
    margin = margin(t = 15),
    hjust = 0.5
  ),
  plot.title.position = "plot",
  plot.caption.position = "plot",
  plot.caption = element_text(
    color = "#AB8100", 
    size = 16,
    lineheight = 1.2, 
    hjust = 0.5
  ))


# plot --------------------------------------------------------------------



ggplot(waffle) +
  waffle::geom_waffle(aes(fill = ingredient,
                          values = grams),
                      n_rows = 40,
                      flip = TRUE,
                      height = 0.8,
                      width = 0.8,
                      size = 1,
                      radius = unit(2, "pt")) +
  coord_equal() +
  scale_fill_manual(values = colors,
                    guide = guide_legend( keyheight = unit(3, units = "mm"), 
                                          keywidth=unit(12, units = "mm"), 
                                          label.position = "bottom",
                                          title.position = 'top', nrow=1)) +
  annotation_custom(xmin=-Inf, ymin=-Inf, xmax=Inf, ymax=Inf, rasterGrob(w)) +
  labs(caption= str_wrap("Consider this your new, go-to waffle recipe when you 
                         want to start your day off on a sweet note. 
                         No fussy steps or unexpected ingredients are 
                         required here, which means you can whip these 
                         up whenever your cravings hit.. https://www.marthastewart.com/338522/waffles |
                         #30DayChartChallenge | Day 2 Waffle | @JacobCJameson\n\n", 160),
       title="\n“Easy Waffles” Recipe by Martha Stewart",
       subtitle = 'Each square corresponds to 1 gram of the ingredient called for in the recipe\n' ,fill="") 


