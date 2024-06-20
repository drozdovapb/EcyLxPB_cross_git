library(ggtree)

#library(extrafont)
#font_import()

tree <- read.tree("2_trimmed_alignments.treefile")

tree$tip.label <- gsub("_", " ", tree$tip.label)

tree$goodSupport <- ifelse(tree$node.label == "/1/100", "black", "#00000000")

#svg(filename = "intro_tree.svg", width = 8, height = 2.5)
ggtree(tree) + geom_tiplab() + 
  xlim(0, 1) + 
  #geom_nodelab() + 
  geom_nodepoint(color = tree$goodSupport, size=3) + 
  geom_treescale() + 
  annotate("text", x=0.04, y=6, label = paste(intToUtf8(9679), "UFB = 100% \n aBayes = 1")) + 
  theme(text = element_text(family='mono'))
#dev.off()

ggsave(filename = "intro_tree.svg", width = 8, height = 2.5)
