FROM node:20-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install SCIP indexers
# TypeScript/JavaScript
RUN npm install -g @sourcegraph/scip-typescript

# Python (via pip)
# Note: scip-python might need a specific install source or binary. 
# Using a placeholder pip install or cloning if not on PyPI yet. 
# For now, we'll try to install strict-python-scip or similar if available, 
# but looking at research, it might be better to download the binary.
# FOR SIMPLICITY: We will assume the user has the 'scip-python' executable or we use a widely available one. 
# Actually, let's stick to TS for now as the robust MVP, and add Python if standard pip install works.

WORKDIR /app

COPY package.json .
RUN npm install

COPY index.js .

ENTRYPOINT ["node", "index.js"]
