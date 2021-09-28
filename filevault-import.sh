#!/bin/bash

PARENT_PROJECT_PATH="$(pwd)"
source "./scripts/functions.sh"

SCRIPT_PARAMS="$@"

set_term_title "Import Content"

AEM_HOST=${AEM_HOST:-localhost}
AEM_PORT=${AEM_PORT:-4502}
#HOST="http://${AEM_HOST}:${AEM_PORT}/crx/server/crx.default/jcr:root/"
HOST="http://${AEM_HOST}:${AEM_PORT}/crx"
JCR_ROOT="$(realpath ./src/main/content/jcr_root/)"
CREDENTIALS="${AEM_USER:-admin}:${AEM_PASS:-admin}"
FILTER="./src/main/content/META-INF/vault/filter.xml"
TIMEOUT=30
VLT_FLAGS="--insecure -Xmx2g"
ROOT_PATH="/"

WATCH_COMMAND=""

function doSync() {


    debug "Upload content to HOST=$HOST" "info"
    debug "THIS WILL OVERWRITE ALL OF YOUR CONTENT IN AEM" "error"

    read  -n 1 -p "Press any key to continue"

    doWorkflowsTurnOff
    vltImport "$CREDENTIALS" "$HOST" "$JCR_ROOT" "$ROOT_PATH" "$VLT_FLAGS"
    doWorkflowsTurnOn

    set_term_title "Done"
}

function main() {


   doSync


}

debugOn

#start
main "$@";