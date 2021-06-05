source('./r_files/flatten_HTML.r')

############### Library Declarations ###############
libraryRequireInstall("ggplot2");
libraryRequireInstall("dplyr");
libraryRequireInstall("visNetwork");
libraryRequireInstall("igraph")
####################################################

################### Actual code ####################
p <- Values

dados_gerais = read.csv("c:/Users/Usuario/Documents/Estudos/People Analytics/Medium/Power BI e Visuais Interativos em R/Grafo.csv", header = TRUE, sep = ',', encoding = 'UTF-8')
nomes = unique(Values$source)
dados_filtrados = dados_gerais[dados_gerais$target %in% nomes,]

id = c(unique(Values$source),unique(Values$target), unique(dados_filtrados$source))
id = sort(id, decreasing = FALSE)
id = unique(id)
name_label = id
node_to = c(Values$target, dados_filtrados$target)
node_from = c(Values$source, dados_filtrados$source)

nodes = data.frame(id = id, title = paste0(name_label))
edges = data.frame(from = node_from, to = node_to, value = c(Values$edge_weight, dados_filtrados$edge_weight), arrows = rep("to", length(node_to)))

# Peso
dados_peso_1 = dados_gerais[dados_gerais$source %in% id,][c("source", "source_weight")]
dados_peso_2 = dados_gerais[dados_gerais$target %in% id,][c("target", "target_weight")]
names(dados_peso_2)[names(dados_peso_2) == "target"] <- "source"
names(dados_peso_2)[names(dados_peso_2) == "target_weight"] <- "source_weight"
dados_peso = rbind(dados_peso_1, dados_peso_2)

dados_peso = unique(dados_peso[c("source", "source_weight")])
attach(dados_peso)
dados_peso = dados_peso[order(source),]
detach(dados_peso)

# Cor
dados_cor_1 = dados_gerais[dados_gerais$source %in% id,][c("source", "source_color")]
dados_cor_2 = dados_gerais[dados_gerais$target %in% id,][c("target", "target_color")]
names(dados_cor_2)[names(dados_cor_2) == "target"] <- "source"
names(dados_cor_2)[names(dados_cor_2) == "target_color"] <- "source_color"
dados_cor = rbind(dados_cor_1, dados_cor_2)

dados_cor = unique(dados_cor[c("source", "source_color")])
attach(dados_cor)
dados_cor = dados_cor[order(source),]
detach(dados_cor)

vis.nodes <- nodes
vis.nodes$size <- dados_peso$source_weight
vis.nodes$color <- dados_cor$source_color
vis.edges <- edges
vis.edges$color <- list(color = '#2B2B2B')

p <- visNetwork(vis.nodes, vis.edges, background = "white")%>%
  visIgraphLayout()%>%
  visOptions(highlightNearest = TRUE)
p

####################################################

############# Create and save widget ###############
internalSaveWidget(p, 'out.html');
####################################################
