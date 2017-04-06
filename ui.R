#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

recipes <- c(
  "Stuffed Peppers",
  "Oyakodon",
  "Beef Fried Rice",
  "Sweet Potato Broccoli Miso Bowl",
  "Cheesy Chicken and Rice Casserole",
  "Shepherd's Pie",
  "Vegetable Chili",
  "Sweet and Sour Stir Fry",
  "Potato Soup",
  "Vegetable Soup"
)
# Define UI for application that displays meals
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Menu Planner"),
  
  # Sidebar with a slider input for number of days to plan meals 
  sidebarLayout(
    sidebarPanel(
       numericInput("req.days",
                   "Number of days:",
                   value = 7,
                   min = 1,
                   max = 30,
                   step = 1,
                   width = '150px'),
       textAreaInput("user.recipes", 
                     "Add your own meal names separated by a comma or new line",
                     value = ""),
       actionButton("button", "Plan!", icon("cutlery")) 
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       tableOutput("menu.table")
       # textOutput("all.recipes")
    )
  )
))
