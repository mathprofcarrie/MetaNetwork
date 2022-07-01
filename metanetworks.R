#metanetwork project
library(igraph)
library(tidyverse)
library(RColorBrewer)

#read in reports
#id is the person reporting
#id.1 is the person they reported
net.df<-read.csv('MetaNetworks.csv')
#Id to group map - 5 groups (4 projects and None for virtual participants)
groups_ed<-read.csv("groups.csv") 

##############################
#This code section makes the network for 
# is the top5 list reported
##############################

#make a graph object
top5_el<-as.matrix(net.df[ , c("id", "id.1")])
top5.g<-graph_from_edgelist(top5_el)

#assign group type
V(top5.g)$groups<-groups_ed$Group

# create color palette based on unique values for vertex attribute
pal <- brewer.pal(5, "Dark2")
my_color <- pal[as.numeric(as.factor(V(top5.g)$groups))]

V(top5.g)$color <- my_color

# plot network
png(file="top5.png",width=800, height=600)
plot(top5.g, edge.arrow.size = 0.1, layout=layout.fruchterman.reingold)
# Add a legend
legend("bottomleft", legend=levels(as.factor(V(top5.g)$groups))  , col = pal , bty = "n", pch=20 , pt.cex = 3, cex = 1.5, text.col=pal , horiz = FALSE)
dev.off()

