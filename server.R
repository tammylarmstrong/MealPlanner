#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  observeEvent(input$button, {
  output$menu.table <- renderTable({
    # base set of meals to choose from
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
    
    # user contributed meal names
    if (input$user.recipes != "") {
    new.recipes <- unlist(strsplit(input$user.recipes, "[,\n]"))
    recipes <- c(recipes, new.recipes)}

    # if we have more recipes than days to plan, just sample from the recipe list
    if (input$req.days <= length(recipes)) {
      menu <- sample(recipes, input$req.days, replace=FALSE)
    }
    # if we are requesting to plan more days than we have recipes, we will need to repeat some.
    # random sampling with replacement could result in repeating recipes very close together,
    # so we want to sample WITHOUT replacement several times, in order to minimize this
    # (could still happen if last recipe chosen equals first recipe in next sample).
    else {
      menu <- c()
      repeat {
        menu <- c(menu, sample(recipes, length(recipes), replace=FALSE))
        remaining <- input$req.days - length(menu) # how many days do we still need to plan?
        if(remaining < length(recipes)) {
          menu <- c(menu, sample(recipes, remaining, replace = FALSE))
          break
        }
        }
      }
    
    # generate menu day names
    menu.days <- format(seq(as.Date(Sys.Date()),as.Date(Sys.Date()+length(menu)-1), "days"), "%a, %b %d")
    data.frame(Day = menu.days, Meal = menu)
  })
})
  output$all.recipes <- renderText(
    print(recipes)
  )
})