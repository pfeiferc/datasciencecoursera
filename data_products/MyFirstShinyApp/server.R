#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
#setwd("C:/Users/Catherine Pfeifer/OneDrive/coursera/9-data product/MyFirstShinyApp")
library(shiny)
library(sp)
library(rgdal)
library(RColorBrewer)
library(dplyr)
library(ggplot2)
library(mapproj)
#library(maptools)
data<-read.csv("./dataShiny.csv")

EA.fort <- read.csv("./EAfort.csv")

# Define server logic required to draw map
shinyServer(function(input, output) {

  output$myMap <- renderPlot ({
       # generate input variable from ui.R 
       liv   <- input$liv
       liv2<-noquote(liv)
       isrural<-ifelse(input$location=="rural",1,0)
       loc<-input$location
  
       

       # subset the data based on input
       if(loc=="both"){
          data2<-data%>% select(liv,x,y)%>%filter(x>0)
          } else{
          data2<-data %>% select(liv,x,y,IsRural) %>% dplyr::filter(IsRural==isrural) %>% filter(x>0)
       } # end of if loop
       data2<-na.omit(data2)

       # the loop above subsets the dataset for the selected animal type, and if rural or urban has been
       # selected, subsets the 
       
              
       # add the coordinates
      
       ggplot()+
            geom_point(data=data2,aes(x,y,colour= data2[1]))+
            scale_colour_distiller(palette='Spectral')+
            geom_path(data = EA.fort,aes(long,lat,group=group))+
            coord_map()+
            ggtitle("proportion of household keeping the selected type of animals")
       
## this is the graphic creation base on the subsetted data
     
       
     })
  })

