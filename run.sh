#!/bin/bash

function plugin_provide {
    if [ ! -f "${PLUGIN_SOURCE}" ]; then
      touch "${PLUGIN_TARGET}"
    else
      mv "${PLUGIN_SOURCE}" "${PLUGIN_TARGET}"
    fi
}

function plugin_wait {
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