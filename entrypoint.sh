#!/bin/bash

# Update package list and install openssh-server
apt update
DEBIAN_FRONTEND=noninteractive apt-get install openssh-server -y

# Setup SSH
mkdir -p ~/.ssh
chmod 700 ~/.ssh
if [ -n "${PUBLIC_KEY}" ]; then
    echo "${PUBLIC_KEY}" >> ~/.ssh/authorized_keys
    chmod 700 ~/.ssh/authorized_keys
fi

# Start SSH service
service ssh start

# Function to login with HuggingFace token
login_with_token() {
    local token=$1
    if [ -n "${token}" ]; then
        echo "Setting HuggingFace token"
        huggingface-cli login --token "${token}"
    fi
}

# Try RUNPOD_SECRET_HF_TOKEN first, then fall back to HUGGINGFACE_TOKEN
login_with_token "${RUNPOD_SECRET_HF_TOKEN}" || login_with_token "${HUGGINGFACE_TOKEN}" 

exec "$@" 