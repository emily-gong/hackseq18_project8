library(data.table)
library(ggplot2)
library(plotly)

data <- fread("data/life_data_sep_avg.csv", sep = ",")

lifeExp <- data[data$Element == "Life expectancy (in years) at age x (ex)" & data$Sex == "Both" & data$GEO == "Canada",]


Age <- lifeExp[,lifeExp$Age_group]
LifeExp <- lifeExp[,lifeExp$AVG_VALUE]
Year <- lifeExp[,lifeExp$YEAR]


p <-  plot_ly(
  x = Age, 
  y = LifeExp, 
  
  frame = Year,  
  type = 'scatter',
  mode = 'lines'
) %>%
  
  layout(
    title = "Life Expectancy in Canada (1980-2016)",
    xaxis = list(
      type = "linear",
      title = "Age"
    ),
    yaxis = list(
      title = "Life Expectancy"
    )
  )

p <- p %>% 
  animation_opts(
    1000, easing = "elastic", redraw = FALSE
  )

p <- p %>% 
  animation_button(
    x = 1, xanchor = "right", y = 0, yanchor = "bottom"
  )
p

chart_link = api_create(p, filename="Life-Expectancy-In-Canada")
chart_link

