#!/usr/bin/env bash

set -Eeuxo pipefail

if ! command -v curl &> /dev/null
then
    echo "'curl' could not be found"
    apt-get -yqq update
    apt-get install -yqq --no-install-recommends curl --fix-missing
fi

CAPTURE=/etc/opt/kerberosio/capture
FILE=$(ls -t ${CAPTURE}/*.mp4 | head -1)

TG_BOT=$(cat ${TG_BOT_FILE})
TG_CHAT=$(cat ${TG_CHAT_FILE})

curl -F chat_id="${TG_CHAT}" \
     -F document=@"${FILE}" \
     -F caption="Kerberos.io | Motioin detected" \
     https://api.telegram.org/bot${TG_BOT}/sendDocument
