# ------------------------------------------------------------------------
# DAY 1 #30DayChartChallenge
# AUTHOR: Jacob Jameson
# THEME: "Part to Whole"
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

font_add_google("Secular One")
showtext_auto()


# load dataset ------------------------------------------------------------

closures <- readxl::read_excel('data/Closures-Database-for-Web.xlsx')

# wrangle data ------------------------------------------------------------

closures <- closures %>%
  arrange(`Medicare Payment`)

coord_x <- c()
for (i in 1:38){
  coord_x <- c(coord_x, seq(1:5))
}

coord_y <- c()
for (i in 1:19){
  coord_y <- c(coord_y, rep.int(i, 10))
}


closures$coord_x <- coord_x
closures$coord_y <- coord_y

closures <- closures %>%
  mutate(long.label = case_when(
    `Medicare Payment` == 'CAH' ~ 'Critical Access Hospital',
    `Medicare Payment` == 'IHS' ~ 'Indian Health Service',
    `Medicare Payment` == 'MDH' ~ 'Medicare Dependent Hospital',
    `Medicare Payment` == 'PPS' ~ 'Prospective Payment System',
    `Medicare Payment` == 'RRC' ~ 'Rural Referral Center',
    `Medicare Payment` == 'SCH' ~ 'Sole Community Hospital',
    TRUE ~ 'Medicare Dependent Hospital'
))


background <- png::readPNG("data/hosp.png")
w <- matrix(rgb(background[,,1],background[,,2],
                background[,,3], background[,,4] * 0.1),
            nrow=dim(background)[1]) 

# theme --------------------------------------------------------------------

theme_set(theme_minimal(base_family = "Secular One"))

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
  plot.background = element_rect(fill = "#f5f5f2", color = NA), 
  legend.text = element_text(size = 16),
  plot.title = element_text(
    color = "#A32004", 
    size = 30, 
    face = "bold",
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
    color = "grey50", 
    size = 14,
    lineheight = 1.2, 
    hjust = 0,
    margin = margin(t = 40) 
  ))


# plot --------------------------------------------------------------------

ggplot(closures, 
       aes(x = coord_x, 
           y = coord_y, 
           fill = long.label)) +
  geom_tile(colour="black", width=1, height=1) +
  coord_fixed() + 
  theme(aspect.ratio = 2/1) + 
  scale_fill_manual(values = c("#D8B70A" ,"#02401B", "#A2A475", 
                               "#81A88D", "#972D15", 'grey40')) +
  labs(caption= str_wrap("Following the convention of the Office of Inspector 
                         General that a closed hospital is “A facility that 
                         stopped providing general, short-term, acute 
                         inpatient care [...].” Data from The Cecil G. 
                         Sheps Center for Health Services Research. @JacobCJameson", 100),
       title="\n190 Rural Hospital Closures and Conversions \nsince January 2005",
       subtitle = 'Closures By Medicare Payment Classification' ,fill="") +
  annotation_custom(xmin=-Inf, ymin=-Inf, xmax=Inf, ymax=Inf, rasterGrob(w)) 
