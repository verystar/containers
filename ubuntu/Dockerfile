ARG VERSION
FROM ubuntu:${VERSION}

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="www.verystar.net"
ENV TZ=Asia/Shanghai

RUN apt-get update && \
    apt-get install -y systemd systemd-sysv && \
    apt-get clean && \
    rm -Rf /usr/share/doc && \
    rm -Rf /usr/share/man && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    cd /lib/systemd/system/sysinit.target.wants/ && \
    ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1 && \
    rm -f /lib/systemd/system/multi-user.target.wants/* && \
    rm -f /etc/systemd/system/*.wants/* && \
    rm -f /lib/systemd/system/local-fs.target.wants/* && \
    rm -f /lib/systemd/system/sockets.target.wants/*udev* && \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl* && \
    rm -f /lib/systemd/system/basic.target.wants/* && \
    rm -f /lib/systemd/system/anaconda.target.wants/* && \
    rm -f /lib/systemd/system/plymouth* && \
    rm -f /lib/systemd/system/systemd-update-utmp*

## For Tekton CI
RUN groupadd --gid 65532 tekton && \
    useradd --uid 65532 --gid tekton --home-dir /home/tekton --create-home --shell /bin/bash tekton

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/lib/systemd/systemd"]