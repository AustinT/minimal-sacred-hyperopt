"""
This file contains the objective function
"""
import os
import time
import numpy as np
import hyperopt
from sacred import Experiment
from sacred.observers import MongoObserver


def expt_config():
    x = 10.
    y = 10.


def function_to_optimize(x, y):
    """
    Optimize the function
    x^2 + y^2,
    with x and y subject to
    Gaussian noise
    """
    return ((x+np.random.randn())**2 +
            (y+np.random.randn())**2)


def difficult_optimization_objective(x, y):
    """
    Basically this function pretends to be a difficult
    function that takes a long time to evaluate,
    which it does by randomly waiting from between 0.1-0.3 seconds
    before calling the actual function
    """
    time.sleep(.2*np.random.random()+.1)
    return function_to_optimize(x, y) 


def hyperopt_objective(params):
    """
    Objective to call from hyperopt,
    that doesn't use sacred
    """
    loss = difficult_optimization_objective(**params)
    return {"loss": loss, "status": hyperopt.STATUS_OK}


def sacred_hyperopt_objective(params):
    """
    Objective to call with hyperopt
    that uses sacred to log the experiment results
    """   
    ex = Experiment('example')
    ex.config(expt_config)
    ex.main(difficult_optimization_objective)
    ex.observers.append(MongoObserver.create(
        url=f"{os.environ['MONGO_WRITE_IP']}:{os.environ['MONGO_PORT']}"))
    run = ex.run(config_updates=params,
                 options={"--loglevel": 40})
    return {"loss": run.result, "status": hyperopt.STATUS_OK}