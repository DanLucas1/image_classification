# Start from a PyTorch base image with GPU support
FROM pytorch/pytorch:latest

# Update the system and install necessary software
RUN apt-get update && apt-get install -y \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Jupyter Notebook, openai and other useful stuff.
RUN pip install jupyter
RUN pip install jupyterlab
RUN pip install nblint
RUN pip install matplotlib
RUN pip install seaborn
RUN pip install scikit-learn
RUN pip install datasets
RUN pip install datasets[vision]

# Set up the working directory
WORKDIR /workspace

# location for HF dataset cache
RUN mkdir /workspace/hf_cache
RUN chmod -R 777 /workspace/hf_cache
ENV HF_DATASETS_CACHE=/workspace/hf_cache

# Change the ownership and permissions of /.local and /workspace
RUN mkdir /.local /.jupyter
RUN chmod -R 777 /.local /.jupyter /workspace

# When the container launches, start a Jupyter Notebook server
CMD ["jupyter", "lab", "--ip='*'", "--port=8888", "--no-browser"]
