#!/bin/bash

set -euo pipefail

# Since pre-hooks are 'source'd, not run, we've already sourced lib.sh.
#source /start-up.d/common/lib.sh

# We are effectively overriding/extending start_server() here.
start_server() {
    # debugpy will allow us to attach a debugger to the running server.
    python /tmp/debugpy --listen 0.0.0.0:5678 $(which vserver-local) start --config ${V6_CONFIG_PATH}
}

dev_setup() {
    echo "Setting up dev environment"
    vserver-local import ${CUSTOM_DIR}/entities.yaml --config /mnt/config/config.yaml

    pip install debugpy -t /tmp
}

dev_main() {
    run_once_container_life dev_setup
}

dev_main $@
