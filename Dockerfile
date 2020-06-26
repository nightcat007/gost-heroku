FROM alpine:3.6

ENV VER=2.11.0 WSPATH=/proxy READBUFFSIZE=8192 WRITEBUFFSIZE=8192 WSCOMPR=false

RUN apk add --no-cache
  curl -sL https://github.com/xiaokaixuan/gost-heroku/releases/download/v${VER}/gost_${VER}_linux_amd64.tar.gz | tar xz && \
  mv gost_${VER}_linux_amd64 gost && \
  chmod a+x gost && \

WORKDIR /

CMD exec /gost -L="quic+ws://:$PORT?path=$WSPATH&rbuf=$READBUFFSIZE&wbuf=$WRITEBUFFSIZE&compression=$WSCOMPR"
