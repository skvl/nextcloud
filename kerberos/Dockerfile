FROM kerberos/kerberos

RUN apt-get -yqq update && apt-get install -yqq --no-install-recommends mailutils ssmtp

COPY notify.sh /notify.sh

