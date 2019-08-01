# monitorrent-alpine
Docker image for Monitorrent app

To update version, run in docker console:

    wget https://github.com/$(wget https://github.com/werwolfby/monitorrent/releases/latest -O - --no-check-certificate | egrep '/.*/.*/monitorrent.*zip' -o) -O /tmp/monitorrent.zip --no-check-certificate
    unzip -od /app/ /tmp/monitorrent.zip
