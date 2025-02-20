FROM ubuntu:20.04
LABEL org.opencontainers.image.authors1="halotroop2288@proton.me" \
      org.opencontainers.image.authors2="gnuton@gnuton.org" \
      org.opencontainers.image.authors3="m@thp.io"

ENV DEBIAN_FRONTEND=noninteractive
ENV VITASDK /usr/local/vitasdk
ENV PATH ${PATH}:${VITASDK}/bin

WORKDIR /build

RUN echo "Installing dependencies..."
RUN apt-get update
RUN apt-get install -y apt-transport-https ca-certificates git-core gnupg cmake curl make python software-properties-common sudo wget xz-utils
RUN rm -rf /var/lib/apt/lists/*

RUN echo "Adding non-root user..."
RUN useradd -ms /bin/bash user && echo "user:user" | chpasswd && adduser user sudo

RUN echo "Installing VitaSDK"
RUN git clone https://github.com/vitasdk/vdpm
WORKDIR /build/vdpm
RUN ./bootstrap-vitasdk.sh
RUN ./install-all.sh
WORKDIR /build

USER root
CMD ["/bin/bash"]
