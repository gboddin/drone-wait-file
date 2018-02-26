FROM alpine
ADD run.sh /run.sh
ENTRYPOINT /run.sh