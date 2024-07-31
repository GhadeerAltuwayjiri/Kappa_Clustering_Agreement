import numpy as np
import matplotlib.pyplot as plt

# Initialize lists to store results
results_list = {}
Zhat_list = {}

# List of cov_sim values
cov_sim_values = [0, 0.1, 0.2, 0.5, 0.7]

# Loop through each cov_sim value
for cov_sim in cov_sim_values:
    Zhat_list[str(cov_sim)] = []
    results_list[str(cov_sim)] = np.zeros(5)
    
    for i in range(5):
        # Access Zhat for the current cov_sim value and sample
        Zhat_current = simulated_data_lists[f"cov_sim_{cov_sim}"]['Zhat'][i]
        Zhat_list[str(cov_sim)].append(Zhat_current)
        
        # Calculate the ratio of matching cluster assignments
        ratio = np.sum(np.diag(np.histogram2d(simulated_data_lists[f"cov_sim_{cov_sim}"]['Ztoy'][i], Zhat_current)[0])) / len(Zhat_current)
        
        # Store the ratio in the results list
        results_list[str(cov_sim)][i] = ratio

# Define the cov_sim values and convert them to character
cov_sim_values = [str(cov_sim) for cov_sim in [0, 0.1, 0.2, 0.5, 0.7]]

# Loop through each cov_sim value for plotting
for cov_sim_value in cov_sim_values:
    # Retrieve the "Kappa Not Applied" values from the results_list for the current cov_sim
    kappa_not_applied_values = results_list[cov_sim_value]
    
    # Assuming 'metrics_array' is structured as [kappa_values, samples, cov_sim_values]
    # and contains the agreement levels when Kappa is applied
    metrics = metrics_array[:, :, int(cov_sim_value)]
    
    # Calculate the average agreement level for each sample across applied kappa values (excluding "Not Applied")
    average_kappa_applied = np.mean(metrics[1:, :], axis=0)  # Exclude the first row
    
    # Calculate the standard error for each sample across applied kappa values
    se_kappa_applied = np.std(metrics[1:, :], axis=0) / np.sqrt(metrics[1:, :].shape[0])
    
    # Plotting
    plt.figure()
    plt.plot(range(1, len(kappa_not_applied_values) + 1), kappa_not_applied_values, 'ro-', label='Kappa = 0')
    plt.errorbar(range(1, len(kappa_not_applied_values) + 1), average_kappa_applied, yerr=se_kappa_applied, fmt='bo-', label='Average Kappa Applied')
    
    plt.xlabel("Samples")
    plt.ylabel("Level of Agreement")
    plt.title(f"Agreement Level Comparison for ω = {cov_sim_value}")
    plt.xticks(range(1, len(kappa_not_applied_values) + 1), [f"Sample {i}" for i in range(1, 6)])
    plt.legend()
    plt.show()
