library(ggplot2)
library(dplyr)
library(palmerpenguins)

ui <- fluidPage(
  titlePanel("Analyse des données des pingouins de Palmer"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("species", "Espèces sélectionnées:",
                         choices = c("Adelie" = "Adelie", "Chinstrap" = "Chinstrap", "Gentoo" = "Gentoo"),
                         selected = c("Adelie", "Chinstrap", "Gentoo")),
      radioButtons("type", "Type de graphique:",
                   choices = c("Histogramme" = "hist", "Densité" = "density")),
      sliderInput("xlim", "Longueurs d'ailes considérées (mm):",
                  min = 170, max = 240, value = c(170, 240)),
      conditionalPanel(
        condition = "input.type == 'hist'",
        sliderInput("bins", "Nombre de barres:",
                    min = 5, max = 50, value = 30)
      )
    ),
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Ailes", plotOutput("fliperPlot")),
                  tabPanel("Bec", plotOutput("billPlot"))
      )
    )
  )
)
