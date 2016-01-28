plotAccuraciesTime <- function(accData,timeData) {
  library(tidyr)
  library(dplyr)
  
  total <- dim(accData)[2]
  number <- (total-1)

  accDataTidy   <- accData  %>% gather(percent,accuracy,2:total)
  timeDataTidy  <- timeData %>% gather(percent,time,2:total)
  
  accDataTidy    <- accDataTidy  %>% arrange(user,percent)
  timeDataTidy   <- timeDataTidy %>% arrange(user,percent)
  
  timeDataTidy   <- timeDataTidy %>% mutate(time_min = time/60)
  
  combinedTidyData <-cbind(accDataTidy,timeDataTidy$time_min)
  names(combinedTidyData)[4]<-"time"
  
  write.csv(combinedTidyData,   file="./output/validationAccuracies.csv"   )
  
  ## plot accuracies
  png(paste0("./figures/ValidationAccuracy.png"),width=600,height=600,units="px")
  
  accPlot <- ggplot(accDataTidy, aes(x = factor(percent), y = accuracy,group = user, color=user))
  accPlot <- accPlot  + geom_point(size=3) +
                        geom_line() +
                        xlab("Training Fraction") +
                        ylab("Accuracy") +
                        ggtitle("Accuracy vs. Training Fraction") 
                        
  print(accPlot)
  
  dev.off()
  
  ## plot time
  png(paste0("./figures/ModelFitTime.png"),width=600,height=600,units="px")
  
  timePlot <- ggplot(timeDataTidy, aes(x = factor(percent), y = time_min,group = user, color=user))
  timePlot <- timePlot  + geom_point(size=3) +
              geom_line() +
              xlab("Training Fraction") +
              ylab("Time (min)") +
              ggtitle("Model Fitting Time vs. Training Fraction") 
  
  print(timePlot)
  
  dev.off()
  
  
  
}