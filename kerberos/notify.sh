#!/usr/bin/env bash

CAPTURES=/etc/opt/kerberosio/capture
FILE=$(ls -t ${CAPTURES}/*.mp4 | head -1)

echo "Motion detected" | mail -s "Kerberos | Motion detected" $(cat /run/secrets/kerberos_default_mail) -A ${FILE}

