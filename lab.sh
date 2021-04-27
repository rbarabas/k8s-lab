#!/usr/bin/env bash

NODES="worker1 worker2 worker3 master1"
#LABUSER=root
OPTIONS="start status stop get-nodes exec list-snapshots create-snapshots delete-snapshots restore-snapshots bash-completion ping"

function usage() {
    echo "Usage:"
    for OPT in ${OPTIONS}; do
        echo " $0 $(echo ${OPT})"
    done
    exit 1
}

function labvirsh() {
    [ $# -lt 1 ] && exit 2
    CMD="$1"
    shift
    ARGS="$@"
    for NODE in ${NODES}; do
        echo "*** ${NODE} ***"
        virsh ${CMD} ${NODE} ${ARGS}
    done
}

function labexec() {
    for NODE in ${NODES}; do
        echo "*** ${NODE} ***"
        if [ -n "${LABUSER}" ]; then
            ssh ${LABUSER}@${NODE} $*
        else
            ssh ${NODE} $*
        fi
    done
}

case $1 in
    start)
        labvirsh start
        ;;
    stop)
        labvirsh shutdown
        ;;
    status)
        labvirsh domstate
        ;;
    exec)
        if [ $# -lt 1 ]; then
            echo "Please specify command to run."
            exit 2
        fi
        labexec $*
        ;;
    list-snapshots)
        labvirsh snapshot-list
        ;;
    create-snapshots)
        if [ $# -lt 2 ]; then
            echo "Please specify snapshot name"
            exit 2 
        fi
        NAME="$2"
        labvirsh snapshot-create-as --name ${NAME}
        ;;
    delete-snapshots)
        if [ $# -lt 2 ]; then
           echo "Please specify snapshot name"
           exit 2
        fi
        NAME="$2"
        labvirsh snapshot-delete ${NAME}
        ;;
    restore-snapshots)
        if [ $# -lt 2 ]; then
           echo "Please specify snapshot name"
           exit 2
        fi
        NAME="$2"
        labvirsh snapshot-revert --snapshotname ${NAME}
;;
    get-nodes)
        echo ${NODES}
        ;;
    bash-completion)
        echo "complete -W \"${OPTIONS}\" lab.sh"
        ;;
    ping)
        labexec uptime
        ;;
    *)
        usage
        ;;
esac
