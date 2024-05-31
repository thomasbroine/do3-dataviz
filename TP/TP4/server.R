library(ggplot2)
library(dplyr)
library(palmerpenguins)  

server <- function(input, output) {
  output$fliperPlot <- renderPlot({
    data <- penguins %>% 
      filter(species %in% input$species,
             flipper_length_mm >= input$xlim[1],
             flipper_length_mm <= input$xlim[2])
    
    if (input$type == "hist") {
      ggplot(data, aes(x = flipper_length_mm, fill = species)) +
        geom_histogram(alpha = 0.6, position = "identity", bins = input$bins) +
        labs(title = "Histogramme des longueurs des ailes", x = "Longueur des ailes (mm)", y = "Nombre")
    } else {
      ggplot(data, aes(x = flipper_length_mm, fill = species)) +
        geom_density(alpha = 0.6, adjust = 1.5) +
        labs(title = "Densité des longueurs des ailes", x = "Longueur des ailes (mm)", y = "Densité")
    }
  })
  
  output$billPlot <- renderPlot({
    data <- penguins %>%
      filter(species %in% input$species)
    ggplot(data, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
      geom_point(alpha = 0.6) +
      geom_smooth(method = "lm", se = FALSE) +
      labs(title = "Relation entre la longueur et la largeur du bec", x = "Longueur du bec (mm)", y = "Largeur du bec (mm)")
  })
}
