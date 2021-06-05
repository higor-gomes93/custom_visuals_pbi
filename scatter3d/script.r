source('./r_files/flatten_HTML.r')

############### Library Declarations ###############
libraryRequireInstall("ggplot2");
libraryRequireInstall("plotly");
libraryRequireInstall("dplyr");
####################################################

################### Actual code ####################
colors <- c('#149400', '#0B88E0', '#8700E0', '#CD00E0', '#E0183B', '#E0540E', '#E0AB3C', '#E0CF19', '#C3DECC')
p <- Values %>%
  plot_ly( x = ~performance, y = ~potential, z = ~engagement, color = ~area, colors = colors, text = ~paste('Nome: ', name)) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = list(text = 'Performance (x)')),
                      yaxis = list(title = list(text = 'Potencial (y)')),
                      zaxis = list(title = list(text = 'Engajamento (z)'))), paper_bgcolor = 'white', plot_bgcolor = 'white', hoverlabel = list(bgcolor = 'white'),hoverlabel = list(bgcolor = 'white'));


############# Create and save widget ###############
internalSaveWidget(p, 'out.html');
####################################################