# AO3 Explorer - Shiny interface to ao3.scraper
# Organized into 5 different modules: history, tag hierarchy, population, comparison, login/authentication
# Login / authentication should be nearly completely invisible to the end user. Might be out of scope for now honestly.
#   - instead, have someone upload a csv for processing
# History is an exploration of personal historical data ( from CSV for now*)
#   - Slider for how long
# Population should be reading from database/buckets eventually, will for now take a csv as input (completely separate from the tab above)
# Comparison loads the two CSVs together
# The more I think about this, the more it seems that these are entirely separate applications.
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
}

# Run the application
shinyApp(ui = ui, server = server)
