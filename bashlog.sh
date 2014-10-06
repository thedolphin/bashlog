#!/bin/bash

createlog() {
    exec 3>$1 || logfail "failed to create logfile '$1'"
    logfile=$1
}

appendlog() {
    exec 3>>$1 || logfail "failed to append to logfile '$1'"
    logfile=$1
}

closelog() {
    if [ "${logfile}" ]; then
        exec 3>&-
        logfile=
    fi
}

logwrapper() {
    [ "${logfile}" ] || logfail "log must be opened"
    while read line; do
        echo $(date "+[%Y-%m-%d %H:%M:%S] ") "${line//[$'\t\r\n']}" >&3
    done
}

log() {
    [ "${logfile}" ] || logfail "log must be opened"
    echo "$@" | logwrapper
}

runcommand() {
    [ "${logfile}" ] || logfail "log must be opened"
    eval "set -x; $@" 2>&1 | logwrapper
    return ${PIPESTATUS[0]}
}

evalcommand() {
    [ "${logfile}" ] || logfail "log must be opened"
    exec 4>&1
    eval "set -x; $@" 2>&1 >&4 4>&- | logwrapper 4>&-
    ret=${PIPESTATUS[0]}
    exec 4>&-
    return ${ret}
}

ok() {
    log "Done"
    exit 0
}

fail() {
    log "Failed: $1"
    exit $2
}

logfail() {
    echo $1 >&2
    exit 255
}
