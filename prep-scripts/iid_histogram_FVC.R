require(terra)

gnd_val <- read.csv("C:/Users/jnesslage/Box/ML_FVC_Data/gnd_val/3_extract/gnd_val.csv")

par(mfrow=c(2,3))
hist(gnd_val$red/255,main="Red Band",col="red",xlab="Red [0,1]",ylim=c(0,60))
hist(gnd_val$green/255,main="Green Band",col="green",xlab="Green [0,1]",ylim=c(0,60))
hist(gnd_val$blue/255,main="Blue Band",col="blue",xlab="Blue [0,1]",ylim=c(0,60))

gnd_val_no_dup <- read.csv("C:/Users/jnesslage/Box/ML_FVC_Data/gnd_val/3_extract/gnd_val_no_dup.csv")


hist(gnd_val_no_dup$red/255,main="Red Band - no dup",col="red",xlab="Red [0,1]",ylim=c(0,60))
hist(gnd_val_no_dup$green/255,main="Green Band - no dup",col="green",xlab="Green [0,1]",ylim=c(0,60))
hist(gnd_val_no_dup$blue/255,main="Blue Band - no dup",col="blue",xlab="Blue [0,1]",ylim=c(0,60))

wilcox.test(gnd_val$red,gnd_val_no_dup$red)
wilcox.test(gnd_val$green,gnd_val_no_dup$green)
wilcox.test(gnd_val$blue,gnd_val_no_dup$blue)
