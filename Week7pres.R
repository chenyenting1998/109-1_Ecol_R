# Week 7 pres.
rm(list = ls()) 
# rm() removes selected objects in the environment
# input the object you want to delete in the "list= "
# ls() returns all the objects in the environment
# rm(list = ls()) means "remove all the objects in the environment" 

# Personal digest
LF.comp.pop.dyn <- function(sp1,sp2,generation,growth.rate.1, growth.rate.2,K1,K2,N12.coefficient,N21.coefficient){
  N1 <- sp1
  N2 <- sp2
  for (i in 2:generation) {
    N1[i] <- N1[i-1] + (growth.rate.1 * N1[i-1] * ((K1 - N1[i-1] - (N12.coefficient * N2[i-1]))/K1))
    N2[i] <- N2[i-1] + (growth.rate.2 * N2[i-1] * ((K2 - N2[i-1] - (N21.coefficient * N1[i-1]))/K2))
  }
  Dynamics <- data.frame(cbind(Generation = 1:generation, N1, N2))
  return(Dynamics)
}

q <- LF.comp.pop.dyn(sp1 = 10, sp2 = ,10, generation = 30,
                growth.rate.1 = 1.2, growth.rate.2 = 1.2,
                K1 = 100, K2 = 100,
                N12.coefficient = 1.2, N21.coefficient = 1.1)

plot(x = q$Generation, y = q$N2, type = "n", xlab = "Generation", ylab = "No. of Individuals")
points(q$N1, col = "blue")
points(q$N2, col = "red")

# debugging prof.s code
# WRONG CODE
# ADVICES: START FROM SCRATCH, 
# JUST GET INSPIRATION FROM MY CODE, WORK STEP BY STEP
grow<-function(start_1, start_2){
  num_gen <-30 # <= into <-
  N1 <- rep(0,10) 
  N2 <- rep(0,10)
  generation<-1:num_gen# rep(1, num_gen) into 1:num_gen
  growth.rate<-1.2
  K1<-100
  K2<-120
  a12<-0.8
  a21<-0.8
  N1[1]<-start_1 # 0 into 5
  N2[1]<-start_2 # start_2 into start_1
  for (i in 2:num_gen)  { # 2:3 into 2:num_gen
    N1[i] = N1[i-1] + (1.2* N1[i-1] * ((K1-N1[i-1]-(a12*N2[i-1]))/K1)) # growth rate of N1 is 3.2 =>1.2
    N2[i] = N2[i-1] + (growth.rate * N2[i-1] * ((K2-N2[i-1]-(a21*N1[i-1]))/K2))
    generation[1]=1
    print (N1[i])
  }
if (N1[1]>0){  # if N1[1] > 0
  plot(N1~generation,typ="b",ylim=c(0,max(c(K1,K2))),ylab="N") # min => max
}  else {
  plot(N1~generation,typ="n",ylim=c(0,max(c(K1,K2))),ylab="N") # min => max
}
print(N2[1])
if (N2[1]>0){
  lines(N2~generation,typ="b",col=2)}
}
  par(mar=c(9,4,1,1), mfrow=c(3,1),las=1) # removing mar; mfrow = c(3,1)
  
  grow(1,0)
  text(4,110,"Species 1 alone")
  
  grow(0,1)
  text(4,110,"Species 2 alone")
  
  grow(1,2)
  text(6,110,"Both Species competing")