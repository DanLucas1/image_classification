#!/bin/bash

echo "starting dockerized training environment"
echo "🐍🧜💇"
# sudo docker run -u $(id -u):$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/workspace -it --rm -p 8888:8888 pytorch-jupyter-openai
sudo docker run --gpus all -u $(id -u):$(id -g) -e OPENAI_API_KEY=$OPENAI_API_KEY -v $(pwd):/workspace -v ~/.ssh:/root/.ssh -it --rm -p 8888:8888 pytorch-jupyter-openai


