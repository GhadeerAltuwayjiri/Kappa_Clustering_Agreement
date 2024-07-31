library(MASS)
library(flowClust)
library(latex2exp)

# Initialize lists to store results
results_list <- list()
Zhat_list <- list()

# List of cov_sim values
cov_sim_values <- c(0, 0.1, 0.2, 0.5, 0.7)

# Loop through each cov_sim value
for (cov_sim in cov_sim_values) {
  Zhat_list[[as.character(cov_sim)]] <- list()
  results_list[[as.character(cov_sim)]] <- numeric(5)
  
  for (i in 1:5) {
    # Access Zhat for the current cov_sim value and sample
    Zhat_current <- simulated_data_lists[[paste0("cov_sim_", cov_sim)]]$Zhat[[i]]
    Zhat_list[[as.character(cov_sim)]][[i]] <- Zhat_current
    
    # Calculate the ratio of matching cluster assignments
    ratio <- sum(diag(table(simulated_data_lists[[paste0("cov_sim_", cov_sim)]]$Ztoy[[i]], Zhat_current))) / length(Zhat_current)
    
    # Store the ratio in the results list
    results_list[[as.character(cov_sim)]][i] <- ratio
  }
}

# Define the cov_sim values and convert them to character
cov_sim_values <- as.character(c(0, 0.1, 0.2, 0.5, 0.7))

# Set plotting parameters back to default
par(mfrow = c(1, 1))

# Loop through each cov_sim value
for (cov_sim_value in cov_sim_values) {
  # Retrieve the "Kappa Not Applied" values from the results_list for the current cov_sim
  kappa_not_applied_values <- results_list[[cov_sim_value]]
  
  # Assuming 'metrics_array' is structured as [kappa_values, samples, cov_sim_values]
  # and contains the agreement levels when Kappa is applied
  metrics <- metrics_array[,,cov_sim_value]
  
  # Calculate the average agreement level for each sample across applied kappa values (excluding "Not Applied")
  average_kappa_applied <- colMeans(metrics[-1,])  # Exclude the first row
  
  # Calculate the standard error for each sample across applied kappa values
  se_kappa_applied <- apply(metrics[-1,], 2, function(x) sd(x) / sqrt(length(x)))
  
  # Plotting
  plot(1:length(kappa_not_applied_values), kappa_not_applied_values, 
       ylim = range(c(kappa_not_applied_values, average_kappa_applied - se_kappa_applied, average_kappa_applied + se_kappa_applied)), 
       xaxt = 'n', pch = 19, xlab = "Samples", ylab = "Level of Agreement", 
       main = TeX(paste("Agreement Level Comparison for $\\omega = ", cov_sim_value)), 
       cex.main = 2)
  axis(1, at = 1:length(kappa_not_applied_values), labels = paste("Sample", 1:5))
  
  # Adding points for 'Kappa Not Applied'
  points(1:length(kappa_not_applied_values), kappa_not_applied_values, col = "red", pch = 19)
  
  # Adding a line for the average agreement level when kappa is applied
  lines(1:length(kappa_not_applied_values), average_kappa_applied, col = "blue", type = "b", pch = 18)
  
  # Adding error bars for the standard error
  for(i in 1:length(kappa_not_applied_values)) {
    lines(c(i, i), c(average_kappa_applied[i] - se_kappa_applied[i], average_kappa_applied[i] + se_kappa_applied[i]), col = "blue")
  }
  
  # Adding a legend for clarity
  legend("center", legend = c("Kappa = 0", "Average Kappa Applied"), col = c("red", "blue"), pch = c(19, 18), cex = 0.8)
}

# Loop through each cov_sim value for plotting all together
cov_sim_values <- as.character(c(0, 0.1, 0.2, 0.5, 0.7))

# Define the layout matrix
layout_matrix <- matrix(c(1, 2,
                          3, 5,
                          4, 4), nrow = 3, byrow = TRUE)

# Set up the layout
layout(layout_matrix, heights = c(1, 2, 1))

# Loop through each cov_sim value
for (cov_sim_value in cov_sim_values) {
  # Retrieve the "Kappa Not Applied" values from the results_list for the current cov_sim
  kappa_not_applied_values <- results_list[[cov_sim_value]]
  
  # Assuming 'metrics_array' is structured as [kappa_values, samples, cov_sim_values]
  # and contains the agreement levels when Kappa is applied
  metrics <- metrics_array[,,cov_sim_value]
  
  # Calculate the average agreement level for each sample across applied kappa values (excluding "Not Applied")
  average_kappa_applied <- colMeans(metrics[-1,])  # Exclude the first row
  
  # Calculate the standard error for each sample across applied kappa values
  se_kappa_applied <- apply(metrics[-1,], 2, function(x) sd(x) / sqrt(length(x)))
  
  # Plotting
  plot(1:length(kappa_not_applied_values), kappa_not_applied_values, 
       ylim = range(c(kappa_not_applied_values, average_kappa_applied - se_kappa_applied, average_kappa_applied + se_kappa_applied)), 
       xaxt = 'n', pch = 19, xlab = "Samples", ylab = "Level of Agreement", 
       main = TeX(paste("Agreement Level Comparison for $\\omega = ", cov_sim_value)), 
       cex.main = 2)
  axis(1, at = 1:length(kappa_not_applied_values), labels = paste("Sample", 1:5))
  
  # Adding points for 'Kappa Not Applied'
  points(1:length(kappa_not_applied_values), kappa_not_applied_values, col = "red", pch = 19)
  
  # Adding a line for the average agreement level when kappa is applied
  lines(1:length(kappa_not_applied_values), average_kappa_applied, col = "blue", type = "b", pch = 18)
  
  # Adding error bars for the standard error
  for(i in 1:length(kappa_not_applied_values)) {
    lines(c(i, i), c(average_kappa_applied[i] - se_kappa_applied[i], average_kappa_applied[i] + se_kappa_applied[i]), col = "blue")
  }
  
  # Adding a legend for clarity
  legend("center", legend = c("Kappa = 0", "Average Kappa Applied"), col = c("red", "blue"), pch = c(19, 18), cex = 0.8)
}
