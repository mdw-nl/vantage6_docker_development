#!/bin/bash

set -euo pipefail

# Since pre-hooks are 'source'd, not run, we've already sourced lib.sh.
#source /vantage6/docker/common/lib.sh

# We are effectively overriding/extending start_server() here!
start_server() {
    # debugpy will allow us to attach a debugger to the running server.
    python /tmp/debugpy --listen 0.0.0.0:5678 $(which vserver-local) start --config ${V6_CONFIG_PATH} -e application
}

dev_setup() {
    echo "Setting up dev environment"
    vserver-local import $(dirname ${PRE_HOOK_PATH})/entities.yaml --config /mnt/config/config.yaml -e application

    pip install debugpy -t /tmp
}

dev_main() {
    run_once_container_life dev_setup
}

dev_main $@
