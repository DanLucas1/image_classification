# Machine Learning for Image Classification
A deep learning model training exercise employing PyTorch and HuggingFace to train models for image classification. A video walkthrough of the project is also available [here](https://www.youtube.com/watch?v=uycarDpI4oc).

## Project Summary
An exploration of ML model training to classify 10 categories of instruments using PyTorch (primarily the torchvision library) and this [training data](https://huggingface.co/datasets/YakupAkdin/instrument-images/tree/main) of 1000 images from Hugging Face datasets. The final project included training a basic 6 layer model before moving on to fine tuning runs using the resnet-18 model and applying image augmentation to account for the small dataset size.

## Process

### 1) Initial Model
The first training run adapted [this](https://pytorch.org/tutorials/beginner/blitz/cifar10_tutorial.html) PyTorch training tutorial to use the Hugging Face data. Hugging Face has conversion to PyTorch tensors built into their datasets library, so only some basic data prep was required (conversions to RBG, tensor data types, resizing, normalization).

The model was a simple 6 layer Convolutional Neural Network from the Pytorch classifier page. Due to the small dataset and model size, a local environment was sufficient for training during this first step. I performed 25 epochs of training, and the resulting outperformed a baseline random guess of 10% accuracy but overfit before reaching 50% accuracy on the test data.

The 1000 images total were split into test/training sets at an 80/20 ratio, meaning that each category had 80 training images and 20 test images. As shown in the confusion matrix below, certain categories (violin, yayli tambur) did not nearly approach a correct prediction count of 20.

![image](https://github.com/DanLucas1/image_classification/assets/97412358/fb9c64cb-d891-4744-ac82-0dbe2ec573fe)

Since using this particular model required downsizing the images to 32x32, my next step was to substitute in a model that would allow me to use the images without removing so much of their information.


### 2) Upgrading to Resnet
Image classification is not a novel task, and there are plenty of well known models that can be fine tuned to perform on target datasets. Of the well known options, Resnet offered a smaller version (resnet-18) which would be less likely to immediately overfit the small dataset, and has support to import from PyTorch directly. Working with the resnet-18 model required a more powerful training environment, so the remainder of the project took place in a Dockerized training environment running on a Google Cloud Compute Engine VM with GPU support.

Resnet-18 had much stronger predictions on test data (77%) but still overfit very quickly. I experimented with lowering the learning rate, which slowed down the overfitting as planned but didn't translate to higher accuracy on test data. The new confusion matrix shows a clear improvement.

![image](https://github.com/DanLucas1/image_classification/assets/97412358/591e1af3-9878-448f-b704-450e01b4802e)

However, loss and training accuracy suggest that we have hit an accuracy cap.

![image](https://github.com/DanLucas1/image_classification/assets/97412358/8e223f75-7d35-46a7-9728-1f880f22ac24)
![image](https://github.com/DanLucas1/image_classification/assets/97412358/feb30c2b-cc48-4033-945b-c42f97e84058)

These results are unsurprising given the limitations of data quantity and variety. To address those limitations I turned to Image Augmentation.


### 3) Image Augmentation
The next training run was identical for step #2 except for the application of [AugMix](https://arxiv.org/pdf/1912.02781) to the training data (and some minor changes to preprocessing to successfully apply Augmix). AugMix applies multiple augmentations with inbuilt randomization to create a more robust distribution of training data. By applying these transformations during each batch of each training loop I would functionally increase the size and variety of my dataset.

The results were consistent with that expectation. The final training loop before loss started to rebound showed 90.75% accuracy on training data and 90.5% on test data, and the confusion matrix for that model state shows a much stronger predictive pattern across all categories.

![image](https://github.com/DanLucas1/image_classification/assets/97412358/b4553ba9-a65f-4e3d-abcb-cb6616d1fcbd)


## Challenges and Next Steps
Throughout the project I had to make accomodations for the small dataset size (1000 images for 10 categories is quite small) and lack of variety in certain categories (e.g. all the electic and acoustic guitar images were incredibly similar with to variation in backgrounds, scale, perspective, or orientation). While I was able to progress in accuracy from step to step, the limited data still effects the utility of the model. For example, even my most accurate model predicts electric and acoustic guitars poorly when they don't match the standardized format of guitar images in the training data.

My next step for improving predictive power on more varied data would be to acquire a higher volume and variety of training data. Taking advantage of a known high-performing classification model and strategic image augmentation did compensate for the limited data somewhat, but this project highlights the importance of having sufficient quality and relevant data for model training.
