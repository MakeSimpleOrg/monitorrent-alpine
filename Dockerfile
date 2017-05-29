FROM alpine
RUN apk update
RUN apk add --no-cache python3 wget unzip && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    rm -r /root/.cache

#Variables by default
ENV MONITORRENT_VERSION="1.1.2"
ENV MONITORRENT_DEBUG=false
ENV MONITORRENT_IP=0.0.0.0
ENV MONITORRENT_PORT=6687
ENV MONITORRENT_DB_PATH=/app/settings/monitorrent.db
ENV MONITORRENT_UID=1000
ENV MONITORRENT_GID=1000

#Adding user app
RUN adduser -D -u $MONITORRENT_UID -g $MONITORRENT_GID app
RUN mkdir -p /app/settings

#Downloading archive with app
RUN wget https://github.com/$(wget https://github.com/werwolfby/monitorrent/releases/latest -O - --no-check-certificate | egrep '/.*/.*/monitorrent.*zip' -o) -O /tmp/monitorrent.zip --no-check-certificate

#Unzipping
RUN unzip -d /app/ /tmp/monitorrent.zip

#Changing work dir
WORKDIR /app

#Installing depencies
RUN pip3 install -r requirements.txt
RUN rm requirements.txt
RUN apk del wget unzip
RUN rm -r /tmp/*
RUN chown -R app:app /app
USER app

CMD ["python3", "server.py"]
