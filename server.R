#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
# La idea general es mostrar simulaciones de estadisticos: en este caso la varianza y la media.
# Para hacer tales simulaciones, se toman n muestras de tamano m. 
#
#
#
#

shinyServer(function(input, output) {
  #Para la Ji-Cuadrada
  output$distPlot <- renderPlot({
    #$n es el numero de muestras; $m es el tamano de la muestra
    radioButton = input$n
    if(radioButton=="cinc"){
      n<-50
    }else if(radioButton=="quin"){
      n<-1000
    }else if(radioButton=="mil"){
      n<-5000
    }
    m = input$m
    media = input$media
    var = input$var
    x<-array(1:n*m, dim = c(n,m))
    

    x[,] <-rnorm(n*m,media,sqrt(var))
      
    
    varMuestrales = seq(1,n,by=1)
    for(i in 1:n){
      varMuestrales[i] = ((m-1)*sd(x[i,])^2)/var
    }
    par(mfrow = c(2,1))
    par(mfg = c(1,1))
    z<- seq(0,2*m, length = 3000)
    y<- dchisq(z, m-1)
    hist(varMuestrales, prob = TRUE, xlab = "", main="", ylab = "")
    #hist(density(mediasMuestrales),type="l","lwd"=1, xlab = "x",prob = TRUE,  ylab = "Medias muestrales", main = "Medias muestrales y t-Student")
    par(new = T)
    plot(z,y,col="green", xlab = "", ylab = "", "lwd" =1, yaxt="n",xaxt="n", xlim = c(min(varMuestrales)-0.5,max(varMuestrales)+0.5), pch=1)
    axis(side=1, col.axis= "green", col.ticks = "green", line=2)
  
    par(mfg = c(2,1))
    x <- seq(media - 2 * var, media + 2 * var, length = 500)
    y <- dnorm(x, media, var)
    plot(x, y, pch=2, ylab = "", main = "Población madre (normal)", xlab="")
    parametro <- sd(varMuestrales)
  }, height = 800)
  

  #Para la t-student:
  output$meanPlot <- renderPlot({
    radioButton = input$n2
    if(radioButton=="cinc"){
      n<-50
    }else if(radioButton=="quin"){
      n<-1000
    }else if(radioButton=="mil"){
      n<-5000
    }
    m = input$m2
    media = input$media2
    var = input$var2
    
    x = array(1:n*m, dim = c(n,m))
    
    for(i in 1:n){
      for(j in 1:m){
        x[i,j] = rnorm(1,media,sqrt(var))
      }
    }
    mediasMuestrales = seq(1,n,by=1)
    for(i in 1:n){
      mediasMuestrales[i] =(mean(x[i,])-media)/(sd(x[i,])/sqrt(m))
    }
    par(mfrow = c(2,1))
    par(mfg = c(1,1))
    z<- seq(-6, 6, length = 3000)
    y<- dt(z, m-1)
    
    
    hist(mediasMuestrales, prob = TRUE, xlab = "", main="", ylab="")
    #hist(density(mediasMuestrales),type="l","lwd"=1, xlab = "x",prob = TRUE,  ylab = "Medias muestrales", main = "Medias muestrales y t-Student")
    par(new = T)
    plot(z,y,col="blue", xlab = "", ylab = "", "lwd" =1, yaxt="n",xaxt="n", xlim = c(min(mediasMuestrales)-0.5,max(mediasMuestrales)+0.5))
    axis(side=1, col.axis= "blue", col.ticks = "blue", line=2)
    par(mfg = c(2,1))
    x <- seq(media - 2 * var, media + 2 * var, length = 500)
    y <- dnorm(x, media, var)
    plot(x, y, pch=2, ylab = "", main = "Población madre (normal)", xlab="")
  }, height = 800)
  
  #para la media muestral
  output$mean2Plot <-renderPlot({
    radioButton = input$n2
    if(radioButton=="cinc"){
      n<-50
    }else if(radioButton=="quin"){
      n<-1000
    }else if(radioButton=="mil"){
      n<-5000
    }
    m = input$m2
    media = input$media2
    var = input$var2
    
    x <- array(1:n*m, dim = c(n,m))
    
    for(i in 1:n){
      for(j in 1:m){
        x[i,j] = rnorm(1,media,sqrt(var))
      }
    }
    mediasMuestrales = seq(1,n,by=1)
    for(i in 1:n){
      mediasMuestrales[i] =(mean(x[i,]))
    }
    par(mfrow = c(2,1))
    par(mfg = c(1,1))
    x<-seq(media-1-var/10,media+1+var/10, length.out = 2000)
    y<-rnorm(2000, media, sqrt(var)/sqrt(m))
    
    hist(mediasMuestrales,prob=TRUE,xlab="", xlim = c(media - 1 - var/10, media + 1 + var/10), ylab="", main="")
    par(new = T)
    a<-seq(media - 1 - var/10, media + 1 + var/10,length=2000)
    b<-dnorm(a, mean = media, sd=sqrt(var)/sqrt(m))
    plot(a,b,col="orange", xlab = "", ylab = "", "lwd" =1,  xaxt="n", yaxt="n", xlim = c(media - 1 - var/10, media + 1 + var/10))
    axis(side=1, col.axis= "orange", col.ticks = "orange", line=2)
    par(mfg = c(2,1))
    x <- seq(media - 2 * var, media + 2 * var, length = 500)
    y <- dnorm(x, media, var)
    plot(x, y, pch=2, ylab = "", main = "Población madre (normal)", xlab="")
  }, height = 800)
  #Para la x-t/sigma/raiz(n)
  output$mean3Plot <-renderPlot({
    radioButton = input$n2
    if(radioButton=="cinc"){
      n<-50
    }else if(radioButton=="quin"){
      n<-1000
    }else if(radioButton=="mil"){
      n<-5000
    }
    m = input$m2
    media = input$media2
    var = input$var2
    par(mfrow=c(2,1))
    par(mfg = c(1,1))
    # En este renderPlot vamos a presentar a la distribucion x-t/sigma/raiz(n) contra la normal
    x = array(1:n*m, dim = c(n,m))
    
    for(i in 1:n){
      for(j in 1:m){
        x[i,j] = rnorm(1,media,sqrt(var))
      }
    }
    mediasMuestrales = seq(1,n,by=1)
    for(i in 1:n){
      mediasMuestrales[i] =(mean(x[i,])-media)/(sqrt(var)/sqrt(m))
    }
    z<- seq(-6, 6, length = 3000)
    y<- dnorm(z)
    
    
    hist(mediasMuestrales, prob = TRUE, xlab = "", main="", ylab = "")
    #hist(density(mediasMuestrales),type="l","lwd"=1, xlab = "x",prob = TRUE,  ylab = "Medias muestrales", main = "Medias muestrales y t-Student")
    par(new = T)
    plot(z,y,col="pink", xlab = "", ylab = "", "lwd" =1, yaxt="n",xaxt="n", xlim = c(min(mediasMuestrales)-0.5,max(mediasMuestrales)+0.5))
    axis(side=1, col.axis= "pink", col.ticks = "pink", line=2)
    par(mfg = c(2,1))
    x <- seq(media - 2 * var, media + 2 * var, length = 500)
    y <- dnorm(x, media, var)
    plot(x, y, pch=2, main = "Población madre (normal)", xlab="", ylab = "")
    
  }, height = 800)
  
})
