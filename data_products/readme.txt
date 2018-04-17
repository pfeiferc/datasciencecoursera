This depository contains my first R shiny app. It uses DHS demographic health survey data (https://www.dhsprogram.com/) 

The objective of the app is to let the user explore the geographic pattern of livestock ownership accross Africa. But geographical data is very heavy to host, so the app did not run on R-Shinys so i restricted it to few countries only. 

The user can now select with a radio button which livestock type is of interest, and whether all data should be used or the rural or urban only. 
The app will the reactivly return the map of the selected data. 
The variable always shows the percent of household keeping the selected type of livestock at the DHS cluster level (group of about 30 households that get a similar gps coordinates in order to make surveys anonymous).


This folder contains the following document 
1. ui.r the user interface in for shiny
2. server.r the function that rshiny calls upon, and this is where the map is create
3. EAfort.csv is a fortified shapefile (fortify) that can be read by ggplot, this is the boundary of the selected East African countris
3. dhsshiny is the tidy dhs data
4. dataprepforShiny.r a code that has been used to tidy the original data.
