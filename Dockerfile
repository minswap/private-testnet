FROM debian:11-slim as builder

WORKDIR /build
RUN apt-get update -y && \
  apt-get install -y wget tar && \
  wget https://hydra.iohk.io/build/17428084/download/1/cardano-node-1.35.3-linux.tar.gz && \
  mkdir -p bin && \
  tar -xzf cardano-node-1.35.3-linux.tar.gz -C bin

FROM debian:11-slim

WORKDIR /root
RUN apt-get update -y && \
  apt-get install -y tzdata ca-certificates
COPY --from=builder /build/bin ./bin
COPY . .
CMD ["./scripts/reset.sh"]
