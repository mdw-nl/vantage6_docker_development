#!/bin/bash

set -euo pipefail

# TODO: This needs to change! Very much tailored to just us for now
echo "Cloning repos.."
git clone -b experimental/dockerized-dev-env git@github.com:mdw-nl/vantage6.git || true
#git clone git@github.com:mdw-nl/vantage6_docker.git || true

# If venv doesn't exist install it
if [[ ! -d "./venv" ]]; then
    echo "Installing venv"
    python -m venv venv
else
    echo "./venv already exists, skipping venv installation"
fi

source venv/bin/activate

# These serve two purposes
#     * Install the `.egg-info` directory in local (for development) copy of
#       vantage6 repository
#     * Install vantage6-client for use in the client (when testing client side
#       from the host)
# This is based on that the Dockerfile for node and server do. See:
# https://github.com/vantage6/vantage6/blob/version/3.10.3/docker/node-and-server.Dockerfile#L41-L46
pip install -e vantage6/vantage6-common
pip install -e vantage6/vantage6-client
pip install -e vantage6/vantage6
pip install -e vantage6/vantage6-node
pip install -e vantage6/vantage6-server
pip install jupyter
# TODO: requirements.txt?
# TODO: we can just do make install-dev here?

