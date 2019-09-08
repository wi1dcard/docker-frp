FROM busybox AS build

ARG VERSION=0.29.0
ARG OS=linux
ARG ARCH=amd64

RUN wget -O frp.tar.gz https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_${OS}_${ARCH}.tar.gz
RUN tar xvzf frp.tar.gz
RUN mv frp_${VERSION}_${OS}_${ARCH} /frp

FROM alpine

COPY --from=build /frp /frp
RUN set -x \
    && ln -s /frp/frpc /usr/bin/frpc \
    && ln -s /frp/frps /usr/bin/frps

CMD [ "frpc" ]
