# Start from a PyTorch base image with GPU support
FROM pytorch/pytorch:latest
#FROM pytorch/pytorch:2.1.1-cuda12.1-cudnn8-runtime

# Update the system and install necessary software
RUN apt-get update && apt-get install -y \
    python3-pip \
    && rm -rf /var/lib/apt/lists/* \
    # Install Python packages
    && pip install jupyter jupyterlab matplotlib seaborn scikit-learn datasets datasets[vision]

# Set up the working directory
WORKDIR /workspace

# location for HF dataset cache and permissions
RUN mkdir /.local /.jupyter /workspace/hf_cache \
    && chmod -R 777 /.local /.jupyter /workspace/hf_cache \
    && echo "export HF_DATASETS_CACHE=/workspace/hf_cache" >> ~/.bashrc

# When the container launches, start a Jupyter Notebook server
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser"]
