library(data.table)
library(ggplot2)
library(plotly)

Sys.setenv("plotly_username"="emily-gong")
Sys.setenv("plotly_api_key"="x7rzNnjyryelpQfrDiMp")

data2 <- fread("data/max_deaths_age_modified.csv", sep = ",")
lifeExp <- data2[ !(data2$GEO == "Canada"),]

lifeExpFemale <- data2[data2$Sex == "F" & !(data2$GEO == "Canada"),]
lifeExpMale   <- data2[data2$Sex == "M" & !(data2$GEO == "Canada"),]

YearF <- lifeExpFemale[,lifeExpFemale$YEAR]
YearM <- lifeExpMale[,lifeExpMale$YEAR]

RegionF <- lifeExpFemale[, lifeExpFemale$GEO]
RegionM <- lifeExpMale[, lifeExpMale$GEO]

female <- lifeExpFemale[,lifeExpFemale$Avg_age]
male <- lifeExpMale[,lifeExpMale$Avg_age]


p <-  plot_ly(
  x = YearF,
  #c('Alberta','British Columbia','Manitoba','New Brunswick','Newfoundland and Labrador','Nova Scotia','Ontario','Quebec','Saskatchewan'), 
  y = female,
  name = 'Female',
  color = 'red',
  
  frame = RegionF,  
  type = 'scatter', 
  mode = 'markers'
) %>%
 add_trace(x = YearM, y = male, frame = RegionM, name = 'Male', color = 'blue', mode = 'markers')  %>%
  
  layout(
    title = "Life Expectancy Across Provinces (1980-2016)",
    xaxis = list(
      type = "linear",
      title = 'YEAR'
    ),
    yaxis = list(
      title = 'AGE'
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

chart_link = api_create(p, filename="Life-Expectancy-Across-Provinces")
chart_link




