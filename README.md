# Kappa Clustering Agreement

This project evaluates the agreement levels in clustering results with and without the application of different kappa values. It generates metrics and plots to compare the agreement levels across various covariance simulations (`cov_sim`).

## Usage

### Requirements

#### R
Ensure you have the following packages installed in R:
- `MASS`
- `flowClust`
- `latex2exp`
- Any other dependent packages (e.g., `flowCore`)

#### Python
Ensure you have the following packages installed in Python:
- `numpy`
- `scikit-learn`
- `matplotlib`

### How to Run

#### R

To run the R code, open the `R/kappa_clustering_agreement.R` file in your R environment and source it.

#### Python

To run the Python code, open the `Python/kappa_clustering_agreement.py` file and execute it in your Python environment.

### Code Explanation

#### R Code

The R script `kappa_clustering_agreement.R` initializes lists to store results and loops through various `cov_sim` values to calculate the agreement levels. It then generates plots to compare the agreement levels for different kappa values.

#### Python Code

The Python script `kappa_clustering_agreement.py` (to be created similarly to the R script) will follow a similar process. It initializes lists to store results and loops through various `cov_sim` values to calculate the agreement levels and generate plots to compare the agreement levels for different kappa values.

## Contribution

We welcome contributions to improve the project. Please open issues or submit pull requests on GitHub.

## License

This project is part of a student project at Trinity College Dublin. For more details, see the `LICENSE` file.
