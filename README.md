## Introduction

This README provides an overview of the source code for the paper "CADICA: Diagnosis of Coronary Artery Disease Using the Imperialist Competitive Algorithm". The code is written in MATLAB and implements an algorithm that uses data mining techniques, a fuzzy expert system, and the imperialist competitive algorithm (ICA) to diagnose coronary artery disease (CAD).

## Prerequisites

To run the CADICA code, you will need the following:

- MATLAB R2021a or later
- Fuzzy Logic Toolbox
- Optimization Toolbox

## Usage

To run the main MATLAB script, execute the following command:

```matlab
MainImperialist -Competition
```

Before running the script, you need to set some parameters as follows:

```matlab
ProblemParams.CostFuncName = 'Alldatasets;' % 'BenchmarkFunction2clevhung' %'Alldatasets';
ProblemParams.CostFuncExtraParams = []; % Reserved for the extra parameters in cost function. In normal application do not use it that is use [].
ProblemParams.NPar = 46; % Number of parameters for membership functions for this file.
AlgorithmParams.NumOfCountries = 100; % Number of initial countries.
AlgorithmParams.NumOfInitialImperialists = 20; % Number of Initial Imperialists.
```

## Dataset

The CADICA algorithm uses the coronary artery disease dataset available in the UCI dataset. The optimization of membership function parameters is also performed in this file.

## Output

The CADICA code will generate the following output:

- Classification accuracy
- Confusion matrix
- ROC curve
- Classification error plot using ICA and particle swarm optimization

The output will be saved to files in the project directory for further analysis and visualization.

## Contributing

If you have any issues or suggestions for improving the CADICA code, feel free to submit a pull request or open an issue on the repository.

If you have any issues or need any more help, please feel free to reach out to me via email (za.mahmoodabadi@gmail.com).
