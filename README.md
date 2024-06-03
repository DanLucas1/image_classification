# Machine Learning for Image Classification
A deep learning model training exercise employing PyTorch and HuggingFace to train models for image classification. A video walkthrough of the project is also available [here](https://www.youtube.com/watch?v=uycarDpI4oc).

## Project Summary
An exploration of ML model training to classify 10 categories of instruments using PyTorch (primarily the torchvision library) and this [training data](https://huggingface.co/datasets/YakupAkdin/instrument-images/tree/main) of 1000 images from Hugging Face datasets. The final project included training a basic 6 layer model before moving on to fine tuning runs using the resnet-18 model and applying image augmentation to account for the small dataset size.

## Process

### 1) Initial Model
The first training run adapted [this](https://pytorch.org/tutorials/beginner/blitz/cifar10_tutorial.html) PyTorch training tutorial to use the Hugging Face data. Hugging Face has conversion to PyTorch tensors built into their datasets library, so only some basic data prep was required (conversions to RBG, tensor data types, resizing, normalization).

The model was a simple 6 layer Convolutional Neural Network from the Pytorch classifier page. Due to the small dataset and model size, a local environment was sufficient for training during this first step. I performed 25 epochs of training, and the resulting outperformed a baseline random guess of 10% accuracy but overfit before reaching 50% accuracy on the test data.

![image](https://github.com/DanLucas1/image_classification/assets/97412358/fb9c64cb-d891-4744-ac82-0dbe2ec573fe)

Since using this model required downsizing the images to 32x32, my next step was to substitute in a model that would allow me to use the images without removing so much of their information.


### 2) Upgrading to Resnet
Of the well known image classification models that could be fine tuned, Resnet offered a smaller version (resnet-18) which would be less likely to immediately overfit the small dataset.


Tuning the resnet-18 model

Next launching a Dockerized training environment on a Google Cloud Compute Engine VM with GPU support.


## Results

## Challenges and Next Steps
Dataset size and characteristics were the limiting elements
A real world the next step would be to invest
A higher volume and variety of image data. Only 100 images for each category

