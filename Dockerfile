FROM debian:stretch-slim
ARG NODE_VERSION
RUN apt-get update \
 && apt-get install -y \
      curl \
      gcc \
      g++ \
      gpg \
      make \
      python \
 && rm -rf /var/lib/apt/lists/*
RUN gpg --keyserver ipv4.pool.sks-keyservers.net --recv-keys \
      9554F04D7259F04124DE6B476D5A82AC7E37093B \
      94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
      FD3A5288F042B6850C66B31F09FE44734EB7990E \
      71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
      DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
      C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
      B9AE9905FFD7803F25714661B63B535A4C206CA9 \
      56730D5401028683275BD23C23EFEFE93C4CFFFE \
 && curl -sSLO https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.xz \
 && curl -sSL https://nodejs.org/dist/v${NODE_VERSION}/SHASUMS256.txt.asc \
    | gpg --batch --decrypt \
    | grep " node-v${NODE_VERSION}.tar.xz\$" \
    | sha256sum -c \
    | grep . \
 && tar -xf node-v${NODE_VERSION}.tar.xz \
 && cd node-v${NODE_VERSION} \
 && ./configure --prefix=/usr \
 && make -j$(getconf _NPROCESSORS_ONLN) \
 && make install

FROM debian:stretch-slim
ARG NODE_USER=node
ARG NODE_UID=1000
ARG NODE_GROUP=node
ARG NODE_GID=1000
ARG NODE_HOME=/home/${NODE_USER}
RUN groupadd --gid ${NODE_GID} ${NODE_GROUP} \
 && useradd --uid ${NODE_UID} --gid ${NODE_GID} --shell /bin/bash \
      --create-home --home ${NODE_HOME} ${NODE_USER}
COPY --from=0 /usr/bin/node /usr/bin
COPY --from=0 /usr/lib/node_modules/  /usr/lib/node_modules/
COPY --from=0 /usr/include/node/ /usr/include/node/
RUN ln -s /usr/lib/node_modules/npm/bin/npm-cli.js /usr/bin/npm
