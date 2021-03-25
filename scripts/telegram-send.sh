#!/usr/bin/env bash

set -Eeuxo pipefail

if ! command -v curl &> /dev/null
then
    echo "'curl' could not be found"
    apt-get -yqq update
    apt-get install -yqq --no-install-recommends curl --fix-missing
fi

DATA_DIR_PATH=/var/lib/motioneye
EXTENSION=mp4
MESSAGE="Motion detected"
NAME="Camera1"
REMOVE=0
TIMEOUT=0

while getopts ":d:e:hm:n:rt:" opt; do
  case ${opt} in
    d )
        DATA_DIR_PATH=$OPTARG
        ;;
    e )
        EXTENSION=$OPTARG
        ;;
    h )
        echo "Usage: ${0} [options]"
        echo "  -d data_dir_path Data directory path ('/var/lib/motioneye' by default)"
        echo "  -e extension     File extension to send ('mp4' by default)"
        echo "  -h               Show this help"
        echo "  -m message       Message text ('Motion detected' by default)"
        echo "  -n name          Camera name been used in message caption ('Camera1' by default)"
        echo "  -r               Remove file after ('false' by default)"
        echo "  -t seconds       Timeout to wait before search file needed to get full file (0 by default)"
        exit 0
        ;;
    m )
        MESSAGE=$OPTARG
        ;;
    n )
        NAME=$OPTARG
        ;;
    r )
        REMOVE=1
        ;;
    t )
        TIMEOUT=$OPTARG
        ;;
    \? )
        echo "Invalid option: $OPTARG" 1>&2
        exit 1
        ;;
    : )
        echo "Invalid option: $OPTARG requires an argument" 1>&2
        exit 1
        ;;
  esac
done
shift $((OPTIND -1))

sleep ${TIMEOUT}
FILE=$(ls -t ${DATA_DIR_PATH}/*.${EXTENSION} | head -1)

TG_BOT=$(cat ${TG_BOT_FILE})
TG_CHAT=$(cat ${TG_CHAT_FILE})

curl -F chat_id="${TG_CHAT}" \
     -F document=@"${FILE}" \
     -F caption="${NAME} | ${MESSAGE}" \
     https://api.telegram.org/bot${TG_BOT}/sendDocument

if [ $REMOVE -eq 1 ]; then
    rm -rf ${FILE}
fi

exit 0
