#!/bin/bash

set -euo pipefail

# Since pre-hooks are 'source'd, not run, we've already sourced lib.sh.
#source /vantage6/docker/common/lib.sh

# We are effectively overriding/extending start_server() here.
start_node() {
    # debugpy will allow us to attach a debugger to the running server.
    python /tmp/debugpy --listen 0.0.0.0:5678 $(which vnode-local) start --config ${V6_CONFIG_PATH} --dockerized -e application
}

dev_setup() {
    echo "Setting up dev environment"
    pip install debugpy -t /tmp
}

dev_main() {
    run_once_container_life dev_setup
}

dev_main $@
