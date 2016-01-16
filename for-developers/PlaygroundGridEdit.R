ggplot(dsObesity, aes(x=FoodHardshipRate, y=ObesityRate, label=State, color=Location)) +
  geom_text(size=3, alpha=1) +
  scale_x_continuous(label=scales::percent) +
  scale_y_continuous(label=scales::percent) +
  scale_color_manual(values=PaletteObesityState) +
  coord_fixed() + 
  chapterTheme +
  theme(legend.position=c(0, 1), legend.justification=c(0, 1)) +
  labs(x="Food Hardship Rate (in 2011)", y="Obesity Rate (in 2011)") +
  theme(legend.title=element_text(colour="gray40"), legend.text=element_text(colour="gray40"))  

grid.ls(grob=T, view=T, recursive=T)
ggplot2::
  
  
  grob <- ggplotGrob(g)

# editGrob(grob, gPath=gPath("guide-box")
grid.ls(grob, "guide-box")


grob[3]
grid.ls(x=ggplotGrob(g), grobs=T, recursive=T)

grob


#   theme(legend.text=element_text(colour=PaletteObesityState))  
#   guides(colour=guide_legend(override.aes=list(colour=PaletteObesityState)))
# guides(colour=guide_legend(override.aes=list(colour=PaletteObesityState)))

# grid.ls()
# k <- grid.gget("guide-box")
# # k$gp
# # str(k)
# kk <- k[[1]]$`99_e636769b6861785e935e2a6171810ca0`
# # str(kk)
# # gpar(kk[4][[1]][[3]]) <- gpar(col="red")
# 
# str(kk[4][[1]][[3]])
# class(kk[4][[1]][[3]]$gp$col)
# 
# kk[4][[1]][[3]]$gp$col <- "gray40"
# grid.grabExpr
# 
# grid.remove(gPath="guide.label.text.3973", global=TRUE)
# grid.remove(gPath="guide", global=TRUE, grep=TRUE)
# grid.remove(gPath="guide\.label", global=TRUE, grep=TRUE)
# grid.remove(gPath="3973", global=TRUE, grep=TRUE)
# grid.remove(gPath="guide.title.text.4241", global=TRUE, grep=F)
# 
# 
# j <- grid.gget(gPath="guide", global=TRUE, grep=TRUE)
# str(j[[1]][1])
# 
# windowsFonts(Verdana="TT Verdana") 
# 
# # grid.gedit("GRID.text",gp=gpar(fontfamily="Verdana", col="red"))
# 
# grid.gedit("axis", gp=gpar(color="red"))
# grid.gedit("guide-box", gp=gpar(fill="red"))
# 
# grid.gedit("guide-box", gp=gpar(cex=20))