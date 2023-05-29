FROM verystar/golang:1.20 as builder
ARG VERSION
RUN go install -tags "oss nolimit" github.com/drone/drone/cmd/drone-server@v{VERSION}

FROM verystar/debian:11
LABEL maintainer="www.verystar.net"
COPY --from=builder /go/bin/drone-server /usr/local/bin/
ENTRYPOINT [ "/usr/local/bin/drone-server" ]
