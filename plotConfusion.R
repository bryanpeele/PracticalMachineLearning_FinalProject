plotConfusion <- function(pred,act,user) {

  confusion<-table(pred,act)
  
  
  for (j in 1:5) {
    confusion[,j]<-confusion[,j]/sum(confusion[,j])
  }
  
  confusion<-as.data.frame(confusion)
  names(confusion)<-c("Predicted","Actual","Freq")
  
  confusion$Freq <- round(confusion$Freq,digits=3)
  
  png(paste0("./figures/",user,"ConfusionMatrix.png"),width=480,height=480,units="px")
  
  plot <- ggplot(confusion)
  plot <- plot  + geom_tile(aes(x=Predicted, y=Actual, fill=Freq)) +
                  geom_text(aes(x=Predicted, y=Actual, label=Freq)) +
                  scale_x_discrete(name="Predicted Class") +
                  scale_y_discrete(name="Actual Class") + 
                  scale_fill_gradient(breaks=seq(from=0, to=1, by=0.1)) + 
                  labs(fill="Frequency") +
                  ggtitle(paste("Validation accuracy for",user))
  print(plot)
  
  dev.off()
}