ARG VERSION
FROM centos:${VERSION}

LABEL maintainer="www.verystar.net"
ENV TZ=Asia/Shanghai
ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
    systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;
RUN yum makecache fast \
    && yum install -y deltarpm epel-release initscripts \
    && yum update -y \
    && yum install -y \
        sudo \
        which \
        ca-certificates \
        procps \
        iputils-ping \
        curl \
        wget \
        iproute \
        tzdata \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && yum clean all \
    && rm -rf /var/cache/yum/*
RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]