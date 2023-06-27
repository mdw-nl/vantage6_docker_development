#!/bin/bash

set -euo pipefail

source /start-up.d/common/lib.sh

dev_setup() {
    echo "Setting up dev environment"
    # TODO: '-e dev' is dependent on mdw-nl/v6server_docker hardcoding dev too, we will change that
    vserver-local import /start-up-hooks.d/entities.yaml --config /etc/xdg/vantage6/config.yaml -e dev
}

main() {
    run_once_container_life dev_setup
}

main $@
