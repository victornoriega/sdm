#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
s1 <- withMathJax("$$\\bar{X_{n}}$$")

shinyUI(fluidPage(
  titlePanel("Muestreo en poblaciones normales"),
  withMathJax(radioButtons("inRadio", "Selecciona una distribución muestral: ",
                  choiceNames = c("Distribución muestral de$$\\bar{X_{n}}$$",
                  "Distribución muestral de $$\\frac{\\bar{X_{n}} - \\mu}{\\sigma/\\sqrt{n}}$$", 
                  "Distribución muestral de $$\\frac{(n - 1)s^{2}}{\\sigma^{2}}$$", 
                  "Distribución muestral de $$\\frac{\\bar{X_{n}} - \\mu}{S_{n}/\\sqrt{n}}$$"),
                   choiceValues = c("distrib3", "distrib4", "distrib2", "distrib1")
  )),
  sidebarLayout(
    conditionalPanel(
      "input.inRadio == 'distrib2'",
      sidebarPanel(
        h2("Estimación de la varianza"),
        radioButtons("n", "Número de muestras:",
                     c("50" = "cinc",
                       "1000" = "quin",
                       "5000" = "mil")),  
      sliderInput("m",
                  "Tamaño de muestra: ",
                  min = 2,
                  max = 50,
                  value = 30),
      sliderInput("media",
                  "Media de la población: ",
                  min = 0,
                  max = 50,
                  value = 0),
      sliderInput("var",
                  "Varianza de la población: ",
                  min = 1,
                  max = 50,
                  value = 1)
     )
    ),
    conditionalPanel(
      "input.inRadio=='distrib2'",
      mainPanel(
        h1(withMathJax("Distribución muestral de $$\\frac{(n - 1)s^{2}}{\\sigma^{2}}$$"),
           style="text-align:center;"),
        h2("Distribución Ji-Cuadrada", style="color:green; text-align:center;"),
         plotOutput("distPlot"),
        style="width:50%;position:absolute;top:0%;left:35%;"
      )
    )
  ),
  sidebarLayout(
    conditionalPanel(
      "input.inRadio=='distrib1'|| input.inRadio == 'distrib3' || input.inRadio=='distrib4'",
      sidebarPanel(
        h2("Estimación de la media"),
        radioButtons("n2", "Número de muestras:",
                     c("50" = "cinc",
                       "1000" = "quin",
                       "5000" = "mil")),  
        sliderInput("m2",
                    "Tamaño de muestra: ",
                    min = 2,
                    max = 50,
                    value = 30),
        sliderInput("media2",
                    "Media de la población: ",
                    min = 0,
                    max = 50,
                    value = 0),
        sliderInput("var2",
                    "Varianza de la población: ",
                    min = 1,
                    max = 50,
                    value = 1)
      )
    ),
    conditionalPanel(
      "input.inRadio == 'distrib1'",
      mainPanel(
        h1(withMathJax("Distribución muestral de $$\\frac{\\bar{X_{n}} - \\mu}{S_{n}/\\sqrt{n}}$$"),
           style="text-align:center;"),
        h2("Distribución t-Student", style="text-align:center;color:blue"),
        plotOutput("meanPlot"), style="width:50%; position:absolute;top:0%; left:35%"
      )
    )
  ),
    conditionalPanel(
      "input.inRadio == 'distrib3'",
      mainPanel(
        h1(withMathJax("Distribución muestral de $$\\bar{X_{n}}$$"),
           style="text-align:center;"),
        h2("Distribución normal", style="text-align:center;color:orange;"),
        plotOutput("mean2Plot"), style="width:50%;position:absolute;top: 0%;left:35%"
      )
    ),
  conditionalPanel(
    "input.inRadio == 'distrib4'",
    mainPanel(
      h1(withMathJax("Distribución muestral de $$\\frac{\\bar{X_{n}} - \\mu}{\\sigma/\\sqrt{n}}$$"),
         style="text-align:center;"),
      h2("Distribución normal estándar", style="text-align:center;color:orange;"),
      plotOutput("mean3Plot"), style="width:50%;position:absolute;top: 0%;left:35%"
    )
  )
 )
  
)
