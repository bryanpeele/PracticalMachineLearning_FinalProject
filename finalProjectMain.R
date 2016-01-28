## start timer
ptm <- proc.time()

## read in testing data
testing<-read.csv("pml-testing.csv")

## store feature set, ignoring NA columns and window data
testingTemp<-testing[,!is.na(testing[1,])]
testingTemp<-testingTemp[,-c(1,3,4,6,7,60)]

## read in training data
training<-read.csv("pml-training.csv")

print("data loaded into R")
timeA<-proc.time()-ptm
print(timeA)

## store feature set, ignoring NA columns (based on available test data) and window data
training<-training[,!is.na(testing[1,])]
training<-training[,-c(1,3,4,6,7)]

## reset testing to Temp
testing<-testingTemp

## Separate data by user
## 6 user names: adelmo, carlitos, charles, eurico, jeremy, pedro

adelmoIndexTr   <-grepl("adelmo",   training$user_name, ignore.case=TRUE)
carlitosIndexTr <-grepl("carlitos", training$user_name, ignore.case=TRUE)
charlesIndexTr  <-grepl("charles",  training$user_name, ignore.case=TRUE)
euricoIndexTr   <-grepl("eurico",   training$user_name, ignore.case=TRUE)
jeremyIndexTr   <-grepl("jeremy",   training$user_name, ignore.case=TRUE)
pedroIndexTr    <-grepl("pedro",    training$user_name, ignore.case=TRUE)

adelmoTr   <-training[adelmoIndexTr,  ]
carlitosTr <-training[carlitosIndexTr,]
charlesTr  <-training[charlesIndexTr, ]
euricoTr   <-training[euricoIndexTr,  ]
jeremyTr   <-training[jeremyIndexTr,  ] 
pedroTr    <-training[pedroIndexTr,   ]

adelmoIndexTe   <-grepl("adelmo",   testing$user_name, ignore.case=TRUE)
carlitosIndexTe <-grepl("carlitos", testing$user_name, ignore.case=TRUE)
charlesIndexTe  <-grepl("charles",  testing$user_name, ignore.case=TRUE)
euricoIndexTe   <-grepl("eurico",   testing$user_name, ignore.case=TRUE)
jeremyIndexTe   <-grepl("jeremy",   testing$user_name, ignore.case=TRUE)
pedroIndexTe    <-grepl("pedro",    testing$user_name, ignore.case=TRUE)

adelmoTe   <-testing[adelmoIndexTe,  ]
carlitosTe <-testing[carlitosIndexTe,]
charlesTe  <-testing[charlesIndexTe, ]
euricoTe   <-testing[euricoIndexTe,  ]
jeremyTe   <-testing[jeremyIndexTe,  ] 
pedroTe    <-testing[pedroIndexTe,   ]


library(caret)
validationAccuracies <- data.frame(user=c("adelmo","carlitos","charles","eurico","jeremy","pedro","cummulative"))
validationTimes      <- data.frame(user=c("adelmo","carlitos","charles","eurico","jeremy","pedro","cummulative"))


## create validation sets (20%) for each user
percent<-0.8

inTrain<-createDataPartition(y=adelmoTr$classe,p=percent,list=FALSE)
adelmoTraining<-adelmoTr[inTrain,]
adelmoValidation<-adelmoTr[-inTrain,]

inTrain<-createDataPartition(y=carlitosTr$classe,p=percent,list=FALSE)
carlitosTraining<-carlitosTr[inTrain,]
carlitosValidation<-carlitosTr[-inTrain,]

inTrain<-createDataPartition(y=charlesTr$classe,p=percent,list=FALSE)
charlesTraining<-charlesTr[inTrain,]
charlesValidation<-charlesTr[-inTrain,]

inTrain<-createDataPartition(y=euricoTr$classe,p=percent,list=FALSE)
euricoTraining<-euricoTr[inTrain,]
euricoValidation<-euricoTr[-inTrain,]

inTrain<-createDataPartition(y=jeremyTr$classe,p=percent,list=FALSE)
jeremyTraining<-jeremyTr[inTrain,]
jeremyValidation<-jeremyTr[-inTrain,]

inTrain<-createDataPartition(y=pedroTr$classe,p=percent,list=FALSE)
pedroTraining<-pedroTr[inTrain,]
pedroValidation<-pedroTr[-inTrain,]

##train all data together
inTrain<-createDataPartition(y=training$classe,p=percent,list=FALSE)
cummTraining<-training[inTrain,]
cummValidation<-training[-inTrain,]


## create models using different portions of training data to compare accuracy
for(i in 1:5)
{
        ## train data for each user
        percent<-0.2*i
        print(paste("ready to grow random forests at",100*percent,"percent"))
        timeB<-proc.time()-ptm
        print(timeB)
        
        inTrain<-createDataPartition(y=adelmoTraining$classe,p=percent,list=FALSE)
        adelmoTrainingTmp<-adelmoTraining[inTrain,]
        adelmoFit<-train(classe~.,method="rf",data=adelmoTrainingTmp[,-c(1,2)],prox=TRUE)
        
        print(paste("training complete for adelmo at",100*percent,"percent"))
        timeC<-proc.time()-ptm
        adelmoTime<-timeC-timeB
        print(timeC)
        
        inTrain<-createDataPartition(y=carlitosTraining$classe,p=percent,list=FALSE)
        carlitosTrainingTmp<-carlitosTraining[inTrain,]
        carlitosFit<-train(classe~.,method="rf",data=carlitosTrainingTmp[,-c(1,2)],prox=TRUE)
        
        print(paste("training complete for carlitos at",100*percent,"percent"))
        timeD<-proc.time()-ptm
        carlitosTime<-timeD-timeC
        print(timeD)
        
        inTrain<-createDataPartition(y=charlesTraining$classe,p=percent,list=FALSE)
        charlesTrainingTmp<-charlesTraining[inTrain,]
        charlesFit<-train(classe~.,method="rf",data=charlesTrainingTmp[,-c(1,2)],prox=TRUE)
        
        print(paste("training complete for charles at",100*percent,"percent"))
        timeE<-proc.time()-ptm
        charlesTime<-timeE-timeD
        print(timeE)
        
        inTrain<-createDataPartition(y=euricoTraining$classe,p=percent,list=FALSE)
        euricoTrainingTmp<-euricoTraining[inTrain,]
        euricoFit<-train(classe~.,method="rf",data=euricoTrainingTmp[,-c(1,2)],prox=TRUE)
        
        print(paste("training complete for eurico at",100*percent,"percent"))
        timeF<-proc.time()-ptm
        euricoTime<-timeF-timeE
        print(timeF)
        
        inTrain<-createDataPartition(y=jeremyTraining$classe,p=percent,list=FALSE)
        jeremyTrainingTmp<-jeremyTraining[inTrain,]
        jeremyFit<-train(classe~.,method="rf",data=jeremyTrainingTmp[,-c(1,2)],prox=TRUE)
        
        print(paste("training complete for jeremy at",100*percent,"percent"))
        timeG<-proc.time()-ptm
        jeremyTime<-timeG-timeF
        print(timeG)
        
        inTrain<-createDataPartition(y=pedroTraining$classe,p=percent,list=FALSE)
        pedroTrainingTmp<-pedroTraining[inTrain,]
        pedroFit<-train(classe~.,method="rf",data=pedroTrainingTmp[,-c(1,2)],prox=TRUE)
        
        print(paste("training complete for pedro at",100*percent,"percent"))
        timeH<-proc.time()-ptm
        pedroTime<-timeH-timeG
        print(timeH)
        
        ##train all data together
        inTrain<-createDataPartition(y=cummTraining$classe,p=percent,list=FALSE)
        cummTrainingTmp<-cummTraining[inTrain,]
        cummFit<-train(classe~.,method="rf",data=cummTrainingTmp[,-c(1,2)],prox=TRUE)
        
        
        print(paste("cummulative training complete at",100*percent,"percent"))
        timeI<-proc.time()-ptm
        cummTime<-timeI-timeH
        print(timeI)
        
        ## test each fit on validation set
        adelmoValPred<-predict(adelmoFit,adelmoValidation)
        adelmoValAccuracy<-sum(adelmoValPred==adelmoValidation$classe)/length(adelmoValidation$classe)
        
        carlitosValPred<-predict(carlitosFit,carlitosValidation)
        carlitosValAccuracy<-sum(carlitosValPred==carlitosValidation$classe)/length(carlitosValidation$classe)
        
        charlesValPred<-predict(charlesFit,charlesValidation)
        charlesValAccuracy<-sum(charlesValPred==charlesValidation$classe)/length(charlesValidation$classe)
        
        euricoValPred<-predict(euricoFit,euricoValidation)
        euricoValAccuracy<-sum(euricoValPred==euricoValidation$classe)/length(euricoValidation$classe)
        
        jeremyValPred<-predict(jeremyFit,jeremyValidation)
        jeremyValAccuracy<-sum(jeremyValPred==jeremyValidation$classe)/length(jeremyValidation$classe)
        
        pedroValPred<-predict(pedroFit,pedroValidation)
        pedroValAccuracy<-sum(pedroValPred==pedroValidation$classe)/length(pedroValidation$classe)
        
        cummValPred<-predict(cummFit,cummValidation)
        cummValAccuracy<-sum(cummValPred==cummValidation$classe)/length(cummValidation$classe)
        
        ## store validation accuracies for each user
        colName<-paste(percent)
        validationAccuracies[colName] <- c(adelmoValAccuracy,carlitosValAccuracy,charlesValAccuracy,euricoValAccuracy,
                                           jeremyValAccuracy,pedroValAccuracy,cummValAccuracy)
        colName<-paste(percent)
        validationTimes[colName]      <- c(adelmoTime[3],carlitosTime[3],charlesTime[3],euricoTime[3],
                                           jeremyTime[3],pedroTime[3],cummTime[3])

}        

## plot and save confusion matrices for final model
library(ggplot2)
source('plotConfusion.R')
plotConfusion(adelmoValPred,   adelmoValidation$classe,   "Adelmo"   )
plotConfusion(carlitosValPred, carlitosValidation$classe, "Carlitos" )
plotConfusion(charlesValPred,  charlesValidation$classe,  "Charles"  )
plotConfusion(euricoValPred,   euricoValidation$classe,   "Eurico"   )
plotConfusion(jeremyValPred,   jeremyValidation$classe,   "Jeremy"   )
plotConfusion(pedroValPred,    pedroValidation$classe,    "Pedro"    )
plotConfusion(cummValPred,     cummValidation$classe,     "all users combined")


## plot accuracy as sample size is increased
source('plotAccuraciesTime.R')
plotAccuraciesTime(validationAccuracies,validationTimes)


print("validation accuracies calculated and written to file")
time<-proc.time()-ptm
print(time)

## create predictions for the test set using each model
adelmoTePred   <-predict(adelmoFit,   adelmoTe   )
carlitosTePred <-predict(carlitosFit, carlitosTe )
charlesTePred  <-predict(charlesFit,  charlesTe  )
euricoTePred   <-predict(euricoFit,   euricoTe   )
jeremyTePred   <-predict(jeremyFit,   jeremyTe   )
pedroTePred    <-predict(pedroFit,    pedroTe    )
cummTePred     <-predict(cummFit,     testing    )

## store predicted testing values
write.csv(adelmoTePred,   file="./output/adelmoTePred.csv"   )
write.csv(carlitosTePred, file="./output/carlitosTePred.csv" )
write.csv(charlesTePred,  file="./output/charlesTePred.csv"  )
write.csv(euricoTePred,   file="./output/euricoTePred.csv"   )
write.csv(jeremyTePred,   file="./output/jeremyTePred.csv"   )
write.csv(pedroTePred,    file="./output/pedroTePred.csv"    )
write.csv(cummTePred,     file="./output/testingPred.csv"    )

print("testing predictions calculated and written to file")
time<-proc.time()-ptm
print(time)

## output summaries of final models
out<-capture.output(adelmoFit$finalModel)
cat("adelmoFit",out,file="./models/adelmoFit.txt",sep="\n")

out<-capture.output(carlitosFit$finalModel)
cat("carlitosFit",out,file="./models/carlitosFit.txt",sep="\n")

out<-capture.output(charlesFit$finalModel)
cat("charlesFit",out,file="./models/charlesFit.txt",sep="\n")

out<-capture.output(euricoFit$finalModel)
cat("euricoFit",out,file="./models/aeuricoFit.txt",sep="\n")

out<-capture.output(jeremyFit$finalModel)
cat("jeremyFit",out,file="./models/jeremyFit.txt",sep="\n")

out<-capture.output(pedroFit$finalModel)
cat("pedroFit",out,file="./models/pedroFit.txt",sep="\n")

out<-capture.output(cummFit$finalModel)
cat("cummFit",out,file="./models/cummFit.txt",sep="\n")
