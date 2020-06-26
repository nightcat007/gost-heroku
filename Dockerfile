FROM alpine:3.6

ENV VER=2.11.0 WSPATH=/catpxy READBUFFSIZE=8192 WRITEBUFFSIZE=8192 WSCOMPR=false

RUN apk add --no-cache
  rm -Rf gost && \
  rm -Rf gost.tar.gz && \
  curl -vvvo gost.tar.gz https://github.com/xiaokaixuan/gost-heroku/releases/download/v${VER}/gost_${VER}_linux_amd64.tar.gz && \
  tar xzvf gost.tar.gz && \
  mv gost_${VER}_linux_amd64 gost && \
  chmod a+x gost && \
  rm -Rf gost.tar.gz

WORKDIR /

CMD exec /gost -L="quic+ws://:$PORT?path=$WSPATH&rbuf=$READBUFFSIZE&wbuf=$WRITEBUFFSIZE&compression=$WSCOMPR"
