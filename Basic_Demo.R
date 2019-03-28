# This code is slightly different from the live-coding script from the event :)

# ---- Load Packages ----
# Install the package to your library with:
# install.packages("shiny")
# Load the package from your library with:
library(shiny)

# ---- User Interface ----
# What does the app look like?
ui <- fluidPage(
  fluidRow(column(6, textInput(inputId = "name", label = "What is your name?", value = "I have no name")),
           column(6, checkboxGroupInput(inputId = "numbers", label = "Choose Your Numbers", choices = c(1:5), selected = 1))),
  fluidRow(column(6, uiOutput("name_response")),
           column(6, uiOutput("numbers_response"))),
  plotOutput("figure1", click = clickOpts(id = "plot_click")),
  fluidRow(uiOutput("plot_click_response")),
  fluidRow(uiOutput("favourite_ask")),
  fluidRow(uiOutput("favourite_response"))
)

# ---- Server ----
# How does the app work?
server <- function(input, output) {
  output$name_response <- renderPrint(paste0("Your name is ", input$name))
  output$numbers_response <- renderPrint(sum(as.numeric(input$numbers)))
  output$figure1 <- renderPlot(barplot(as.numeric(input$numbers), xlab = input$name))
  output$favourite_ask <- renderUI(selectInput(inputId = "favourite_selection", label = "Which is your favourite number?", choices = c(" ", input$numbers), selected = " "))
  output$favourite_response <- renderUI(tagList("Learn more about your favourite number ", a("here", href = paste0("https://en.wikipedia.org/wiki/", input$favourite_selection))))
  output$plot_click_response <- renderPrint(if(length(input$plot_click) > 0) paste0("You've clicked at y = ", input$plot_click[2]))
}

# ---- Run Application ----
shinyApp(ui, server)
