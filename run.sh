#!/bin/bash

function plugin_provide {
    SOURCE_FILE="${PLUGIN_SOURCE}"
    TARGET_FILE="${PLUGIN_TARGET}"
    if [ ! -f "${SOURCE_FILE}" ]; then
      touch "${TARGET_FILE}"
    else
      mv "${SOURCE_FILE}" "${TARGET_FILE}"
    fi
}

function plugin_wait {
    TARGET_FILE=${PLUGIN_TARGET}
    while /bin/true; do
        [ ! -f ${PLUGIN_TARGET} ] && sleep 1 && continue
        if [ $(stat -c%s ${PLUGIN_TARGET}) -lt 1 ]; then
            echo "ERROR: File is empty"
            exit 1
        fi
    done
}

case "${PLUGIN_MODE}" in
    "provide")
        plugin_provide
        ;;
    "wait")
        plugin_wait
        ;;
    *)
        echo "mode ${PLUGIN_MODE} not recognised"
        ;;
esac