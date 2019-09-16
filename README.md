# Minimal Hyperopt Sacred
A minimal example of using sacred and hyperopt together.

The results are shown in 2 jupyter notebooks:
1. `hyperopt-no-sacred`: shows hyperopt being used sequentially and in parallel
2. `hyperopt-sacred`: a less-well documented example showing hyperopt and sacred together

# How to run
1. Run the environment setup script: `source setup_env.sh`
2. Launch the mongodb process by typing `mdb`
3. In a new shell, run the setup script again (step 1),
 then launch jupyter notebook/jupyterlab to run the examples.

# Requirements
- Python 3.6+
- Sacred, hyperopt, numpy, scipy
- Access to bash
