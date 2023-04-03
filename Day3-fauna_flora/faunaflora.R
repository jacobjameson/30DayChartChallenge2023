# ------------------------------------------------------------------------
# DAY 3 #30DayChartChallenge
# AUTHOR: Jacob Jameson
# THEME: "Fauna Flora"
# ------------------------------------------------------------------------

# load packages ----------------------------------------------------------
rm(list = ls())

libs <- c("tidyverse", 'png', 'patchwork', 'grid',
          "ggtext", "showtext", 'ggpubr', 'maps',
          'ggimage', 'ggsvg')


installed_libs <- libs %in% rownames (installed.packages ())

if (any (installed_libs == F)) {
  install.packages (libs[!installed_libs])
}

invisible(lapply (libs, library, character.only = T))

font_add_google("Pacifico")
showtext_auto()

# load dataset ------------------------------------------------------------


hoya <- read_tsv('data/hoya.csv')
hoya$image <- 'data/hoya.png'

world_map <- map_data("world")


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
  plot.background = element_rect(fill = "#FAEFFD", color = NA), 
  legend.text = element_text(size = 16),
  legend.position = "top",
  plot.title = element_text(
    color = "#741AAC", 
    size = 56, 
    face = "bold",
    hjust = 0.5
  ),
  plot.subtitle = element_text(
    color = "#741AAC", 
    size = 30,
    lineheight = 1.35,
    margin = margin(t = 15),
    hjust = 0.5
  ),
  plot.title.position = "plot",
  plot.caption.position = "plot",
  plot.caption = element_text(
    color = "#741AAC", 
    size = 16,
    lineheight = 1.2, 
    hjust = 0.5
  ))


# plot --------------------------------------------------------------------

ggplot() + coord_fixed() +
  xlab("") + ylab("") + 
  geom_polygon(data=world_map, aes(x=long, y=lat, group=group), 
               colour="#005437", fill="#005437") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        panel.background = element_rect(fill = '#FAEFFD', colour = '#FAEFFD'), 
        axis.line = element_line(colour = "#FAEFFD"), legend.position="none",
        axis.ticks=element_blank(), axis.text.x=element_blank(),
        axis.text.y=element_blank()) +
  #geom_point(data=hoya, 
  #           aes(x=decimalLongitude, y=decimalLatitude), colour="Deep Pink", 
  #           fill="Pink",pch=21, size=2, alpha=I(0.7)) +
  geom_image(data=hoya, aes(x=decimalLongitude, y=decimalLatitude, image=image), 
             width = 0.45, height = 1, size=0.025) +
  labs(caption= str_wrap("Hoya is a genus of over 500 accepted species of tropical plants 
                          in the dogbane family, Apocynaceae. Most are native to several countries of 
                          Asia such as Philippines, India, Thailand, Malaysia, Vietnam, Bangladesh, 
                          Indonesia, Polynesia, New Guinea, and vast variety of species could also be
                          found in Australia. | Inspired by @madisoncoots's Hoyas |
                         #30DayChartChallenge | Day 3 Fauna/Flora | @JacobCJameson\n\n", 160),
       title="\nWax On, Wax Off",
       subtitle = 'Discovering the Many Locations Where Hoya Plants Grow' ,fill="") 


