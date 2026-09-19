##############################################
# - - - - Setting libraries - - - - -----

suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
  library(scales)
})

options(scipen = 999)

# - - - - Setting functions - - - - -----

tidying_tables <- function(myfile, ch1, ch2, name1, name2){
  metadata <- read.delim(myfile)
  conditions <- metadata[,1]
  files <- metadata[,2]
  tidy_data <- data.frame()
  for(i in seq_along(files)){
    tidy_table <- read.delim(files[i], sep=",") %>%
      select(all_of(c(ch1, ch2))) %>% 
      rename(!!name1 := !!ch1, !!name2 := !!ch2) %>%
      mutate(condition = conditions[i])
    tidy_data <- rbind(tidy_data, tidy_table)
  }
  return(tidy_data)
}

# - - - - Code to run from command line - - - - ---- 
# Ignore this first section to run from R Studio
args <- commandArgs(trailingOnly=TRUE)

meta_file <- args[1]
ch1 <- args[2]
ch2 <- args[3]
name1 <- args[4]
name2 <- args[5]

# - - - - Code to run from within R - - - - ----
# Uncomment to run from R Studio

# Seting the working directory 
#work.space <- dirname(rstudioapi::getSourceEditorContext()$path)
#setwd(work.space)

#meta <- "name_of_metadata_file.txt"
#ch1 = "name of first channel"
#name1 = "name of the first gene"
#ch2 = "name of second channel"
#name2 = "name of the second gene"


# - - - IMPORT DATA - - ----- 

data <- tidying_tables(meta_file, ch1, ch2, name1, name2)

#---- THEME SET ----
theme_set(theme_bw()+
            theme(axis.title.y=element_text(size = 12),
                  axis.text.y=element_text(size = 12),
                  axis.title.x = element_text(size = 12),
                  axis.text.x = element_text(size = 12),
                  legend.text = element_text(size = 10),
                  legend.title = element_text(size = 10)))

my_pal <- colorRampPalette(c('#5e4fa2ff','#4d71b2ff','#358abcff',
                             '#5db2acff','#7ecaa5ff','#ddf19aff','#fff9b6ff','#fed27fff','#fca65dff',
                             '#f7824cff','#ed6346ff','#ca354dff','#9e0142ff'))(250)

# - - - MAKING THE PLOT - - - - - 

pdf("cytometry_hexplot.pdf", height =4, width =10)

ggplot(data, aes(.data[[name2]], .data[[name1]]))+
  facet_wrap(~condition)+
  ggplot2::geom_hex(binwidth = 0.05, alpha = 0.9)+
  guides(fill = guide_colourbar(barwidth = 0.7, barheight = 15))+
  scale_y_log10(labels = trans_format("log10", math_format(10^.x)))+
  scale_x_log10(labels = trans_format("log10", math_format(10^.x)))+
  scale_color_gradientn(colors = my_pal) +
  scale_fill_gradientn(colors = my_pal) +
  coord_cartesian(xlim=c(100,10000000),ylim=c(100,10000000))+
  geom_vline(xintercept=100000,linetype="dashed",linewidth = 0.3, color = "gray35")+
  geom_hline(yintercept=100000,linetype="dashed",linewidth = 0.3, color = "gray35")

dev.off()