# CuRTAIL

This repository provides an API for CuRTAIL framework (http://arxiv.org/abs/1709.02538). CuRTAIL can be used as a generic framework for characterizing and thwarting  adversarial samples in the context of deep learning.


### Python Packages Required:
Tensorflow(v 1.2.1), Keras(v 2.0.6), scipy(v 0.19.1), sklearn(v 0.18.2)

### Matlab Packages Required:
ompbox10. See http://www.cs.technion.ac.il/~ronrubin/software.html for installation instructions.


## Description of files:

**mnist/defense.py:** the main function to train model and perform attacks, with function parameters specified using function arguments. For more information please run:
```
cd mnist
python defense.py --help
```

**denoiser.m:** a matlab script that uses ompbox10 to denoise images.

**curtail.pyc:** includes modules required for all attack and defense algorithms.

**Note:** Most files are provided in .pyc file format. The repo includes an example with mnist dataset. If you wish to use CuRTAIL framework on a different model topology, please email bita@ucsd.edu and we will provide the corresponding executables for your model.


### Functions

**Train:** train a victim model and saves it as **victim.h5** batch_size and epochs corresponding to the batch size and number of epochs for the model, repectively.

**retrain_clustered_sequential:** train a set of MRR modules for the second to last layer and save the models for later use in defense. The number of MRR modules is specified by parameter num_MRR.

**black_box_attack:** perform attacks on the victim model (without considering the defenders).

**black_box_defense:** evaluate the black-box defense, the number of defenders is specified by num_MRR.

**white_box_attack:** simultaneously attack victim model and defenders, report the attack success rate and L_2 norm of the perturbation.


## Usage

* Determine the function desired
* pass in the argument to specify the function
* pass in argument to specify specific parameters (if desired)

**Note:** Please only select one function each time

example:
```
cd mnist
python defense.pyc -Train
```
