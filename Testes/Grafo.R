library(igraph)
library(visNetwork)
library(plotly)
library(ggplot2)

dataset = read.csv('c:/Users/Usuario/Documents/I.Systems/ona3.csv', header = TRUE, sep = ',')

nodes = data.frame(id = unique(dataset$source))
edges = data.frame(from = dataset$source, to = dataset$target, value = dataset$edge_weight)


p = visNetwork(nodes, edges, background = "#191B1D")%>%
  visIgraphLayout(type = "full")#%>%
  #visOptions()

p

