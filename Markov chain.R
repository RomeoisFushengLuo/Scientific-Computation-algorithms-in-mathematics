
# Define the transition probabilities
transition_probabilities <- matrix(c(0.6, 0.4, 0.3, 0.7),
                                   nrow = 2,
                                   byrow = TRUE, # byrow: logical, if FALSE, the matrix is filled by columns
                                   dimnames = list(c("A", "B"), c("A", "B")))
# Define the initial state
current_state <- "A"
# Simulate the Markov chain for 10 steps
chain <- character(10)
chain[1] <- current_state
for (i in 2:10) {
  current_state <- sample(c("A", "B"), size = 1, prob =
                            transition_probabilities[current_state,])
  # size:a non-negative integer giving the number of items to choose. i.e. From 'A' 'B', we only choose one state.
  chain[i] <- current_state
}

chain # The simulated chain is completely random, this brings different results for a multiple times.he

# If initial distribution is given
initial_distribution <- matrix(c(0.2, 0.8),
                                 nrow = 1,
                                 byrow = TRUE, # The matrix is filled by rows. 
                                 dimnames = list(c("X_0"), c("A", "B") ))

current_state <- sample(c("A", "B"), size = 1, prob = initial_distribution["X_0",])

# Simulate the Markov chain for 10 steps
chain <- character(10)
chain[1] <- current_state
for (i in 2:10) {
  current_state <- sample(c("A", "B"), size = 1, prob =
                            transition_probabilities[current_state,])
  chain[i] <- current_state
}

# Print the simulated chain
chain

chain <- replace(chain, chain=="A", 1)
chain <- replace(chain, chain=="B", 2)
plot(chain, type = "l", lty = 1) # lty = 1 对应实线，2，3，4，对应虚线（越来越浅）


#####################################
# Q1
# Keep rolling a die and let Xn be the value of the n-th roll.
                                   
# Set the number of time steps
nSteps <- 100

# Initialize an empty vector to store the process
process <- numeric(nSteps)

# Roll the die for each time step and add the result to the process
for (i in 1:nSteps){
  roll <- sample(1:6, size=1, replace=TRUE) # the sampling should be with replacement
  process[i] <- roll
}

process
plot(process, type='l', lty = 1)


# Keep tossing a coin, let Xn be the number of heads so far.
nSteps <- 100
process <- numeric(nSteps)

# Initialize the number of heads to 0
num_heads <- 0

for (i in 1:nSteps){
  toss <- sample(c("head", "tail"), size=1, replace=TRUE, prob = c(1/2,1/2))
  if (toss=="head"){
    num_heads <- num_heads+1
  }
  process[i] <- num_heads
}

process
plot(process,type='l',lyt=1)


##############################
# Q2

nSteps <- 100
process <- numeric(nSteps)
process[1] <- 1

for (i in 1:nSteps){
  if (process[i] == 0){
    process[i+1] <- 1
  } else if (process[i] == 2){
    process[i+1] <- 1
  } else{
    process[i+1] <- sample(c(0,2), size=1, replace=TRUE)
  }
}  

process
plot(process, type="l", lty=1)

### (b) 
transition_matrix <- matrix(c(0, 1, 0, 0.5, 0, 0.5, 0, 1, 0), 
                            nrow = 3, 
                            byrow = TRUE,
                            dimnames = list(c(0, 1, 2), c(0, 1, 2)))
library(expm) 

n_step_transition <- transition_matrix %^% 5

prob <- n_step_transition[1,1]

print(prob)

### (c)
### (c) 
p_11n <- numeric(100)
for (t in 1:100){
  n_step_transition <- transition_matrix %^% t
  p_11n[t] <- n_step_transition[1,1]
}

# Plot the probabilities 
plot(p_11n,  type = "l", lty = 1)


#####################################
## Q3

N <- 10
process <- numeric(N)
Xmax <- 0
for (i in 1:N){
  toss <- sample(1:6, size=1, replace=TRUE)
  process[i] <- toss
  if (process[i+1] > process[i]){
    Xmax <- process[i+1]
  } else {
    Xmax <- process[i]
  }
}

process
Xmax
